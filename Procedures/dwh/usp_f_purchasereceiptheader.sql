-- PROCEDURE: dwh.usp_f_purchasereceiptheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_purchasereceiptheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_purchasereceiptheader(
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
	FROM stg.stg_rct_purchase_hdr;

	UPDATE dwh.f_purchasereceiptheader t
    SET 
         
        rcgh_date_key                 = COALESCE(d.datekey,-1),
        rcgh_num_type_no    	 =  	s.rcgh_num_type_no,      
          rcgh_wh_no    	     =   	s.rcgh_wh_no,
          rcgh_ref_doc_no     	 =   	s.rcgh_ref_doc_no,
          rcgh_ref_doc_type     = 	  	s.rcgh_ref_doc_type,
          rcgh_po_no     =   			s.rcgh_po_no,
          rcgh_receipt_date     =   	s.rcgh_receipt_date,
          rcgh_purchase_point     =  	s.rcgh_purchase_point,
          rcgh_posting_fb     =   		s.rcgh_posting_fb,
          rcgh_status     =   			s.rcgh_status,
          rcgh_created_date     =  		s.rcgh_created_date,
          rcgh_modified_by     =   		s.rcgh_modified_by,
          rcgh_modified_date     =   	s.rcgh_modified_date,
          rcgh_timestamp       =   		s.rcgh_timestamp,
          
		etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_rct_purchase_hdr s
	LEFT JOIN dwh.d_date D 			
		ON s.rcgh_receipt_date::date = D.dateactual
    WHERE   t.rcgh_ouinstid     =   s.rcgh_ouinstid
		AND t.rcgh_receipt_no     =   s.rcgh_receipt_no;
		
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_purchasereceiptheader
	(
	  rcgh_date_key, rcgh_ouinstid,   rcgh_receipt_no,   rcgh_num_type_no,   rcgh_wh_no,   rcgh_ref_doc_no,   rcgh_ref_doc_type,   rcgh_po_no,   rcgh_receipt_date,   rcgh_purchase_point,   rcgh_posting_fb,   rcgh_status,    rcgh_created_date,   rcgh_modified_by,   rcgh_modified_date,   rcgh_timestamp,  			 etlactiveind					, etljobname
		, envsourcecd							, datasourcecd							, etlcreatedatetime
	)
	
	SELECT 
	   	  D.datekey	,	   AH.rcgh_ouinstid   ,AH.rcgh_receipt_no,     AH.rcgh_num_type_no,   AH.rcgh_wh_no,   AH.rcgh_ref_doc_no,   AH.rcgh_ref_doc_type,   AH.rcgh_po_no,   AH.rcgh_receipt_date,   AH.rcgh_purchase_point,   AH.rcgh_posting_fb,   AH.rcgh_status,    AH.rcgh_created_date,   AH.rcgh_modified_by,   AH.rcgh_modified_date,   AH.rcgh_timestamp,   1 AS etlactiveind				, p_etljobname
		, p_envsourcecd							, p_datasourcecd						, NOW()
	FROM stg.stg_rct_purchase_hdr AH
	
	LEFT JOIN dwh.d_date D 			
		ON AH.rcgh_receipt_date::date 	= D.dateactual
	
	LEFT JOIN dwh.f_purchasereceiptheader FH 	
		ON  FH.rcgh_ouinstid     =   AH.rcgh_ouinstid 
		AND FH.rcgh_receipt_no     =   AH.rcgh_receipt_no 

    WHERE FH.rcgh_receipt_no IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_rct_purchase_hdr
	(
		rcgh_ouinstid,   rcgh_receipt_no,   rcgh_num_type_no,   rcgh_wh_no,   rcgh_ref_doc_no,   rcgh_ref_doc_type,   rcgh_po_no,   rcgh_receipt_date,   rcgh_purchase_point,   rcgh_posting_fb,   rcgh_status,   rcgh_reason_code,   rcgh_created_by,   rcgh_created_date,   rcgh_modified_by,   rcgh_modified_date,   rcgh_timestamp,   process_flag,  etlcreateddatetime
	
	)
	SELECT 
		rcgh_ouinstid,   rcgh_receipt_no,   rcgh_num_type_no,   rcgh_wh_no,   rcgh_ref_doc_no,   rcgh_ref_doc_type,   rcgh_po_no,   rcgh_receipt_date,   rcgh_purchase_point,   rcgh_posting_fb,   rcgh_status,   rcgh_reason_code,   rcgh_created_by,   rcgh_created_date,   rcgh_modified_by,   rcgh_modified_date,   rcgh_timestamp,   process_flag, etlcreateddatetime
	FROM stg.stg_rct_purchase_hdr;
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
ALTER PROCEDURE dwh.usp_f_purchasereceiptheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
