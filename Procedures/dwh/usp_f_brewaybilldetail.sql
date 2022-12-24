-- PROCEDURE: dwh.usp_f_brewaybilldetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_brewaybilldetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_brewaybilldetail(
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
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN
	
		SELECT COUNT(1) INTO srccnt FROM stg.stg_tms_br_ewayBill_details;

		INSERT INTO dwh.f_brewaybilldetail
	(
	    br_key,
		ewbd_br_no,					ewbd_ouinstance,			ewbd_bill_no,			ewbd_ewaybl_guid,
		ewbd_remarks,				ewbd_created_date,			ewbd_created_by,		ewbd_modified_date,
		ewbd_modified_by,			ewbd_timestamp,				ewbd_expiry_date,		ewbd_shipper_invoice_date,
		ewbd_shipper_invoice_value,	ewbd_shipper_invoice_no,
		etlactiveind,       		etljobname, 				envsourcecd, 			datasourcecd, 	
        etlcreatedatetime
	)
	
    SELECT 
	    fh.br_key,
		s.ewbd_br_no,					s.ewbd_ouinstance,				s.ewbd_bill_no,			s.ewbd_ewaybl_guid,
		s.ewbd_remarks,					s.ewbd_created_date,			s.ewbd_created_by,		s.ewbd_modified_date,
		s.ewbd_modified_by,				s.ewbd_timestamp,				s.ewbd_expiry_date,		s.ewbd_shipper_invoice_date,
		s.ewbd_shipper_invoice_value,	s.ewbd_shipper_invoice_no,
		1,                    			p_etljobname,		 			p_envsourcecd,	   		p_datasourcecd,			
        NOW()
	FROM stg.stg_tms_br_ewayBill_details s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.ewbd_ouinstance 						= fh.br_ouinstance
            AND S.ewbd_br_no                            = fh.br_request_Id
    LEFT JOIN dwh.f_brewaybilldetail t
    ON 	COALESCE(s.ewbd_br_no,'NULL') 	    			= COALESCE(t.ewbd_br_no,'NULL')
	AND COALESCE(s.ewbd_ouinstance,0)  			        = COALESCE(t.ewbd_ouinstance,0)
	AND COALESCE(s.ewbd_bill_no,'NULL')  				= COALESCE(t.ewbd_bill_no,'NULL')
	AND COALESCE(s.ewbd_ewaybl_guid,'NULL') 			= COALESCE(t.ewbd_ewaybl_guid ,'NULL')
    AND COALESCE(s.ewbd_remarks,'NULL') 				= COALESCE(t.ewbd_remarks,'NULL')
    --AND COALESCE(s.ewbd_created_date,'NULL') 			= COALESCE(t.ewbd_created_date,'NULL')
    AND COALESCE(s.ewbd_created_by,'NULL') 				= COALESCE(t.ewbd_created_by,'NULL')
    --AND COALESCE(s.ewbd_modified_date,'NULL')  			= COALESCE(t.ewbd_modified_date,'NULL')
    AND COALESCE(s.ewbd_modified_by,'NULL') 			= COALESCE(t.ewbd_modified_by,'NULL')
    --AND COALESCE(s.ewbd_timestamp,0)  			        = COALESCE(t.ewbd_timestamp,0)
    --AND COALESCE(s.ewbd_expiry_date,'NULL') 			= COALESCE(t.ewbd_expiry_date,'NULL')
	--AND COALESCE(s.ewbd_shipper_invoice_date,'NULL') 	= COALESCE(t.ewbd_shipper_invoice_date,'NULL')
	AND COALESCE(s.ewbd_shipper_invoice_value,0) 	    = COALESCE(t.ewbd_shipper_invoice_value,0)
	AND COALESCE(s.ewbd_shipper_invoice_no,'NULL') 		= COALESCE(t.ewbd_shipper_invoice_no,'NULL')
    WHERE t.ewbd_ouinstance IS NULL;
   
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	select 0 into updcnt;
	
	
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_tms_br_ewayBill_details
	(
		ewbd_br_no, 			ewbd_ouinstance, 			ewbd_bill_no, 				ewbd_ewaybl_guid, 			ewbd_remarks, 
		ewbd_created_date, 		ewbd_created_by, 			ewbd_modified_date, 		ewbd_modified_by, 			ewbd_timestamp, 
		ewbd_expiry_date, 		ewbd_shipper_invoice_date, 	ewbd_shipper_invoice_value, ewbd_shipper_invoice_no, 	etlcreateddatetime

	)
	SELECT 
		ewbd_br_no, 			ewbd_ouinstance, 			ewbd_bill_no, 				ewbd_ewaybl_guid, 			ewbd_remarks, 
		ewbd_created_date, 		ewbd_created_by, 			ewbd_modified_date, 		ewbd_modified_by, 			ewbd_timestamp, 
		ewbd_expiry_date, 		ewbd_shipper_invoice_date, 	ewbd_shipper_invoice_value, ewbd_shipper_invoice_no, 	etlcreateddatetime

	FROM stg.stg_tms_br_ewayBill_details;
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
ALTER PROCEDURE dwh.usp_f_brewaybilldetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
