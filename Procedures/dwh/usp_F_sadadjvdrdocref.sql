-- PROCEDURE: dwh.usp_F_sadadjvdrdocref(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_F_sadadjvdrdocref(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_F_sadadjvdrdocref(
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
    FROM stg.Stg_sad_adjv_drdoc_ref;

    UPDATE dwh.F_sadadjvdrdocref t
    SET
	
		sadadjvdrdocdtl_key   = sd.sadadjvdrdocdtl_key,
        parent_key              = s.parent_key,
        ref_dr_doc_no           = s.ref_dr_doc_no,
        dr_doc_ou               = s.dr_doc_ou,
        dr_doc_type             = s.dr_doc_type,
        term_no                 = s.term_no,
        dr_doc_adj_amt          = s.dr_doc_adj_amt,
        dr_doc_unadj_amt        = s.dr_doc_unadj_amt,
        tran_type               = s.tran_type,
        discount                = s.discount,
        guid                    = s.guid,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.Stg_sad_adjv_drdoc_ref s
	
	INNER JOIN  dwh.f_sadadjvdrdocdtl sd
	ON s.ref_dr_doc_no = sd.dr_doc_no 
	and s.dr_doc_ou 	= sd.dr_doc_ou
	and s.dr_doc_type	= sd.dr_doc_type   
	AND s.guid = sd.batch_id 
    WHERE t.parent_key = s.parent_key
    AND t.ref_dr_doc_no = s.ref_dr_doc_no
    AND t.dr_doc_ou = s.dr_doc_ou
    AND t.dr_doc_type = s.dr_doc_type
    AND t.term_no = s.term_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sadadjvdrdocref
    (
       sadadjvdrdocdtl_key , parent_key, ref_dr_doc_no, dr_doc_ou, dr_doc_type, term_no, dr_doc_adj_amt, dr_doc_unadj_amt, tran_type, discount, guid, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
         sd.sadadjvdrdocdtl_key, s.parent_key, s.ref_dr_doc_no, s.dr_doc_ou, s.dr_doc_type, s.term_no, s.dr_doc_adj_amt, s.dr_doc_unadj_amt, s.tran_type, s.discount, s.guid, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_sad_adjv_drdoc_ref s
	INNER JOIN  dwh.f_sadadjvdrdocdtl sd
	ON s.ref_dr_doc_no = sd.dr_doc_no 
	and s.dr_doc_ou 	= sd.dr_doc_ou
	and s.dr_doc_type	= sd.dr_doc_type   
	AND s.guid = sd.batch_id 
    LEFT JOIN dwh.F_sadadjvdrdocref t
    ON s.parent_key = t.parent_key
    AND s.ref_dr_doc_no = t.ref_dr_doc_no
    AND s.dr_doc_ou = t.dr_doc_ou
    AND s.dr_doc_type = t.dr_doc_type
    AND s.term_no = t.term_no
    WHERE t.parent_key IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sad_adjv_drdoc_ref
    (
        parent_key, ref_dr_doc_no, dr_doc_ou, dr_doc_type, term_no, dr_doc_adj_amt, dr_doc_unadj_amt, tran_type, discount, guid, etlcreateddatetime
    )
    SELECT
        parent_key, ref_dr_doc_no, dr_doc_ou, dr_doc_type, term_no, dr_doc_adj_amt, dr_doc_unadj_amt, tran_type, discount, guid, etlcreateddatetime
    FROM stg.Stg_sad_adjv_drdoc_ref;
    
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

ALTER PROCEDURE dwh.usp_F_sadadjvdrdocref(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
