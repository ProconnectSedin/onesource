-- PROCEDURE: dwh.usp_f_ainvassettransferouthdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ainvassettransferouthdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ainvassettransferouthdr(
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
    FROM stg.Stg_ainv_asset_transfer_out_hdr;

    UPDATE dwh.F_ainvassettransferouthdr t
    SET
        tran_type                    = s.tran_type,
        tran_ou                      = s.tran_ou,
        tran_no                      = s.tran_no,
        no_type                      = s.no_type,
        status                       = s.status,
        confirm_reqd                 = s.confirm_reqd,
        transfer_date                = s.transfer_date,
        tcal_status                  = s.tcal_status,
        tcal_exclusive_amt           = s.tcal_exclusive_amt,
        transfer_in_no               = s.transfer_in_no,
        receipt_date                 = s.receipt_date,
        transfer_in_status           = s.transfer_in_status,
        tcal_status_in               = s.tcal_status_in,
        tcal_exclusive_amt_in        = s.tcal_exclusive_amt_in,
        timestamp                    = s.timestamp,
        no_type_in                   = s.no_type_in,
        createdby                    = s.createdby,
        createddate                  = s.createddate,
        modifiedby                   = s.modifiedby,
        modifieddate                 = s.modifieddate,
        transfer_in_ou               = s.transfer_in_ou,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.Stg_ainv_asset_transfer_out_hdr s
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ainvassettransferouthdr
    (
        tran_type, tran_ou, tran_no, no_type, status, confirm_reqd, transfer_date, tcal_status, tcal_exclusive_amt, transfer_in_no, receipt_date, transfer_in_status, tcal_status_in, tcal_exclusive_amt_in, timestamp, no_type_in, createdby, createddate, modifiedby, modifieddate, transfer_in_ou, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.no_type, s.status, s.confirm_reqd, s.transfer_date, s.tcal_status, s.tcal_exclusive_amt, s.transfer_in_no, s.receipt_date, s.transfer_in_status, s.tcal_status_in, s.tcal_exclusive_amt_in, s.timestamp, s.no_type_in, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.transfer_in_ou, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_ainv_asset_transfer_out_hdr s
    LEFT JOIN dwh.F_ainvassettransferouthdr t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ainv_asset_transfer_out_hdr
    (
        tran_type, tran_ou, tran_no, no_type, status, confirm_reqd, tax_amount, transfer_date, tcal_status, tcal_exclusive_amt, total_tcal_amount, transfer_in_no, receipt_date, transfer_in_status, tcal_status_in, tcal_exclusive_amt_in, total_tcal_amount_in, timestamp, no_type_in, createdby, createddate, modifiedby, modifieddate, transfer_in_ou, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, no_type, status, confirm_reqd, tax_amount, transfer_date, tcal_status, tcal_exclusive_amt, total_tcal_amount, transfer_in_no, receipt_date, transfer_in_status, tcal_status_in, tcal_exclusive_amt_in, total_tcal_amount_in, timestamp, no_type_in, createdby, createddate, modifiedby, modifieddate, transfer_in_ou, etlcreateddatetime
    FROM stg.Stg_ainv_asset_transfer_out_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_ainvassettransferouthdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
