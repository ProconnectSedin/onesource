CREATE OR REPLACE FUNCTION ods.ufn_controldtl_upload(p_sourcename_d_in character varying, p_sourcetype_d_in character varying, p_sourcedescription_d_in character varying, p_sourceid_d_in character varying, p_sourceobject_d_in character varying, p_dataflowflag_d_in character varying, p_isreadyforexecution_d_in character varying, p_loadtype_d_in character varying, p_loadfrequency_d_in character varying, p_flowstatus_d_in character varying, p_targetname_d_in character varying, p_targetschemaname_d_in character varying, p_targetobject_d_in character varying, p_targetprocedurename_d_in character varying, p_jobname_d_in character varying, p_createddate_d_in character varying, p_lastupdateddate_d_in character varying, p_createduser_d_in character varying, p_isapplicable_d_in character varying, p_profilename_d_in character varying, p_emailto_d_in character varying, p_archcondition_d_in character varying, p_isdecomreq_d_in character varying, p_archintvlcond_d_in character varying, p_sourcequery_d_in character varying, p_sourcecallingseq_d_in character varying, p_etllastrundate_d_in character varying, p_latestbatchid_d_in character varying, p_flag_d_in character varying) RETURNS TABLE(p_validflag_out character varying, p_errormsg_out character varying)
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