-- PROCEDURE: dwh.usp_f_contracttransferinvoicedetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_contracttransferinvoicedetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_contracttransferinvoicedetail(
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

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

	IF EXISTS(SELECT 1  FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) = NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_contract_transfer_inv_dtl;

    UPDATE dwh.f_contracttransferinvoicedetail t
    SET
        cont_inv_hdr_key                     = fh.cont_hdr_key,
        cont_transfer_contract_id            = s.wms_cont_transfer_contract_id,
        cont_transfer_ref_doc_no             = s.wms_cont_transfer_ref_doc_no,
        cont_transfer_ref_doc_date           = s.wms_cont_transfer_ref_doc_date,
        cont_transfer_draft_inv_no           = s.wms_cont_transfer_draft_inv_no,
        cont_Supplier_id                     = s.wms_cont_Supplier_id,
        cont_customer_id                     = s.wms_cont_customer_id,
        cont_transfer_currency               = s.wms_cont_transfer_currency,
        cont_location                        = s.wms_cont_location,
        cont_fb_id                           = s.wms_cont_fb_id,
        cont_transfer_billing_address        = s.wms_cont_transfer_billing_address,
        cont_refdoc_inv_value                = s.wms_cont_refdoc_inv_value,
        etlactiveind                         = 1,
        etljobname                           = p_etljobname,
        envsourcecd                          = p_envsourcecd,
        datasourcecd                         = p_datasourcecd,
        etlupdatedatetime                    = NOW()
    FROM stg.stg_wms_contract_transfer_inv_dtl s
	Inner Join dwh.f_contracttransferinvoiceheader fh
	on  s.wms_cont_transfer_inv_no =  fh.cont_transfer_inv_no
    and s.wms_cont_transfer_inv_ou =  fh.cont_transfer_inv_ou  
    WHERE t.cont_transfer_inv_no   =  s.wms_cont_transfer_inv_no
    AND t.cont_transfer_lineno     =  s.wms_cont_transfer_lineno
    AND t.cont_transfer_inv_ou     =  s.wms_cont_transfer_inv_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_contracttransferinvoicedetail
    (
        cont_inv_hdr_key,cont_transfer_inv_no, cont_transfer_lineno, cont_transfer_inv_ou, cont_transfer_contract_id, cont_transfer_ref_doc_no, 
		cont_transfer_ref_doc_date, cont_transfer_draft_inv_no, cont_Supplier_id, cont_customer_id, cont_transfer_currency, 
		cont_location, cont_fb_id, cont_transfer_billing_address, cont_refdoc_inv_value, etlactiveind, etljobname, envsourcecd, 
		datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.cont_hdr_key,s.wms_cont_transfer_inv_no, s.wms_cont_transfer_lineno, s.wms_cont_transfer_inv_ou, s.wms_cont_transfer_contract_id, s.wms_cont_transfer_ref_doc_no,
		s.wms_cont_transfer_ref_doc_date, s.wms_cont_transfer_draft_inv_no, s.wms_cont_Supplier_id, s.wms_cont_customer_id, s.wms_cont_transfer_currency,
		s.wms_cont_location, s.wms_cont_fb_id, s.wms_cont_transfer_billing_address, s.wms_cont_refdoc_inv_value, 1, p_etljobname, p_envsourcecd,
		p_datasourcecd, NOW()
    FROM stg.stg_wms_contract_transfer_inv_dtl s
	Inner Join dwh.f_contracttransferinvoiceheader fh
	on  s.wms_cont_transfer_inv_no =  fh.cont_transfer_inv_no
    and s.wms_cont_transfer_inv_ou =  fh.cont_transfer_inv_ou 
    LEFT JOIN dwh.f_contracttransferinvoicedetail t
    ON s.wms_cont_transfer_inv_no = t.cont_transfer_inv_no
    AND s.wms_cont_transfer_lineno = t.cont_transfer_lineno
    AND s.wms_cont_transfer_inv_ou = t.cont_transfer_inv_ou
    WHERE t.cont_transfer_inv_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    INSERT INTO raw.raw_wms_contract_transfer_inv_dtl
    (
        wms_cont_transfer_inv_no, wms_cont_transfer_lineno, wms_cont_transfer_inv_ou, wms_cont_transfer_contract_id, 
		wms_cont_transfer_ref_doc_no, wms_cont_transfer_ref_doc_date, wms_cont_transfer_draft_inv_no, wms_cont_Supplier_id, 
		wms_cont_customer_id, wms_cont_transfer_currency, wms_cont_location, wms_cont_fb_id, wms_cont_transfer_billing_address, 
		wms_cont_refdoc_inv_value, etlcreateddatetime
    )
    SELECT
        wms_cont_transfer_inv_no, wms_cont_transfer_lineno, wms_cont_transfer_inv_ou, wms_cont_transfer_contract_id, 
		wms_cont_transfer_ref_doc_no, wms_cont_transfer_ref_doc_date, wms_cont_transfer_draft_inv_no, wms_cont_Supplier_id, 
		wms_cont_customer_id, wms_cont_transfer_currency, wms_cont_location, wms_cont_fb_id, wms_cont_transfer_billing_address, 
		wms_cont_refdoc_inv_value, etlcreateddatetime
    FROM stg.stg_wms_contract_transfer_inv_dtl;

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
ALTER PROCEDURE dwh.usp_f_contracttransferinvoicedetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
