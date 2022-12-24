CREATE OR REPLACE PROCEDURE dwh.usp_f_cdiarpostingsdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    ON    d.sourceid			= h.sourceid
    WHERE d.sourceid		    = p_sourceId
    AND   d.dataflowflag		= p_dataflowflag
    AND   d.targetobject		= p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_cdi_ar_postings_dtl;

    UPDATE dwh.f_cdiarpostingsdtl t
    SET
		company_key				= COALESCE(c.company_key,-1),
		fb_key					= -1,
		curr_key				= COALESCE(cr.curr_key,-1),
		itm_hdr_key				= COALESCE(i.itm_hdr_key,-1),
		uom_key					= COALESCE(u.uom_key,-1),
		customer_key			= COALESCE(cs.customer_key,-1),
		mac_post_flag	 		= s.mac_post_flag,
		vat_line_no	 			= s.vat_line_no,
		vatusageid	 			= s.vatusageid,
		line_no	 				= s.line_no,
		company_code	 		= s.company_code,
		posting_status	 		= s.posting_status,
		posting_date	 		= s.posting_date,
		fb_id	 				= s.fb_id,
		tran_date	 			= s.tran_date,
		account_type	 		= s.account_type,
		account_code	 		= s.account_code,
		drcr_id	 				= s.drcr_id,
		tran_currency	 		= s.tran_currency,
		tran_amount	 			= s.tran_amount,
		exchange_rate	 		= s.exchange_rate,
		base_amount	 			= s.base_amount,
		par_exchange_rate	 	= s.par_exchange_rate,
		par_base_amount	 		= s.par_base_amount,
		cost_center	 			= s.cost_center,
		analysis_code	 		= s.analysis_code,
		subanalysis_code	 	= s.subanalysis_code,
		guid	 				= s.guid,
		entry_date	 			= s.entry_date,
		auth_date	 			= s.auth_date,
		item_code	 			= s.item_code,
		item_variant	 		= s.item_variant,
		quantity	 			= s.quantity,
		reftran_fbid	 		= s.reftran_fbid,
		reftran_no	 			= s.reftran_no,
		reftran_ou	 			= s.reftran_ou,
		reftran_type	 		= s.reftran_type,
		uom	 					= s.uom,
		cust_code	 			= s.cust_code,
		createdby	 			= s.createdby,
		createddate	 			= s.createddate,
		modifiedby	 			= s.modifiedby,
		modifieddate	 		= s.modifieddate,
		hdrremarks	 			= s.hdrremarks,
		mlremarks	 			= s.mlremarks,
		roundoff_flag	 		= s.roundoff_flag,
		item_tcd_type	 		= s.item_tcd_type,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_cdi_ar_postings_dtl s
	LEFT JOIN dwh.d_company c
		ON  s.company_code		= c.company_code
-- 	LEFT JOIN dwh.d_financebook f
-- 		ON  s.fb_id				= f.fb_id
	LEFT JOIN dwh.d_currency cr
		ON  s.tran_currency		= cr.iso_curr_code
	LEFT JOIN dwh.d_itemheader i
		ON  s.item_code			= i.itm_code
		AND s.tran_ou			= i.itm_ou
	LEFT JOIN dwh.d_uom u
		ON  s.uom				= u.mas_uomcode
		AND s.tran_ou			= u.mas_ouinstance
	LEFT JOIN dwh.d_customer cs
		ON  s.cust_code			= cs.customer_id	
		AND s.tran_ou			= cs.customer_ou
    WHERE 	t.tran_type	 		= s.tran_type
		AND	t.tran_ou	 		= s.tran_ou
		AND	t.tran_no	 		= s.tran_no
		AND t.posting_line_no	= s.posting_line_no
		AND t.ctimestamp	 	= s.ctimestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_cdiarpostingsdtl
    (
    	company_key					, fb_key				, curr_key,
		itm_hdr_key					, uom_key				, customer_key 					, tran_type, 
		tran_ou						, tran_no				, posting_line_no				, mac_post_flag, 
		vat_line_no					, vatusageid			, ctimestamp					, line_no, 
		company_code				, posting_status		, posting_date					, fb_id, 
		tran_date					, account_type			, account_code					, drcr_id, 
		tran_currency				, tran_amount			, exchange_rate					, base_amount, 
		par_exchange_rate			, par_base_amount		, cost_center					, analysis_code, 
		subanalysis_code			, guid					, entry_date					, auth_date, 
		item_code					, item_variant			, quantity						, reftran_fbid, 
		reftran_no					, reftran_ou			, reftran_type					, uom, 
		cust_code					, createdby				, createddate					, modifiedby, 
		modifieddate				, hdrremarks			, mlremarks						, roundoff_flag, 
		item_tcd_type				, etlactiveind			, etljobname					, envsourcecd, 
		datasourcecd				, etlcreatedatetime
    )

    SELECT
		COALESCE(c.company_key,-1)	, -1					, COALESCE(cr.curr_key,-1),
		COALESCE(i.itm_hdr_key,-1)	, COALESCE(u.uom_key,-1), COALESCE(cs.customer_key,-1)	, s.tran_type, 
		s.tran_ou					, s.tran_no				, s.posting_line_no				, s.mac_post_flag, 
		s.vat_line_no				, s.vatusageid			, s.ctimestamp					, s.line_no, 
		s.company_code				, s.posting_status		, s.posting_date				, s.fb_id, 
		s.tran_date					, s.account_type		, s.account_code				, s.drcr_id, 
		s.tran_currency				, s.tran_amount			, s.exchange_rate				, s.base_amount, 
		s.par_exchange_rate			, s.par_base_amount		, s.cost_center					, s.analysis_code, 
		s.subanalysis_code			, s.guid				, s.entry_date					, s.auth_date, 
		s.item_code					, s.item_variant		, s.quantity					, s.reftran_fbid, 
		s.reftran_no				, s.reftran_ou			, s.reftran_type				, s.uom, 
		s.cust_code					, s.createdby			, s.createddate					, s.modifiedby, 
		s.modifieddate				, s.hdrremarks			, s.mlremarks					, s.roundoff_flag, 
		s.item_tcd_type				, 1						, p_etljobname					, p_envsourcecd, 
		p_datasourcecd				, NOW()	
    FROM stg.stg_cdi_ar_postings_dtl s
	LEFT JOIN dwh.d_company c
		ON  s.company_code		= c.company_code
