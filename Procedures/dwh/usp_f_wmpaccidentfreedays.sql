CREATE OR REPLACE PROCEDURE dwh.usp_f_wmpaccidentfreedays(
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
		ON d.sourceid 		= h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
		
		 	SELECT COUNT(1) INTO srccnt
			FROM stg.stg_wmpaccidentfreedays;
			
			Truncate table dwh.f_wmpaccidentfreedays
			Restart identity;
			
			GET DIAGNOSTICS updcnt = ROW_COUNT;
			
		insert into dwh.f_wmpaccidentfreedays
		(
			wafc_ou, wafc_date, division_code, location_code,
			customer_id, Score, etlactiveind,	etljobname,
			envsourcecd, datasourcecd, etlcreatedatetime
		)

		select 
		
			wafc_ou, wafc_date, division_code, location_code,
			customer_id, Score, 1, p_etljobname,
			p_envsourcecd,p_datasourcecd, now()
			
			from stg.stg_wmpaccidentfreedays;
			GET DIAGNOSTICS inscnt = ROW_COUNT;
		
			if p_rawstorageflag = 1
			Then
			
			insert into raw.raw_wmpaccidentfreedays
			(
			wafc_ou, wafc_date, division_code, location_code,
			customer_id, Score, etlcreatedatetime			
			)
			
			select 
						wafc_ou, wafc_date, division_code, location_code,
			customer_id, Score, now()
			
			from stg.stg_wmpaccidentfreedays;
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
ALTER PROCEDURE dwh.usp_f_wmpaccidentfreedays(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;