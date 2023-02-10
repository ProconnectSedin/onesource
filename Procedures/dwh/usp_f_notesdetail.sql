-- PROCEDURE: dwh.usp_f_notesdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_notesdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_notesdetail(
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_not_notes_dtl;

    UPDATE dwh.F_NotesDetail t
    SET
		notes_hdr_key	 	 = coalesce(b.notes_hdr_key,-1),
        tran_no              = s.tran_no,
        tran_type            = s.tran_type,
        tran_ou              = s.tran_ou,
        amendment_no         = s.amendment_no,
        keyfield1            = s.keyfield1,
        keyfield2            = s.keyfield2,
        keyfield3            = s.keyfield3,
        keyfield4            = s.keyfield4,
        notes_compkey        = s.notes_compkey,
        line_no              = s.line_no,
        line_entity          = s.line_entity,
        line_notes           = s.line_notes,
        line_df              = s.line_df,
        line_file            = s.line_file,
        line_desc            = s.line_desc,
        line_df_desc         = s.line_df_desc,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_not_notes_dtl s
	INNER JOIN dwh.f_notesheader b
	ON 	b.notes_compkey	= s.notes_compkey
    WHERE t.notes_compkey = s.notes_compkey
    AND t.line_no = s.line_no
    AND t.line_entity = s.line_entity;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_NotesDetail
    (
		notes_hdr_key	, tran_no		, tran_type		, tran_ou		, amendment_no, 
		keyfield1		, keyfield2		, keyfield3		, keyfield4		, notes_compkey, 
		line_no			, line_entity	, line_notes	, line_df		, line_file, 
		line_desc		, line_df_desc	, 
		etlactiveind	, etljobname	, envsourcecd	, datasourcecd	, etlcreatedatetime
    )

    SELECT
        coalesce(b.notes_hdr_key,-1)	, s.tran_no		, s.tran_type	, s.tran_ou		, s.amendment_no,
		s.keyfield1		, s.keyfield2	, s.keyfield3	, s.keyfield4	, s.notes_compkey,
		s.line_no		, s.line_entity	, s.line_notes	, s.line_df		, s.line_file,
		s.line_desc		, s.line_df_desc,
				1		, p_etljobname	, p_envsourcecd	, p_datasourcecd, NOW()
    FROM stg.stg_not_notes_dtl s
	INNER JOIN dwh.f_notesheader b
	ON 	b.notes_compkey	= s.notes_compkey
    LEFT JOIN dwh.F_NotesDetail t
    ON s.notes_compkey = t.notes_compkey
    AND s.line_no = t.line_no
    AND s.line_entity = t.line_entity
    WHERE t.tran_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_not_notes_dtl
    (
        tran_no, tran_type, tran_ou, amendment_no, keyfield1,
		keyfield2, keyfield3, keyfield4, notes_compkey, line_no,
		line_entity, line_notes, line_df, line_file, line_desc,
		line_df_desc, etlcreatedatetime
    )
    SELECT
        tran_no, tran_type, tran_ou, amendment_no, keyfield1, 
		keyfield2, keyfield3, keyfield4, notes_compkey, line_no,
		line_entity, line_notes, line_df, line_file, line_desc,
		line_df_desc, etlcreatedatetime
    FROM stg.stg_not_notes_dtl;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_notesdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
