-- PROCEDURE: dwh.usp_d_tcalvalidadjcrdrdocmet(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_tcalvalidadjcrdrdocmet(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_tcalvalidadjcrdrdocmet(
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
    FROM stg.stg_tcal_validadj_crdrdoc_met;

    UPDATE dwh.D_tcalvalidadjcrdrdocmet t
    SET
        tax_type             = s.tax_type,
        tax_community        = s.tax_community,
        Component            = s.Component,
        cr_doc_type          = s.cr_doc_type,
        dr_doc_type          = s.dr_doc_type,
        allow                = s.allow,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_tcal_validadj_crdrdoc_met s
    WHERE t.tax_type = s.tax_type
    AND t.tax_community = s.tax_community
    AND t.Component = s.Component
    AND t.cr_doc_type = s.cr_doc_type
    AND t.dr_doc_type = s.dr_doc_type;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_tcalvalidadjcrdrdocmet
    (
        tax_type, tax_community, Component, cr_doc_type, dr_doc_type, allow, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tax_type, s.tax_community, s.Component, s.cr_doc_type, s.dr_doc_type, s.allow, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tcal_validadj_crdrdoc_met s
    LEFT JOIN dwh.D_tcalvalidadjcrdrdocmet t
    ON s.tax_type = t.tax_type
    AND s.tax_community = t.tax_community
    AND s.Component = t.Component
    AND s.cr_doc_type = t.cr_doc_type
    AND s.dr_doc_type = t.dr_doc_type
    WHERE t.tax_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tcal_validadj_crdrdoc_met
    (
        tax_type, tax_community, Component, cr_doc_type, dr_doc_type, allow, etlcreateddatetime
    )
    SELECT
        tax_type, tax_community, Component, cr_doc_type, dr_doc_type, allow, etlcreateddatetime
    FROM stg.stg_tcal_validadj_crdrdoc_met;
    
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
ALTER PROCEDURE dwh.usp_d_tcalvalidadjcrdrdocmet(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
