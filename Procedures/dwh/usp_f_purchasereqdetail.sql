-- PROCEDURE: dwh.usp_f_purchasereqdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_purchasereqdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_purchasereqdetail(
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
    p_batchid INTEGER;
	p_taskname VARCHAR(100);
	p_packagename  VARCHAR(100);
    p_errorid INTEGER;
	p_errordesc character varying;
	p_errorline INTEGER;
    p_depsource VARCHAR(100);
    p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag,h.depsource
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON  d.sourceid      = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt FROM stg.stg_prq_prqit_item_detail;

	UPDATE dwh.F_PurchaseReqDetail t
    SET 
		  preqm_hr_key					= fh.preqm_hr_key
		, preqm_dtl_loc_key				= COALESCE(l.loc_key,-1)
		, preqm_dtl_customer_key		= COALESCE(c.customer_key,-1)
		, preqm_dtl_vendor_key			= COALESCE(v.vendor_key,-1)
		, preqm_dtl_wh_key				= COALESCE(w.wh_key,-1)
        , preqm_dtl_uom_key			    = COALESCE(u.uom_key,-1)
		, prqit_itemcode                = s.prqit_itemcode
		, prqit_variant                 = s.prqit_variant
		, prqit_itemdescription         = s.prqit_itemdescription
		, prqit_reqdqty                 = s.prqit_reqdqty
		, prqit_puom                    = s.prqit_puom
		, prqit_cost                    = s.prqit_cost
		, prqit_costper                 = s.prqit_costper
		, prqit_needdate                = s.prqit_needdate
		, prqit_pr_del_type             = s.prqit_pr_del_type
		, prqit_warehousecode           = s.prqit_warehousecode
		, prqit_prposalid               = s.prqit_prposalid
		, prqit_authqty                 = s.prqit_authqty
		, prqit_customercode            = s.prqit_customercode
		, prqit_balqty                  = s.prqit_balqty
		, prqit_prlinestatus            = s.prqit_prlinestatus
		, prqit_supplier_code           = s.prqit_supplier_code
		, prqit_pref_supplier_code      = s.prqit_pref_supplier_code
		, prqit_referencetype           = s.prqit_referencetype
		, prqit_ref_doc                 = s.prqit_ref_doc
		, prqit_refdoclineno            = s.prqit_refdoclineno
		, prqit_adhocitemclass          = s.prqit_adhocitemclass
		, prqit_attrvalue               = s.prqit_attrvalue
		, prqit_createdby               = s.prqit_createdby
		, prqit_createddate             = s.prqit_createddate
		, prqit_lastmodifiedby          = s.prqit_lastmodifiedby
		, prqit_lastmodifieddate        = s.prqit_lastmodifieddate
		, prqit_availableqty            = s.prqit_availableqty
		, prqit_location                = s.prqit_location
		, prqit_comments                = s.prqit_comments
		, etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_prq_prqit_item_detail s
	INNER JOIN 	dwh.f_purchasereqheader fh 
		ON  s.prqit_prou 				= fh.preqm_prou 
		AND s.prqit_prno 			    = fh.preqm_prno 
	LEFT JOIN dwh.d_location l 		
		ON  s.prqit_location 			= l.loc_code 
        AND s.prqit_prou        		= l.loc_ou
	LEFT JOIN dwh.d_customer c 			
		ON  s.prqit_customercode 		= c.customer_id
        AND s.prqit_prou        		= c.customer_ou
	LEFT JOIN dwh.d_vendor v 		
		ON  s.prqit_pref_supplier_code  = v.vendor_id 
        AND s.prqit_prou        		= v.vendor_ou
    LEFT JOIN dwh.d_warehouse w 		
		ON  s.prqit_warehousecode  		= w.wh_code 
        AND s.prqit_prou        		= w.wh_ou    
	LEFT JOIN dwh.d_uom u 		
		ON  s.prqit_puom  		        = u.mas_uomcode 
        AND s.prqit_prou        		= u.mas_ouinstance	
    WHERE   t.prqit_prou 				= s.prqit_prou
		AND	t.prqit_prno 				= s.prqit_prno
		AND	t.preqm_hr_key				= fh.preqm_hr_key;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.F_PurchaseReqDetail
	(
		  preqm_hr_key				, preqm_dtl_loc_key		, preqm_dtl_customer_key	, preqm_dtl_vendor_key		, preqm_dtl_wh_key 	        , preqm_dtl_uom_key
        , prqit_prou				, prqit_prno			, prqit_lineno			    , prqit_itemcode			, prqit_variant
        , prqit_itemdescription		, prqit_reqdqty			, prqit_puom			    , prqit_cost				, prqit_costper
        , prqit_needdate			, prqit_pr_del_type		, prqit_warehousecode	    , prqit_prposalid			, prqit_authqty
        , prqit_customercode		, prqit_balqty			, prqit_prlinestatus	    , prqit_supplier_code		, prqit_pref_supplier_code
        , prqit_referencetype		, prqit_ref_doc			, prqit_refdoclineno	    , prqit_adhocitemclass		, prqit_attrvalue
        , prqit_createdby			, prqit_createddate		, prqit_lastmodifiedby	    , prqit_lastmodifieddate	, prqit_availableqty
        , prqit_location			, prqit_comments
		, etlactiveind				, etljobname			, envsourcecd				, datasourcecd	            , etlcreatedatetime
	)
	
	SELECT 
		  fh.preqm_hr_key			, COALESCE(l.loc_key,-1)	, COALESCE(c.customer_key,-1)   , COALESCE(v.vendor_key,-1)	, COALESCE(w.wh_key,-1) 		, COALESCE(u.uom_key,-1)
        , s.prqit_prou				, s.prqit_prno				, s.prqit_lineno			    , s.prqit_itemcode			, s.prqit_variant
		, s.prqit_itemdescription	, s.prqit_reqdqty			, s.prqit_puom				    , s.prqit_cost				, s.prqit_costper
		, s.prqit_needdate			, s.prqit_pr_del_type		, s.prqit_warehousecode		    , s.prqit_prposalid			, s.prqit_authqty
		, s.prqit_customercode		, s.prqit_balqty			, s.prqit_prlinestatus		    , s.prqit_supplier_code		, s.prqit_pref_supplier_code
		, s.prqit_referencetype		, s.prqit_ref_doc			, s.prqit_refdoclineno		    , s.prqit_adhocitemclass	, s.prqit_attrvalue
		, s.prqit_createdby			, s.prqit_createddate		, s.prqit_lastmodifiedby	    , s.prqit_lastmodifieddate	, s.prqit_availableqty
		, s.prqit_location			, s.prqit_comments
		, 1 AS etlactiveind			, p_etljobname				, p_envsourcecd				    , p_datasourcecd	        , NOW()
	FROM stg.stg_prq_prqit_item_detail s
	INNER JOIN 	dwh.f_purchasereqheader fh 
		ON  s.prqit_prou 				= fh.preqm_prou 
		AND s.prqit_prno 			    = fh.preqm_prno 
	LEFT JOIN dwh.d_location l 		
		ON  s.prqit_location 			= l.loc_code 
        AND s.prqit_prou        		= l.loc_ou
	LEFT JOIN dwh.d_customer c 			
		ON  s.prqit_customercode 		= c.customer_id
        AND s.prqit_prou        		= c.customer_ou
	LEFT JOIN dwh.d_vendor v 		
		ON  s.prqit_pref_supplier_code  	= v.vendor_id 
        AND s.prqit_prou        		= v.vendor_ou
    LEFT JOIN dwh.d_warehouse w 		
		ON  s.prqit_warehousecode  		= w.wh_code 
        AND s.prqit_prou        		= w.wh_ou    
	LEFT JOIN dwh.d_uom u 		
		ON  s.prqit_puom  		        = u.mas_uomcode 
        AND s.prqit_prou        		= u.mas_ouinstance		
	LEFT JOIN dwh.F_PurchaseReqDetail fd  	
		ON  fh.preqm_prou 				= fd.prqit_prou 
		AND fh.preqm_prno 			    = fd.prqit_prno 
		AND fh.preqm_hr_key				= fd.preqm_hr_key
    WHERE fd.prqit_prno IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_prq_prqit_item_detail
	(
		prqit_prou, 			prqit_prno, 				prqit_lineno, 			prqit_itemcode, 		prqit_variant, 
        prqit_itemdescription, 	prqit_reqdqty, 				prqit_puom, 			prqit_cost, 			prqit_costper, 
        prqit_needdate, 		prqit_pr_del_type, 			prqit_warehousecode, 	prqit_budgetid, 		prqit_prposalid, 
        prqit_dropshipid, 		prqit_authqty, 				prqit_customercode, 	prqit_balqty, 			prqit_prlinestatus, 
        prqit_supplier_code, 	prqit_pref_supplier_code, 	prqit_drg_revision_no, 	prqit_referencetype, 	prqit_ref_doc, 
        prqit_refdoclineno, 	prqit_adhocitemclass, 		prqit_remarks, 			prqit_attrvalue, 		prqit_createdby, 
        prqit_createddate, 		prqit_lastmodifiedby, 		prqit_lastmodifieddate, prqit_drgno, 			prqit_wbs, 
        prqit_availableqty, 	prqit_location, 			prqit_comments, 		etlcreateddatetime
	
	)
	SELECT 
		prqit_prou, 			prqit_prno, 				prqit_lineno, 			prqit_itemcode, 		prqit_variant, 
        prqit_itemdescription, 	prqit_reqdqty, 				prqit_puom, 			prqit_cost, 			prqit_costper, 
        prqit_needdate, 		prqit_pr_del_type, 			prqit_warehousecode, 	prqit_budgetid, 		prqit_prposalid, 
        prqit_dropshipid, 		prqit_authqty, 				prqit_customercode, 	prqit_balqty, 			prqit_prlinestatus, 
        prqit_supplier_code, 	prqit_pref_supplier_code, 	prqit_drg_revision_no, 	prqit_referencetype, 	prqit_ref_doc, 
        prqit_refdoclineno, 	prqit_adhocitemclass, 		prqit_remarks, 			prqit_attrvalue, 		prqit_createdby, 
        prqit_createddate, 		prqit_lastmodifiedby, 		prqit_lastmodifieddate, prqit_drgno, 			prqit_wbs, 
        prqit_availableqty, 	prqit_location, 			prqit_comments, 		etlcreateddatetime
	FROM stg.stg_prq_prqit_item_detail;
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
ALTER PROCEDURE dwh.usp_f_purchasereqdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
