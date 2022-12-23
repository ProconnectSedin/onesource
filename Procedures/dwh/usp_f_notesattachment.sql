CREATE PROCEDURE dwh.usp_f_notesattachment(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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
    FROM stg.stg_Not_Notes_AttachDoc;

    UPDATE dwh.F_NotesAttachment t
    SET
        tran_no                   	= s.tran_no,
        tran_type                 	= s.tran_type,
        tran_ou                   	= s.tran_ou,
        amendment_no              	= s.amendment_no,
        keyfield1                 	= s.keyfield1,
        keyfield2                 	= s.keyfield2,
        keyfield3                 	= s.keyfield3,
        keyfield4                 	= s.keyfield4,
        doc_attach_compkey        	= s.doc_attach_compkey,
        natimestamp               	= s.natimestamp,
        created_by                	= s.created_by,
        created_date              	= s.created_date,
        modified_by               	= s.modified_by,
        modified_date             	= s.modified_date,
        attach_file               	= s.attach_file,
        attach_df                 	= s.attach_df,
        Attached_on               	= s.Attached_on,
        attach_desc               	= s.attach_desc,
        notes_comments            	= s.notes_comments,
        etlactiveind              	= 1,
        etljobname                	= p_etljobname,
        envsourcecd               	= p_envsourcecd,
        datasourcecd              	= p_datasourcecd,
        etlupdatedatetime         	= NOW()
    FROM stg.stg_Not_Notes_AttachDoc s
    WHERE   t.Sequence_no 			= s.Sequence_no
		AND t.notes_compkey 		= s.notes_compkey
		AND t.line_no 				= s.line_no
		AND t.line_entity 			= s.line_entity;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_NotesAttachment
    (
        Sequence_no, tran_no, tran_type, tran_ou, amendment_no, keyfield1, keyfield2, keyfield3, keyfield4, notes_compkey, doc_attach_compkey, natimestamp, created_by, created_date, modified_by, modified_date, line_no, line_entity, attach_file, attach_df, Attached_on, attach_desc, notes_comments, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.Sequence_no, s.tran_no, s.tran_type, s.tran_ou, s.amendment_no, s.keyfield1, s.keyfield2, s.keyfield3, s.keyfield4, s.notes_compkey, s.doc_attach_compkey, s.natimestamp, s.created_by, s.created_date, s.modified_by, s.modified_date, s.line_no, s.line_entity, s.attach_file, s.attach_df, s.Attached_on, s.attach_desc, s.notes_comments, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_Not_Notes_AttachDoc s
    LEFT JOIN dwh.F_NotesAttachment t
		ON s.Sequence_no 			= t.Sequence_no
		AND s.notes_compkey 		= t.notes_compkey
		AND s.line_no 				= t.line_no
		AND s.line_entity 			= t.line_entity
    WHERE t.Sequence_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_Not_Notes_AttachDoc
    (
        Sequence_no, tran_no, tran_type, tran_ou, amendment_no, keyfield1, keyfield2, keyfield3, keyfield4, notes_compkey, doc_attach_compkey, natimestamp, created_by, created_date, modified_by, modified_date, line_no, line_entity, attach_file, attach_df, Attached_on, attach_desc, notes_comments, etlcreateddatetime
    )
    SELECT
        Sequence_no, tran_no, tran_type, tran_ou, amendment_no, keyfield1, keyfield2, keyfield3, keyfield4, notes_compkey, doc_attach_compkey, natimestamp, created_by, created_date, modified_by, modified_date, line_no, line_entity, attach_file, attach_df, Attached_on, attach_desc, notes_comments, etlcreateddatetime
    FROM stg.stg_Not_Notes_AttachDoc;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;