-- PROCEDURE: dwh.usp_f_ainvassettransferoutdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ainvassettransferoutdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ainvassettransferoutdtl(
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
    FROM stg.Stg_ainv_asset_transfer_out_dtl;

    UPDATE dwh.F_ainvassettransferoutdtl t
    SET
	    ainvassettransferouthdr_key   = fh.ainvassettransferouthdr_key,
        tran_type               = s.tran_type,
        tran_ou                 = s.tran_ou,
        tran_no                 = s.tran_no,
        fb                      = s.fb,
        asset_number            = s.asset_number,
        tag_number              = s.tag_number,
        recv_loc_code           = s.recv_loc_code,
        recv_cost_center        = s.recv_cost_center,
        asset_loc_code          = s.asset_loc_code,
        cost_center             = s.cost_center,
        confirm_date            = s.confirm_date,
        confirm_status          = s.confirm_status,
        dest_ouid               = s.dest_ouid,
        book_value              = s.book_value,
        exchange_rate           = s.exchange_rate,
        tran_currency           = s.tran_currency,
        remarks                 = s.remarks,
        line_no                 = s.line_no,
        transfer_in_no          = s.transfer_in_no,
        transfer_in_ou          = s.transfer_in_ou,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.Stg_ainv_asset_transfer_out_dtl s
	INNER JOIN 	dwh.f_ainvassettransferouthdr fh 
			ON  s.tran_type 				= fh.tran_type 
			AND s.tran_ou 			= fh.tran_ou 
			AND s.tran_no 				= fh.tran_no
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.fb = s.fb
    AND t.asset_number = s.asset_number
    AND t.tag_number = s.tag_number
    AND t.line_no = s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ainvassettransferoutdtl
    (
       ainvassettransferouthdr_key, tran_type, tran_ou, tran_no, fb, asset_number, tag_number, recv_loc_code, recv_cost_center, asset_loc_code, cost_center, confirm_date, confirm_status, dest_ouid, book_value, exchange_rate, tran_currency, remarks, line_no, transfer_in_no, transfer_in_ou, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      fh.ainvassettransferouthdr_key , s.tran_type, s.tran_ou, s.tran_no, s.fb, s.asset_number, s.tag_number, s.recv_loc_code, s.recv_cost_center, s.asset_loc_code, s.cost_center, s.confirm_date, s.confirm_status, s.dest_ouid, s.book_value, s.exchange_rate, s.tran_currency, s.remarks, s.line_no, s.transfer_in_no, s.transfer_in_ou, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_ainv_asset_transfer_out_dtl s
	INNER JOIN 	dwh.f_ainvassettransferouthdr fh 
			ON  s.tran_type 				= fh.tran_type 
			AND s.tran_ou 			= fh.tran_ou 
			AND s.tran_no 				= fh.tran_no
    LEFT JOIN dwh.F_ainvassettransferoutdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.fb = t.fb
    AND s.asset_number = t.asset_number
    AND s.tag_number = t.tag_number
    AND s.line_no = t.line_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ainv_asset_transfer_out_dtl
    (
        tran_type, tran_ou, tran_no, fb, asset_number, tag_number, recv_loc_code, recv_cost_center, asset_loc_code, cost_center, confirm_date, confirm_status, dest_ouid, book_value, par_base_book_value, exchange_rate, par_exchange_rate, tran_currency, remarks, line_no, transfer_in_no, transfer_in_ou, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, fb, asset_number, tag_number, recv_loc_code, recv_cost_center, asset_loc_code, cost_center, confirm_date, confirm_status, dest_ouid, book_value, par_base_book_value, exchange_rate, par_exchange_rate, tran_currency, remarks, line_no, transfer_in_no, transfer_in_ou, etlcreateddatetime
    FROM stg.Stg_ainv_asset_transfer_out_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_ainvassettransferoutdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
