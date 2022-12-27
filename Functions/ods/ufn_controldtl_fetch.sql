CREATE FUNCTION ods.ufn_controldtl_fetch(p_sourceid character varying) RETURNS TABLE(v_sourcename character varying, v_sourcetype character varying, v_sourcedescription character varying, v_sourceid character varying, v_sourceobject character varying, v_dataflowflag character varying, v_isreadyforexecution boolean, v_loadtype character varying, v_loadfrequency character varying, v_flowstatus character varying, v_targetname character varying, v_targetschemaname character varying, v_targetobject character varying, v_targetprocedurename character varying, v_jobname character varying, v_createddate timestamp without time zone, v_lastupdateddate timestamp without time zone, v_createduser character varying, v_isapplicable boolean, v_profilename character varying, v_emailto character varying, v_archcondition character varying, v_isdecomreq integer, v_archintvlcond character varying, v_sourcequery character varying, v_sourcecallingseq integer, v_etllastrundate timestamp without time zone, v_latestbatchid integer)
    LANGUAGE plpgsql
    AS $$
BEGIN  
   
 IF p_SourceId IS NULL OR p_SourceId ='' THEN  
    p_SourceId := '%';
 END IF;  
 
  p_SourceId := REPLACE(TRIM(p_SourceId),'*','%');  
  
  RETURN QUERY SELECT SourceName,   Sourcetype,    SourceDescription,    SourceId,  
   SourceObject,  DataflowFlag,   CAST(IsReadyForExecution AS BOOLEAN),   LoadType,  
   LoadFrequency,  FlowStatus,    TargetName,      TargetSchemaName,  
   TargetObject,  TargetProcedureName, JobName,      CreatedDate,  
   LastUpdatedDate, CreatedUser,   CAST(Isapplicable AS BOOLEAN),     ProfileName,  
   EmailTo,   ArchCondition,   IsDecomReq,      ArchIntvlCond,   
   SourceQuery::varchar(10000),  SourceCallingSeq,  EtlLastRunDate,     LatestBatchId 
   
   FROM ods.ControlDetail WHERE SourceId ~~* p_SourceId   
    ORDER BY ID;
END;
$$;