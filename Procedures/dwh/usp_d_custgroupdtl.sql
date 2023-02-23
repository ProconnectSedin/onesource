-- PROCEDURE: dwh.usp_d_custgroupdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_custgroupdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_custgroupdtl(
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
    FROM stg.stg_cust_group_dtl;

    UPDATE dwh.d_custgroupdtl t
    SET
        cgd_lo                        = s.cgd_lo,
        cgd_bu                        = s.cgd_bu,
        cgd_control_group_flag        = s.cgd_control_group_flag,
        cgd_group_type_code           = s.cgd_group_type_code,
        cgd_cust_group_code           = s.cgd_cust_group_code,
        cgd_line_no                   = s.cgd_line_no,
        cgd_customer_code             = s.cgd_customer_code,
        cgd_created_by                = s.cgd_created_by,
        cgd_created_date              = s.cgd_created_date,
        cgd_modified_by               = s.cgd_modified_by,
        cgd_modified_date             = s.cgd_modified_date,
        cgd_addnl1                    = s.cgd_addnl1,
        cgd_addnl2                    = s.cgd_addnl2,
        cgd_addnl3                    = s.cgd_addnl3,
        cgd_company_code              = s.cgd_company_code,
        cgd_created_ou                = s.cgd_created_ou,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_cust_group_dtl s
    WHERE t.cgd_lo = s.cgd_lo
    AND t.cgd_bu = s.cgd_bu
    AND t.cgd_control_group_flag = s.cgd_control_group_flag
    AND t.cgd_group_type_code = s.cgd_group_type_code
    AND t.cgd_cust_group_code = s.cgd_cust_group_code
    AND t.cgd_line_no = s.cgd_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_custgroupdtl
    (
        cgd_lo, cgd_bu, cgd_control_group_flag, cgd_group_type_code, cgd_cust_group_code, cgd_line_no, cgd_customer_code, cgd_created_by, cgd_created_date, cgd_modified_by, cgd_modified_date, cgd_addnl1, cgd_addnl2, cgd_addnl3, cgd_company_code, cgd_created_ou, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.cgd_lo, s.cgd_bu, s.cgd_control_group_flag, s.cgd_group_type_code, s.cgd_cust_group_code, s.cgd_line_no, s.cgd_customer_code, s.cgd_created_by, s.cgd_created_date, s.cgd_modified_by, s.cgd_modified_date, s.cgd_addnl1, s.cgd_addnl2, s.cgd_addnl3, s.cgd_company_code, s.cgd_created_ou, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cust_group_dtl s
    LEFT JOIN dwh.D_custgroupdtl t
    ON s.cgd_lo = t.cgd_lo
    AND s.cgd_bu = t.cgd_bu
    AND s.cgd_control_group_flag = t.cgd_control_group_flag
    AND s.cgd_group_type_code = t.cgd_group_type_code
    AND s.cgd_cust_group_code = t.cgd_cust_group_code
    AND s.cgd_line_no = t.cgd_line_no
    WHERE t.cgd_lo IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cust_group_dtl
    (
        cgd_lo, cgd_bu, cgd_control_group_flag, cgd_group_type_code, cgd_cust_group_code, cgd_line_no, cgd_customer_code, cgd_created_by, cgd_created_date, cgd_modified_by, cgd_modified_date, cgd_addnl1, cgd_addnl2, cgd_addnl3, cgd_company_code, cgd_created_ou, etlcreateddatetime
    )
    SELECT
        cgd_lo, cgd_bu, cgd_control_group_flag, cgd_group_type_code, cgd_cust_group_code, cgd_line_no, cgd_customer_code, cgd_created_by, cgd_created_date, cgd_modified_by, cgd_modified_date, cgd_addnl1, cgd_addnl2, cgd_addnl3, cgd_company_code, cgd_created_ou, etlcreateddatetime
    FROM stg.stg_cust_group_dtl;
    
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
ALTER PROCEDURE dwh.usp_d_custgroupdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
