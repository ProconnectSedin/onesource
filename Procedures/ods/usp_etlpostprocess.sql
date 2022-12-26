-- PROCEDURE: ods.usp_etlpostprocess(character varying, character varying, character varying, integer, integer, integer, integer, integer)

-- DROP PROCEDURE IF EXISTS ods.usp_etlpostprocess(character varying, character varying, character varying, integer, integer, integer, integer, integer);

CREATE OR REPLACE PROCEDURE ods.usp_etlpostprocess(
	IN psourceid character varying,
	IN ptargetobject character varying,
	IN pdataflowflag character varying,
	IN sourcegroupflag integer,
	IN pbatchid integer,
	IN psourcecount integer,
	IN pinsertcount integer,
	IN pupdatecount integer)
LANGUAGE 'plpgsql'
AS $BODY$
  
--Declare variables  
  
DECLARE   
	vSrcDelCnt 				INT := 0;  
	IsFailed 				INT :=0;
	ErrorId					VARCHAR(50);
	ErrorDesc				VARCHAR(2000);
	ErrorLine				VARCHAR(2000);
	STGtoDWLastRunDate 		TIMESTAMP(3);
	DepSourceLastRunDate 	TIMESTAMP(3);
	DepSource 				VARCHAR(40); 
	DepSourceStatus 		VARCHAR(40);
	v_etllastrundate 		TIMESTAMP(3);
	deletecount 			INTEGER;
	flag1 					INTEGER;
	flag2 					CHARACTER;
BEGIN

-- SQLINES DEMO ***  Error Table
-- SQLINES LICENSE FOR EVALUATION USE ONLY
	SELECT 
		COALESCE(COUNT(*),0) INTO IsFailed 
	FROM ODS.Error
	WHERE LatestBatchId = pbatchid  
	AND TargetObject = ptargetobject  
	AND SourceId = psourceid  
	AND DataflowFlag = pdataflowflag;
	
	SELECT NOW()::TIMESTAMP INTO v_etllastrundate;

IF IsFailed = 0 
THEN 	
	IF (pdataflowflag = 'SRCtoStg')  
		THEN  
			-- SQLINES DEMO *** ADER FOR STATUS
		UPDATE ODS.ControlDetail
		SET     IsReadyForExecution		= 0  
		WHERE   SourceId				= psourceid  
		AND     DataflowFlag			= 'SRCtoStg'  
		AND     Isapplicable			= 1;
        
		UPDATE ODS.ControlHeader
		SET		Status				=	'Started',
				LastUpdatedDate		=	NOW()
		WHERE	SourceId			=	psourceid 
		AND		Isapplicable		=	1;
		
		UPDATE ODS.ControlDetail
		SET     IsReadyForExecution		= 1  
		WHERE   SourceId				= psourceid  
		AND     DataflowFlag			= 'StgtoDW'  
		AND     Isapplicable			= 1;
	END IF;		
  
	IF (pdataflowflag = 'StgtoDW')  
	THEN  

		-- SQLINES DEMO *** ADER FOR STATUS

		UPDATE ODS.ControlHeader
		SET		Status				=	'Completed',
				LastUpdatedDate		=	NOW()
		WHERE	SourceId			=	psourceid 
		AND		Isapplicable		=	1;

		  
		UPDATE ODS.ControlDetail
		SET		IsReadyForExecution 	= 0
		WHERE 	TargetObject 			= ptargetobject
		AND 	SourceId 				= psourceid  
		AND 	DataflowFlag			= 'StgtoDW'  
		AND 	Isapplicable			= 1;

		UPDATE ODS.ControlDetail
		SET     IsReadyForExecution		= 1
		WHERE   SourceId				= psourceid  
		AND     DataflowFlag			= 'SRCtoStg'  
		AND     Isapplicable			= 1;
		
		IF sourcegroupflag =  1
		THEN
		
		update ods.sourcegroupingdtl
		set status 				= 'Completed',
			lastrundatetime		=	v_etllastrundate,
			loadenddatetime = NOW()::timestamp
			where sourceid = psourceid
			and schemaname = 'dwh'
			and isapplicable = 1;
			
		END IF;		   

	END IF; 

	-- SQLINES DEMO *** le with Status and Updated date  
  
	UPDATE ODS.ControlDetail
	SET		FlowStatus 		= 'Completed',
			EtlLastRunDate 	= v_etllastrundate
	WHERE 	LatestBatchId 	= pbatchid  
	AND 	TargetObject 	= ptargetobject   
	AND 	SourceId 		= psourceid  
	AND 	DataflowFlag 	= pdataflowflag  
	AND 	Isapplicable 	= 1;

	UPDATE ODS.Audit 
	SET		SrcRwCnt 		= psourcecount,
			TgtInscnt 		= pinsertcount,
			TgtUpdcnt 		= pupdatecount,
			FlowStatus 		= 'Completed',
			UpdatedDate 	= Now(),
			LoadEndTime 	= Now()  
	WHERE 	LatestBatchId 	= pbatchid  
	AND 	TargetObject 	= ptargetobject  
	AND 	SourceId 		= psourceid  
	AND 	DataflowFlag 	= pdataflowflag; 

	ELSE 

		-- SQLINES DEMO *** le with Status and Updated date  

		UPDATE ODS.ControlHeader
		SET		Status				=	'Failed',
				LastUpdatedDate		=	NOW()
		WHERE	SourceId			=	psourceid 
		AND		Isapplicable		=	1;
  
		UPDATE ODS.ControlDetail 
		SET		FlowStatus 			= 'Failed'     
		WHERE 	LatestBatchId 		= pbatchid  
		AND 	TargetObject 		= ptargetobject   
		AND 	SourceId 			= psourceid  
		AND 	DataflowFlag 		= pdataflowflag  
		AND 	Isapplicable 		= 1;

		
		UPDATE ODS.Audit
	    SET		SrcRwCnt 		= psourcecount,
			    TgtInscnt 		= pinsertcount,		    
			    TgtUpdcnt 		= pupdatecount,
				FlowStatus 		= 'Failed',
				UpdatedDate 	= Now(),
				LoadEndTime 	= Now()  
		WHERE 	LatestBatchId 	= pbatchid  
		AND 	TargetObject 	= ptargetobject  
		AND 	SourceId 		= psourceid  
		AND 	DataflowFlag 	= pdataflowflag;
		
		IF sourcegroupflag =  1
	THEN		
		update ods.sourcegroupingdtl
		set status = 'Failed',
		loadenddatetime = NOW()::timestamp
		where sourceid = psourceid
		and schemaname = 'dwh'
		and isapplicable = 1;
		
	END IF;
  

	END IF;

END;
$BODY$;
ALTER PROCEDURE ods.usp_etlpostprocess(character varying, character varying, character varying, integer, integer, integer, integer, integer)
    OWNER TO proconnect;
