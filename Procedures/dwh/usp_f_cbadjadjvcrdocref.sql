-- PROCEDURE: dwh.usp_f_cbadjadjvcrdocref(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cbadjadjvcrdocref(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cbadjadjvcrdocref(
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
    FROM stg.Stg_cbadj_adjv_crdoc_ref;

    UPDATE dwh.F_cbadjadjvcrdocref t
    SET
		adj_docdtl_key			= hd.adj_docdtl_key,
        parent_key              = s.parent_key,
        ref_cr_doc_no           = s.ref_cr_doc_no,
        cr_doc_ou               = s.cr_doc_ou,
        cr_doc_type             = s.cr_doc_type,
        term_no                 = s.term_no,
        cr_doc_adj_amt          = s.cr_doc_adj_amt,
        cr_doc_unadj_amt        = s.cr_doc_unadj_amt,
        tran_type               = s.tran_type,
        guid                    = s.guid,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.Stg_cbadj_adjv_crdoc_ref s
	INNER JOIN dwh.F_cbadjadjvcrdocdtl hd
	ON s.ref_cr_doc_no 	= hd.cr_doc_no
	AND s.cr_doc_ou		= hd.cr_doc_ou 
	and s.cr_doc_type 	= hd.cr_doc_type 
	and s.guid 			= hd.batch_id
    WHERE t.parent_key 	= s.parent_key
    AND t.ref_cr_doc_no = s.ref_cr_doc_no
    AND t.cr_doc_ou 	= s.cr_doc_ou
    AND t.cr_doc_type 	= s.cr_doc_type
    AND t.term_no 		= s.term_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cbadjadjvcrdocref
    (
		adj_docdtl_key	,
        parent_key		, ref_cr_doc_no		, cr_doc_ou		, cr_doc_type	, term_no,
		cr_doc_adj_amt	, cr_doc_unadj_amt	, tran_type		, guid			, 
		etlactiveind	, etljobname		, envsourcecd	, datasourcecd	, etlcreatedatetime
    )

    SELECT
		hd.adj_docdtl_key	,
        s.parent_key		, s.ref_cr_doc_no	, s.cr_doc_ou	, s.cr_doc_type	, s.term_no, 
		s.cr_doc_adj_amt	, s.cr_doc_unadj_amt, s.tran_type	, s.guid		,
			1				, p_etljobname		, p_envsourcecd	, p_datasourcecd, NOW()
    FROM stg.Stg_cbadj_adjv_crdoc_ref s
	INNER JOIN dwh.F_cbadjadjvcrdocdtl hd
	ON s.ref_cr_doc_no 	= hd.cr_doc_no
	AND s.cr_doc_ou		= hd.cr_doc_ou 
	and s.cr_doc_type 	= hd.cr_doc_type 
	and s.guid 			= hd.batch_id
    LEFT JOIN dwh.F_cbadjadjvcrdocref t
    ON s.parent_key = t.parent_key
    AND s.ref_cr_doc_no = t.ref_cr_doc_no
    AND s.cr_doc_ou = t.cr_doc_ou
    AND s.cr_doc_type = t.cr_doc_type
    AND s.term_no = t.term_no
    WHERE t.parent_key IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cbadj_adjv_crdoc_ref
    (
        parent_key, ref_cr_doc_no, cr_doc_ou, cr_doc_type, term_no, cr_doc_adj_amt, cr_doc_unadj_amt, tran_type, guid, etlcreateddatetime
    )
    SELECT
        parent_key, ref_cr_doc_no, cr_doc_ou, cr_doc_type, term_no, cr_doc_adj_amt, cr_doc_unadj_amt, tran_type, guid, etlcreateddatetime
    FROM stg.Stg_cbadj_adjv_crdoc_ref;
    
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
ALTER PROCEDURE dwh.usp_f_cbadjadjvcrdocref(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
