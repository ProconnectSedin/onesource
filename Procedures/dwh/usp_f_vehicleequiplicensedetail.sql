CREATE PROCEDURE dwh.usp_f_vehicleequiplicensedetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_tms_vrvel_veh_eqp_license_dtl;

    UPDATE dwh.F_VehicleEquipLicenseDetail t
    SET
        vrvel_vendor_key                 = COALESCE(v.vendor_key,-1),
        vrvel_ouinstance                = s.vrvel_ouinstance,
        vrvel_tend_req_no               = s.vrvel_tend_req_no,
        vrvel_line_no                   = s.vrvel_line_no,
        vrvel_resp_line_no              = s.vrvel_resp_line_no,
        vrvel_license_plate_no          = s.vrvel_license_plate_no,
        vrvel_created_by                = s.vrvel_created_by,
        vrvel_created_date              = s.vrvel_created_date,
        vrvel_last_modified_by          = s.vrvel_last_modified_by,
        vrvel_last_modified_date        = s.vrvel_last_modified_date,
        vrvel_timestamp                 = s.vrvel_timestamp,
        vrvel_is_assigned               = s.vrvel_is_assigned,
        vrvel_tend_rpt_dt_time          = s.vrvel_tend_rpt_dt_time,
        vrvel_tend_cont_person1         = s.vrvel_tend_cont_person1,
        vrvel_tend_cont_det1            = s.vrvel_tend_cont_det1,
        vrvel_tend_cont_person2         = s.vrvel_tend_cont_person2,
        vrvel_tend_cont_det2            = s.vrvel_tend_cont_det2,
        vrvel_vendor_id                 = s.vrvel_vendor_id,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_tms_vrvel_veh_eqp_license_dtl s
    LEFT JOIN dwh.d_vendor v       
        ON  s.vrvel_vendor_id           = v.vendor_id 
        AND s.vrvel_ouinstance           = v.vendor_ou
    WHERE t.vrvel_ouinstance = s.vrvel_ouinstance
    AND t.vrvel_tend_req_no = s.vrvel_tend_req_no
    AND t.vrvel_line_no = s.vrvel_line_no
    AND t.vrvel_resp_line_no = s.vrvel_resp_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_VehicleEquipLicenseDetail
    (
        vrvel_vendor_key, vrvel_ouinstance, vrvel_tend_req_no, vrvel_line_no, vrvel_resp_line_no, vrvel_license_plate_no, vrvel_created_by, vrvel_created_date, vrvel_last_modified_by, vrvel_last_modified_date, vrvel_timestamp, vrvel_is_assigned, vrvel_tend_rpt_dt_time, vrvel_tend_cont_person1, vrvel_tend_cont_det1, vrvel_tend_cont_person2, vrvel_tend_cont_det2, vrvel_vendor_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(v.vendor_key,-1), s.vrvel_ouinstance, s.vrvel_tend_req_no, s.vrvel_line_no, s.vrvel_resp_line_no, s.vrvel_license_plate_no, s.vrvel_created_by, s.vrvel_created_date, s.vrvel_last_modified_by, s.vrvel_last_modified_date, s.vrvel_timestamp, s.vrvel_is_assigned, s.vrvel_tend_rpt_dt_time, s.vrvel_tend_cont_person1, s.vrvel_tend_cont_det1, s.vrvel_tend_cont_person2, s.vrvel_tend_cont_det2, s.vrvel_vendor_id, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_vrvel_veh_eqp_license_dtl s
     LEFT JOIN dwh.d_vendor v       
        ON  s.vrvel_vendor_id           = v.vendor_id 
        AND s.vrvel_ouinstance           = v.vendor_ou
    LEFT JOIN dwh.F_VehicleEquipLicenseDetail t
    ON s.vrvel_ouinstance = t.vrvel_ouinstance
    AND s.vrvel_tend_req_no = t.vrvel_tend_req_no
    AND s.vrvel_line_no = t.vrvel_line_no
    AND s.vrvel_resp_line_no = t.vrvel_resp_line_no
    WHERE t.vrvel_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_vrvel_veh_eqp_license_dtl
    (
        vrvel_ouinstance, vrvel_tend_req_no, vrvel_line_no, vrvel_resp_line_no, vrvel_license_plate_no, vrvel_created_by, vrvel_created_date, vrvel_last_modified_by, vrvel_last_modified_date, vrvel_timestamp, vrvel_is_assigned, vrvel_tend_rpt_dt_time, vrvel_tend_cont_person1, vrvel_tend_cont_det1, vrvel_tend_cont_person2, vrvel_tend_cont_det2, vrvel_vendor_id, etlcreateddatetime
    )
    SELECT
        vrvel_ouinstance, vrvel_tend_req_no, vrvel_line_no, vrvel_resp_line_no, vrvel_license_plate_no, vrvel_created_by, vrvel_created_date, vrvel_last_modified_by, vrvel_last_modified_date, vrvel_timestamp, vrvel_is_assigned, vrvel_tend_rpt_dt_time, vrvel_tend_cont_person1, vrvel_tend_cont_det1, vrvel_tend_cont_person2, vrvel_tend_cont_det2, vrvel_vendor_id, etlcreateddatetime
    FROM stg.stg_tms_vrvel_veh_eqp_license_dtl;
    
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