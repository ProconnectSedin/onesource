CREATE OR REPLACE PROCEDURE ods.usp_source_target_count(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	CREATE TEMP TABLE dwh_target_count
  (
    Sourcetable varchar(100) COLLATE public.nocase,
	Targettable varchar(100) COLLATE public.nocase,
 	TargetDimension varchar(50) COLLATE public.nocase,
	TargetAttributes varchar(50) COLLATE public.nocase,
 	Period bigint,   	
 	TargetDataCount bigint
  )
  ON COMMIT DELETE ROWS;
   
  
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname,p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_datavalidation;
	
	
	TRUNCATE ONLY ods.source_target_count RESTART IDENTITY;
	
	INSERT INTO ods.source_target_count
	(sourcetable,dimension,Period,SourceDataCount)		
	SELECT 	sourcetable,dimension,Period,SourceDataCount
	FROM stg.stg_datavalidation;
	
 	select 0 into inscnt;
	
	 
	 UPDATE ods.source_target_count d
	 set 	targettable 	= t.dwhtablename,
	 		targetdatacount = t.datacount
	 FROM ods.dwh_data_count t
	 where  TRIM(d.Sourcetable) 	= TRIM(t.sourcetable)
	 and 	TRIM(d.Period)     		= TRIM(t.period)
	 and 	TRIM(d.dimension) 		= TRIM(t.dimension);
	 
	 GET DIAGNOSTICS updcnt = ROW_COUNT;
	 
	 update ods.source_target_count
	 set diffcount = SourceDataCount - targetdatacount
	 where 1=1;

	 

	 
	 

	
	
	  EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;