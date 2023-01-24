-- PROCEDURE: dwh.usp_f_outboundschdetailhistoryweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_outboundschdetailhistoryweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_outboundschdetailhistoryweekly(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE
    p_etljobname VARCHAR(100);
    p_envsourcecd VARCHAR(50);
    p_datasourcecd VARCHAR(50);
    p_batchid integer;
    p_taskname VARCHAR(100);
    p_packagename  VARCHAR(100);
    p_errorid integer;
    p_errordesc character varying;
    p_errorline integer;
	p_depsource VARCHAR(100);
    p_rawstorageflag integer;
	p_intervaldays integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag, h.depsource, d.intervaldays
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag, p_depsource, p_intervaldays
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;
			
  IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_outbound_sch_dtl_h;

    UPDATE dwh.F_OutboundSchDetailHistory t
    SET 
        obh_hr_his_key                  = sb.obh_hr_key,
        oub_loc_key                     = COALESCE(l.loc_key,-1),
        oub_itm_key                     = COALESCE(c.itm_hdr_key,-1),
        oub_sch_item_code               = s.wms_oub_sch_item_code,
        oub_sch_order_qty               = s.wms_oub_sch_order_qty,
        oub_sch_masteruom               = s.wms_oub_sch_masteruom,
        oub_sch_deliverydate            = s.wms_oub_sch_deliverydate,
        oub_sch_serfrom                 = s.wms_oub_sch_serfrom,
        oub_sch_serto                   = s.wms_oub_sch_serto,
        oub_sch_plan_gd_iss_dt          = s.wms_oub_sch_plan_gd_iss_dt,
        oub_sch_plan_gd_iss_time        = s.wms_oub_sch_plan_gd_iss_time,
        oub_sch_operation_status        = s.wms_oub_sch_operation_status,
        oub_sch_picked_qty              = s.wms_oub_sch_picked_qty,
        oub_sch_packed_qty              = s.wms_oub_sch_packed_qty,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_wms_outbound_sch_dtl_h s
   INNER JOIN dwh.F_OutboundHeader sb
    
       ON s.wms_oub_sch_loc_code = sb.oub_loc_code 
    and s.wms_oub_outbound_ord =sb.oub_outbound_ord
    and s.wms_oub_sch_ou = sb.oub_ou
    LEFT JOIN dwh.d_location L      
        ON s.wms_oub_sch_loc_code   = L.loc_code 
        AND s.wms_oub_sch_ou        = L.loc_ou
    LEFT JOIN dwh.d_itemheader C        
    ON s.wms_oub_sch_item_code       = C.itm_code 
    AND s.wms_oub_sch_ou             = C.itm_ou
    WHERE t.oub_sch_loc_code = s.wms_oub_sch_loc_code
    AND t.oub_sch_ou = s.wms_oub_sch_ou
    AND t.oub_outbound_ord = s.wms_oub_outbound_ord
    AND t.oub_sch_amendno = s.wms_oub_sch_amendno
    AND t.oub_sch_lineno = s.wms_oub_sch_lineno
    AND t.oub_item_lineno = s.wms_oub_item_lineno;

      GET DIAGNOSTICS updcnt = ROW_COUNT;
	
-- DELETE from dwh.F_OutboundSchDetailHistory t
-- 	USING stg.stg_wms_outbound_sch_dtl_h s
-- 		where t.oub_sch_loc_code = s.wms_oub_sch_loc_code
--     AND t.oub_sch_ou = s.wms_oub_sch_ou
--     AND t.oub_outbound_ord = s.wms_oub_outbound_ord
--     AND t.oub_sch_amendno = s.wms_oub_sch_amendno
--     AND t.oub_sch_lineno = s.wms_oub_sch_lineno
--     AND t.oub_item_lineno = s.wms_oub_item_lineno;
-- -- 	and COALESCE(fh.oub_modified_date,fh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
 
    INSERT INTO dwh.F_OutboundSchDetailHistory
    (
       obh_hr_his_key,oub_loc_key,oub_itm_key, oub_sch_loc_code, oub_sch_ou, oub_outbound_ord, oub_sch_amendno, oub_sch_lineno, oub_sch_item_code, oub_item_lineno, oub_sch_order_qty, oub_sch_masteruom, oub_sch_deliverydate, oub_sch_serfrom, oub_sch_serto, oub_sch_plan_gd_iss_dt, oub_sch_plan_gd_iss_time, oub_sch_operation_status, oub_sch_picked_qty, oub_sch_packed_qty, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       sb.obh_hr_key,COALESCE(l.loc_key,-1),COALESCE(c.itm_hdr_key,-1), s.wms_oub_sch_loc_code, s.wms_oub_sch_ou, s.wms_oub_outbound_ord, s.wms_oub_sch_amendno, s.wms_oub_sch_lineno, s.wms_oub_sch_item_code, s.wms_oub_item_lineno, s.wms_oub_sch_order_qty, s.wms_oub_sch_masteruom, s.wms_oub_sch_deliverydate, s.wms_oub_sch_serfrom, s.wms_oub_sch_serto, s.wms_oub_sch_plan_gd_iss_dt, s.wms_oub_sch_plan_gd_iss_time, s.wms_oub_sch_operation_status, s.wms_oub_sch_picked_qty, s.wms_oub_sch_packed_qty, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_outbound_sch_dtl_h s

    INNER JOIN dwh.F_OutboundHeader sb
    
    ON s.wms_oub_sch_loc_code = sb.oub_loc_code 
    and s.wms_oub_outbound_ord =sb.oub_outbound_ord
    and s.wms_oub_sch_ou = sb.oub_ou
    LEFT JOIN dwh.d_location L      
        ON s.wms_oub_sch_loc_code   = L.loc_code 
        AND s.wms_oub_sch_ou        = L.loc_ou
    LEFT JOIN dwh.d_itemheader C        
    ON s.wms_oub_sch_item_code       = C.itm_code 
    AND s.wms_oub_sch_ou             = C.itm_ou
    LEFT JOIN dwh.F_OutboundSchDetailHistory t
    ON s.wms_oub_sch_loc_code = t.oub_sch_loc_code
    AND s.wms_oub_sch_ou = t.oub_sch_ou
    AND s.wms_oub_outbound_ord = t.oub_outbound_ord
    AND s.wms_oub_sch_amendno = t.oub_sch_amendno
    AND s.wms_oub_sch_lineno = t.oub_sch_lineno
    AND s.wms_oub_item_lineno = t.oub_item_lineno
    WHERE t.oub_sch_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

--Updating etlactiveind for Deleted source data 

		UPDATE	dwh.F_OutboundSchDetailHistory t1
		SET		etlactiveind		=  0,
				etlupdatedatetime	= Now()::TIMESTAMP
		FROM	dwh.F_OutboundSchDetailHistory t
		LEFT JOIN stg.stg_wms_outbound_sch_dtl_h s
		ON		t.oub_sch_loc_code		= s.wms_oub_sch_loc_code
		AND 	t.oub_sch_ou			= s.wms_oub_sch_ou
		AND 	t.oub_outbound_ord		= s.wms_oub_outbound_ord
		AND 	t.oub_sch_amendno		= s.wms_oub_sch_amendno
		AND 	t.oub_sch_lineno		= s.wms_oub_sch_lineno
		AND 	t.oub_item_lineno		= s.wms_oub_item_lineno
		WHERE	t.obd_sdl_his_key		= t1.obd_sdl_his_key
		AND		COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
		AND		s.wms_oub_sch_loc_code IS NULL;

--Updating etlactiveind for Deleted source data ends;

-- 		update dwh.F_OutboundSchDetailHistory a
-- 		SET 	obh_hr_his_key 		=	b.obh_hr_his_key,
-- 		 		etlupdatedatetime	=	now()
-- 		FROM dwh.F_OutboundHeaderHistory b
-- 		where b.oub_ou			=	a.oub_sch_ou
-- 		AND b.oub_loc_code		=	a.oub_sch_loc_code
-- 		and b.oub_outbound_ord	=	a.oub_outbound_ord
-- 		and b.oub_amendno		=	a.oub_sch_amendno
-- 		and COALESCE(b.oub_modified_date,b.oub_created_date)::DATE>=(CURRENT_DATE - INTERVAL '90 days')::DATE;
		
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_outbound_sch_dtl_h
    (
        wms_oub_sch_loc_code, wms_oub_sch_ou, wms_oub_outbound_ord, wms_oub_sch_amendno, wms_oub_sch_lineno, wms_oub_sch_item_code, wms_oub_item_lineno, wms_oub_sch_order_qty, wms_oub_sch_masteruom, wms_oub_sch_deliverydate, wms_oub_sch_serfrom, wms_oub_sch_serto, wms_oub_sch_plan_gd_iss_dt, wms_oub_sch_plan_gd_iss_time, wms_oub_sch_operation_status, wms_oub_sch_picked_qty, wms_oub_sch_packed_qty, etlcreateddatetime
    )
    SELECT
        wms_oub_sch_loc_code, wms_oub_sch_ou, wms_oub_outbound_ord, wms_oub_sch_amendno, wms_oub_sch_lineno, wms_oub_sch_item_code, wms_oub_item_lineno, wms_oub_sch_order_qty, wms_oub_sch_masteruom, wms_oub_sch_deliverydate, wms_oub_sch_serfrom, wms_oub_sch_serto, wms_oub_sch_plan_gd_iss_dt, wms_oub_sch_plan_gd_iss_time, wms_oub_sch_operation_status, wms_oub_sch_picked_qty, wms_oub_sch_packed_qty, etlcreateddatetime
    FROM stg.stg_wms_outbound_sch_dtl_h;
    
    END IF;
	
	 ELSE    
         p_errorid   := 0;
         select 0 into inscnt;
            select 0 into updcnt;
         select 0 into srccnt;    
         
         IF p_depsource IS NULL
         THEN 
         p_errordesc := 'The Dependent source cannot be NULL.';
         ELSE
         p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
         END IF;
         CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_outboundschdetailhistoryweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
