-- PROCEDURE: dwh.usp_d_locationshiftdetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_locationshiftdetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_locationshiftdetails(
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag

	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag

	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_loc_location_shift_dtl;

	UPDATE dwh.d_locationshiftdetails t
    SET 
		location_key			= COALESCE(d.loc_key, -1),
        loc_shft_shift          = s.wms_loc_shft_shift,
        loc_shft_fr_time        = s.wms_loc_shft_fr_time,
        loc_shft_to_time        = s.wms_loc_shft_to_time,
        etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_wms_loc_location_shift_dtl s
	LEFT JOIN dwh.d_location d
	ON s.wms_loc_code  	        = d.loc_code
	AND s.wms_loc_ou 		    = d.loc_ou
    WHERE t.loc_code  		    = s.wms_loc_code
	AND t.loc_shft_lineno 		= s.wms_loc_shft_lineno
	AND t.loc_ou 			    = s.wms_loc_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_locationshiftdetails
	(	
		location_key,
		loc_ou,             loc_code,                   loc_shft_lineno,    loc_shft_shift,     loc_shft_fr_time,   
        loc_shft_to_time,	etlactiveind,etljobname,    envsourcecd, 	    datasourcecd, 	    etlcreatedatetime
	)
	
    SELECT 
		COALESCE(d.loc_key, -1),
		s.wms_loc_ou,               s.wms_loc_code,           s.wms_loc_shft_lineno,       s.wms_loc_shft_shift,
        s.wms_loc_shft_fr_time,  s.wms_loc_shft_to_time ,   1,     p_etljobname,		p_envsourcecd,	p_datasourcecd, NOW()
	FROM stg.stg_wms_loc_location_shift_dtl s
	LEFT JOIN dwh.d_location d
	ON s.wms_loc_code  		 	   = d.loc_code
	AND s.wms_loc_ou 			    = d.loc_ou
    LEFT JOIN dwh.d_locationshiftdetails t
    ON 	t.loc_code  		    = s.wms_loc_code
	AND t.loc_shft_lineno 		= s.wms_loc_shft_lineno
	AND t.loc_ou 			    = s.wms_loc_ou
    WHERE t.loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_wms_loc_location_shift_dtl
	(
	 wms_loc_ou, wms_loc_code, wms_loc_shft_lineno, wms_loc_shft_shift, wms_loc_shft_fr_time, 
        wms_loc_shft_to_time, etlcreateddatetime

	)
	SELECT 
		wms_loc_ou, wms_loc_code, wms_loc_shft_lineno, wms_loc_shft_shift, wms_loc_shft_fr_time, 
        wms_loc_shft_to_time, etlcreateddatetime

	FROM stg.stg_wms_loc_location_shift_dtl;
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
ALTER PROCEDURE dwh.usp_d_locationshiftdetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
