-- PROCEDURE: dwh.usp_d_trdtaxgroupdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_trdtaxgroupdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_trdtaxgroupdtl(
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
    FROM stg.stg_trd_tax_group_dtl;

    UPDATE dwh.D_trdtaxgroupdtl t
    SET
		d_trdtaxgrouphdr_key       = bb.trdtaxgrouphdr_key,
        company_code               = s.company_code,
        tax_group_code             = s.tax_group_code,
        item_code                  = s.item_code,
        variant                    = s.variant,
        effective_from_date        = s.effective_from_date,
        type                       = s.type,
        effective_to_date          = s.effective_to_date,
        created_at                 = s.created_at,
        assessable_rate            = s.assessable_rate,
        commoditycode              = s.commoditycode,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_trd_tax_group_dtl s
	
	INNER JOIN dwh.d_trdtaxgrouphdr bb
	
     ON  s.tax_group_code  = bb.tax_group_code 
     and s.company_code =bb.company_code 

    WHERE t.company_code = s.company_code
    AND t.tax_group_code = s.tax_group_code
    AND t.item_code = s.item_code
    AND t.variant = s.variant
    AND t.type = s.type
	AND  t.d_trdtaxgrouphdr_key = bb.trdtaxgrouphdr_key ;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_trdtaxgroupdtl
    (
       d_trdtaxgrouphdr_key, company_code, tax_group_code, item_code, variant, effective_from_date, type, effective_to_date, created_at, assessable_rate, commoditycode, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       bb.trdtaxgrouphdr_key, s.company_code, s.tax_group_code, s.item_code, s.variant, s.effective_from_date, s.type, s.effective_to_date, s.created_at, s.assessable_rate, s.commoditycode, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_trd_tax_group_dtl s
	
		INNER JOIN dwh.d_trdtaxgrouphdr bb
	
     ON  s.tax_group_code  = bb.tax_group_code 
     and s.company_code =bb.company_code 
    LEFT JOIN dwh.D_trdtaxgroupdtl t
    ON s.company_code = t.company_code
    AND s.tax_group_code = t.tax_group_code
    AND s.item_code = t.item_code
    AND s.variant = t.variant
    AND s.type = t.type
	AND  t.d_trdtaxgrouphdr_key = bb.trdtaxgrouphdr_key
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_trd_tax_group_dtl
    (
        company_code, tax_group_code, item_code, variant, effective_from_date, type, effective_to_date, created_at, assessable_rate, commoditycode, etlcreateddatetime
    )
    SELECT
        company_code, tax_group_code, item_code, variant, effective_from_date, type, effective_to_date, created_at, assessable_rate, commoditycode, etlcreateddatetime
    FROM stg.stg_trd_tax_group_dtl;
    
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
ALTER PROCEDURE dwh.usp_d_trdtaxgroupdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
