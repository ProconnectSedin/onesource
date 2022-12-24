-- PROCEDURE: dwh.usp_f_outboundlotsrldetailweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_outboundlotsrldetailweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_outboundlotsrldetailweekly(
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
	p_interval integer;
	

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag ,h.depsource, d.intervaldays
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag ,p_depsource, p_interval
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
    FROM stg.stg_wms_outbound_lot_ser_dtl;

    UPDATE dwh.F_OutboundLotSrlDetail t
    SET
	     obh_hr_key   			   = oh.obh_hr_key,
         oub_loc_key               = COALESCE(l.loc_key,-1),
        oub_itm_key                = COALESCE(c.itm_hdr_key,-1),
        oub_item_code              = s.wms_oub_item_code,
        oub_item_lineno            = s.wms_oub_item_lineno,
        oub_lotsl_order_qty        = s.wms_oub_lotsl_order_qty,
        oub_lotsl_batchno          = s.wms_oub_lotsl_batchno,
        oub_lotsl_serialno         = s.wms_oub_lotsl_serialno,
        oub_lotsl_masteruom        = s.wms_oub_lotsl_masteruom,
        oub_refdocno1              = s.wms_oub_refdocno1,
        oub_refdocno2              = s.wms_oub_refdocno2,
        oub_thu_id                 = s.wms_oub_thu_id,
        oub_thu_srno               = s.wms_oub_thu_srno,
        oub_cus_srno               = s.wms_oub_cus_srno,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_wms_outbound_lot_ser_dtl s
	
	INNER JOIN dwh.f_outboundheader oh
	on  s.wms_oub_lotsl_loc_code = oh.oub_loc_code  
	and s.wms_oub_outbound_ord =oh.oub_outbound_ord 
	and s.wms_oub_lotsl_ou = oh.oub_ou
	 
    LEFT JOIN dwh.d_location L      
        ON s.wms_oub_lotsl_loc_code     = L.loc_code 
        AND s.wms_oub_lotsl_ou        = L.loc_ou

    LEFT JOIN dwh.d_itemheader C        
    ON s.wms_oub_item_code       = C.itm_code 
    AND s.wms_oub_lotsl_ou             = C.itm_ou

    WHERE t.oub_lotsl_loc_code = s.wms_oub_lotsl_loc_code
    AND t.oub_lotsl_ou = s.wms_oub_lotsl_ou
    AND t.oub_outbound_ord = s.wms_oub_outbound_ord
    AND t.oub_lotsl_lineno = s.wms_oub_lotsl_lineno
	AND  t.obh_hr_key   = oh.obh_hr_key;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

/*
	DELETE FROM dwh.F_OutboundLotSrlDetail t
	USING stg.stg_wms_outbound_lot_ser_dtl s
		WHERE s.wms_oub_lotsl_loc_code = t.oub_lotsl_loc_code
    	AND s.wms_oub_lotsl_ou = t.oub_lotsl_ou
    	AND s.wms_oub_outbound_ord = t.oub_outbound_ord
    	AND s.wms_oub_lotsl_lineno = t.oub_lotsl_lineno;
-- 	AND 	COALESCE(fh.oub_modified_date,fh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;	
*/
    INSERT INTO dwh.F_OutboundLotSrlDetail
    (
        obh_hr_key, oub_loc_key , oub_itm_key ,oub_lotsl_loc_code, oub_lotsl_ou, oub_outbound_ord, oub_lotsl_lineno, oub_item_code, oub_item_lineno, oub_lotsl_order_qty, oub_lotsl_batchno, oub_lotsl_serialno, oub_lotsl_masteruom, oub_refdocno1, oub_refdocno2, oub_thu_id, oub_thu_srno, oub_cus_srno, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        oh.obh_hr_key, COALESCE(l.loc_key,-1), COALESCE(c.itm_hdr_key,-1),s.wms_oub_lotsl_loc_code, s.wms_oub_lotsl_ou, s.wms_oub_outbound_ord, s.wms_oub_lotsl_lineno, s.wms_oub_item_code, s.wms_oub_item_lineno, s.wms_oub_lotsl_order_qty, s.wms_oub_lotsl_batchno, s.wms_oub_lotsl_serialno, s.wms_oub_lotsl_masteruom, s.wms_oub_refdocno1, s.wms_oub_refdocno2, s.wms_oub_thu_id, s.wms_oub_thu_srno, s.wms_oub_cus_srno, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_outbound_lot_ser_dtl s
   	INNER JOIN dwh.f_outboundheader oh
	on s.wms_oub_lotsl_ou = oh.oub_ou
	and s.wms_oub_lotsl_loc_code = oh.oub_loc_code
	and s.wms_oub_outbound_ord =oh.oub_outbound_ord 
	 
    LEFT JOIN dwh.d_location L      
        ON s.wms_oub_lotsl_loc_code     = L.loc_code 
        AND s.wms_oub_lotsl_ou        = L.loc_ou

    LEFT JOIN dwh.d_itemheader C        
    ON s.wms_oub_item_code       = C.itm_code 
    AND s.wms_oub_lotsl_ou             = C.itm_ou

    LEFT JOIN dwh.F_OutboundLotSrlDetail t
    ON s.wms_oub_lotsl_loc_code = t.oub_lotsl_loc_code
    AND s.wms_oub_lotsl_ou = t.oub_lotsl_ou
    AND s.wms_oub_outbound_ord = t.oub_outbound_ord
    AND s.wms_oub_lotsl_lineno = t.oub_lotsl_lineno
	AND  t.obh_hr_key   = oh.obh_hr_key
    WHERE t.oub_lotsl_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
-- 	UPDATE dwh.F_OutboundLotSrlDetail t1
-- 	set etlactiveind =  0,
-- 	etlupdatedatetime = Now()::timestamp
-- 	from dwh.F_OutboundLotSrlDetail t
-- 	left join stg.stg_wms_outbound_lot_ser_dtl s
-- 	on t.oub_lotsl_loc_code = s.wms_oub_lotsl_loc_code
--     AND t.oub_lotsl_ou = s.wms_oub_lotsl_ou
--     AND t.oub_outbound_ord = s.wms_oub_outbound_ord
--     AND t.oub_lotsl_lineno = s.wms_oub_lotsl_lineno
-- 	AND t.obh_hr_key= t1.t.obh_hr_key
-- 	where COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
-- 	and s.wms_oub_lotsl_ou is null;
	
	--GET DIAGNOSTICS updcnt = ROW_COUNT;
/*	
	UPDATE dwh.F_OutboundLotSrlDetail od 
	SET obh_hr_key = oh.obh_hr_key,
		etlupdatedatetime          = NOW()
	FROM dwh.f_outboundheader oh 
	WHERE od.oub_lotsl_ou = oh.oub_ou
	AND od.oub_lotsl_loc_code = oh.oub_loc_code  
	and od.oub_outbound_ord =oh.oub_outbound_ord 
	AND COALESCE(oh.oub_modified_date,oh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
		
    select 0 into updcnt;
*/
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_outbound_lot_ser_dtl
    (
        wms_oub_lotsl_loc_code, wms_oub_lotsl_ou, wms_oub_outbound_ord, wms_oub_lotsl_lineno, wms_oub_item_code, wms_oub_item_lineno, wms_oub_lotsl_order_qty, wms_oub_lotsl_batchno, wms_oub_lotsl_serialno, wms_oub_lotsl_masteruom, wms_oub_refdocno1, wms_oub_refdocno2, wms_oub_thu_id, wms_oub_thu_srno, wms_oub_cus_srno, etlcreateddatetime
    )
    SELECT
        wms_oub_lotsl_loc_code, wms_oub_lotsl_ou, wms_oub_outbound_ord, wms_oub_lotsl_lineno, wms_oub_item_code, wms_oub_item_lineno, wms_oub_lotsl_order_qty, wms_oub_lotsl_batchno, wms_oub_lotsl_serialno, wms_oub_lotsl_masteruom, wms_oub_refdocno1, wms_oub_refdocno2, wms_oub_thu_id, wms_oub_thu_srno, wms_oub_cus_srno, etlcreateddatetime
    FROM stg.stg_wms_outbound_lot_ser_dtl;
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
ALTER PROCEDURE dwh.usp_f_outboundlotsrldetailweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
