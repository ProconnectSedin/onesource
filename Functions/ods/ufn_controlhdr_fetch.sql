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