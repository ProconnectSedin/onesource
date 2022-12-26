CREATE OR REPLACE PROCEDURE dwh.usp_f_contracttransferinvoiceheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_contract_transfer_inv_hdr;

    UPDATE dwh.f_contracttransferinvoiceheader t
    SET
        cont_transfer_inv_date             = s.wms_cont_transfer_inv_date,
        cont_inv_no                        = s.wms_cont_inv_no,
        cont_inv_date                      = s.wms_cont_inv_date,
        cont_flag                          = s.wms_cont_flag,
        cont_timestamp                     = s.wms_cont_timestamp,
        cont_created_by                    = s.wms_cont_created_by,
        cont_created_dt                    = s.wms_cont_created_dt,
        cont_modified_by                   = s.wms_cont_modified_by,
        cont_modified_dt                   = s.wms_cont_modified_dt,
        cont_tran_type                     = s.wms_cont_tran_type,
        cont_rcti_flag                     = s.wms_cont_rcti_flag,
        cont_billing_profile               = s.wms_cont_billing_profile,
        cont_transfer_received_by          = s.wms_cont_transfer_received_by,
        cont_transfer_date_received        = s.wms_cont_transfer_date_received,
        cont_transfer_inv_value            = s.wms_cont_transfer_inv_value,
        etlactiveind                       = 1,
        etljobname                         = p_etljobname,
        envsourcecd                        = p_envsourcecd,
        datasourcecd                       = p_datasourcecd,
        etlupdatedatetime                  = NOW()
    FROM stg.stg_wms_contract_transfer_inv_hdr s
    WHERE t.cont_transfer_inv_no	= s.wms_cont_transfer_inv_no
    AND t.cont_transfer_inv_ou		= s.wms_cont_transfer_inv_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_contracttransferinvoiceheader
    (
        cont_transfer_inv_no, cont_transfer_inv_ou, cont_transfer_inv_date, cont_inv_no, cont_inv_date, cont_flag, cont_timestamp, 
		cont_created_by, cont_created_dt, cont_modified_by, cont_modified_dt, cont_tran_type, cont_rcti_flag, cont_billing_profile, 
		cont_transfer_received_by, cont_transfer_date_received, cont_transfer_inv_value, etlactiveind, etljobname, envsourcecd, 
		datasourcecd, etlcreatedatetime
    )

    SELECT
        s.wms_cont_transfer_inv_no, s.wms_cont_transfer_inv_ou, s.wms_cont_transfer_inv_date, s.wms_cont_inv_no, s.wms_cont_inv_date, s.wms_cont_flag, s.wms_cont_timestamp,
		s.wms_cont_created_by, s.wms_cont_created_dt, s.wms_cont_modified_by, s.wms_cont_modified_dt, s.wms_cont_tran_type, s.wms_cont_rcti_flag, s.wms_cont_billing_profile,
		s.wms_cont_transfer_received_by, s.wms_cont_transfer_date_received, s.wms_cont_transfer_inv_value, 1, p_etljobname, p_envsourcecd,
		p_datasourcecd, NOW()
    FROM stg.stg_wms_contract_transfer_inv_hdr s
    LEFT JOIN dwh.f_contracttransferinvoiceheader t
    ON s.wms_cont_transfer_inv_no = t.cont_transfer_inv_no
    AND s.wms_cont_transfer_inv_ou = t.cont_transfer_inv_ou
    WHERE t.cont_transfer_inv_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    INSERT INTO raw.raw_wms_contract_transfer_inv_hdr
    (
        wms_cont_transfer_inv_no, wms_cont_transfer_inv_ou, wms_cont_transfer_inv_date, wms_cont_inv_no, wms_cont_inv_date, wms_cont_flag, 
		wms_cont_timestamp, wms_cont_created_by, wms_cont_created_dt, wms_cont_modified_by, wms_cont_modified_dt, wms_cont_tran_type, 
		wms_cont_rcti_flag, wms_cont_billing_profile, wms_cont_transfer_received_by, wms_cont_transfer_date_received, 
		wms_cont_transfer_inv_value, etlcreateddatetime
    )
    SELECT
        wms_cont_transfer_inv_no, wms_cont_transfer_inv_ou, wms_cont_transfer_inv_date, wms_cont_inv_no, wms_cont_inv_date, wms_cont_flag, 
		wms_cont_timestamp, wms_cont_created_by, wms_cont_created_dt, wms_cont_modified_by, wms_cont_modified_dt, wms_cont_tran_type,
		wms_cont_rcti_flag, wms_cont_billing_profile, wms_cont_transfer_received_by, wms_cont_transfer_date_received, 
		wms_cont_transfer_inv_value, etlcreateddatetime
    FROM stg.stg_wms_contract_transfer_inv_hdr;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;