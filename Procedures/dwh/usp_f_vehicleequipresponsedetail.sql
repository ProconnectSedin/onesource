CREATE OR REPLACE PROCEDURE dwh.usp_f_vehicleequipresponsedetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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
    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_vrve_veh_eqp_response_dtl;

    UPDATE dwh.F_VehicleEquipResponseDetail t
    SET
        vrve_vendor_key              = COALESCE(v.vendor_key,-1),
        vrve_ouinstance                = s.vrve_ouinstance,
        vrve_tend_req_no               = s.vrve_tend_req_no,
        vrve_line_no                   = s.vrve_line_no,
        vrve_vendor_id                 = s.vrve_vendor_id,
        vrve_resp_status               = s.vrve_resp_status,
        vrve_resp_for                  = s.vrve_resp_for,
        vrve_type                      = s.vrve_type,
        vrve_req_qty                   = s.vrve_req_qty,
        vrve_vend_ref_no               = s.vrve_vend_ref_no,
        vrve_vend_ref_date             = s.vrve_vend_ref_date,
        vrve_contract_id               = s.vrve_contract_id,
        vrve_confirm_status            = s.vrve_confirm_status,
        vrve_confirm_qty               = s.vrve_confirm_qty,
        vrve_rate                      = s.vrve_rate,
        vrve_created_by                = s.vrve_created_by,
        vrve_created_date              = s.vrve_created_date,
        vrve_last_modified_by          = s.vrve_last_modified_by,
        vrve_last_modified_date        = s.vrve_last_modified_date,
        vrve_confirm_price             = s.vrve_confirm_price,
        vrve_confirm_date              = s.vrve_confirm_date,
        vrve_rpt_date_time             = s.vrve_rpt_date_time,
        vrvel_remarks                  = s.vrvel_remarks,
        vrvel_reject_code              = s.vrvel_reject_code,
        vrve_for_period                = s.vrve_for_period,
        vrve_period_uom                = s.vrve_period_uom,
        vrve_from_geo                  = s.vrve_from_geo,
        vrve_from_geo_type             = s.vrve_from_geo_type,
        vrve_to_geo                    = s.vrve_to_geo,
        vrve_to_geo_type               = s.vrve_to_geo_type,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_tms_vrve_veh_eqp_response_dtl s
    LEFT JOIN dwh.d_vendor v       
        ON  s.vrve_vendor_id         = v.vendor_id 
        AND s.vrve_ouinstance        = v.vendor_ou
    WHERE t.vrve_ouinstance = s.vrve_ouinstance
    AND t.vrve_tend_req_no = s.vrve_tend_req_no
    AND t.vrve_line_no = s.vrve_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_VehicleEquipResponseDetail
    (
         vrve_vendor_key,vrve_ouinstance, vrve_tend_req_no, vrve_line_no, vrve_vendor_id, vrve_resp_status, vrve_resp_for, vrve_type, vrve_req_qty, vrve_vend_ref_no, vrve_vend_ref_date, vrve_contract_id, vrve_confirm_status, vrve_confirm_qty, vrve_rate, vrve_created_by, vrve_created_date, vrve_last_modified_by, vrve_last_modified_date, vrve_confirm_price, vrve_confirm_date, vrve_rpt_date_time, vrvel_remarks, vrvel_reject_code, vrve_for_period, vrve_period_uom, vrve_from_geo, vrve_from_geo_type, vrve_to_geo, vrve_to_geo_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
         COALESCE(v.vendor_key,-1) ,s.vrve_ouinstance, s.vrve_tend_req_no, s.vrve_line_no, s.vrve_vendor_id, s.vrve_resp_status, s.vrve_resp_for, s.vrve_type, s.vrve_req_qty, s.vrve_vend_ref_no, s.vrve_vend_ref_date, s.vrve_contract_id, s.vrve_confirm_status, s.vrve_confirm_qty, s.vrve_rate, s.vrve_created_by, s.vrve_created_date, s.vrve_last_modified_by, s.vrve_last_modified_date, s.vrve_confirm_price, s.vrve_confirm_date, s.vrve_rpt_date_time, s.vrvel_remarks, s.vrvel_reject_code, s.vrve_for_period, s.vrve_period_uom, s.vrve_from_geo, s.vrve_from_geo_type, s.vrve_to_geo, s.vrve_to_geo_type, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_vrve_veh_eqp_response_dtl s
     LEFT JOIN dwh.d_vendor v       
        ON  s.vrve_vendor_id         = v.vendor_id 
        AND s.vrve_ouinstance        = v.vendor_ou
    LEFT JOIN dwh.F_VehicleEquipResponseDetail t
    ON s.vrve_ouinstance = t.vrve_ouinstance
    AND s.vrve_tend_req_no = t.vrve_tend_req_no
    AND s.vrve_line_no = t.vrve_line_no
    WHERE t.vrve_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_vrve_veh_eqp_response_dtl
    (
        vrve_ouinstance, vrve_tend_req_no, vrve_line_no, vrve_vendor_id, vrve_resp_status, vrve_resp_for, vrve_type, vrve_req_qty, vrve_vend_ref_no, vrve_vend_ref_date, vrve_contract_id, vrve_confirm_status, vrve_confirm_qty, vrve_rate, vrve_created_by, vrve_created_date, vrve_last_modified_by, vrve_last_modified_date, vrve_timestamp, vrve_confirm_price, vrve_confirm_date, vrve_rpt_date_time, vrvel_remarks, vrvel_reject_code, vrve_for_period, vrve_period_uom, vrve_from_geo, vrve_from_geo_type, vrve_to_geo, vrve_to_geo_type, etlcreateddatetime
    )
    SELECT
        vrve_ouinstance, vrve_tend_req_no, vrve_line_no, vrve_vendor_id, vrve_resp_status, vrve_resp_for, vrve_type, vrve_req_qty, vrve_vend_ref_no, vrve_vend_ref_date, vrve_contract_id, vrve_confirm_status, vrve_confirm_qty, vrve_rate, vrve_created_by, vrve_created_date, vrve_last_modified_by, vrve_last_modified_date, vrve_timestamp, vrve_confirm_price, vrve_confirm_date, vrve_rpt_date_time, vrvel_remarks, vrvel_reject_code, vrve_for_period, vrve_period_uom, vrve_from_geo, vrve_from_geo_type, vrve_to_geo, vrve_to_geo_type, etlcreateddatetime
    FROM stg.stg_tms_vrve_veh_eqp_response_dtl;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;