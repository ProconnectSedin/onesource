--
-- Name: usp_ods_data_count(); Type: FUNCTION; Schema: ods; Owner: proconnect
--

CREATE FUNCTION ods.usp_ods_data_count() RETURNS void
    LANGUAGE plpgsql
    AS $$

    declare v_Data text;
    v_TableName text;
    v_Column_List text;
    v_FromClause text;
    v_WhereClause text;
    v_GroupByClause text;
begin
    select TableName from DataValidation_ScriptGenerator;
    select Column_List from DataValidation_ScriptGenerator;
    select TableName from DataValidation_ScriptGenerator;
    select WhereClause_ColumnName from DataValidation_ScriptGenerator;
    select GroupBy_ColumnName from DataValidation_ScriptGenerator;

    v_Data:='select '' '|| v_TableName || ''',' || v_Column_List ||
    'from ' || v_TableName || ' where ' || v_WhereClause ||
    'group by '|| v_GroupByClause;
    Select v_Data;
END;
$$;


ALTER FUNCTION ods.usp_ods_data_count() OWNER TO proconnect;

--
-- Name: control_table_insertscript_generator(text, text, text); Type: FUNCTION; Schema: ods; Owner: proconnect
--

CREATE FUNCTION ods.control_table_insertscript_generator(p_schema text, p_table text, p_where text) RETURNS SETOF text
    LANGUAGE plpgsql
    AS $$
 DECLARE
     dumpquery_0 text;
     dumpquery_1 text;
     selquery text;
     selvalue text;
     valrec record;
     colrec record;
 BEGIN

     -- ------ --
     -- GLOBAL --
     --   build base INSERT
     --   build SELECT array[ ... ]
     dumpquery_0 := 'INSERT INTO ' ||  quote_ident(p_schema) || '.' || quote_ident(p_table) || '(';
     selquery    := 'SELECT array[';

     <<label0>>
     FOR colrec IN SELECT table_schema, table_name, column_name, data_type
                   FROM information_schema.columns
                   WHERE table_name = p_table and table_schema = p_schema
                   AND column_name <> 'id'
                   ORDER BY ordinal_position
     LOOP
         dumpquery_0 := dumpquery_0 || quote_ident(colrec.column_name) || ',';
         selquery    := selquery    || 'CAST(' || quote_ident(colrec.column_name) || ' AS TEXT),';
     END LOOP label0;

     dumpquery_0 := substring(dumpquery_0 ,1,length(dumpquery_0)-1) || ')';
     dumpquery_0 := dumpquery_0 || ' VALUES (';
     selquery    := substring(selquery    ,1,length(selquery)-1)    || '] AS MYARRAY';
     selquery    := selquery    || ' FROM ' ||quote_ident(p_schema)||'.'||quote_ident(p_table);
     selquery    := selquery    || ' WHERE sourceid ='''|| p_where||'''';
     -- GLOBAL --
     -- ------ --

     -- ----------- --
     -- SELECT LOOP --
     --   execute SELECT built and loop on each row
     <<label1>>
     FOR valrec IN  EXECUTE  selquery
     LOOP
         dumpquery_1 := '';
         IF not found THEN
             EXIT ;
         END IF;

         -- ----------- --
         -- LOOP ARRAY (EACH FIELDS) --
         <<label2>>
         FOREACH selvalue in ARRAY valrec.MYARRAY
         LOOP
             IF selvalue IS NULL
             THEN selvalue := 'NULL';
             ELSE selvalue := quote_literal(selvalue);
             END IF;
             dumpquery_1 := dumpquery_1 || selvalue || ',';
         END LOOP label2;
         dumpquery_1 := substring(dumpquery_1 ,1,length(dumpquery_1)-1) || ');';
         -- LOOP ARRAY (EACH FIELD) --
         -- ----------- --

         -- debug: RETURN NEXT dumpquery_0 || dumpquery_1 || ' --' || selquery;
         -- debug: RETURN NEXT selquery;
         RETURN NEXT dumpquery_0 || dumpquery_1;

     END LOOP label1 ;
     -- SELECT LOOP --
     -- ----------- --

 RETURN ;
 END
 
$$;


ALTER FUNCTION ods.control_table_insertscript_generator(p_schema text, p_table text, p_where text) OWNER TO proconnect;

--
-- Name: controldetailaudit(); Type: FUNCTION; Schema: ods; Owner: proconnect
--

CREATE FUNCTION ods.controldetailaudit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
    INSERT INTO
        ods.controldetailaudit(id,sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,
                              isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,
                              jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,
                              archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,
                              latestbatchid,executiontype,intervaldays,eventname)
                    VALUES  (new.id, new.sourcename, new.sourcetype,    new.sourcedescription,new.sourceid,new.sourceobject,new.dataflowflag,
                             new.isreadyforexecution,    new.loadtype, new.loadfrequency,new.flowstatus,new.targetname,new.targetschemaname,new.targetobject,new.targetprocedurename,
                             new.jobname,new.createddate,new.lastupdateddate,   new.createduser,new.isapplicable,new.profilename,new.emailto,
                             new.archcondition,  new.isdecomreq,new.archintvlcond,  new.sourcequery,new.sourcecallingseq,new.etllastrundate,
                             new.latestbatchid,new.executiontype,new.intervaldays,tg_op);

      RETURN new;
      ELSIF (TG_OP = 'UPDATE') THEN
      INSERT INTO
        ods.controldetailaudit(id,sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,
                              isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,
                              jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,
                              archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,
                              latestbatchid,executiontype,intervaldays,eventname)
                    VALUES  (old.id, old.sourcename, old.sourcetype,    old.sourcedescription,old.sourceid,old.sourceobject,old.dataflowflag,
                             old.isreadyforexecution,    old.loadtype, old.loadfrequency,old.flowstatus,old.targetname,old.targetschemaname,old.targetobject,old.targetprocedurename,
                             old.jobname,old.createddate,old.lastupdateddate,   old.createduser,old.isapplicable,old.profilename,old.emailto,
                             old.archcondition,  old.isdecomreq,old.archintvlcond,  old.sourcequery,old.sourcecallingseq,old.etllastrundate,
                             old.latestbatchid,old.executiontype,old.intervaldays,tg_op);
     RETURN old;
     END IF;
END;
$$;


ALTER FUNCTION ods.controldetailaudit() OWNER TO proconnect;

--
-- Name: controlheaderaudit(); Type: FUNCTION; Schema: ods; Owner: proconnect
--

CREATE FUNCTION ods.controlheaderaudit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
    INSERT INTO
        ods.controlheaderaudit(id,sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,
                              dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,
                              lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,
                              archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,
                              apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,
                              rawstorageflag,sourcegroup,eventname)
                    VALUES  (new.id,             new.sourcename, new.sourcetype,    new.sourcedescription,new.sourceid,new.connectionstr,new.adlscontainername,
                             new.dwobjectname,   new.objecttype, new.dldirstructure,new.dlpurgeflag,new.dwpurgeflag,new.ftpcheck,new.status,new.createddate,
                             new.lastupdateddate,new.createduser,new.isapplicable,  new.profilename,new.emailto,new.archcondition,new.depsource,
                             new.archintvlcond,  new.sourcecallingseq,new.apiurl,   new.apimethod,new.apiauthorizationtype,new.apiaccesstoken,
                             new.apipymodulename,new.apiqueryparameters,new.apirequestbody,new.envsourcecode,new.datasourcecode,new.sourcedelimiter,
                             new.rawstorageflag, new.sourcegroup,tg_op);

      RETURN new;
      ELSIF (TG_OP = 'UPDATE') THEN
          INSERT INTO
        ods.controlheaderaudit(id,sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,
                              dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,
                              lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,
                              archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,
                              apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,
                              rawstorageflag,sourcegroup,eventname)
                    VALUES  (old.id,             old.sourcename, old.sourcetype,    old.sourcedescription,old.sourceid,old.connectionstr,old.adlscontainername,
                             old.dwobjectname,   old.objecttype, old.dldirstructure,old.dlpurgeflag,old.dwpurgeflag,old.ftpcheck,old.status,old.createddate,
                             old.lastupdateddate,old.createduser,old.isapplicable,  old.profilename,old.emailto,old.archcondition,old.depsource,
                             old.archintvlcond,  old.sourcecallingseq,old.apiurl,   old.apimethod,old.apiauthorizationtype,old.apiaccesstoken,
                             old.apipymodulename,old.apiqueryparameters,old.apirequestbody,old.envsourcecode,old.datasourcecode,old.sourcedelimiter,
                             old.rawstorageflag, old.sourcegroup,tg_op);

      RETURN old;
      END IF;
END;
$$;


ALTER FUNCTION ods.controlheaderaudit() OWNER TO proconnect;

--
-- Name: ufn_controldtl_fetch(character varying); Type: FUNCTION; Schema: ods; Owner: proconnect
--

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


ALTER FUNCTION ods.ufn_controldtl_fetch(p_sourceid character varying) OWNER TO proconnect;

--
-- Name: ufn_controldtl_upload(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: ods; Owner: proconnect
--

CREATE FUNCTION ods.ufn_controldtl_upload(p_sourcename_d_in character varying, p_sourcetype_d_in character varying, p_sourcedescription_d_in character varying, p_sourceid_d_in character varying, p_sourceobject_d_in character varying, p_dataflowflag_d_in character varying, p_isreadyforexecution_d_in character varying, p_loadtype_d_in character varying, p_loadfrequency_d_in character varying, p_flowstatus_d_in character varying, p_targetname_d_in character varying, p_targetschemaname_d_in character varying, p_targetobject_d_in character varying, p_targetprocedurename_d_in character varying, p_jobname_d_in character varying, p_createddate_d_in character varying, p_lastupdateddate_d_in character varying, p_createduser_d_in character varying, p_isapplicable_d_in character varying, p_profilename_d_in character varying, p_emailto_d_in character varying, p_archcondition_d_in character varying, p_isdecomreq_d_in character varying, p_archintvlcond_d_in character varying, p_sourcequery_d_in character varying, p_sourcecallingseq_d_in character varying, p_etllastrundate_d_in character varying, p_latestbatchid_d_in character varying, p_flag_d_in character varying) RETURNS TABLE(p_validflag_out character varying, p_errormsg_out character varying)
    LANGUAGE plpgsql
    AS $$

DECLARE v_IsReadyForExecution_D_in BOOLEAN;
        v_Isapplicable_D_in BOOLEAN;
        v_IsReadyForExecution_D_in_cvt INTEGER;
        v_Isapplicable_D_in_cvt INTEGER;
        v_IsDecomReq_D_in INTEGER;
        v_SourceCallingSeq_D_in INTEGER;
        v_LatestBatchId_D_in INTEGER;
        v_createddate_d_in TIMESTAMP;
        v_lastupdateddate_d_in TIMESTAMP;
        v_etllastrundate_d_in TIMESTAMP;
        
BEGIN  
  

   p_SourceName_D_in          := TRIM(p_SourceName_D_in);               p_Sourcetype_D_in           := TRIM(p_Sourcetype_D_in);   
   p_SourceDescription_D_in   := TRIM(p_SourceDescription_D_in);        p_SourceId_D_in             := TRIM(p_SourceId_D_in);     
   p_SourceObject_D_in        := TRIM(p_SourceObject_D_in);             p_DataflowFlag_D_in         := TRIM(p_DataflowFlag_D_in);   
   p_IsReadyForExecution_D_in := TRIM(p_IsReadyForExecution_D_in);      p_LoadType_D_in             := TRIM(p_LoadType_D_in);     
   p_LoadFrequency_D_in       := TRIM(p_LoadFrequency_D_in);            p_FlowStatus_D_in           := TRIM(p_FlowStatus_D_in);    
   p_TargetName_D_in          := TRIM(p_TargetName_D_in);               p_TargetSchemaName_D_in     := TRIM(p_TargetSchemaName_D_in);   
   p_TargetObject_D_in        := TRIM(p_TargetObject_D_in);             p_TargetProcedureName_D_in  := TRIM(p_TargetProcedureName_D_in);   
   p_JobName_D_in             := TRIM(p_JobName_D_in);                  p_CreatedUser_D_in          := TRIM(p_CreatedUser_D_in);     
   p_Isapplicable_D_in        := TRIM(p_Isapplicable_D_in);             p_ProfileName_D_in          := TRIM(p_ProfileName_D_in);     
   p_EmailTo_D_in             := TRIM(p_EmailTo_D_in);                  p_ArchCondition_D_in        := TRIM(p_ArchCondition_D_in);    
   p_IsDecomReq_D_in          := TRIM(p_IsDecomReq_D_in);               p_ArchIntvlCond_D_in        := TRIM(p_ArchIntvlCond_D_in);  
   p_SourceQuery_D_in         := TRIM(p_SourceQuery_D_in);              p_SourceCallingSeq_D_in     := TRIM(p_SourceCallingSeq_D_in);  
   p_EtlLastRunDate_D_in      := TRIM(p_EtlLastRunDate_D_in);           p_LatestBatchId_D_in        := TRIM(p_LatestBatchId_D_in);  
   p_Flag_D_in                := TRIM(p_Flag_D_in);  
  
  
   IF p_SourceName_D_in ='NULL' OR p_SourceName_D_in ='' THEN   
     p_SourceName_D_in := NULL;
   END IF;  
  
   IF p_Sourcetype_D_in ='NULL' OR p_Sourcetype_D_in ='' THEN   
     p_Sourcetype_D_in := NULL;
   END IF;  
  
   IF p_SourceDescription_D_in ='NULL' OR p_SourceDescription_D_in ='' THEN   
     p_SourceDescription_D_in :=NULL ;
   END IF;  
  
   IF p_SourceId_D_in ='NULL' OR p_SourceId_D_in ='' THEN  
    p_SourceId_D_in := NULL;
   END IF;  
  
   IF p_SourceObject_D_in ='NULL' OR p_SourceObject_D_in ='' THEN   
    p_SourceObject_D_in :=NULL ;
   END IF;  
  
   IF p_DataflowFlag_D_in ='NULL' OR p_DataflowFlag_D_in ='' THEN   
    p_DataflowFlag_D_in :=NULL ;
   END IF;  
  
   IF p_IsReadyForExecution_D_in ='NULL' OR p_IsReadyForExecution_D_in ='' THEN  
    p_IsReadyForExecution_D_in :=NULL ;
   END IF;  
  
   IF p_LoadType_D_in ='NULL' OR p_LoadType_D_in ='' THEN  
    p_LoadType_D_in := NULL;
   END IF;  
  
   IF p_LoadFrequency_D_in ='NULL' OR p_LoadFrequency_D_in ='' THEN 
    p_LoadFrequency_D_in := NULL;
   END IF;  
  
   IF p_FlowStatus_D_in ='NULL' OR p_FlowStatus_D_in ='' THEN   
    p_FlowStatus_D_in :=NULL ;
   END IF;  
  
   IF p_TargetSchemaName_D_in ='NULL' OR p_TargetSchemaName_D_in ='' THEN   
    p_TargetSchemaName_D_in :=NULL ;
   END IF;  
      
   IF p_TargetObject_D_in ='NULL' OR p_TargetObject_D_in ='' THEN   
    p_TargetObject_D_in :=NULL ;
   END IF;  
  
      
   IF p_TargetProcedureName_D_in ='NULL' OR p_TargetProcedureName_D_in ='' THEN  
    p_TargetProcedureName_D_in :=NULL ;
   END IF;  
      
  
   IF p_JobName_D_in ='NULL' OR p_JobName_D_in ='' THEN   
    p_JobName_D_in := NULL;
   END IF;  
  
   IF p_CreatedUser_D_in ='NULL' OR p_CreatedUser_D_in ='' THEN   
    p_CreatedUser_D_in := NULL;
   END IF;  
  
   IF p_Isapplicable_D_in ='NULL' OR p_Isapplicable_D_in ='' THEN   
    p_Isapplicable_D_in := NULL;
   END IF;  
  
   IF p_ProfileName_D_in ='NULL' OR p_ProfileName_D_in ='' THEN   
    p_ProfileName_D_in := NULL;
   END IF;  
  
   IF p_EmailTo_D_in ='NULL' OR p_EmailTo_D_in ='' THEN   
    p_EmailTo_D_in := NULL;
   END IF;  
  
   IF p_ArchCondition_D_in ='NULL' OR p_ArchCondition_D_in ='' THEN   
    p_ArchCondition_D_in := NULL;
   END IF;  
  
   IF p_IsDecomReq_D_in ='NULL' OR p_IsDecomReq_D_in ='' THEN   
    p_IsDecomReq_D_in := NULL;
   END IF;  
  
   IF p_ArchIntvlCond_D_in ='NULL' OR p_ArchIntvlCond_D_in ='' THEN   
    p_ArchIntvlCond_D_in := NULL;
   END IF;  
  
   IF p_SourceQuery_D_in ='NULL' OR p_SourceQuery_D_in ='' THEN   
    p_SourceQuery_D_in := NULL;
   END IF;  
      
   IF p_SourceCallingSeq_D_in ='NULL' OR p_SourceCallingSeq_D_in ='' THEN   
    p_SourceCallingSeq_D_in := NULL;
   END IF;  
   
   IF p_createddate_d_in ='NULL' OR p_createddate_d_in ='' THEN   
    p_createddate_d_in := NULL;
   END IF;  
   
   IF p_lastupdateddate_d_in ='NULL' OR p_lastupdateddate_d_in ='' THEN   
    p_lastupdateddate_d_in := NULL;
   END IF;  
      
   IF p_EtlLastRunDate_D_in ='NULL' OR p_EtlLastRunDate_D_in ='' THEN   
    p_EtlLastRunDate_D_in := NULL;
   END IF;  
      
   IF p_LatestBatchId_D_in ='NULL' OR p_LatestBatchId_D_in ='' THEN   
    p_LatestBatchId_D_in := NULL;
   END IF;  
      
   IF p_Flag_D_in ='NULL' OR p_Flag_D_in ='' THEN   
    p_Flag_D_in := NULL;
   END IF; 
   
   IF p_IsReadyForExecution_D_in = 'true'
   then v_IsReadyForExecution_D_in = 1;
   else v_IsReadyForExecution_D_in = 0;
   end If;
   
   IF p_Isapplicable_D_in = 'true'
   then v_Isapplicable_D_in = 1;
   else v_Isapplicable_D_in = 0;
   end If;
      
    v_IsReadyForExecution_D_in  := CAST(p_IsReadyForExecution_D_in AS BOOLEAN);
    v_Isapplicable_D_in         := CAST(p_Isapplicable_D_in AS BOOLEAN);
    v_IsDecomReq_D_in           := CAST(p_IsDecomReq_D_in AS INTEGER);
    v_SourceCallingSeq_D_in     := CAST(p_SourceCallingSeq_D_in AS INTEGER) ;
    v_LatestBatchId_D_in        := CAST(p_LatestBatchId_D_in AS INTEGER) ;
    p_createddate_d_in          := TO_TIMESTAMP(p_createddate_d_in,'DD-MM-YYYY HH24:MI:SS');
    p_lastupdateddate_d_in      := TO_TIMESTAMP(p_lastupdateddate_d_in,'DD-MM-YYYY HH24:MI:SS');
    p_etllastrundate_d_in       := TO_TIMESTAMP(p_etllastrundate_d_in,'DD-MM-YYYY HH24:MI:SS');
    v_createddate_d_in          := COALESCE(CAST(p_createddate_d_in AS TIMESTAMP),NOW());
    v_lastupdateddate_d_in      := COALESCE(CAST(p_lastupdateddate_d_in AS TIMESTAMP),NOW());
    v_etllastrundate_d_in       := CAST(p_etllastrundate_d_in AS TIMESTAMP);
    
    IF v_IsReadyForExecution_D_in = 'true'
   then v_IsReadyForExecution_D_in_cvt = 1;
   else v_IsReadyForExecution_D_in_cvt = 0;
   end If;
   
   IF v_Isapplicable_D_in = 'true'
   then v_Isapplicable_D_in_cvt = 1;
   else v_Isapplicable_D_in_cvt = 0;
   end If;
    
    
    
 IF p_Flag_D_in = 'Insert'  
 THEN  
  IF EXISTS(SELECT 'x' FROM ods.ControlDetail   
     WHERE SourceId     = p_SourceId_D_in  
     AND  TargetName    = p_TargetName_D_in  
     AND  DataflowFlag  = p_DataflowFlag_D_in  
     AND  TargetObject  = p_TargetObject_D_in)  
  THEN  
   
   p_ValidFlag_out := 'No';    
   p_ErrorMsg_out :='Alert: Record already exist in the Control Detail table for this Source ID; Change flag to "Update"';   
   RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;  
  ELSE  
   
   INSERT INTO ods.ControlDetail  
   (  
    SourceName,         Sourcetype,             SourceDescription,  SourceId,               SourceObject,  
    DataflowFlag,       IsReadyForExecution,    LoadType,           LoadFrequency,          FlowStatus,  
    TargetName,         TargetSchemaName,       TargetObject,       TargetProcedureName,    JobName,  
    CreatedDate,        LastUpdatedDate,        CreatedUser,        Isapplicable,           ProfileName,      
    EmailTo,            ArchCondition,          IsDecomReq,         ArchIntvlCond,          SourceQuery,  
    SourceCallingSeq,   LatestBatchId,          EtlLastRunDate  
   )  
   SELECT  
   p_SourceName_D_in,       p_Sourcetype_D_in,          p_SourceDescription_D_in,   p_SourceId_D_in,            p_SourceObject_D_in,    
   p_DataflowFlag_D_in,     v_IsReadyForExecution_D_in_cvt, p_LoadType_D_in,            p_LoadFrequency_D_in,       p_FlowStatus_D_in,    
   p_TargetName_D_in,       p_TargetSchemaName_D_in,    p_TargetObject_D_in,        p_TargetProcedureName_D_in, p_JobName_D_in,      
   NOW(),                   NOW(),                      p_CreatedUser_D_in,         v_Isapplicable_D_in_cvt,        p_ProfileName_D_in,     
   p_EmailTo_D_in,          p_ArchCondition_D_in,       v_IsDecomReq_D_in,          p_ArchIntvlCond_D_in,       p_SourceQuery_D_in,  
   v_SourceCallingSeq_D_in, 0,                          v_EtlLastRunDate_D_in; 
  
   
   p_ValidFlag_out := 'Yes';   
   p_ErrorMsg_out :='Info: Record inserted successfully';   
   RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;     
  END IF;  
 ELSE IF p_Flag_D_in = 'Update'  
 THEN  
  IF EXISTS( SELECT 'x' FROM ods.ControlDetail   
     WHERE SourceId     = p_SourceId_D_in  
     AND  TargetName    = p_TargetName_D_in  
     AND  DataflowFlag  = p_DataflowFlag_D_in  
     AND  TargetObject  = p_TargetObject_D_in  
       
  )  
  THEN  
   UPDATE ods.ControlDetail  
   SET  
    SourceName              = p_SourceName_D_in,            Sourcetype          = p_Sourcetype_D_in,     
    SourceDescription       = p_SourceDescription_D_in,     SourceObject        = p_SourceObject_D_in,  
    IsReadyForExecution     = v_IsReadyForExecution_D_in_cvt,   LoadType            = p_LoadType_D_in,      
    LoadFrequency           = p_LoadFrequency_D_in,         FlowStatus          = p_FlowStatus_D_in,      
    TargetSchemaName        = p_TargetSchemaName_D_in,      TargetObject        = p_TargetObject_D_in,  
    TargetProcedureName     = p_TargetProcedureName_D_in,   JobName             = p_JobName_D_in,  
    LastUpdatedDate         = NOW(),                        Isapplicable        = v_Isapplicable_D_in_cvt,    
    ProfileName             = p_ProfileName_D_in,           EmailTo             = p_EmailTo_D_in,  
    ArchCondition           = p_ArchCondition_D_in,         IsDecomReq          = v_IsDecomReq_D_in,      
    ArchIntvlCond           = p_ArchIntvlCond_D_in,         SourceQuery         = p_SourceQuery_D_in,  
    EtlLastRunDate          = v_EtlLastRunDate_D_in,        SourceCallingSeq    = v_SourceCallingSeq_D_in  
   WHERE SourceId           = p_SourceId_D_in  
   AND  TargetName          = p_TargetName_D_in  
   AND  DataflowFlag        = p_DataflowFlag_D_in  
   AND  TargetObject        = p_TargetObject_D_in;  
     
        
   
   p_ValidFlag_out := 'Yes';    
   p_ErrorMsg_out :='Info: Record Updated successfully';   
   RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;  
  ELSE  
   
   p_ValidFlag_out := 'No';  
   p_ErrorMsg_out :='Alert: Record not exist in the Control Detail table for this Source ID; verify and change the flag to "Insert"';   
   RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;  
  END IF;  
 ELSE  
   
   p_ValidFlag_out := 'NA';    
   p_ErrorMsg_out :='Info: Record not considered for processing';   
   RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;  
 END IF;
 END IF;  
  
  
END
$$;


ALTER FUNCTION ods.ufn_controldtl_upload(p_sourcename_d_in character varying, p_sourcetype_d_in character varying, p_sourcedescription_d_in character varying, p_sourceid_d_in character varying, p_sourceobject_d_in character varying, p_dataflowflag_d_in character varying, p_isreadyforexecution_d_in character varying, p_loadtype_d_in character varying, p_loadfrequency_d_in character varying, p_flowstatus_d_in character varying, p_targetname_d_in character varying, p_targetschemaname_d_in character varying, p_targetobject_d_in character varying, p_targetprocedurename_d_in character varying, p_jobname_d_in character varying, p_createddate_d_in character varying, p_lastupdateddate_d_in character varying, p_createduser_d_in character varying, p_isapplicable_d_in character varying, p_profilename_d_in character varying, p_emailto_d_in character varying, p_archcondition_d_in character varying, p_isdecomreq_d_in character varying, p_archintvlcond_d_in character varying, p_sourcequery_d_in character varying, p_sourcecallingseq_d_in character varying, p_etllastrundate_d_in character varying, p_latestbatchid_d_in character varying, p_flag_d_in character varying) OWNER TO proconnect;

--
-- Name: ufn_controlhdr_fetch(character varying); Type: FUNCTION; Schema: ods; Owner: proconnect
--

CREATE FUNCTION ods.ufn_controlhdr_fetch(p_sourceid character varying) RETURNS TABLE(v_sourcename character varying, v_sourcetype character varying, v_sourcedescription character varying, v_sourceid character varying, v_connectionstr character varying, v_adlscontainername character varying, v_dwobjectname character varying, v_objecttype character varying, v_dldirstructure character varying, v_dlpurgeflag character, v_dwpurgeflag character, v_ftpcheck integer, v_status character varying, v_createddate timestamp without time zone, v_lastupdateddate timestamp without time zone, v_createduser character varying, v_isapplicable boolean, v_profilename character varying, v_emailto character varying, v_archcondition character varying, v_depsource character varying, v_archintvlcond character varying, v_sourcecallingseq integer, v_apiurl character varying, v_apimethod character varying, v_apiauthorizationtype character varying, v_apiaccesstoken character varying, v_apipymodulename character varying, v_apiqueryparameters character varying, v_apirequestbody character varying, v_envsourcecode character varying, v_datasourcecode character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN

    IF p_SourceId IS NULL OR p_SourceId ='' THEN    
        p_SourceId := '%';
    END IF;      

    p_SourceId := REPLACE(TRIM(p_SourceId),'*','%');    
    
    RETURN QUERY SELECT 
        SourceName,   Sourcetype,    SourceDescription,    SourceId,    
        ConnectionStr,  ADLSContainerName,  DWObjectName,     ObjectType,    
        DLDirStructure,  DLPurgeFlag,   DWPurgeFlag,     FTPCheck,    
        Status,    CreatedDate,   LastUpdatedDate,    CreatedUser,    
        cast(Isapplicable as boolean) ,  ProfileName,   EmailTo,      ArchCondition,    
        DepSource,   ArchIntvlCond,   SourceCallingSeq,    APIUrl,        
        APIMethod,   APIAuthorizationType, APIAccessToken,     APIPyModuleName,    
        APIQueryParameters, APIRequestBody  , EnvSourceCode,  
        DataSourceCode      
    FROM ods.ControlHeader WHERE SourceId ~~* p_SourceId   
    ORDER BY ID;
END;
$$;


ALTER FUNCTION ods.ufn_controlhdr_fetch(p_sourceid character varying) OWNER TO proconnect;

--
-- Name: ufn_controlhdr_upload(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying); Type: FUNCTION; Schema: ods; Owner: proconnect
--

CREATE FUNCTION ods.ufn_controlhdr_upload(p_sourcename_h_in character varying, p_sourcetype_h_in character varying, p_sourcedescription_h_in character varying, p_sourceid_h_in character varying, p_connectionstr_h_in character varying, p_adlscontainername_h_in character varying, p_dwobjectname_h_in character varying, p_objecttype_h_in character varying, p_dldirstructure_h_in character varying, p_dlpurgeflag_h_in character varying, p_dwpurgeflag_h_in character varying, p_ftpcheck_h_in character varying, p_status_h_in character varying, p_createddate_h_in character varying, p_lastupdateddate_h_in character varying, p_createduser_h_in character varying, p_isapplicable_h_in character varying, p_profilename_h_in character varying, p_emailto_h_in character varying, p_archcondition_h_in character varying, p_dep_source_in character varying, p_archintvlcond_h_in character varying, p_sourcecallingseq_h_in character varying, p_apiurl_in character varying, p_apimethod_in character varying, p_apiauthorizationtype_in character varying, p_apiaccesstoken_in character varying, p_apipymodulename_in character varying, p_apiqueryparameters_in character varying, p_apirequestbody_in character varying, p_envsourcecode_h_in character varying, p_datasourcecode_h_in character varying, p_flag_h_in character varying) RETURNS TABLE(p_validflag_out character varying, p_errormsg_out character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE v_FTPCheck_H_in INTEGER;
        v_Isapplicable_H_in BOOLEAN;
        v_SourceCallingSeq_H_in INTEGER;
        v_Isapplicable_H_in_cvt INTEGER;
BEGIN
 
    p_SourceName_H_in           := TRIM(p_SourceName_H_in);             p_Sourcetype_H_in           := TRIM(p_Sourcetype_H_in);   
    p_SourceDescription_H_in    := TRIM(p_SourceDescription_H_in);      p_SourceId_H_in             := TRIM(p_SourceId_H_in);     
    p_ConnectionStr_H_in        := TRIM(p_ConnectionStr_H_in);          p_ADLSContainerName_H_in    := TRIM(p_ADLSContainerName_H_in);   
    p_DWObjectName_H_in         := TRIM(p_DWObjectName_H_in);           p_ObjectType_H_in           := TRIM(p_ObjectType_H_in);     
    p_DLDirStructure_H_in       := TRIM(p_DLDirStructure_H_in);         p_DLPurgeFlag_H_in          := TRIM(p_DLPurgeFlag_H_in);    
    p_DWPurgeFlag_H_in          := TRIM(p_DWPurgeFlag_H_in);            p_FTPCheck_H_in             := TRIM(p_FTPCheck_H_in);    
    p_Status_H_in               := TRIM(p_Status_H_in);                 p_CreatedUser_H_in          := TRIM(p_CreatedUser_H_in);     
    p_Isapplicable_H_in         := TRIM(p_Isapplicable_H_in);           p_ProfileName_H_in          := TRIM(p_ProfileName_H_in);     
    p_EmailTo_H_in              := TRIM(p_EmailTo_H_in);                p_ArchCondition_H_in        := TRIM(p_ArchCondition_H_in);    
    p_Dep_Source_in             := TRIM(p_Dep_Source_in);               p_ArchIntvlCond_H_in        := TRIM(p_ArchIntvlCond_H_in);  
    p_SourceCallingSeq_H_in     := TRIM(p_SourceCallingSeq_H_in);       p_APIUrl_in                 := TRIM(p_APIUrl_in);  
    p_APIMethod_in              := TRIM(p_APIMethod_in);                p_APIAuthorizationType_in   := TRIM(p_APIAuthorizationType_in);  
    p_APIAccessToken_in         := TRIM(p_APIAccessToken_in);           p_APIPyModuleName_in        := TRIM(p_APIPyModuleName_in);  
    p_APIQueryParameters_in     := TRIM(p_APIQueryParameters_in);       p_APIRequestBody_in         := TRIM(p_APIRequestBody_in);  
    p_EnvSourceCode_H_in        := TRIM(p_EnvSourceCode_H_in);          p_DataSourceCode_H_in       := TRIM(p_DataSourceCode_H_in);  
  
  
    IF p_SourceName_H_in ='NULL' OR p_SourceName_H_in ='' THEN   
        p_SourceName_H_in := NULL;
    END IF;  
  
    IF p_Sourcetype_H_in ='NULL' OR p_Sourcetype_H_in ='' THEN   
        p_Sourcetype_H_in := NULL;
    END IF;  
  
    IF p_SourceDescription_H_in ='NULL' OR p_SourceDescription_H_in ='' THEN     
        p_SourceDescription_H_in := NULL;
    END IF;  
  
    IF p_SourceId_H_in ='NULL' OR p_SourceId_H_in ='' THEN     
        p_SourceId_H_in := NULL;
    END IF;  
  
    IF p_ConnectionStr_H_in ='NULL' OR p_ConnectionStr_H_in ='' THEN     
        p_ConnectionStr_H_in := NULL;
    END IF;  
  
    IF p_ADLSContainerName_H_in ='NULL' OR p_ADLSContainerName_H_in ='' THEN      
        p_ADLSContainerName_H_in := NULL;
    END IF;  
  
    IF p_DWObjectName_H_in ='NULL' OR p_DWObjectName_H_in ='' THEN    
        p_DWObjectName_H_in := NULL;
    END IF;  
  
    IF p_ObjectType_H_in ='NULL' OR p_ObjectType_H_in ='' THEN    
        p_ObjectType_H_in := NULL;
    END IF;  
  
    IF p_DLDirStructure_H_in ='NULL' OR p_DLDirStructure_H_in ='' THEN 
        p_DLDirStructure_H_in := NULL;
    END IF;  
  
    IF p_DLPurgeFlag_H_in ='NULL' OR p_DLPurgeFlag_H_in ='' THEN    
        p_DLPurgeFlag_H_in := NULL;
    END IF;  
  
    IF p_FTPCheck_H_in ='NULL' OR p_FTPCheck_H_in ='' THEN     
        p_FTPCheck_H_in := NULL;
    END IF;
  
    IF p_Status_H_in ='NULL' OR p_Status_H_in ='' THEN    
        p_Status_H_in := NULL;
    END IF;  
  
    IF p_CreatedUser_H_in ='NULL' OR p_CreatedUser_H_in ='' THEN      
        p_CreatedUser_H_in := NULL;
    END IF;  
  
    IF p_Isapplicable_H_in ='NULL' OR p_Isapplicable_H_in ='' THEN     
        p_Isapplicable_H_in := NULL;
    END IF;
         
    IF p_ProfileName_H_in ='NULL' OR p_ProfileName_H_in ='' THEN     
        p_ProfileName_H_in := NULL;
    END IF;  
  
    IF p_EmailTo_H_in ='NULL' OR p_EmailTo_H_in ='' THEN      
        p_EmailTo_H_in := NULL;
    END IF;  
  
    IF p_ArchCondition_H_in ='NULL' OR p_ArchCondition_H_in ='' THEN      
        p_ArchCondition_H_in := NULL;
    END IF;  
  
    IF p_Dep_Source_in ='NULL' OR p_Dep_Source_in ='' THEN      
        p_Dep_Source_in := NULL;
    END IF;  
  
    IF p_ArchIntvlCond_H_in ='NULL' OR p_ArchIntvlCond_H_in ='' THEN      
        p_ArchIntvlCond_H_in := NULL;
    END IF;  
  
    IF p_SourceCallingSeq_H_in ='NULL' OR p_SourceCallingSeq_H_in ='' THEN       
        p_SourceCallingSeq_H_in := NULL;
    END IF;
  
    IF p_APIUrl_in ='NULL' OR p_APIUrl_in ='' THEN      
        p_APIUrl_in := NULL;
    END IF;  
  
    IF p_APIMethod_in ='NULL' OR p_APIMethod_in ='' THEN      
        p_APIMethod_in := NULL;
    END IF;  
  
    IF p_APIAuthorizationType_in ='NULL' OR p_APIAuthorizationType_in ='' THEN      
        p_APIAuthorizationType_in := NULL;
    END IF;  
  
    IF p_APIAccessToken_in ='NULL' OR p_APIAccessToken_in ='' THEN      
        p_APIAccessToken_in := NULL;
    END IF;  
  
    IF p_APIPyModuleName_in ='NULL' OR p_APIPyModuleName_in ='' THEN      
        p_APIPyModuleName_in := NULL;
    END IF;  
  
    IF p_APIQueryParameters_in ='NULL' OR p_APIQueryParameters_in ='' THEN     
        p_APIQueryParameters_in := NULL;
    END IF;  
  
    IF p_APIRequestBody_in ='NULL' OR p_APIRequestBody_in ='' THEN      
        p_APIRequestBody_in := NULL;
    END IF;  
   
    IF p_EnvSourceCode_H_in ='NULL' OR p_EnvSourceCode_H_in ='' THEN      
        p_EnvSourceCode_H_in := NULL;
    END IF;  
  
    IF p_DataSourceCode_H_in ='NULL' OR p_DataSourceCode_H_in ='' THEN   
        p_DataSourceCode_H_in := NULL;
    END IF;  
    
    v_FTPCheck_H_in         := CAST(p_FTPCheck_H_in AS INTEGER);
    v_Isapplicable_H_in     := CAST(p_Isapplicable_H_in AS Boolean);
    v_SourceCallingSeq_H_in := CAST(p_SourceCallingSeq_H_in AS INTEGER);
    
    IF v_Isapplicable_H_in = 'true'
    THEN v_Isapplicable_H_in_cvt = 1;
    ELSE
    v_Isapplicable_H_in_cvt = 0;
    END IF;
  
    IF p_Flag_H_in = 'Insert' THEN  
        IF EXISTS(SELECT 'x' FROM ods.ControlHeader WHERE SourceId  = p_SourceId_H_in) THEN  
            p_ValidFlag_out := 'No';    
            p_ErrorMsg_out :='Alert: Record already exist in the Control table for this Source ID, Change flag to "Update"';   
            RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;  
        ELSE     
            INSERT INTO ods.ControlHeader  
            (  
                SourceName,             Sourcetype,     SourceDescription,  SourceId,           ConnectionStr,  
                ADLSContainerName,      DWObjectName,   ObjectType,         DLDirStructure,     DLPurgeFlag,  
                DWPurgeFlag,            FTPCheck,       Status,             CreatedDate,        LastUpdatedDate,  
                CreatedUser,            Isapplicable,   ProfileName,        EmailTo,            ArchCondition,  
                DepSource,              ArchIntvlCond,  SourceCallingSeq,   APIUrl,             APIMethod,  
                APIAuthorizationType,   APIAccessToken, APIPyModuleName,    APIQueryParameters, APIRequestBody,  
                EnvSourceCode,          DataSourceCode  
            )  
            SELECT  
                p_SourceName_H_in,          p_Sourcetype_H_in,      p_SourceDescription_H_in,   p_SourceId_H_in,        p_ConnectionStr_H_in,    
                p_ADLSContainerName_H_in,   p_DWObjectName_H_in,    p_ObjectType_H_in,          p_DLDirStructure_H_in,  p_DLPurgeFlag_H_in,    
                p_DWPurgeFlag_H_in,         v_FTPCheck_H_in,        p_Status_H_in,              NOW(),                  NOW(),  
                p_CreatedUser_H_in,         v_Isapplicable_H_in_cvt,    p_ProfileName_H_in,         p_EmailTo_H_in,         p_ArchCondition_H_in,    
                p_Dep_Source_in,            p_ArchIntvlCond_H_in,   v_SourceCallingSeq_H_in,    p_APIUrl_in,            p_APIMethod_in,  
                p_APIAuthorizationType_in,  p_APIAccessToken_in,    p_APIPyModuleName_in,       p_APIQueryParameters_in,p_APIRequestBody_in,  
                p_EnvSourceCode_H_in,       p_DataSourceCode_H_in;  
  
            p_ValidFlag_out := 'Yes';  
            p_ErrorMsg_out :='Info: Record inserted successfully';   
            RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;       
        END IF;  

        ELSE IF p_Flag_H_in = 'Update' THEN  
            IF EXISTS(SELECT 'x' FROM ods.ControlHeader WHERE SourceId  = p_SourceId_H_in)  
            THEN  
            UPDATE ods.ControlHeader  
            SET  
                SourceName              = p_SourceName_H_in,            Sourcetype          = p_Sourcetype_H_in,     
                SourceDescription       = p_SourceDescription_H_in,     ConnectionStr       = p_ConnectionStr_H_in,  
                ADLSContainerName       = p_ADLSContainerName_H_in,     DWObjectName        = p_DWObjectName_H_in,  
                ObjectType              = p_ObjectType_H_in,            DLDirStructure      = p_DLDirStructure_H_in,  
                DLPurgeFlag             = p_DLPurgeFlag_H_in,           DWPurgeFlag         = p_DWPurgeFlag_H_in,  
                FTPCheck                = v_FTPCheck_H_in,              Status              = p_Status_H_in,  
                LastUpdatedDate         = NOW(),                        Isapplicable        = v_Isapplicable_H_in_cvt,    
                ProfileName             = p_ProfileName_H_in,           EmailTo             = p_EmailTo_H_in,  
                ArchCondition           = p_ArchCondition_H_in,         DepSource           = p_Dep_Source_in,      
                ArchIntvlCond           = p_ArchIntvlCond_H_in,         SourceCallingSeq    = v_SourceCallingSeq_H_in,  
                APIUrl                  = p_APIUrl_in,                  APIMethod           = p_APIMethod_in,  
                APIAuthorizationType    = p_APIAuthorizationType_in,    APIAccessToken      = p_APIAccessToken_in,   
                APIPyModuleName         = p_APIPyModuleName_in,         APIQueryParameters  = p_APIQueryParameters_in,  
                APIRequestBody          = p_APIRequestBody_in,          EnvSourceCode       = p_EnvSourceCode_H_in,  
                DataSourceCode          = p_DataSourceCode_H_in  
            WHERE SourceId              = p_SourceId_H_in;
        
            p_ValidFlag_out := 'Yes';  
            p_ErrorMsg_out :='Info: Record Updated successfully';   
            RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;  
            ELSE  
 
            p_ValidFlag_out := 'No';  
            p_ErrorMsg_out :='Alert: Record not exist in the Control table for this Source ID, verify and change the flag to "Insert"';   
            RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;  
        END IF;  
        ELSE  
            p_ValidFlag_out := 'NA';  
            p_ErrorMsg_out :='Info: Record not considered for processing';   
            RETURN QUERY SELECT p_ValidFlag_out,p_ErrorMsg_out;  
        END IF;
    END IF;  
END;
$$;


ALTER FUNCTION ods.ufn_controlhdr_upload(p_sourcename_h_in character varying, p_sourcetype_h_in character varying, p_sourcedescription_h_in character varying, p_sourceid_h_in character varying, p_connectionstr_h_in character varying, p_adlscontainername_h_in character varying, p_dwobjectname_h_in character varying, p_objecttype_h_in character varying, p_dldirstructure_h_in character varying, p_dlpurgeflag_h_in character varying, p_dwpurgeflag_h_in character varying, p_ftpcheck_h_in character varying, p_status_h_in character varying, p_createddate_h_in character varying, p_lastupdateddate_h_in character varying, p_createduser_h_in character varying, p_isapplicable_h_in character varying, p_profilename_h_in character varying, p_emailto_h_in character varying, p_archcondition_h_in character varying, p_dep_source_in character varying, p_archintvlcond_h_in character varying, p_sourcecallingseq_h_in character varying, p_apiurl_in character varying, p_apimethod_in character varying, p_apiauthorizationtype_in character varying, p_apiaccesstoken_in character varying, p_apipymodulename_in character varying, p_apiqueryparameters_in character varying, p_apirequestbody_in character varying, p_envsourcecode_h_in character varying, p_datasourcecode_h_in character varying, p_flag_h_in character varying) OWNER TO proconnect;

--
-- Name: usp_target_count(bigint); Type: FUNCTION; Schema: ods; Owner: proconnect
--

CREATE FUNCTION ods.usp_target_count(v_rowid bigint) RETURNS TABLE(v_sourcetable text, v_dwhtable text, v_dimension character varying, v_period numeric, v_sourcedatacount bigint)
    LANGUAGE plpgsql
    AS $$

declare v_max int;
 v_id integer =1;
 v_Data text;
 v_DB text;
 v_SchemaName text;
 v_TableName text;
 v_dwhtable text;
 v_Column_List text;
 v_FromClause text;
 v_WhereClause text;
 v_GroupByClause text;
 v_JoinTableName text;
 v_JoinCondition text;
    
 begin
   select              DB,
                       SchemaName,
                       sourcetable,
                       TableName,
                       Column_List,
                       TableName,    
                       WhereClause_ColumnName,
                       GroupBy_ColumnName,
                       Join_TableName,
                       Join_ColumnName into v_DB, v_SchemaName, v_TableName, v_dwhtable,v_Column_List, v_FromClause, v_WhereClause, v_GroupByClause, v_JoinTableName, v_JoinCondition
            FROM    ods.DataValidation_ScriptGenerator
            WHERE    Row_id = v_rowid;
        
            IF v_WhereClause IS NULL AND v_GroupByClause IS NULL
             THEN
                v_Data='select '''|| v_TableName || ''','''||v_dwhtable||''','|| v_Column_List ||'from ' || v_SchemaName|| '.'|| v_dwhtable;
             END IF; 

                IF v_WhereClause IS NOT NULL AND v_GroupByClause IS NULL 
              THEN
                v_Data='select '''|| v_TableName || ''','''||v_dwhtable||''','|| v_Column_List ||'from ' || v_SchemaName|| '.' || v_dwhtable || ' where ' || v_WhereClause;
              END IF;   
        
            IF  v_WhereClause IS NOT NULL AND v_GroupByClause IS NOT NULL AND v_JoinTableName IS NOT NULL
             THEN
                v_Data:='select '''|| v_TableName || ''','''||v_dwhtable||''','|| v_Column_List ||'from ' || v_SchemaName|| '.' || v_dwhtable || ' d join ' || v_SchemaName|| '.' ||  v_JoinTableName || ' h ' || v_JoinCondition || ' where ' || v_WhereClause ||' group by '|| v_GroupByClause;
            END IF;
            
            IF  v_WhereClause IS NOT NULL AND v_GroupByClause IS NOT NULL AND v_JoinTableName IS NULL                
                THEN
                v_Data:='select '''|| v_TableName || ''','''||v_dwhtable||''','|| v_Column_List ||'from ' || v_SchemaName|| '.' || v_dwhtable || ' where ' || v_WhereClause ||' group by '|| v_GroupByClause;
            END IF;  
            
            

      RETURN QUERY EXECUTE v_Data;
          
END;
$$;


ALTER FUNCTION ods.usp_target_count(v_rowid bigint) OWNER TO proconnect;

--
-- Name: count_rows_of_table(text, text); Type: FUNCTION; Schema: public; Owner: proconnect
--

CREATE FUNCTION public.count_rows_of_table(schema text, tablename text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare
  query_template constant text not null :=
    '
      select count(*) from "?schema"."?tablename"
    ';

  query constant text not null :=
    replace(
      replace(
        query_template, '?schema', schema),
     '?tablename', tablename);

  result int not null := -1;
begin
  execute query into result;
  return result;
end;
$$;


ALTER FUNCTION public.count_rows_of_table(schema text, tablename text) OWNER TO proconnect;

--
-- Name: function_copy(); Type: FUNCTION; Schema: public; Owner: proconnect
--

CREATE FUNCTION public.function_copy() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    
    INSERT INTO
        table2(id,name)
        VALUES(new.id,new.name);

      RETURN new;
END;
$$;


ALTER FUNCTION public.function_copy() OWNER TO proconnect;