-- 	LEFT JOIN dwh.d_financebook f
-- 		ON  s.fb_id				= f.fb_id
	LEFT JOIN dwh.d_currency cr
		ON  s.tran_currency		= cr.iso_curr_code
	LEFT JOIN dwh.d_itemheader i
		ON  s.item_code			= i.itm_code
		AND s.tran_ou			= i.itm_ou
	LEFT JOIN dwh.d_uom u
		ON  s.uom				= u.mas_uomcode
		AND s.tran_ou			= u.mas_ouinstance
	LEFT JOIN dwh.d_customer cs
		ON  s.cust_code			= cs.customer_id	
		AND s.tran_ou			= cs.customer_ou	
    LEFT JOIN dwh.f_cdiarpostingsdtl t
    ON		t.tran_type	 		= s.tran_type
		AND	t.tran_ou	 		= s.tran_ou
		AND	t.tran_no	 		= s.tran_no
		AND t.posting_line_no	= s.posting_line_no
		AND t.ctimestamp	 	= s.ctimestamp
    WHERE	t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cdi_ar_postings_dtl
    (
        tran_type		, tran_ou			, tran_no			, posting_line_no	, mac_post_flag, 
		vat_line_no		, vatusageid		, ctimestamp		, line_no			, company_code, 
		posting_status	, posting_date		, fb_id				, tran_date			, account_type, 
		account_code	, drcr_id			, tran_currency		, tran_amount		, exchange_rate, 
		base_amount		, par_exchange_rate	, par_base_amount	, cost_center		, analysis_code, 
		subanalysis_code, guid				, entry_date		, auth_date			, item_code, 
		item_variant	, quantity			, reftran_fbid		, reftran_no		, reftran_ou, 
		reftran_type	, uom				, cust_code			, org_vat_base_amt	, createdby, 
		createddate		, modifiedby		, modifieddate		, hdrremarks		, mlremarks, 
		roundoff_flag	, item_tcd_type		, address_id		, etlcreateddatetime
    )
    SELECT
        tran_type		, tran_ou			, tran_no			, posting_line_no	, mac_post_flag, 
		vat_line_no		, vatusageid		, ctimestamp		, line_no			, company_code, 
		posting_status	, posting_date		, fb_id				, tran_date			, account_type, 
		account_code	, drcr_id			, tran_currency		, tran_amount		, exchange_rate, 
		base_amount		, par_exchange_rate	, par_base_amount	, cost_center		, analysis_code, 
		subanalysis_code, guid				, entry_date		, auth_date			, item_code, 
		item_variant	, quantity			, reftran_fbid		, reftran_no		, reftran_ou, 
		reftran_type	, uom				, cust_code			, org_vat_base_amt	, createdby, 
		createddate		, modifiedby		, modifieddate		, hdrremarks		, mlremarks, 
		roundoff_flag	, item_tcd_type		, address_id		, etlcreateddatetime
    FROM stg.stg_cdi_ar_postings_dtl;
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