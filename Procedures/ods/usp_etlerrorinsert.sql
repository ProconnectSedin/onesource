CREATE OR REPLACE PROCEDURE ods.usp_etlerrorinsert(IN p_sourceid character varying, IN p_targetobject character varying, IN p_dataflowflag character varying, IN p_batchid integer, IN p_taskname character varying, IN p_packagename character varying, IN p_errorid integer, IN p_errordesc character varying, IN p_errorline integer)
    LANGUAGE plpgsql
    AS $$

DECLARE p_Flag1			INT ;
		p_Flag2			VARCHAR(100);
    
BEGIN
	
-- SQLINES DEMO ***  with Status, Source, Target, Inserted and Updated record counts

	IF ( SELECT 1 FROM  ODS.ControlDetail 
				WHERE TargetObject	= p_TargetObject   
				AND SourceId		= p_SourceId  
				AND DataflowFlag	= p_DataflowFlag  ) = 1
	THEN

	-- SQLINES LICENSE FOR EVALUATION USE ONLY
		INSERT INTO ODS.Error
				   (SourceName						,SourceType
				   ,SourceDescription				,SourceId
				   ,SourceObject					,DataflowFlag
				   ,TargetName						,TargetSchemaName
				   ,TargetObject					,TargetProcedureName
				   ,TaskName						,PackageName
				   ,JobName							,ErrorID
				   ,ErrorDesc						,ErrorLine
				   ,ErrorDate						,LatestBatchId)
		SELECT 
				    SourceName						,SourceType
				   ,SourceDescription				,SourceId
				   ,SourceObject					,DataflowFlag
				   ,TargetName						,TargetSchemaName
				   ,TargetObject					,TargetProcedureName
				   ,p_TaskName						,p_PackageName
				   ,JobName							,p_ErrorId
				   ,p_ErrorDesc						,p_ErrorLine
				   ,NOW()							,LatestBatchId
		FROM ODS.ControlDetail
		WHERE 	TargetObject 	= p_TargetObject   
		AND 	SourceId 		= p_SourceId  
		AND 	DataflowFlag 	= p_DataflowFlag;

	END IF;

	-- SQLINES DEMO *** control Table

	UPDATE ODS.ControlDetail
	SET		FlowStatus 	= 'Failed'    
	WHERE 	TargetObject 	= p_TargetObject   
	AND 	SourceId 		= p_SourceId  
	AND 	DataflowFlag 	= p_DataflowFlag 
    AND     latestbatchid   = p_batchid;
    
	UPDATE ODS.ControlHeader
	SET		Status 	= 'Failed'    
	WHERE 	SourceId 		= p_SourceId;    

	-- SQLINES DEMO ***  Audit Table
	UPDATE ODS.Audit
	SET		FlowStatus 	= 'Failed'     
	WHERE 	TargetObject 	= p_TargetObject   
	AND 	SourceId 		= p_SourceId  
	AND 	DataflowFlag 	= p_DataflowFlag
    AND     latestbatchid   = p_batchid;  
	
	IF p_dataflowflag = 'DWtoClick'
	THEN
		INSERT INTO ODS.Error
				   (SourceName						,SourceType
				   ,SourceDescription				,SourceId
				   ,SourceObject					,DataflowFlag
				   ,TargetName						,TargetSchemaName
				   ,TargetObject					,TargetProcedureName
				   ,TaskName						,PackageName
				   ,JobName							,ErrorID
				   ,ErrorDesc						,ErrorLine
				   ,ErrorDate						,LatestBatchId)
		SELECT 
				    'onesource'						,'PostgreSQL'
				   ,'PostgreSQL'					,p_sourceid
				   ,p_sourceid						,p_dataflowflag
				   ,'click'							,'click'
				   ,p_targetobject					,NULL
				   ,p_TaskName						,p_PackageName
				   ,NULL							,p_ErrorId
				   ,p_ErrorDesc						,p_ErrorLine
				   ,NOW()							,p_batchid;
				   
			END IF;

END;
$$;