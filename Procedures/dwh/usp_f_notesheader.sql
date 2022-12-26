-- PROCEDURE: dwh.usp_f_notesheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_notesheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_notesheader(
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_not_notes_hdr;

	UPDATE dwh.f_notesheader t
    SET
		tran_no				=	s.tran_no
		, tran_type			=	s.tran_type
		, tran_ou			=	s.tran_ou
		, amendment_no		=	s.amendment_no
		, keyfield1			=	s.keyfield1
		, keyfield2			=	s.keyfield2
		, keyfield3			=	s.keyfield3
		, keyfield4			=	s.keyfield4
		, doc_attach_compkey=	s.doc_attach_compkey
		, doc_notes			=	s.doc_notes
		, time_stamp		=	s.timestamp
		, created_by		=	s.created_by
		, created_date		=	s.created_date
		, modified_by		=	s.modified_by
		, modified_date		=	s.modified_date
		, doc_db			=	s.doc_db
		, doc_file			=	s.doc_file
		, doc_desc			=	s.doc_desc
		, doc_db_desc		=	s.doc_db_desc
		, Folder			=	s.Folder
		, etlactiveind 		=	1
		, etljobname 		=	p_etljobname
		, envsourcecd 		=	p_envsourcecd
		, datasourcecd 		=	p_datasourcecd
		, etlupdatedatetime =	NOW()
		FROM	stg.stg_not_notes_hdr s
		WHERE	t.notes_compkey	= s.notes_compkey;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.f_notesheader
	(   
        tran_no				,	tran_type		,	tran_ou			,
		amendment_no		,	keyfield1		,	keyfield2		,
		keyfield3			,	keyfield4		,	notes_compkey	,
		doc_attach_compkey	,	doc_notes		,	time_stamp		,
		created_by			,	created_date	,	modified_by		,
		modified_date		,	doc_db			,	doc_file		,
		doc_desc			,	doc_db_desc		,	Folder			,
		etlactiveind		,	etljobname		,	envsourcecd		,
		datasourcecd		,	etlcreatedatetime
	)
	
	SELECT 
		OH.tran_no				,	OH.tran_type		,	OH.tran_ou			,
		OH.amendment_no			,	OH.keyfield1		,	OH.keyfield2		,
		OH.keyfield3			,	OH.keyfield4		,	OH.notes_compkey	,
		OH.doc_attach_compkey	,	OH.doc_notes		,	OH.timestamp		,
		OH.created_by			,	OH.created_date		,	OH.modified_by		,
		OH.modified_date		,	OH.doc_db			,	OH.doc_file			,
		OH.doc_desc				,	OH.doc_db_desc		,	OH.Folder			,
		1 AS etlactiveind		,	p_etljobname		,	p_envsourcecd		,
		p_datasourcecd			,	NOW()
      
	FROM stg.stg_not_notes_hdr OH
	LEFT JOIN dwh.f_notesheader FH 	
	ON FH.notes_compkey 	= OH.notes_compkey
    WHERE FH.notes_compkey IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_not_notes_hdr
	(
		tran_no			,	tran_type			,	tran_ou			,	amendment_no	,
		keyfield1		,	keyfield2			,	keyfield3		,	keyfield4		,
		notes_compkey	,	doc_attach_compkey	,	doc_notes		,	"timestamp"		,
		created_by		,   created_date		,    modified_by	,	modified_date	,
		doc_db			,	doc_file			,    doc_desc		,	doc_db_desc		,
		folder			,	etlcreateddatetime
	)
	SELECT 
		tran_no				,	tran_type		,	tran_ou			,	amendment_no	,
		keyfield1			,	keyfield2		,	keyfield3		,	keyfield4		,
		notes_compkey		,	doc_attach_compkey,	doc_notes		,	timestamp		,
		created_by			,	created_date	,	modified_by		,	modified_date	,
		doc_db				,	doc_file		,	doc_desc		,	doc_db_desc		,
		Folder				,	etlcreateddatetime
	FROM stg.stg_not_notes_hdr;
    END IF;
    
    
    EXCEPTION WHEN others THEN
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;
   
 
   
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_notesheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
