-- PROCEDURE: dwh.usp_f_contractheaderhistory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_contractheaderhistory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_contractheaderhistory(
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
    FROM stg.stg_wms_contract_hdr_h;

    UPDATE dwh.F_ContractHeaderHistory t
    SET
        cont_hdr_hst_vendor_key 		 = COALESCE(v.vendor_key,-1),
		cont_hdr_hst_loc_key 	 		 = COALESCE(l.loc_key,-1),
		cont_hdr_hst_customer_key 		 = COALESCE(c.customer_key,-1),
		cont_hdr_hst_datekey 		 	 = COALESCE(d.datekey,-1),
		cont_hdr_hst_curr_key 	 		 = COALESCE(cu.curr_key,-1),
        cont_desc                        = s.wms_cont_desc,
        cont_date                        = s.wms_cont_date,
        cont_type                        = s.wms_cont_type,
        cont_status                      = s.wms_cont_status,
        cont_rsn_code                    = s.wms_cont_rsn_code,
        cont_service_type                = s.wms_cont_service_type,
        cont_valid_from                  = s.wms_cont_valid_from,
        cont_valid_to                    = s.wms_cont_valid_to,
        cont_cust_contract_ref_no        = s.wms_cont_cust_contract_ref_no,
        cont_customer_id                 = s.wms_cont_customer_id,
        cont_supp_contract_ref_no        = s.wms_cont_supp_contract_ref_no,
        cont_vendor_id                   = s.wms_cont_vendor_id,
        cont_ref_doc_type                = s.wms_cont_ref_doc_type,
        cont_ref_doc_no                  = s.wms_cont_ref_doc_no,
        cont_bill_freq                   = s.wms_cont_bill_freq,
        cont_bill_date_day               = s.wms_cont_bill_date_day,
        cont_billing_stage               = s.wms_cont_billing_stage,
        cont_currency                    = s.wms_cont_currency,
        cont_exchange_rate               = s.wms_cont_exchange_rate,
        cont_bulk_rate_chg_per           = s.wms_cont_bulk_rate_chg_per,
        cont_division                    = s.wms_cont_division,
        cont_location                    = s.wms_cont_location,
        cont_remarks                     = s.wms_cont_remarks,
        cont_slab_type                   = s.wms_cont_slab_type,
        cont_timestamp                   = s.wms_cont_timestamp,
        cont_created_by                  = s.wms_cont_created_by,
        cont_created_dt                  = s.wms_cont_created_dt,
        cont_modified_by                 = s.wms_cont_modified_by,
        cont_modified_dt                 = s.wms_cont_modified_dt,
        cont_space_last_bill_dt          = s.wms_cont_space_last_bill_dt,
        cont_payment_type                = s.wms_cont_payment_type,
        cont_std_cont_portal             = s.wms_cont_std_cont_portal,
        cont_vendor_group                = s.wms_cont_vendor_group,
        cont_cust_grp                    = s.wms_cont_cust_grp,
        cont_lag_time                    = s.wms_cont_lag_time,
        cont_lag_time_uom                = s.wms_cont_lag_time_uom,
        cont_non_billable                = s.wms_cont_non_billable,
        non_billable_chk                 = s.wms_non_billable_chk,
        cont_last_day                    = s.wms_cont_last_day,
        cont_div_loc_cust                = s.wms_cont_div_loc_cust,
        cont_numbering_type              = s.wms_cont_numbering_type,
        cont_workflow_status             = s.wms_cont_workflow_status,
        cont_reason_for_return           = s.wms_cont_reason_for_return,
        min_weight                       = s.wms_min_weight,
        volm_conversion                  = s.wms_volm_conversion,
        cont_plan_DIFOT                  = s.wms_cont_plan_DIFOT,
        etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
    FROM stg.stg_wms_contract_hdr_h s
	INNER JOIN dwh.f_contractheader fh
	on		fh.cont_id			= s.wms_cont_id
	and		fh.cont_ou			= s.wms_cont_ou
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_cont_location   = l.loc_code 
        AND s.wms_cont_ou         = l.loc_ou
	LEFT JOIN dwh.d_customer c 			
		ON  s.wms_cont_customer_id = c.customer_id
		AND s.wms_cont_ou          = c.customer_ou
	LEFT JOIN dwh.d_vendor v 		
		ON  s.wms_cont_vendor_id  	= v.vendor_id
		AND s.wms_cont_ou 			= v.vendor_ou
	LEFT JOIN dwh.d_currency cu 		
		ON  s.wms_cont_currency  	= cu.iso_curr_code
	LEFT JOIN dwh.d_date d 		
		ON  s.wms_cont_date::date   = d.dateactual
	WHERE   t.cont_id 		= s.wms_cont_id
    AND 	t.cont_ou 		= s.wms_cont_ou
    AND 	t.cont_amendno  = s.wms_cont_amendno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

-- 	Delete from dwh.F_ContractHeaderHistory t
-- 	USING stg.stg_wms_contract_hdr_h s
-- 	where	s.wms_cont_id 		= t.cont_id
--     AND 	s.wms_cont_ou 		= t.cont_ou
--     AND 	s.wms_cont_amendno  = t.cont_amendno;
-- 	AND COALESCE(wms_cont_modified_dt,wms_cont_created_dt)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;

    INSERT INTO dwh.F_ContractHeaderHistory
    (
		cont_hdr_hst_vendor_key,	cont_hdr_hst_loc_key,	cont_hdr_hst_customer_key,	cont_hdr_hst_datekey,	cont_hdr_hst_curr_key,
        cont_id, 			cont_ou, 					cont_amendno, 			cont_desc, 					cont_date, 
		cont_type, 			cont_status, 				cont_rsn_code, 			cont_service_type, 			cont_valid_from, 
		cont_valid_to, 		cont_cust_contract_ref_no, 	cont_customer_id, 		cont_supp_contract_ref_no, 	cont_vendor_id, 
		cont_ref_doc_type, 	cont_ref_doc_no, 			cont_bill_freq, 		cont_bill_date_day, 		cont_billing_stage, 
		cont_currency, 		cont_exchange_rate, 		cont_bulk_rate_chg_per, cont_division, 				cont_location, 
		cont_remarks, 		cont_slab_type, 			cont_timestamp, 		cont_created_by, 			cont_created_dt, 
		cont_modified_by, 	cont_modified_dt, 			cont_space_last_bill_dt,cont_payment_type, 			cont_std_cont_portal, 
		cont_vendor_group, 	cont_cust_grp, 				cont_lag_time, 			cont_lag_time_uom, 			cont_non_billable, 
		non_billable_chk, 	cont_last_day, 				cont_div_loc_cust, 		cont_numbering_type, 		cont_workflow_status, 
		cont_reason_for_return, min_weight, 			volm_conversion, 		cont_plan_DIFOT, 			etlactiveind, 
		etljobname, 		envsourcecd, 				datasourcecd, 			etlcreatedatetime
    )

    SELECT
        COALESCE(v.vendor_key,-1),  COALESCE(l.loc_key,-1), COALESCE(c.customer_key,-1),    COALESCE(d.datekey,-1),     COALESCE(cu.curr_key,-1),
        s.wms_cont_id, 		     s.wms_cont_ou, 					s.wms_cont_amendno, 			s.wms_cont_desc, 		 		 s.wms_cont_date, 
		s.wms_cont_type, 	 	 s.wms_cont_status, 				s.wms_cont_rsn_code, 			s.wms_cont_service_type, 		 s.wms_cont_valid_from, 
		s.wms_cont_valid_to, 	 s.wms_cont_cust_contract_ref_no, 	s.wms_cont_customer_id, 		s.wms_cont_supp_contract_ref_no, s.wms_cont_vendor_id, 
		s.wms_cont_ref_doc_type, s.wms_cont_ref_doc_no, 			s.wms_cont_bill_freq, 			s.wms_cont_bill_date_day, 		 s.wms_cont_billing_stage, 
		s.wms_cont_currency, 	 s.wms_cont_exchange_rate, 			s.wms_cont_bulk_rate_chg_per, 	s.wms_cont_division, 			 s.wms_cont_location, 
		s.wms_cont_remarks, 	 s.wms_cont_slab_type, 				s.wms_cont_timestamp, 			s.wms_cont_created_by, 			 s.wms_cont_created_dt, 
		s.wms_cont_modified_by,  s.wms_cont_modified_dt, 			s.wms_cont_space_last_bill_dt, 	s.wms_cont_payment_type, 		 s.wms_cont_std_cont_portal, 
		s.wms_cont_vendor_group, s.wms_cont_cust_grp, 				s.wms_cont_lag_time, 			s.wms_cont_lag_time_uom, 		 s.wms_cont_non_billable, 
		s.wms_non_billable_chk,  s.wms_cont_last_day, 				s.wms_cont_div_loc_cust, 		s.wms_cont_numbering_type, 		 s.wms_cont_workflow_status, 
		s.wms_cont_reason_for_return, s.wms_min_weight, 			s.wms_volm_conversion, 			s.wms_cont_plan_DIFOT, 			 1, 
		p_etljobname, 			 p_envsourcecd, 					p_datasourcecd, 				NOW()
    FROM stg.stg_wms_contract_hdr_h s
	INNER JOIN dwh.f_contractheader fh
	on		fh.cont_id			= s.wms_cont_id
	and		fh.cont_ou			= s.wms_cont_ou
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_cont_location   = l.loc_code 
        AND s.wms_cont_ou         = l.loc_ou
	LEFT JOIN dwh.d_customer c 			
		ON  s.wms_cont_customer_id = c.customer_id
		AND s.wms_cont_ou          = c.customer_ou
	LEFT JOIN dwh.d_vendor v 		
		ON  s.wms_cont_vendor_id  	= v.vendor_id
		AND s.wms_cont_ou 			= v.vendor_ou
	LEFT JOIN dwh.d_currency cu 		
		ON  s.wms_cont_currency  	= cu.iso_curr_code
	LEFT JOIN dwh.d_date d 		
		ON  s.wms_cont_date::date   = d.dateactual
    LEFT JOIN dwh.F_ContractHeaderHistory t
    ON 		s.wms_cont_id 		= t.cont_id
    AND 	s.wms_cont_ou 		= t.cont_ou
    AND 	s.wms_cont_amendno  = t.cont_amendno
    WHERE t.cont_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_contract_hdr_h
    (
        wms_cont_id, 			wms_cont_ou, 					wms_cont_amendno, 			wms_cont_desc, 					wms_cont_date, 
		wms_cont_type, 			wms_cont_status, 				wms_cont_rsn_code, 			wms_cont_service_type, 			wms_cont_valid_from, 
		wms_cont_valid_to, 		wms_cont_cust_contract_ref_no, 	wms_cont_customer_id, 		wms_cont_supp_contract_ref_no,  wms_cont_vendor_id, 
		wms_cont_ref_doc_type, 	wms_cont_ref_doc_no, 			wms_cont_bill_freq, 		wms_cont_bill_date_day, 		wms_cont_billing_stage, 
		wms_cont_currency, 		wms_cont_exchange_rate, 		wms_cont_bulk_rate_chg_per, wms_cont_division, 				wms_cont_location, 
		wms_cont_remarks, 		wms_cont_slab_type, 			wms_cont_timestamp, 		wms_cont_created_by, 			wms_cont_created_dt, 
		wms_cont_modified_by, 	wms_cont_modified_dt, 			wms_cont_space_last_bill_dt,wms_cont_payment_type, 			wms_cont_std_cont_portal, 
		wms_cont_vendor_group, 	wms_cont_cust_grp, 				wms_cont_lag_time, 			wms_cont_lag_time_uom, 			wms_cont_non_billable, 
		wms_non_billable_chk, 	wms_cont_last_day, 				wms_cont_div_loc_cust, 		wms_cont_numbering_type, 		wms_cont_workflow_status, 
		wms_cont_reason_for_return, wms_min_weight, 			wms_volm_conversion, 		wms_cont_plan_DIFOT, 			etlcreateddatetime
    )
    SELECT
        wms_cont_id, 			wms_cont_ou, 					wms_cont_amendno, 			wms_cont_desc, 					wms_cont_date, 
		wms_cont_type, 			wms_cont_status, 				wms_cont_rsn_code, 			wms_cont_service_type, 			wms_cont_valid_from, 
		wms_cont_valid_to, 		wms_cont_cust_contract_ref_no, 	wms_cont_customer_id, 		wms_cont_supp_contract_ref_no,  wms_cont_vendor_id, 
		wms_cont_ref_doc_type, 	wms_cont_ref_doc_no, 			wms_cont_bill_freq, 		wms_cont_bill_date_day, 		wms_cont_billing_stage, 
		wms_cont_currency, 		wms_cont_exchange_rate, 		wms_cont_bulk_rate_chg_per, wms_cont_division, 				wms_cont_location, 
		wms_cont_remarks, 		wms_cont_slab_type, 			wms_cont_timestamp, 		wms_cont_created_by, 			wms_cont_created_dt, 
		wms_cont_modified_by, 	wms_cont_modified_dt, 			wms_cont_space_last_bill_dt,wms_cont_payment_type, 			wms_cont_std_cont_portal, 
		wms_cont_vendor_group, 	wms_cont_cust_grp, 				wms_cont_lag_time, 			wms_cont_lag_time_uom, 			wms_cont_non_billable, 
		wms_non_billable_chk, 	wms_cont_last_day, 				wms_cont_div_loc_cust, 		wms_cont_numbering_type, 		wms_cont_workflow_status, 
		wms_cont_reason_for_return, wms_min_weight, 			wms_volm_conversion, 		wms_cont_plan_DIFOT, 			etlcreateddatetime
    FROM stg.stg_wms_contract_hdr_h;
    
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
ALTER PROCEDURE dwh.usp_f_contractheaderhistory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
