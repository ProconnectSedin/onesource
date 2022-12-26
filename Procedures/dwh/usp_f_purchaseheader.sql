-- PROCEDURE: dwh.usp_f_purchaseheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_purchaseheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_purchaseheader(
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
	FROM stg.stg_po_pomas_pur_order_hdr;

	UPDATE dwh.f_purchaseheader t
    SET 
         po_loc_key                   = COALESCE(l.loc_key,-1)
        ,po_date_key                  = COALESCE(d.datekey,-1)
        ,po_cur_key                  = COALESCE(c.curr_key,-1)
        ,po_supp_key                  = COALESCE(v.vendor_key,-1)
		,podate =  s.pomas_podate
		,poauthdate =  s.pomas_poauthdate
		,podocstatus =  s.pomas_podocstatus
		,potype =  s.pomas_potype
		,loitoorder =  s.pomas_loitoorder
		,loi =  s.pomas_loi
		,hold =  s.pomas_hold
		,orgsource =  s.pomas_orgsource
		,suppliercode =  s.pomas_suppliercode
		,contactperson =  s.pomas_contactperson
		,pocurrency =  s.pomas_pocurrency
		,exchangerate =  s.pomas_exchangerate
		,pobasicvalue =  s.pomas_pobasicvalue
		,tcdtotalrate =  s.pomas_tcdtotalrate
		,poaddlncharge =  s.pomas_poaddlncharge
		,folder =  s.pomas_folder
		,remarks =  s.pomas_remarks
		,createdby =  s.pomas_createdby
		,holdreason =  s.pomas_holdreason
		,createddate =  s.pomas_createddate
		,lastmodifiedby =  s.pomas_lastmodifiedby
		,lastmodifieddate =  s.pomas_lastmodifieddate
		,ptimestamp =  s.pomas_timestamp
		,avgvatrate =  s.pomas_avgvatrate
		,vatinclusive =  s.pomas_vatinclusive
		,filename =  s.pomas_filename
		,tax_status =  s.pomas_tax_status
		,tcal_total_amount =  s.pomas_tcal_total_amount
		,tcal_excl_amount =  s.pomas_tcal_excl_amount
		,qpoflag =  s.pomas_qpoflag
		,wfstatus =  s.pomas_wfstatus
		,imports =  s.pomas_imports
		,shipfrm =  s.pomas_shipfrm
		,numseries =  s.pomas_numseries
		,amd_srccomp =  s.pomas_amd_srccomp
		,poamendmentdate =  s.pomas_poamendmentdate
		,gen_from =  s.gen_from
		,location =  s.pomas_location
		,poitm_location =  s.poitm_location
		,contract =  s.pomas_contract
		,party_tax_region =  s.pomas_party_tax_region
		,party_regd_no =  s.pomas_party_regd_no
		,own_tax_region =  s.pomas_own_tax_region
		,mail_sent =  s.pomas_mail_sent
		,auth_remarks =  s.pomas_auth_remarks
		,reason_return =  s.pomas_reason_return
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_po_pomas_pur_order_hdr s
	LEFT JOIN dwh.d_location L 		
		ON s.pomas_location 	= L.loc_code 
        AND s.pomas_poou        = L.loc_ou
	LEFT JOIN dwh.d_date D 			
		ON s.pomas_podate::date = D.dateactual
	LEFT JOIN dwh.d_currency C 		
		ON s.pomas_pocurrency  = C.iso_curr_code 
	LEFT JOIN dwh.d_vendor V 		
		ON s.pomas_suppliercode  = V.vendor_id 
        AND s.pomas_poou        = V.vendor_ou	
    WHERE t.poou =  s.pomas_poou
      AND t.pono =  s.pomas_pono
      AND t.poamendmentno =  s.pomas_poamendmentno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_purchaseheader
	(
		po_loc_key,				po_date_key,			po_cur_key,			po_supp_key, 
        poou,					pono,					poamendmentno,		podate,
		poauthdate,				podocstatus,			potype,				loitoorder,
		loi,					hold,					orgsource,			suppliercode,
		contactperson,			pocurrency,				exchangerate,		pobasicvalue,
		tcdtotalrate,			poaddlncharge,			folder,				remarks,
		createdby,				holdreason,				createddate,		lastmodifiedby,
		lastmodifieddate,		ptimestamp,				avgvatrate,			vatinclusive,
		filename,				tax_status,				tcal_total_amount,	tcal_excl_amount,
		qpoflag,				wfstatus,				imports,			shipfrm,
		numseries,				amd_srccomp,			poamendmentdate,	gen_from,
		location,				poitm_location,			contract,			party_tax_region,
		party_regd_no,			own_tax_region,			mail_sent,			auth_remarks,
		reason_return,          etlactiveind,		    etljobname,         envsourcecd,							 
        datasourcecd,			etlcreatedatetime
	)
	
	SELECT 
	   	COALESCE(L.loc_key,-1),			D.datekey,						COALESCE(C.curr_key,-1),	    COALESCE(V.vendor_key,-1),		
        s.pomas_poou,					s.pomas_pono,					s.pomas_poamendmentno,		s.pomas_podate,
		s.pomas_poauthdate,				s.pomas_podocstatus,			s.pomas_potype,				s.pomas_loitoorder,
		s.pomas_loi,					s.pomas_hold,					s.pomas_orgsource,			s.pomas_suppliercode,
		s.pomas_contactperson,			s.pomas_pocurrency,				s.pomas_exchangerate,		s.pomas_pobasicvalue,
		s.pomas_tcdtotalrate,			s.pomas_poaddlncharge,			s.pomas_folder,				s.pomas_remarks,
		s.pomas_createdby,				s.pomas_holdreason,				s.pomas_createddate,		s.pomas_lastmodifiedby,
		s.pomas_lastmodifieddate,		s.pomas_timestamp,				s.pomas_avgvatrate,			s.pomas_vatinclusive,
		s.pomas_filename,				s.pomas_tax_status,				s.pomas_tcal_total_amount,	s.pomas_tcal_excl_amount,
		s.pomas_qpoflag,				s.pomas_wfstatus,				s.pomas_imports,			s.pomas_shipfrm,
		s.pomas_numseries,				s.pomas_amd_srccomp,			s.pomas_poamendmentdate,	s.gen_from,
		s.pomas_location,				s.poitm_location,				s.pomas_contract,			s.pomas_party_tax_region,
		s.pomas_party_regd_no,			s.pomas_own_tax_region,			s.pomas_mail_sent,			s.pomas_auth_remarks,
		s.pomas_reason_return,          1 AS etlactiveind,				p_etljobname,               p_envsourcecd,							
        p_datasourcecd,					NOW()
	FROM stg.stg_po_pomas_pur_order_hdr s
	LEFT JOIN dwh.d_location L 		
		ON s.pomas_location 	    = L.loc_code 
        AND s.pomas_poou           = L.loc_ou
	LEFT JOIN dwh.d_date D 			
		ON s.pomas_podate::date 	= D.dateactual
	LEFT JOIN dwh.d_currency C 		
		ON s.pomas_pocurrency	    = C.iso_curr_code 
	LEFT JOIN dwh.d_vendor V 		
		ON s.pomas_suppliercode 	= V.vendor_id 
        AND s.pomas_poou           = V.vendor_ou
	LEFT JOIN dwh.f_purchaseheader FH 	
		ON FH.poou =  s.pomas_poou
      AND FH.pono =  s.pomas_pono
      AND FH.poamendmentno =  s.pomas_poamendmentno
    WHERE FH.pono IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_po_pomas_pur_order_hdr
	(
		pomas_poou, pomas_pono, pomas_poamendmentno, pomas_podate, pomas_poauthdate, 
		pomas_podocstatus, pomas_potype, pomas_loitoorder, pomas_loi, pomas_hold, 
		pomas_orgsource, pomas_requoteno, pomas_suppliercode, pomas_contactperson, 
		pomas_buyercode, pomas_pocurrency, pomas_exchangerate, pomas_pobasicvalue, 
		pomas_tcdtotalrate, pomas_poaddlncharge, pomas_folder, pomas_remarks, 
		pomas_createdby, pomas_holdreason, pomas_createddate, pomas_lastmodifiedby, 
		pomas_lastmodifieddate, pomas_timestamp, pomas_avgvatrate, pomas_vatinclusive, 
		pomas_pcstatus, pomas_filename, pomas_tax_status, pomas_tcal_total_amount, 
		pomas_tcal_excl_amount, pomas_qpoflag, pomas_wfstatus, pomas_imports, pomas_shipfrm, 
		pomas_numseries, pomas_refdocno, pomas_refdocou, pomas_ms_app_flag, pomas_retentionperc, 
		pomas_ret_postol, pomas_ret_negtol, pomas_so_no, pomas_so_ou, pomas_so_amendno, 
		pomas_amd_srccomp, pomas_poamendmentdate, gen_from, pomas_clientcode, pomas_budgetdescription, 
		pomas_location, poitm_location, pomas_contract, pomas_party_tax_region, pomas_party_regd_no, 
		pomas_own_tax_region, pomas_mail_sent, pomas_cls_code, pomas_scls_code, pomas_auth_remarks, 
		pomas_reason_return, etlcreateddatetime
	
	)
	SELECT 
		pomas_poou, pomas_pono, pomas_poamendmentno, pomas_podate, pomas_poauthdate, 
		pomas_podocstatus, pomas_potype, pomas_loitoorder, pomas_loi, pomas_hold, 
		pomas_orgsource, pomas_requoteno, pomas_suppliercode, pomas_contactperson, 
		pomas_buyercode, pomas_pocurrency, pomas_exchangerate, pomas_pobasicvalue, 
		pomas_tcdtotalrate, pomas_poaddlncharge, pomas_folder, pomas_remarks, 
		pomas_createdby, pomas_holdreason, pomas_createddate, pomas_lastmodifiedby, 
		pomas_lastmodifieddate, pomas_timestamp, pomas_avgvatrate, pomas_vatinclusive, 
		pomas_pcstatus, pomas_filename, pomas_tax_status, pomas_tcal_total_amount, 
		pomas_tcal_excl_amount, pomas_qpoflag, pomas_wfstatus, pomas_imports, pomas_shipfrm, 
		pomas_numseries, pomas_refdocno, pomas_refdocou, pomas_ms_app_flag, pomas_retentionperc, 
		pomas_ret_postol, pomas_ret_negtol, pomas_so_no, pomas_so_ou, pomas_so_amendno, 
		pomas_amd_srccomp, pomas_poamendmentdate, gen_from, pomas_clientcode, pomas_budgetdescription, 
		pomas_location, poitm_location, pomas_contract, pomas_party_tax_region, pomas_party_regd_no, 
		pomas_own_tax_region, pomas_mail_sent, pomas_cls_code, pomas_scls_code, pomas_auth_remarks, 
		pomas_reason_return, etlcreateddatetime
	FROM stg.stg_po_pomas_pur_order_hdr;
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
ALTER PROCEDURE dwh.usp_f_purchaseheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
