-- PROCEDURE: ods.usp_etlpreprocess(character varying, character varying, character varying, integer, integer, character varying, character varying, integer)

-- DROP PROCEDURE IF EXISTS ods.usp_etlpreprocess(character varying, character varying, character varying, integer, integer, character varying, character varying, integer);

-- added sourcegroupflag in sp
CREATE OR REPLACE PROCEDURE ods.usp_etlpreprocess(
	IN psourceid character varying,
	IN ptargetobject character varying,
	IN pdataflowflag character varying,
	IN sourcegroupflag integer,
	IN sourcecount integer,
	IN useragent character varying,
	IN etlbatchid character varying,
	INOUT batchid integer)
LANGUAGE 'plpgsql'
AS $BODY$

	DECLARE Sql1 			TEXT;
			Stagetable 		VARCHAR(100);
			ErrorId			VARCHAR(50);
			ErrorDesc		VARCHAR(2000);
			ErrorLine		VARCHAR(2000);
			TargetSchema  	VARCHAR(400);
			vSourceName		VARCHAR(100);
	        loadstarttime   timestamp without time zone;
	        executionflag   integer;
	        flag1           integer;
	        flag2           character varying;            

BEGIN

	ExecutionFlag := 1;

	-- SQLINES LICENSE FOR EVALUATION USE ONLY
	SELECT IsReadyForExecution,
		  TargetSchemaName || '.' || TargetObject,
		  SourceName INTO ExecutionFlag, TargetSchema, vSourceName
	FROM ods.ControlDetail
	WHERE SourceId		= psourceid
	AND   TargetObject	= ptargetobject
	AND   DataflowFlag	= pdataflowflag
	AND   Isapplicable 	= 1; 	
	
	
	--TRUNCATE TABLE targetobject;
    IF (pdataflowflag = 'SRCtoStg')  
	THEN     
        EXECUTE 'TRUNCATE ' || TargetSchema;
	END IF;

    IF (pdataflowflag = 'STGtoDW')  
	THEN  
		SELECT  
            SourceObject INTO Stagetable
        FROM ODS.ControlDetail
        WHERE SourceId = psourceid 
		AND DataflowFlag = pdataflowflag 
        AND TargetObject = ptargetobject
		AND Isapplicable = 1;
		
		Sql1 := N'SELECT @SourceCount  = COUNT(1) FROM OneSource_Stage.dbo.'||Stagetable;
		EXECUTE sp_executesql Sql1, N'@SourceCount NVARCHAR(100) OUTPUT', SourceCount = SourceCount OUTPUT;
	END IF;
-- SQLINES DEMO *** om Control table

	SELECT 
		COALESCE(LatestBatchId,0) + 1 AS Batch INTO BatchId 
	FROM ODS.ControlDetail
	WHERE SourceId = psourceid 
	AND TargetObject = ptargetobject
	AND DataflowFlag = pdataflowflag
	AND Isapplicable = 1; 
	
	LoadStartTime := now();

-- SQLINES DEMO *** Control Header

	UPDATE ODS.ControlHeader
	SET		Status			=	'Started',
			LastUpdatedDate	=	NOW()
	WHERE	SourceId		=	psourceid 
	AND		Isapplicable	=	1;

-- SQLINES DEMO *** Control Table

	UPDATE ODS.ControlDetail
	SET LatestBatchId 	= BatchId,
		FlowStatus 		= 'Started'
	WHERE SourceId 		= psourceid 
	AND TargetObject 	= ptargetobject
	AND DataflowFlag 	= pdataflowflag
	and Isapplicable 	= 1;

-- SQLINES DEMO ***  with Status, Source, Target, Inserted and Updated record counts

-- SQLINES LICENSE FOR EVALUATION USE ONLY
	INSERT INTO ODS.Audit
			   (SourceName          ,Sourcetype			,SourceDescription         	,SourceObject
			   ,SourceId			,DataflowFlag       ,SrcRwCnt					,SrcDelCnt           
			   ,TgtInscnt           ,TgtDelcnt			,TgtUpdcnt				   	,FlowStatus
			   ,TargetName          ,TargetSchemaName   ,TargetObject				,TargetProcedureName
			   ,CreatedDate         ,UpdatedDate        ,LoadStartTime			   	,LoadEndTime
			   ,LatestBatchId		,LoadType			,etlbatchid					,useragent		,sourcegroupflag)
	SELECT		SourceName	        ,Sourcetype	        ,SourceDescription	        ,SourceObject
			   ,SourceId	        ,DataflowFlag	    ,SourceCount				,0
			   ,NULL				,NULL				,NULL						,'Started'
			   ,TargetName          ,TargetSchemaName   ,TargetObject				,TargetProcedureName
			   ,Now()				,NULL				,LoadStartTime				,NULL
			   ,BatchId				,LoadType			,etlbatchid					,useragent		,sourcegroupflag
	FROM ODS.ControlDetail
	WHERE SourceId = psourceid 
	AND TargetObject = ptargetobject
	AND DataflowFlag = pdataflowflag
	and Isapplicable = 1;
	
	IF sourcegroupflag =  1
	THEN
	
	update ods.sourcegroupingdtl
	set status = 'Started',
	loadstartdatetime = NOW()::timestamp
	where sourceid = psourceid
	and schemaname = 'dwh'
	and isapplicable = 1
	and pdataflowflag = 'SRCtoStg';
	
	END IF;
	
	select BatchId INTO batchid;

END;
$BODY$;
ALTER PROCEDURE ods.usp_etlpreprocess(character varying, character varying, character varying, integer, integer, character varying, character varying, integer)
    OWNER TO proconnect;
