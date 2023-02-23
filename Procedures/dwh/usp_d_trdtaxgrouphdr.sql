-- PROCEDURE: dwh.usp_d_trdtaxgrouphdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_trdtaxgrouphdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_trdtaxgrouphdr(
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
    FROM stg.stg_trd_tax_group_hdr;

    UPDATE dwh.D_trdtaxgrouphdr t
    SET
        company_code          = s.company_code,
        tax_group_code        = s.tax_group_code,
        tax_group_desc        = s.tax_group_desc,
        tax_type              = s.tax_type,
        protest_flag          = s.protest_flag,
        created_at            = s.created_at,
        created_by            = s.created_by,
        created_date          = s.created_date,
        modified_by           = s.modified_by,
        modified_date         = s.modified_date,
        timestamp             = s.timestamp,
        tax_community         = s.tax_community,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_trd_tax_group_hdr s
    WHERE t.company_code = s.company_code
    AND t.tax_group_code = s.tax_group_code;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_trdtaxgrouphdr
    (
        company_code, tax_group_code, tax_group_desc, tax_type, protest_flag, created_at, created_by, created_date, modified_by, modified_date, timestamp, tax_community, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.company_code, s.tax_group_code, s.tax_group_desc, s.tax_type, s.protest_flag, s.created_at, s.created_by, s.created_date, s.modified_by, s.modified_date, s.timestamp, s.tax_community, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_trd_tax_group_hdr s
    LEFT JOIN dwh.D_trdtaxgrouphdr t
    ON s.company_code = t.company_code
    AND s.tax_group_code = t.tax_group_code
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_trd_tax_group_hdr
    (
        company_code, tax_group_code, tax_group_desc, tax_type, tax_region, protest_flag, tax_uom, created_at, created_by, created_date, modified_by, modified_date, timestamp, tax_community, etlcreateddatetime
    )
    SELECT
        company_code, tax_group_code, tax_group_desc, tax_type, tax_region, protest_flag, tax_uom, created_at, created_by, created_date, modified_by, modified_date, timestamp, tax_community, etlcreateddatetime
    FROM stg.stg_trd_tax_group_hdr;
    
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
ALTER PROCEDURE dwh.usp_d_trdtaxgrouphdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
