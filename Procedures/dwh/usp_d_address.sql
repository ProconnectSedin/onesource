CREATE PROCEDURE dwh.usp_d_address(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag

	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag

	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_emod_addr_mst;

	UPDATE dwh.d_address t
    SET 
		atimestamp    		=      s.atimestamp,      
		address1	  		=      s.address1,
		address2 	  		=	   s.address2,
		address3  	  		=      s.address3,
		address_desc  		=	   s.address_desc,
		city                =      s.city, 
		state   			=	   s.state,
		country       		=	   s.country,
		phone_no      		=	   s.phone_no,
		url           		=	   s.url,
		zip_code      		=	   s.zip_code,
		createdby     		=	   s.createdby,
		createddate   		=	   s.createddate,
		modifiedby    		=	   s.modifiedby,
		modifieddate  		=	   s.modifieddate,
		state_code    		=	   s.state_code,
		etlactiveind 		= 	   1,
		etljobname 			= 	   p_etljobname,
		envsourcecd 		= 	   p_envsourcecd ,
		datasourcecd 		= 	   p_datasourcecd ,
		etlupdatedatetime 	= 	   NOW()
		
    FROM stg.stg_emod_addr_mst s
    WHERE t.address_id  	= 	   s.address_id;

    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_address
	(
		address_id, 		atimestamp, 		address1, 		 	address2, 
		address3, 			address_desc, 		city, 			 	state, 
		country, 			phone_no, 			url, 			 	zip_code, 
		createdby, 			createddate, 		modifiedby,      	modifieddate, 
		state_code, 		etlactiveind, 		etljobname,      	envsourcecd, 
		datasourcecd,       etlcreatedatetime
	)
	
    SELECT 
		s.address_id, 		s.atimestamp, 		s.address1, 		s.address2, 
		s.address3, 		s.address_desc, 	s.city, 			s.state, 
		s.country, 			s.phone_no, 		s.url, 			 	s.zip_code, 
		s.createdby, 		s.createddate, 		s.modifiedby,      	s.modifieddate, 
		s.state_code, 		1, 					p_etljobname,      	p_envsourcecd, 
		p_datasourcecd,     now()
	FROM stg.stg_emod_addr_mst s
    LEFT JOIN dwh.d_address t
    ON 	s.address_id  		= 	t.address_id
    WHERE t.address_id IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN

	INSERT INTO raw.raw_emod_addr_mst
	(
		address_id, 		atimestamp, 		address1, 		address2, 		
		address3,			address_desc, 		city, 			state, 		
		country, 			phone_no,			fax, 			telex, 				
		url, 				mail_stop, 			zip_code, 		createdby, 
		createddate, 		modifiedby,		 	modifieddate, 	state_code,
        email_id, 			etlcreateddatetime	
	)
	SELECT 
		address_id, 		atimestamp, 		address1, 		address2, 		
		address3,			address_desc, 		city, 			state, 		
		country, 			phone_no,			fax, 			telex, 				
		url, 				mail_stop, 			zip_code, 		createdby, 
		createddate, 		modifiedby,		 	modifieddate, 	state_code,
        email_id, 			etlcreateddatetime
	FROM stg.stg_emod_addr_mst;

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
$$;