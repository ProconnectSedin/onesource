-- PROCEDURE: dwh.usp_f_custtdsinfo(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_custtdsinfo(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_custtdsinfo(
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
    FROM stg.stg_cust_tds_info;

    UPDATE dwh.F_custtdsinfo t
    SET
-- 		cust_code_key			  = COALESCE(cu.customer_key, -1),	--no "ou" in this table F_custtdsinfo
		comp_code_key			  = COALESCE(cp.company_key, -1),
        ctds_lo                   = s.ctds_lo,
        ctds_comp_code            = s.ctds_comp_code,
        ctds_cust_code            = s.ctds_cust_code,
        ctds_tax_type             = s.ctds_tax_type,
        ctds_tax_community        = s.ctds_tax_community,
        ctds_tax_option           = s.ctds_tax_option,
        ctds_serial_no            = s.ctds_serial_no,
        ctds_assessee_type        = s.ctds_assessee_type,
        ctds_region_type          = s.ctds_region_type,
        ctds_region_code          = s.ctds_region_code,
        ctds_regd_no              = s.ctds_regd_no,
        ctds_category_code        = s.ctds_category_code,
        ctds_class_code           = s.ctds_class_code,
        ctds_default              = s.ctds_default,
        ctds_taxrate_appl         = s.ctds_taxrate_appl,
        ctds_special_rate         = s.ctds_special_rate,
        ctds_dateof_issue         = s.ctds_dateof_issue,
        ctds_valid_upto           = s.ctds_valid_upto,
        ctds_remarks              = s.ctds_remarks,
        ctds_created_by           = s.ctds_created_by,
        ctds_created_date         = s.ctds_created_date,
        ctds_modified_by          = s.ctds_modified_by,
        ctds_modified_date        = s.ctds_modified_date,
        Pan_No                    = s.Pan_No,
        Aadhaar_No                = s.Aadhaar_No,
        tax_status                = s.tax_status,
        return_frequency          = s.return_frequency,
        tax_regno_status          = s.tax_regno_status,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_cust_tds_info s
-- 	LEFT JOIN dwh.d_customer cu
-- 	ON s.ctds_cust_code	= cu.customer_id
-- 	AND s.
	LEFT JOIN dwh.d_company cp
	ON s.ctds_comp_code = cp.company_code
	AND s.ctds_serial_no = cp.serial_no
    WHERE t.ctds_lo = s.ctds_lo
    AND t.ctds_comp_code = s.ctds_comp_code
    AND t.ctds_cust_code = s.ctds_cust_code
    AND t.ctds_tax_type = s.ctds_tax_type
    AND t.ctds_tax_community = s.ctds_tax_community
    AND t.ctds_serial_no = s.ctds_serial_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_custtdsinfo
    (
		comp_code_key, ctds_lo, ctds_comp_code, ctds_cust_code, ctds_tax_type, ctds_tax_community, ctds_tax_option, ctds_serial_no, ctds_assessee_type, ctds_region_type, ctds_region_code, ctds_regd_no, ctds_category_code, ctds_class_code, ctds_default, ctds_taxrate_appl, ctds_special_rate, ctds_dateof_issue, ctds_valid_upto, ctds_remarks, ctds_created_by, ctds_created_date, ctds_modified_by, ctds_modified_date, Pan_No, Aadhaar_No, tax_status, return_frequency, tax_regno_status, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(cp.company_key, -1), s.ctds_lo, s.ctds_comp_code, s.ctds_cust_code, s.ctds_tax_type, s.ctds_tax_community, s.ctds_tax_option, s.ctds_serial_no, s.ctds_assessee_type, s.ctds_region_type, s.ctds_region_code, s.ctds_regd_no, s.ctds_category_code, s.ctds_class_code, s.ctds_default, s.ctds_taxrate_appl, s.ctds_special_rate, s.ctds_dateof_issue, s.ctds_valid_upto, s.ctds_remarks, s.ctds_created_by, s.ctds_created_date, s.ctds_modified_by, s.ctds_modified_date, s.Pan_No, s.Aadhaar_No, s.tax_status, s.return_frequency, s.tax_regno_status, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cust_tds_info s
-- 	LEFT JOIN dwh.d_customer cu
-- 	ON s.ctds_cust_code	= cu.customer_id
-- 	AND s.
	LEFT JOIN dwh.d_company cp
	ON s.ctds_comp_code = cp.company_code
	AND s.ctds_serial_no = cp.serial_no
    LEFT JOIN dwh.F_custtdsinfo t
    ON s.ctds_lo = t.ctds_lo
    AND s.ctds_comp_code = t.ctds_comp_code
    AND s.ctds_cust_code = t.ctds_cust_code
    AND s.ctds_tax_type = t.ctds_tax_type
    AND s.ctds_tax_community = t.ctds_tax_community
    AND s.ctds_serial_no = t.ctds_serial_no
    WHERE t.ctds_lo IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cust_tds_info
    (
        ctds_lo, ctds_comp_code, ctds_cust_code, ctds_tax_type, ctds_tax_community, ctds_tax_option, ctds_serial_no, ctds_assessee_type, ctds_region_type, ctds_region_code, ctds_regd_no, ctds_category_code, ctds_class_code, ctds_default, ctds_taxrate_appl, ctds_tax_code, ctds_special_rate, ctds_cert_no, ctds_placeof_issue, ctds_dateof_issue, ctds_valid_upto, ctds_remarks, ctds_created_by, ctds_created_date, ctds_modified_by, ctds_modified_date, ctds_addnl1, ctds_addnl2, ctds_addnl3, ctds_address_id, Pan_No, Aadhaar_No, tax_status, return_frequency, tax_regno_status, etlcreateddatetime
    )
    SELECT
        ctds_lo, ctds_comp_code, ctds_cust_code, ctds_tax_type, ctds_tax_community, ctds_tax_option, ctds_serial_no, ctds_assessee_type, ctds_region_type, ctds_region_code, ctds_regd_no, ctds_category_code, ctds_class_code, ctds_default, ctds_taxrate_appl, ctds_tax_code, ctds_special_rate, ctds_cert_no, ctds_placeof_issue, ctds_dateof_issue, ctds_valid_upto, ctds_remarks, ctds_created_by, ctds_created_date, ctds_modified_by, ctds_modified_date, ctds_addnl1, ctds_addnl2, ctds_addnl3, ctds_address_id, Pan_No, Aadhaar_No, tax_status, return_frequency, tax_regno_status, etlcreateddatetime
    FROM stg.stg_cust_tds_info;
    
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
ALTER PROCEDURE dwh.usp_f_custtdsinfo(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
