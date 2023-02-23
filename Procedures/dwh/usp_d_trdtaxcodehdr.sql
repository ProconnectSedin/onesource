-- PROCEDURE: dwh.usp_d_trdtaxcodehdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_trdtaxcodehdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_trdtaxcodehdr(
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
    FROM stg.stg_trd_tax_code_hdr;

    UPDATE dwh.D_trdtaxcodehdr t
    SET
        company_code               = s.company_code,
        tax_code                   = s.tax_code,
        tax_code_desc              = s.tax_code_desc,
        tax_type                   = s.tax_type,
        tax_community              = s.tax_community,
        tax_region                 = s.tax_region,
        code_type                  = s.code_type,
        tax_basis                  = s.tax_basis,
        tax_uom                    = s.tax_uom,
        status                     = s.status,
        created_at                 = s.created_at,
        created_by                 = s.created_by,
        created_date               = s.created_date,
        modified_by                = s.modified_by,
        modified_date              = s.modified_date,
        timestamp                  = s.timestamp,
        code_classification        = s.code_classification,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_trd_tax_code_hdr s
    WHERE t.company_code = s.company_code
    AND t.tax_code = s.tax_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_trdtaxcodehdr
    (
        company_code, tax_code, tax_code_desc, tax_type, tax_community, tax_region, code_type, tax_basis, tax_uom, status, created_at, created_by, created_date, modified_by, modified_date, timestamp, code_classification, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.company_code, s.tax_code, s.tax_code_desc, s.tax_type, s.tax_community, s.tax_region, s.code_type, s.tax_basis, s.tax_uom, s.status, s.created_at, s.created_by, s.created_date, s.modified_by, s.modified_date, s.timestamp, s.code_classification, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_trd_tax_code_hdr s
    LEFT JOIN dwh.D_trdtaxcodehdr t
    ON s.company_code = t.company_code
    AND s.tax_code = t.tax_code
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_trd_tax_code_hdr
    (
        company_code, tax_code, tax_code_desc, tax_type, tax_community, tax_region, code_type, tax_basis, tax_uom, status, created_at, created_by, created_date, modified_by, modified_date, timestamp, code_classification, sub_code_type, etlcreateddatetime
    )
    SELECT
        company_code, tax_code, tax_code_desc, tax_type, tax_community, tax_region, code_type, tax_basis, tax_uom, status, created_at, created_by, created_date, modified_by, modified_date, timestamp, code_classification, sub_code_type, etlcreateddatetime
    FROM stg.stg_trd_tax_code_hdr;
    
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
ALTER PROCEDURE dwh.usp_d_trdtaxcodehdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
