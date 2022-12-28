CREATE OR REPLACE FUNCTION ods.ufn_controlhdr_upload(p_sourcename_h_in character varying, p_sourcetype_h_in character varying, p_sourcedescription_h_in character varying, p_sourceid_h_in character varying, p_connectionstr_h_in character varying, p_adlscontainername_h_in character varying, p_dwobjectname_h_in character varying, p_objecttype_h_in character varying, p_dldirstructure_h_in character varying, p_dlpurgeflag_h_in character varying, p_dwpurgeflag_h_in character varying, p_ftpcheck_h_in character varying, p_status_h_in character varying, p_createddate_h_in character varying, p_lastupdateddate_h_in character varying, p_createduser_h_in character varying, p_isapplicable_h_in character varying, p_profilename_h_in character varying, p_emailto_h_in character varying, p_archcondition_h_in character varying, p_dep_source_in character varying, p_archintvlcond_h_in character varying, p_sourcecallingseq_h_in character varying, p_apiurl_in character varying, p_apimethod_in character varying, p_apiauthorizationtype_in character varying, p_apiaccesstoken_in character varying, p_apipymodulename_in character varying, p_apiqueryparameters_in character varying, p_apirequestbody_in character varying, p_envsourcecode_h_in character varying, p_datasourcecode_h_in character varying, p_flag_h_in character varying) RETURNS TABLE(p_validflag_out character varying, p_errormsg_out character varying)
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