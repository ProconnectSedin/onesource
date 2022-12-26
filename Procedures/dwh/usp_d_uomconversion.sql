CREATE OR REPLACE PROCEDURE dwh.usp_d_uomconversion(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
	FROM stg.stg_uom_con_indconversion;

	UPDATE dwh.D_UomConversion t
    SET 
		con_ouinstance		= s.con_ouinstance,
		con_confact_ntr		= s.con_confact_ntr,
		con_confact_dtr		= s.con_confact_dtr,
		con_created_by		= s.con_created_by,
		con_created_date	= s.con_created_date,
		con_modified_by		= s.con_modified_by,
		con_modified_date	= s.con_modified_date,
		con_flag			= s.con_flag,
		con_convert_type	= s.con_convert_type,
		etlactiveind 		= 1,
		etljobname 			= p_etljobname,
		envsourcecd 		= p_envsourcecd ,
		datasourcecd 		= p_datasourcecd ,
		etlupdatedatetime 	= NOW()	
    FROM stg.stg_uom_con_indconversion s
    WHERE t.con_fromuomcode  	= s.con_fromuomcode
	AND t.con_touomcode 		= s.con_touomcode;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.D_UomConversion
	(
	con_ouinstance,		 	con_fromuomcode,		con_touomcode, 
	con_confact_ntr,		con_confact_dtr, 			con_created_by, 
	con_created_date, 		con_modified_by, 		con_modified_date, 			con_flag, 
	con_convert_type,		etlactiveind, 			etljobname, 				envsourcecd, 	
	datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
	s.con_ouinstance, 		s.con_fromuomcode, 		s.con_touomcode,
	s.con_confact_ntr,		s.con_confact_dtr, 		s.con_created_by, 
	s.con_created_date,		s.con_modified_by, 		s.con_modified_date, 	s.con_flag, 
	s.con_convert_type,		1,				p_etljobname,	
	p_envsourcecd,			p_datasourcecd,			NOW()

	FROM stg.stg_uom_con_indconversion s
    LEFT JOIN dwh.D_UomConversion t
    ON 	s.con_fromuomcode  		= t.con_fromuomcode
	AND s.con_touomcode 		= t.con_touomcode 
    WHERE t.con_fromuomcode IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN

	INSERT INTO raw.raw_uom_con_indconversion

	(
	    con_ouinstance, con_fromuomcode, con_touomcode, con_confact_ntr, con_confact_dtr, con_created_by, 
        con_created_date, con_modified_by, con_modified_date, con_flag, con_convert_type, etlcreateddatetime

	)
	SELECT 
	    con_ouinstance, con_fromuomcode, con_touomcode, con_confact_ntr, con_confact_dtr, con_created_by, 
        con_created_date, con_modified_by, con_modified_date, con_flag, con_convert_type, etlcreateddatetime

	FROM stg.stg_uom_con_indconversion;
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