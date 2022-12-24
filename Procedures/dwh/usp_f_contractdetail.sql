-- PROCEDURE: dwh.usp_f_contractdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_contractdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_contractdetail(
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

	IF EXISTS(SELECT 1  FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_contract_dtl;

    UPDATE dwh.f_contractDetail t
    SET
	    cont_hdr_key                   = fh.cont_hdr_key,
        cont_tariff_ser_id             = s.wms_cont_tariff_ser_id,
        cont_rate                      = s.wms_cont_rate,
        cont_min_change                = s.wms_cont_min_change,
        cont_min_change_added          = s.wms_cont_min_change_added,
        cont_cost                      = s.wms_cont_cost,
        cont_margin_per                = s.wms_cont_margin_per,
        cont_max_charge                = s.wms_cont_max_charge,
        cont_rate_valid_from           = s.wms_cont_rate_valid_from,
        cont_rate_valid_to             = s.wms_cont_rate_valid_to,
        cont_basic_charge              = s.wms_cont_basic_charge,
        cont_reimbursable              = s.wms_cont_reimbursable,
        cont_percentrate               = s.wms_cont_percentrate,
        cont_val_currency              = s.wms_cont_val_currency,
        cont_bill_currency             = s.wms_cont_bill_currency,
        cont_exchange_rate_type        = s.wms_cont_exchange_rate_type,
        cont_discount                  = s.wms_cont_discount,
        cont_draft_bill_grp            = s.wms_cont_draft_bill_grp,
        cont_created_by                = s.wms_cont_created_by,
        cont_created_dt                = s.wms_cont_created_dt,
        cont_modified_by               = s.wms_cont_modified_by,
        cont_modified_dt               = s.wms_cont_modified_dt,
        cont_advance_chk               = s.wms_cont_advance_chk,
        bill_pay_to_id                 = s.wms_bill_pay_to_id,
        inco_terms                     = s.wms_inco_terms,
        cont_bulk_remarks              = s.wms_cont_bulk_remarks,
        cont_type_ml                   = s.wms_cont_type_ml,
        cont_tariff_bill_stage         = s.wms_cont_tariff_bill_stage,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_wms_contract_dtl s
	INNER JOIN dwh.f_contractheader fh
	on		fh.cont_id			= s.wms_cont_id
	and		fh.cont_ou			= s.wms_cont_ou
    WHERE	t.cont_id			= s.wms_cont_id
    AND		t.cont_lineno		= s.wms_cont_lineno
    AND		t.cont_ou			= s.wms_cont_ou
    AND		t.cont_tariff_id	= s.wms_cont_tariff_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

/*
	Delete from dwh.f_contractDetail t
	USING stg.stg_wms_contract_dtl s
	WHERE	s.wms_cont_id			= t.cont_id
    AND		s.wms_cont_lineno		= t.cont_lineno
    AND		s.wms_cont_ou			= t.cont_ou
    AND		s.wms_cont_tariff_id	= t.cont_tariff_id;
-- 	and COALESCE(ch.cont_modified_dt,ch.cont_created_dt)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/
    INSERT INTO dwh.f_contractDetail
    (
        cont_hdr_key,cont_id, cont_lineno, cont_ou, cont_tariff_id, cont_tariff_ser_id, cont_rate, cont_min_change, cont_min_change_added, 
		cont_cost, cont_margin_per, cont_max_charge, cont_rate_valid_from, cont_rate_valid_to, cont_basic_charge, cont_reimbursable, 
		cont_percentrate, cont_val_currency, cont_bill_currency, cont_exchange_rate_type, cont_discount, cont_draft_bill_grp, 
		cont_created_by, cont_created_dt, cont_modified_by, cont_modified_dt, cont_advance_chk, bill_pay_to_id, inco_terms, 
		cont_bulk_remarks, cont_type_ml, cont_tariff_bill_stage, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.cont_hdr_key,s.wms_cont_id, s.wms_cont_lineno, s.wms_cont_ou, s.wms_cont_tariff_id, s.wms_cont_tariff_ser_id, s.wms_cont_rate, s.wms_cont_min_change, s.wms_cont_min_change_added, 
		s.wms_cont_cost, s.wms_cont_margin_per, s.wms_cont_max_charge, s.wms_cont_rate_valid_from, s.wms_cont_rate_valid_to, s.wms_cont_basic_charge, s.wms_cont_reimbursable, 
		s.wms_cont_percentrate, s.wms_cont_val_currency, s.wms_cont_bill_currency, s.wms_cont_exchange_rate_type, s.wms_cont_discount, s.wms_cont_draft_bill_grp, 
		s.wms_cont_created_by, s.wms_cont_created_dt, s.wms_cont_modified_by, s.wms_cont_modified_dt, s.wms_cont_advance_chk, s.wms_bill_pay_to_id, s.wms_inco_terms, 
		s.wms_cont_bulk_remarks, s.wms_cont_type_ml, s.wms_cont_tariff_bill_stage, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_contract_dtl s
	INNER JOIN dwh.f_contractheader fh
	on		fh.cont_id				= s.wms_cont_id
	and		fh.cont_ou				= s.wms_cont_ou
    LEFT JOIN dwh.f_contractDetail t
    ON		s.wms_cont_id			= t.cont_id
    AND		s.wms_cont_lineno		= t.cont_lineno
    AND		s.wms_cont_ou			= t.cont_ou
    AND		s.wms_cont_tariff_id	= t.cont_tariff_id
    WHERE	t.cont_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
--	select 0 into updcnt;
/*
	UPDATE dwh.f_contractDetail t
    SET 	 cont_hdr_key            = fh.cont_hdr_key,
			 etlupdatedatetime       = NOW()
	FROM dwh.f_contractheader fh
	WHERE	t.cont_id	=	fh.cont_id			
	and		t.cont_ou	=	fh.cont_ou		
	and COALESCE(fh.cont_modified_dt,fh.cont_created_dt)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/	
	
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_contract_dtl
    (
        wms_cont_id, wms_cont_lineno, wms_cont_ou, wms_cont_tariff_id, wms_cont_tariff_ser_id, wms_cont_rate, wms_cont_min_change, wms_cont_min_change_added, wms_cont_cost, 
		wms_cont_margin_per, wms_cont_max_charge, wms_cont_rate_valid_from, wms_cont_rate_valid_to, wms_cont_basic_charge, wms_cont_reimbursable, wms_cont_percentrate, 
		wms_cont_val_currency, wms_cont_bill_currency, wms_cont_exchange_rate_type, wms_cont_discount, wms_cont_draft_bill_grp, wms_cont_created_by, wms_cont_created_dt, 
		wms_cont_modified_by, wms_cont_modified_dt, wms_cont_advance_chk, wms_bill_pay_to_id, wms_inco_terms, wms_cont_bulk_remarks, wms_cont_type_ml, wms_cont_tariff_bill_stage, 
		etlcreateddatetime
    )
    SELECT
        wms_cont_id, wms_cont_lineno, wms_cont_ou, wms_cont_tariff_id, wms_cont_tariff_ser_id, wms_cont_rate, wms_cont_min_change, wms_cont_min_change_added, wms_cont_cost, 
		wms_cont_margin_per, wms_cont_max_charge, wms_cont_rate_valid_from, wms_cont_rate_valid_to, wms_cont_basic_charge, wms_cont_reimbursable, wms_cont_percentrate, 
		wms_cont_val_currency, wms_cont_bill_currency, wms_cont_exchange_rate_type, wms_cont_discount, wms_cont_draft_bill_grp, wms_cont_created_by, wms_cont_created_dt, 
		wms_cont_modified_by, wms_cont_modified_dt, wms_cont_advance_chk, wms_bill_pay_to_id, wms_inco_terms, wms_cont_bulk_remarks, wms_cont_type_ml, wms_cont_tariff_bill_stage, 
		etlcreateddatetime
    FROM stg.stg_wms_contract_dtl;
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
ALTER PROCEDURE dwh.usp_f_contractdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
