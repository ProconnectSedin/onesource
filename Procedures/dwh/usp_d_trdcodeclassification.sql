-- PROCEDURE: dwh.usp_d_trdcodeclassification(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_trdcodeclassification(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_trdcodeclassification(
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
    FROM stg.stg_trd_code_classification;
	UPDATE dwh.D_trdcodeclassification t
    SET
        tax_type                        = s.tax_type,
        tax_community                   = s.tax_community,
        Code_classification             = s.Code_classification,
        code_type                       = s.code_type,
        Code_classification_code        = s.Code_classification_code,
        code_type_code                  = s.code_type_code,
        language_id                     = s.language_id,
        default_flag                    = s.default_flag,
        cml_len                         = s.cml_len,
        cml_translate                   = s.cml_translate,
        Orderby                         = s.Orderby,
        sub_code_type                   = s.sub_code_type,
        sub_code_type_code              = s.sub_code_type_code,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_trd_code_classification s
    WHERE t.tax_type = s.tax_type
    AND t.tax_community = s.tax_community
    AND t.Code_classification = s.Code_classification
    AND t.code_type = s.code_type
    AND t.Code_classification_code = s.Code_classification_code;
	
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_trdcodeclassification
    (
        tax_type, tax_community, Code_classification, code_type, Code_classification_code, code_type_code, language_id, default_flag, cml_len, cml_translate, Orderby, sub_code_type, sub_code_type_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tax_type, s.tax_community, s.Code_classification, s.code_type, s.Code_classification_code, s.code_type_code, s.language_id, s.default_flag, s.cml_len, s.cml_translate, s.Orderby, s.sub_code_type, s.sub_code_type_code, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_trd_code_classification s
    LEFT JOIN dwh.D_trdcodeclassification t
    ON s.tax_type = t.tax_type
    AND s.tax_community = t.tax_community
    AND s.Code_classification = t.Code_classification
    AND s.code_type = t.code_type
    AND s.Code_classification_code = t.Code_classification_code
    WHERE t.tax_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_trd_code_classification
    (
        tax_type, tax_community, Code_classification, code_type, Code_classification_code, code_type_code, language_id, default_flag, cml_len, cml_translate, Orderby, sub_code_type, sub_code_type_code, etlcreateddatetime
    )
    SELECT
        tax_type, tax_community, Code_classification, code_type, Code_classification_code, code_type_code, language_id, default_flag, cml_len, cml_translate, Orderby, sub_code_type, sub_code_type_code, etlcreateddatetime
    FROM stg.stg_trd_code_classification;
    
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
ALTER PROCEDURE dwh.usp_d_trdcodeclassification(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
