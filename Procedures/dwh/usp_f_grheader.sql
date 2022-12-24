-- PROCEDURE: dwh.usp_f_grheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grheader(
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_gr_hdr_grmain;

	UPDATE dwh.f_grheader t
    SET 
          gr_date_key                   = COALESCE(d.datekey,-1)
        , gr_emp_hdr_key                = COALESCE(e.emp_hdr_key,-1)
        , gr_vendor_key                 = COALESCE(v.vendor_key,-1)
        , gr_curr_key                  	= COALESCE(c.curr_key,-1)
		, grdate 						= s.gr_hdr_grdate
		, grstatus 						= s.gr_hdr_grstatus
		, numseries 					= s.gr_hdr_numseries
		, grfolder 						= s.gr_hdr_grfolder
		, grtype 						= s.gr_hdr_grtype
		, gatepassno 					= s.gr_hdr_gatepassno
		, gatepassdate 					= s.gr_hdr_gatepassdate
		, noofitems 					= s.gr_hdr_noofitems
		, delynoteno 					= s.gr_hdr_delynoteno
		, delynotedate 					= s.gr_hdr_delynotedate
		, empcode 						= s.gr_hdr_empcode
		, orderdoc 						= s.gr_hdr_orderdoc
		, orderou 						= s.gr_hdr_orderou
		, orderno 						= s.gr_hdr_orderno
		, orderamendno 					= s.gr_hdr_orderamendno
		, orderdate 					= s.gr_hdr_orderdate
		, orderapprdate 				= s.gr_hdr_orderapprdate
		, orderfolder 					= s.gr_hdr_orderfolder
		, contperson 					= s.gr_hdr_contperson
		, refdoclineno 					= s.gr_hdr_refdoclineno
		, suppcode 						= s.gr_hdr_suppcode
		, shipfromid 					= s.gr_hdr_shipfromid
		, autoinvoice 					= s.gr_hdr_autoinvoice
		, invoiceat	 					= s.gr_hdr_invoiceat
		, pay2sypplier 					= s.gr_hdr_pay2sypplier
		, invbeforegr 					= s.gr_hdr_invbeforegr
		, docvalue 						= s.gr_hdr_docvalue
		, addlcharges 					= s.gr_hdr_addlcharges
		, tcdtotalvalue 				= s.gr_hdr_tcdtotalvalue
		, totalvalue 					= s.gr_hdr_totalvalue
		, exchrate 						= s.gr_hdr_exchrate
		, currency 						= s.gr_hdr_currency
		, frdate 						= s.gr_hdr_frdate
		, fadate 						= s.gr_hdr_fadate
		, fmdate 						= s.gr_hdr_fmdate
		, vatincl 						= s.gr_hdr_vatincl
		, createdby 					= s.gr_hdr_createdby
		, createdate 					= s.gr_hdr_createdate
		, modifiedby 					= s.gr_hdr_modifiedby
		, modifieddate 					= s.gr_hdr_modifieddate
		, grtimestamp 					= s.gr_hdr_timestamp
		, remarks 						= s.gr_hdr_remarks
		, tcal_status 					= s.gr_hdr_tcal_status
		, total_tcal_amount 			= s.gr_hdr_total_tcal_amount
		, tot_excludingtcal_amount 		= s.gr_hdr_tot_excludingtcal_amount
		, lr_no 						= s.gr_hdr_lr_no
		, lr_date 						= s.gr_hdr_lr_date
		, revdate 						= s.gr_hdr_revdate
		, revremrks 					= s.gr_hdr_revremrks
		, revres_cd 					= s.gr_hdr_revres_cd
		, revres_dsc 					= s.gr_hdr_revres_dsc
		, suppinvno 					= s.gr_hdr_suppinvno
		, suppinvdate 					= s.gr_hdr_suppinvdate
		, party_tax_region 				= s.gr_hdr_party_tax_region
		, party_regd_no 				= s.gr_hdr_party_regd_no
		, own_tax_region 				= s.gr_hdr_own_tax_region
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_gr_hdr_grmain s
	LEFT JOIN dwh.d_date d 			
		ON 	s.gr_hdr_grdate::date 		= d.dateactual
	LEFT JOIN dwh.d_employeeheader e 		
		ON 	s.gr_hdr_empcode 			= e.emp_employee_code 
        AND s.gr_hdr_ouinstid        	= e.emp_ou		
	LEFT JOIN dwh.d_vendor v 		
		ON 	s.gr_hdr_suppcode  			= v.vendor_id 
        AND s.gr_hdr_ouinstid        	= v.vendor_ou
	LEFT JOIN dwh.d_currency c 		
		ON 	s.gr_hdr_currency  			= c.iso_curr_code 	
    WHERE 	t.ouinstid 					= s.gr_hdr_ouinstid
		AND t.grno 						= s.gr_hdr_grno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_grheader
	(
		gr_date_key					, gr_emp_hdr_key				, gr_vendor_key						, gr_curr_key, 
		ouinstid					, grno							, grdate							, grstatus, 
		numseries					, grfolder						, grtype							, gatepassno, 
		gatepassdate				, noofitems						, delynoteno						, delynotedate, 
		empcode						, orderdoc						, orderou							, orderno, 
		orderamendno				, orderdate						, orderapprdate						, orderfolder, 
		contperson					, refdoclineno					, suppcode							, shipfromid, 
		autoinvoice					, invoiceat						, pay2sypplier						, invbeforegr, 
		docvalue					, addlcharges					, tcdtotalvalue						, totalvalue, 
		exchrate					, currency						, frdate							, fadate, 
		fmdate						, vatincl						, createdby							, createdate, 
		modifiedby					, modifieddate					, grtimestamp						, remarks, 
		tcal_status					, total_tcal_amount				, tot_excludingtcal_amount			, lr_no, 
		lr_date						, revdate						, revremrks							, revres_cd, 
		revres_dsc					, suppinvno						, suppinvdate						, party_tax_region, 
		party_regd_no				, own_tax_region				, etlactiveind						, etljobname, 
		envsourcecd					, datasourcecd					, etlcreatedatetime

	)
	
	SELECT 
	   	COALESCE(d.datekey,-1)		, COALESCE(e.emp_hdr_key,-1)	, COALESCE(v.vendor_key,-1)			,COALESCE(c.curr_key,-1),
		s.gr_hdr_ouinstid			, s.gr_hdr_grno					, s.gr_hdr_grdate					, s.gr_hdr_grstatus, 
		s.gr_hdr_numseries			, s.gr_hdr_grfolder				, s.gr_hdr_grtype					, s.gr_hdr_gatepassno, 
		s.gr_hdr_gatepassdate		, s.gr_hdr_noofitems			, s.gr_hdr_delynoteno				, s.gr_hdr_delynotedate, 
		s.gr_hdr_empcode			, s.gr_hdr_orderdoc				, s.gr_hdr_orderou					, s.gr_hdr_orderno, 
		s.gr_hdr_orderamendno		, s.gr_hdr_orderdate			, s.gr_hdr_orderapprdate			, s.gr_hdr_orderfolder, 
		s.gr_hdr_contperson			, s.gr_hdr_refdoclineno			, s.gr_hdr_suppcode					, s.gr_hdr_shipfromid, 
		s.gr_hdr_autoinvoice		, s.gr_hdr_invoiceat			, s.gr_hdr_pay2sypplier				, s.gr_hdr_invbeforegr, 
		s.gr_hdr_docvalue			, s.gr_hdr_addlcharges			, s.gr_hdr_tcdtotalvalue			, s.gr_hdr_totalvalue, 
		s.gr_hdr_exchrate			, s.gr_hdr_currency				, s.gr_hdr_frdate					, s.gr_hdr_fadate, 
		s.gr_hdr_fmdate				, s.gr_hdr_vatincl				, s.gr_hdr_createdby				, s.gr_hdr_createdate, 
		s.gr_hdr_modifiedby			, s.gr_hdr_modifieddate			, s.gr_hdr_timestamp				, s.gr_hdr_remarks, 
		s.gr_hdr_tcal_status		, s.gr_hdr_total_tcal_amount	, s.gr_hdr_tot_excludingtcal_amount	, s.gr_hdr_lr_no, 
		s.gr_hdr_lr_date			, s.gr_hdr_revdate				, s.gr_hdr_revremrks				, s.gr_hdr_revres_cd, 
		s.gr_hdr_revres_dsc			, s.gr_hdr_suppinvno			, s.gr_hdr_suppinvdate				, s.gr_hdr_party_tax_region, 
		s.gr_hdr_party_regd_no		, s.gr_hdr_own_tax_region		, 1 AS etlactiveind					, p_etljobname,
		p_envsourcecd				, p_datasourcecd				, NOW()
	FROM stg.stg_gr_hdr_grmain s
	LEFT JOIN dwh.d_date d 			
		ON 	s.gr_hdr_grdate::date 		= d.dateactual
	LEFT JOIN dwh.d_employeeheader e 		
		ON 	s.gr_hdr_empcode 			= e.emp_employee_code 
        AND s.gr_hdr_ouinstid        	= e.emp_ou		
	LEFT JOIN dwh.d_vendor v 		
		ON 	s.gr_hdr_suppcode  			= v.vendor_id 
        AND s.gr_hdr_ouinstid        	= v.vendor_ou
	LEFT JOIN dwh.d_currency c 		
		ON 	s.gr_hdr_currency  			= c.iso_curr_code 
	LEFT JOIN dwh.f_grheader t 	
		ON  t.ouinstid 					= s.gr_hdr_ouinstid
		AND t.grno 						= s.gr_hdr_grno
    WHERE t.grno IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_gr_hdr_grmain
	(
		gr_hdr_ouinstid					, gr_hdr_grno			, gr_hdr_grdate				, gr_hdr_grstatus, 
		gr_hdr_numseries				, gr_hdr_grfolder		, gr_hdr_grtype				, gr_hdr_gatepassno, 
		gr_hdr_gatepassdate				, gr_hdr_transmode		, gr_hdr_carriername		, gr_hdr_vehicleno, 
		gr_hdr_noofitems				, gr_hdr_consweight		, gr_hdr_consuom			, gr_hdr_delynoteno, 
		gr_hdr_delynotedate				, gr_hdr_empcode		, gr_hdr_orderdoc			, gr_hdr_orderou, 
		gr_hdr_orderno					, gr_hdr_orderamendno	, gr_hdr_orderdate			, gr_hdr_orderapprdate, 
		gr_hdr_orderfolder				, gr_hdr_contperson		, gr_hdr_refdoc				, gr_hdr_refdocno, 
		gr_hdr_refdoclineno				, gr_hdr_suppcode		, gr_hdr_shipfromid			, gr_hdr_autoinvoice, 
		gr_hdr_invoiceat				, gr_hdr_pay2sypplier	, gr_hdr_invbeforegr		, gr_hdr_docvalue, 
		gr_hdr_addlcharges				, gr_hdr_tcdtotalvalue	, gr_hdr_totalvalue			, gr_hdr_exchrate, 
		gr_hdr_currency					, gr_hdr_frdate			, gr_hdr_fadate				, gr_hdr_fmdate, 
		gr_hdr_tcddocvalue				, gr_hdr_otcddocvalue	, gr_hdr_vatincl			, gr_hdr_retainchrg, 
		gr_hdr_createdby				, gr_hdr_createdate		, gr_hdr_modifiedby			, gr_hdr_modifieddate, 
		gr_hdr_timestamp				, gr_hdr_invoicevalue	, gr_hdr_remarks			, gr_hdr_refou, 
		gr_hdr_vatcharges				, gr_hdr_nonvatcharges	, gr_hdr_doclvldisc			, gr_hdr_totexclamt, 
		gr_hdr_totinclamt				, gr_hdr_totvatamt		, gr_hdr_tcal_status		, gr_hdr_total_tcal_amount, 
		gr_hdr_tot_excludingtcal_amount	, gr_hdr_tareweight		, gr_hdr_grossweight		, gr_hdr_weight, 
		gr_hdr_entryno					, gr_hdr_lc_no			, gr_hdr_ref_id				, gr_hdr_lr_no, 
		gr_hdr_lr_date					, gr_hdr_revdate		, gr_hdr_revremrks			, gr_hdr_revres_cd, 
		gr_hdr_revres_dsc				, gr_hdr_form57f		, gr_hdr_staxformno			, gr_hdr_roadpermitno, 
		gr_hdr_tripsheetno				, gr_hdr_suppinvno		, gr_hdr_suppinvdate		, gr_hdr_genfrom, 
		gr_hdr_party_tax_region			, gr_hdr_party_regd_no	, gr_hdr_own_tax_region		, gr_hdr_vessel_code, 
		gr_hdr_vessel_name				, gr_hdr_voyage_id		, gr_hdr_additional_info	, etlcreateddatetime
	)
	SELECT 
		gr_hdr_ouinstid					, gr_hdr_grno			, gr_hdr_grdate				, gr_hdr_grstatus, 
		gr_hdr_numseries				, gr_hdr_grfolder		, gr_hdr_grtype				, gr_hdr_gatepassno, 
		gr_hdr_gatepassdate				, gr_hdr_transmode		, gr_hdr_carriername		, gr_hdr_vehicleno, 
		gr_hdr_noofitems				, gr_hdr_consweight		, gr_hdr_consuom			, gr_hdr_delynoteno, 
		gr_hdr_delynotedate				, gr_hdr_empcode		, gr_hdr_orderdoc			, gr_hdr_orderou, 
		gr_hdr_orderno					, gr_hdr_orderamendno	, gr_hdr_orderdate			, gr_hdr_orderapprdate, 
		gr_hdr_orderfolder				, gr_hdr_contperson		, gr_hdr_refdoc				, gr_hdr_refdocno, 
		gr_hdr_refdoclineno				, gr_hdr_suppcode		, gr_hdr_shipfromid			, gr_hdr_autoinvoice, 
		gr_hdr_invoiceat				, gr_hdr_pay2sypplier	, gr_hdr_invbeforegr		, gr_hdr_docvalue, 
		gr_hdr_addlcharges				, gr_hdr_tcdtotalvalue	, gr_hdr_totalvalue			, gr_hdr_exchrate, 
		gr_hdr_currency					, gr_hdr_frdate			, gr_hdr_fadate				, gr_hdr_fmdate, 
		gr_hdr_tcddocvalue				, gr_hdr_otcddocvalue	, gr_hdr_vatincl			, gr_hdr_retainchrg, 
		gr_hdr_createdby				, gr_hdr_createdate		, gr_hdr_modifiedby			, gr_hdr_modifieddate, 
		gr_hdr_timestamp				, gr_hdr_invoicevalue	, gr_hdr_remarks			, gr_hdr_refou, 
		gr_hdr_vatcharges				, gr_hdr_nonvatcharges	, gr_hdr_doclvldisc			, gr_hdr_totexclamt, 
		gr_hdr_totinclamt				, gr_hdr_totvatamt		, gr_hdr_tcal_status		, gr_hdr_total_tcal_amount, 
		gr_hdr_tot_excludingtcal_amount	, gr_hdr_tareweight		, gr_hdr_grossweight		, gr_hdr_weight, 
		gr_hdr_entryno					, gr_hdr_lc_no			, gr_hdr_ref_id				, gr_hdr_lr_no, 
		gr_hdr_lr_date					, gr_hdr_revdate		, gr_hdr_revremrks			, gr_hdr_revres_cd, 
		gr_hdr_revres_dsc				, gr_hdr_form57f		, gr_hdr_staxformno			, gr_hdr_roadpermitno, 
		gr_hdr_tripsheetno				, gr_hdr_suppinvno		, gr_hdr_suppinvdate		, gr_hdr_genfrom, 
		gr_hdr_party_tax_region			, gr_hdr_party_regd_no	, gr_hdr_own_tax_region		, gr_hdr_vessel_code, 
		gr_hdr_vessel_name				, gr_hdr_voyage_id		, gr_hdr_additional_info	, etlcreateddatetime
	FROM stg.stg_gr_hdr_grmain;
    END IF;
    
    EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);
    
        
       select 0 into inscnt;
       select 0 into updcnt;   
       
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_grheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
