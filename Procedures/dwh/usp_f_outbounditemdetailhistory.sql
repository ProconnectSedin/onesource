-- PROCEDURE: dwh.usp_f_outbounditemdetailhistory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_outbounditemdetailhistory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_outbounditemdetailhistory(
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

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
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
    FROM stg.stg_wms_outbound_item_detail_h;

    UPDATE dwh.F_OutboundItemDetailHistory t
    SET
        obh_hr_his_key                =sb.obh_hr_his_key,
        obd_itm_key                   = COALESCE(l.itm_hdr_key,-1),
        obd_loc_key                   = COALESCE(c.loc_key,-1), 
        oub_item_code                 = s.wms_oub_item_code,
        oub_itm_order_qty             = s.wms_oub_itm_order_qty,
        oub_itm_sch_type              = s.wms_oub_itm_sch_type,
        oub_itm_balqty                = s.wms_oub_itm_balqty,
        oub_itm_issueqty              = s.wms_oub_itm_issueqty,
        oub_itm_processqty            = s.wms_oub_itm_processqty,
        oub_itm_masteruom             = s.wms_oub_itm_masteruom,
        oub_itm_deliverydate          = s.wms_oub_itm_deliverydate,
        oub_itm_serfrom               = s.wms_oub_itm_serfrom,
        oub_itm_serto                 = s.wms_oub_itm_serto,
        oub_itm_plan_gd_iss_dt        = s.wms_oub_itm_plan_gd_iss_dt,
        oub_itm_plan_dt_iss           = s.wms_oub_itm_plan_dt_iss,
        oub_itm_sub_rules             = s.wms_oub_itm_sub_rules,
        oub_itm_pack_remarks          = s.wms_oub_itm_pack_remarks,
        oub_itm_su                    = s.wms_oub_itm_su,
        oub_itm_uid_serial_no         = s.wms_oub_itm_uid_serial_no,
        oub_itm_cancel                = s.wms_oub_itm_cancel,
        oub_itm_cancel_code           = s.wms_oub_itm_cancel_code,
        oub_itm_wave_no               = s.wms_oub_itm_wave_no,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_wms_outbound_item_detail_h s
     
        INNER JOIN dwh.F_OutboundHeaderHistory sb
    
       ON s.wms_oub_itm_loc_code = sb.oub_loc_code 
    and s.wms_oub_outbound_ord =sb.oub_outbound_ord
    and s.wms_oub_itm_ou = sb.oub_ou
    and s.wms_oub_itm_amendno=sb.oub_amendno

    LEFT JOIN dwh.d_itemheader L        
        ON s.wms_oub_item_code       = L.itm_code 
        AND s.wms_oub_itm_ou      = L.itm_ou

    LEFT JOIN dwh.d_location C      
        ON s.wms_oub_itm_loc_code  = C.loc_code 
        AND s.wms_oub_itm_ou        = C.loc_ou

    WHERE t.oub_itm_loc_code = s.wms_oub_itm_loc_code
    AND t.oub_itm_ou = s.wms_oub_itm_ou
    AND t.oub_outbound_ord = s.wms_oub_outbound_ord
    AND t.oub_itm_amendno = s.wms_oub_itm_amendno
    AND t.oub_itm_lineno = s.wms_oub_itm_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

-- 	DELETE FROM dwh.F_OutboundItemDetailHistory t
-- 	USING stg.stg_wms_outbound_item_detail_h s
-- 		WHERE t.oub_itm_loc_code = s.wms_oub_itm_loc_code
--     AND t.oub_itm_ou = s.wms_oub_itm_ou
--     AND t.oub_outbound_ord = s.wms_oub_outbound_ord
--     AND t.oub_itm_amendno = s.wms_oub_itm_amendno
--     AND t.oub_itm_lineno = s.wms_oub_itm_lineno;
-- -- 	AND 	COALESCE(fh.oub_modified_date,fh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;	

    INSERT INTO dwh.F_OutboundItemDetailHistory
    (
        obh_hr_his_key ,obd_itm_key,obd_loc_key, oub_itm_loc_code, oub_itm_ou, oub_outbound_ord, oub_itm_amendno, oub_itm_lineno, oub_item_code, oub_itm_order_qty, oub_itm_sch_type, oub_itm_balqty, oub_itm_issueqty, oub_itm_processqty, oub_itm_masteruom, oub_itm_deliverydate, oub_itm_serfrom, oub_itm_serto, oub_itm_plan_gd_iss_dt, oub_itm_plan_dt_iss, oub_itm_sub_rules, oub_itm_pack_remarks, oub_itm_su, oub_itm_uid_serial_no, oub_itm_cancel, oub_itm_cancel_code, oub_itm_wave_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        sb.obh_hr_his_key, COALESCE(l.itm_hdr_key,-1),COALESCE(c.loc_key,-1),s.wms_oub_itm_loc_code, s.wms_oub_itm_ou, s.wms_oub_outbound_ord, s.wms_oub_itm_amendno, s.wms_oub_itm_lineno, s.wms_oub_item_code, s.wms_oub_itm_order_qty, s.wms_oub_itm_sch_type, s.wms_oub_itm_balqty, s.wms_oub_itm_issueqty, s.wms_oub_itm_processqty, s.wms_oub_itm_masteruom, s.wms_oub_itm_deliverydate, s.wms_oub_itm_serfrom, s.wms_oub_itm_serto, s.wms_oub_itm_plan_gd_iss_dt, s.wms_oub_itm_plan_dt_iss, s.wms_oub_itm_sub_rules, s.wms_oub_itm_pack_remarks, s.wms_oub_itm_su, s.wms_oub_itm_uid_serial_no, s.wms_oub_itm_cancel, s.wms_oub_itm_cancel_code, s.wms_oub_itm_wave_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_outbound_item_detail_h s
    
     INNER JOIN dwh.F_OutboundHeaderHistory sb
    
       ON s.wms_oub_itm_loc_code = sb.oub_loc_code 
    and s.wms_oub_outbound_ord =sb.oub_outbound_ord
    and s.wms_oub_itm_ou = sb.oub_ou
    and s.wms_oub_itm_amendno=sb.oub_amendno

    LEFT JOIN dwh.d_itemheader L        
        ON s.wms_oub_item_code       = L.itm_code 
        AND s.wms_oub_itm_ou      = L.itm_ou

    LEFT JOIN dwh.d_location C      
        ON s.wms_oub_itm_loc_code  = C.loc_code 
        AND s.wms_oub_itm_ou        = C.loc_ou

    LEFT JOIN dwh.F_OutboundItemDetailHistory t
    ON s.wms_oub_itm_loc_code = t.oub_itm_loc_code
    AND s.wms_oub_itm_ou = t.oub_itm_ou
    AND s.wms_oub_outbound_ord = t.oub_outbound_ord
    AND s.wms_oub_itm_amendno = t.oub_itm_amendno
    AND s.wms_oub_itm_lineno = t.oub_itm_lineno
    WHERE t.oub_itm_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	UPDATE dwh.F_OutboundItemDetailHistory od 
	SET obh_hr_his_key = oh.obh_hr_his_key,
		etlupdatedatetime             = NOW()
	FROM dwh.F_OutboundHeaderHistory oh 
	WHERE od.oub_itm_ou = oh.oub_ou 
	and od.oub_itm_loc_code = oh.oub_loc_code 
	and od.oub_outbound_ord =oh.oub_outbound_ord 
	and od.oub_itm_amendno=oh.oub_amendno
	AND COALESCE(oh.oub_modified_date,oh.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
	

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_outbound_item_detail_h
    (
        wms_oub_itm_loc_code, wms_oub_itm_ou, wms_oub_outbound_ord, wms_oub_itm_amendno, wms_oub_itm_lineno, wms_oub_item_code, wms_oub_itm_order_qty, wms_oub_itm_sch_type, wms_oub_itm_balqty, wms_oub_itm_issueqty, wms_oub_itm_processqty, wms_oub_itm_masteruom, wms_oub_itm_deliverydate, wms_oub_itm_serfrom, wms_oub_itm_serto, wms_oub_itm_plan_gd_iss_dt, wms_oub_itm_plan_dt_iss, wms_oub_itm_sub_rules, wms_oub_itm_pack_remarks, wms_oub_itm_su, wms_oub_itm_uid_serial_no, wms_oub_itm_cancel, wms_oub_itm_cancel_code, wms_oub_itm_wave_no, etlcreateddatetime
    )
    SELECT
        wms_oub_itm_loc_code, wms_oub_itm_ou, wms_oub_outbound_ord, wms_oub_itm_amendno, wms_oub_itm_lineno, wms_oub_item_code, wms_oub_itm_order_qty, wms_oub_itm_sch_type, wms_oub_itm_balqty, wms_oub_itm_issueqty, wms_oub_itm_processqty, wms_oub_itm_masteruom, wms_oub_itm_deliverydate, wms_oub_itm_serfrom, wms_oub_itm_serto, wms_oub_itm_plan_gd_iss_dt, wms_oub_itm_plan_dt_iss, wms_oub_itm_sub_rules, wms_oub_itm_pack_remarks, wms_oub_itm_su, wms_oub_itm_uid_serial_no, wms_oub_itm_cancel, wms_oub_itm_cancel_code, wms_oub_itm_wave_no, etlcreateddatetime
    FROM stg.stg_wms_outbound_item_detail_h;
    
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
ALTER PROCEDURE dwh.usp_f_outbounditemdetailhistory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
