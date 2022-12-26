-- PROCEDURE: dwh.usp_f_purchasedetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_purchasedetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_purchasedetails(
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

    SELECT COUNT(1) INTO srccnt FROM stg.stg_po_poitm_item_detail;

	UPDATE dwh.f_purchasedetails t
    SET 
		 po_hr_key					= fh.po_hr_key
		,po_dtl_loc_key				= COALESCE(l.loc_key,-1)
		,po_dtl_wh_key			    = COALESCE(wh.wh_key,-1)
		,po_dtl_cust_key			= COALESCE(c.customer_key,-1)
		,po_dtl_uom_key				= COALESCE(u.uom_key,-1)
		,itemcode                   = s.poitm_itemcode
		,variant                    = s.poitm_variant
		,order_quantity             = s.poitm_order_quantity
		,pobalancequantity          = s.poitm_pobalancequantity
		,puom                       = s.poitm_puom
		,po_cost                    = s.poitm_po_cost
		,costper                    = s.poitm_costper
		,shiptoou                   = s.poitm_shiptoou
		,tcdtotalamount             = s.poitm_tcdtotalamount
		,warehousecode              = s.poitm_warehousecode
		,itemvalue                  = s.poitm_itemvalue
		,polinestatus               = s.poitm_polinestatus
		,createdby                  = s.poitm_createdby
		,createddate                = s.poitm_createddate
		,lastmodifiedby             = s.poitm_lastmodifiedby
		,lastmodifieddate           = s.poitm_lastmodifieddate
		,itemdescription            = s.poitm_itemdescription
		,schedtype                  = s.poitm_schedtype
		,needdate                   = s.poitm_needdate
		,accunit                    = s.poitm_accunit
		,adhocitemclass             = s.poitm_adhocitemclass
		,refdocno                   = s.poitm_refdocno
		,refdoclineno               = s.poitm_refdoclineno
		,comments                   = s.poitm_comments
		,customercode               = s.poitm_customercode
		,proposalid                 = s.poitm_proposalid
		,attrvalue                  = s.poitm_attrvalue
		,grrecdqty                  = s.poitm_grrecdqty
		,graccpdqty                 = s.poitm_graccpdqty
		,grmovdqty                  = s.poitm_grmovdqty
		,matched_qty                = s.poitm_matched_qty
		,matched_amt                = s.poitm_matched_amt
		,billed_qty                 = s.poitm_billed_qty
		,billed_amt                 = s.poitm_billed_amt
		,adhocplng                  = s.poitm_adhocplng
		,location                   = s.poitm_location
		,availableqty               = s.poitm_availableqty
		, etlactiveind 			    = 1
		, etljobname 				= p_etljobname
		, envsourcecd 				= p_envsourcecd
		, datasourcecd 				= p_datasourcecd
		, etlupdatedatetime 		= NOW()	
    FROM stg.stg_po_poitm_item_detail s
	INNER JOIN 	dwh.f_purchaseheader fh 
		ON  s.poitm_poou 				= fh.poou 
		AND s.poitm_pono 			    = fh.pono 
		AND s.poitm_poamendmentno 		= fh.poamendmentno     
	LEFT JOIN dwh.d_location L 		
		ON  s.poitm_location 			= L.loc_code 
        AND s.poitm_poou        		= L.loc_ou
	LEFT JOIN dwh.d_warehouse wh 			
		ON  s.poitm_warehousecode 		= wh.wh_code
        AND s.poitm_poou        		= wh.wh_ou
	LEFT JOIN dwh.d_customer c 		
		ON  s.poitm_customercode  		= c.customer_id 
        AND s.poitm_poou        		= c.customer_ou
	LEFT JOIN dwh.d_uom u 		
		ON  s.poitm_puom  		        = u.mas_uomcode 
        AND s.poitm_poou        		= u.mas_ouinstance	
    WHERE   t.poou 						= s.poitm_poou 
		AND t.pono 			    		= s.poitm_pono 
		AND t.poamendmentno 			= s.poitm_poamendmentno
		AND t.polineno	= s.poitm_polineno;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_purchasedetails
	(
		  po_hr_key				    , po_dtl_loc_key			, po_dtl_wh_key		        , po_dtl_cust_key			, po_dtl_uom_key, 		
		  poou,			            pono,				        poamendmentno,			    polineno,			        itemcode,
		  variant,		            order_quantity,	            pobalancequantity,		    puom,				        po_cost,
		  costper,		            shiptoou,			        tcdtotalamount,			    warehousecode,		        itemvalue,
		  polinestatus,	            createdby,		            createddate,			    lastmodifiedby,		        lastmodifieddate,
		  itemdescription,          schedtype,		            needdate,				    accunit,			        adhocitemclass,
	      refdocno,		            refdoclineno,	            comments,				    customercode,		        proposalid,
		  attrvalue,		        grrecdqty,		            graccpdqty,				    grmovdqty,			        matched_qty,
		  matched_amt,	            billed_qty,		            billed_amt,				    adhocplng,			        location,
		  availableqty,

		  etlactiveind				, etljobname				, envsourcecd				, datasourcecd	            , etlcreatedatetime
	)
	
	SELECT 
		fh.po_hr_key			 , COALESCE(l.loc_key,-1)	,COALESCE(wh.wh_key,-1)         ,COALESCE(c.customer_key,-1)	,COALESCE(u.uom_key,-1), 
        s.poitm_poou,			 s.poitm_pono,				s.poitm_poamendmentno,			s.poitm_polineno,			s.poitm_itemcode,
		s.poitm_variant,		 s.poitm_order_quantity,	s.poitm_pobalancequantity,		s.poitm_puom,				s.poitm_po_cost,
		s.poitm_costper,		 s.poitm_shiptoou,			s.poitm_tcdtotalamount,			s.poitm_warehousecode,		s.poitm_itemvalue,
		s.poitm_polinestatus,	 s.poitm_createdby,		    s.poitm_createddate,			s.poitm_lastmodifiedby,		s.poitm_lastmodifieddate,
		s.poitm_itemdescription, s.poitm_schedtype,		    s.poitm_needdate,				s.poitm_accunit,			s.poitm_adhocitemclass,
		s.poitm_refdocno,		 s.poitm_refdoclineno,	    s.poitm_comments,				s.poitm_customercode,		s.poitm_proposalid,
		s.poitm_attrvalue,		 s.poitm_grrecdqty,		    s.poitm_graccpdqty,				s.poitm_grmovdqty,			s.poitm_matched_qty,
		s.poitm_matched_amt,	 s.poitm_billed_qty,		s.poitm_billed_amt,				s.poitm_adhocplng,			s.poitm_location,
		s.poitm_availableqty,
        1 AS etlactiveind		 , p_etljobname				, p_envsourcecd				, p_datasourcecd	            , NOW()
	FROM stg.stg_po_poitm_item_detail s
	INNER JOIN dwh.f_purchaseheader fh 
		ON  s.poitm_poou 				= fh.poou 
		AND s.poitm_pono 			    = fh.pono 
		AND s.poitm_poamendmentno 		= fh.poamendmentno
	LEFT JOIN dwh.d_location L 		
		ON  s.poitm_location 			= L.loc_code 
        AND s.poitm_poou        		= L.loc_ou
	LEFT JOIN dwh.d_warehouse wh 			
		ON  s.poitm_warehousecode 		= wh.wh_code
        AND s.poitm_poou        		= wh.wh_ou
	LEFT JOIN dwh.d_customer c 		
		ON  s.poitm_customercode  		= c.customer_id 
        AND s.poitm_poou        		= c.customer_ou
	LEFT JOIN dwh.d_uom u 		
		ON  s.poitm_puom  		        = u.mas_uomcode 
        AND s.poitm_poou        		= u.mas_ouinstance		
	LEFT JOIN dwh.f_purchasedetails fd  	
		ON  s.poitm_poou 				= fd.poou 
		AND s.poitm_pono 			    = fd.pono 
		AND s.poitm_poamendmentno		= fd.poamendmentno
		AND s.poitm_polineno			= fd.polineno
    WHERE fd.pono IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_po_poitm_item_detail
	(
		poitm_poou, poitm_pono, poitm_poamendmentno, poitm_polineno, poitm_itemcode, 
		poitm_variant, poitm_order_quantity, poitm_pobalancequantity, poitm_puom, 
		poitm_po_cost, poitm_costper, poitm_shiptoou, poitm_tcdtotalamount, poitm_warehousecode,
		poitm_itemvalue, poitm_polinestatus, poitm_createdby, poitm_createddate, 
		poitm_lastmodifiedby, poitm_lastmodifieddate, poitm_itemdescription, poitm_schedtype, 
		poitm_needdate, poitm_accunit, poitm_drawingrevno, poitm_adhocitemclass, poitm_refdocno, 
		poitm_refdoclineno, poitm_comments, poitm_bugetid, poitm_customercode, poitm_proposalid, 
		poitm_dropshipid, poitm_attrvalue, poitm_contactperson, poitm_grrecdqty, poitm_graccpdqty, 
		poitm_grreturnedqty, poitm_grrejdqty, poitm_grmovdqty, poitm_qtnlineno, poitm_despatchqty, 
		poitm_matched_qty, poitm_matched_amt, poitm_billed_qty, poitm_billed_amt, poitm_drgno, 
		poitm_project, poitm_project_ou, poitm_ms_app_flag, poitm_retained_amt, poitm_retention_amt, 
		poitm_ret_remarks, poitm_wbs_id, poitm_solineno, poitm_adhocplng, poitm_location, poitm_availableqty, 
		etlcreateddatetime
	
	)
	SELECT 
		poitm_poou, poitm_pono, poitm_poamendmentno, poitm_polineno, poitm_itemcode, 
		poitm_variant, poitm_order_quantity, poitm_pobalancequantity, poitm_puom, 
		poitm_po_cost, poitm_costper, poitm_shiptoou, poitm_tcdtotalamount, poitm_warehousecode,
		poitm_itemvalue, poitm_polinestatus, poitm_createdby, poitm_createddate, 
		poitm_lastmodifiedby, poitm_lastmodifieddate, poitm_itemdescription, poitm_schedtype, 
		poitm_needdate, poitm_accunit, poitm_drawingrevno, poitm_adhocitemclass, poitm_refdocno, 
		poitm_refdoclineno, poitm_comments, poitm_bugetid, poitm_customercode, poitm_proposalid, 
		poitm_dropshipid, poitm_attrvalue, poitm_contactperson, poitm_grrecdqty, poitm_graccpdqty, 
		poitm_grreturnedqty, poitm_grrejdqty, poitm_grmovdqty, poitm_qtnlineno, poitm_despatchqty, 
		poitm_matched_qty, poitm_matched_amt, poitm_billed_qty, poitm_billed_amt, poitm_drgno, 
		poitm_project, poitm_project_ou, poitm_ms_app_flag, poitm_retained_amt, poitm_retention_amt, 
		poitm_ret_remarks, poitm_wbs_id, poitm_solineno, poitm_adhocplng, poitm_location, poitm_availableqty, 
		etlcreateddatetime
	FROM stg.stg_po_poitm_item_detail;
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
ALTER PROCEDURE dwh.usp_f_purchasedetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
