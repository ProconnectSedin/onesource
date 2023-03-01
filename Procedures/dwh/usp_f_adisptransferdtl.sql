-- PROCEDURE: dwh.usp_f_adisptransferdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_adisptransferdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_adisptransferdtl(
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
    FROM stg.Stg_adisp_transfer_dtl;

    UPDATE dwh.f_adisptransferdtl t
    SET
        timestamp                    = s.timestamp,
        asset_grp                    = s.asset_grp,
        asset_class                  = s.asset_class,
        asset_location               = s.asset_location,
        cost_center                  = s.cost_center,
        asset_cost                   = s.asset_cost,
        cum_depr_amount              = s.cum_depr_amount,
        asset_book_value             = s.asset_book_value,
        remarks                      = s.remarks,
        receiving_location           = s.receiving_location,
        receiving_cost_center        = s.receiving_cost_center,
        receipt_remarks              = s.receipt_remarks,
        transfer_status              = s.transfer_status,
        createdby                    = s.createdby,
        createddate                  = s.createddate,
        modifiedby                   = s.modifiedby,
        modifieddate                 = s.modifieddate,
        line_no                      = s.line_no,
        transfer_in_no               = s.transfer_in_no,
        exchange_rate                = s.exchange_rate,
        tran_currency                = s.tran_currency,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.Stg_adisp_transfer_dtl s
    WHERE t.transfer_number 		 = s.transfer_number
    AND   t.ou_id 					 = s.ou_id
    AND   t.asset_number 			 = s.asset_number
    AND   t.tag_number 				 = s.tag_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_adisptransferdtl
    (
        transfer_number,    ou_id, 				asset_number, 		tag_number, 		timestamp, 
		asset_grp, 			asset_class, 		asset_location, 	cost_center, 		asset_cost, 
		cum_depr_amount, 	asset_book_value, 	remarks, 			receiving_location, receiving_cost_center, 
		receipt_remarks, 	transfer_status, 	createdby, 			createddate, 		modifiedby, 
		modifieddate, 		line_no, 			transfer_in_no, 	exchange_rate, 		tran_currency, 
		etlactiveind, 		etljobname, 		envsourcecd, 		datasourcecd, 		etlcreatedatetime
    )

    SELECT
        s.transfer_number, 	s.ou_id, 			s.asset_number, 	s.tag_number, 			s.timestamp, 
		s.asset_grp, 		s.asset_class, 		s.asset_location, 	s.cost_center, 			s.asset_cost, 
		s.cum_depr_amount, 	s.asset_book_value, s.remarks, 			s.receiving_location, 	s.receiving_cost_center, 
		s.receipt_remarks, 	s.transfer_status, 	s.createdby, 		s.createddate, 			s.modifiedby, 
		s.modifieddate, 	s.line_no, 			s.transfer_in_no, 	s.exchange_rate, 		s.tran_currency, 
		1, 					p_etljobname, 		p_envsourcecd, 		p_datasourcecd, 		NOW()
    FROM stg.Stg_adisp_transfer_dtl s
    LEFT JOIN dwh.f_adisptransferdtl t
    ON  s.transfer_number = t.transfer_number
    AND s.ou_id 		  = t.ou_id
    AND s.asset_number 	  = t.asset_number
    AND s.tag_number 	  = t.tag_number
    WHERE t.transfer_number IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adisp_transfer_dtl
    (
        transfer_number, 	ou_id, 				asset_number, 		tag_number, 			timestamp, 
		asset_grp, 			asset_class, 		asset_location, 	cost_center,		  	asset_cost, 
		cum_depr_amount, 	asset_book_value, 	remarks, 			receiving_location, 	receiving_cost_center, 
		receipt_remarks, 	transfer_status, 	createdby, 			createddate, 			modifiedby, 
		modifieddate, 		line_no, 			transfer_in_no, 	transfer_in_status, 	par_base_book_value, 
		exchange_rate, 		par_exchange_rate, 	tran_currency, 		etlcreateddatetime
    )
    SELECT
        transfer_number, 	ou_id, 				asset_number, 		tag_number, 			timestamp, 
		asset_grp, 			asset_class, 		asset_location, 	cost_center,		  	asset_cost, 
		cum_depr_amount, 	asset_book_value, 	remarks, 			receiving_location, 	receiving_cost_center, 
		receipt_remarks, 	transfer_status, 	createdby, 			createddate, 			modifiedby, 
		modifieddate, 		line_no, 			transfer_in_no, 	transfer_in_status, 	par_base_book_value, 
		exchange_rate, 		par_exchange_rate, 	tran_currency, 		etlcreateddatetime
    FROM stg.Stg_adisp_transfer_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_adisptransferdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
