-- PROCEDURE: dwh.usp_f_suppthresholdtrans(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_suppthresholdtrans(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_suppthresholdtrans(
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
    FROM stg.stg_supp_threshold_trans;

    UPDATE dwh.F_suppthresholdtrans t
    SET 
		supp_key			 = COALESCE(v.vendor_key,-1),
		date_key			 = COALESCE(d.datekey,-1),
        tran_no              = s.tran_no,
        tran_ou              = s.tran_ou,
        tran_type            = s.tran_type,
        tran_amount          = s.tran_amount,
        tran_status          = s.tran_status,
        supplier_code        = s.supplier_code,
        tax_type             = s.tax_type,
        tax_community        = s.tax_community,
        tax_region           = s.tax_region,
        tax_category         = s.tax_category,
        tax_class            = s.tax_class,
        tran_date            = s.tran_date,
        tax_code             = s.tax_code,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_supp_threshold_trans s
	LEFT JOIN dwh.d_date d     
    	ON s.tran_date::date     = d.dateactual
	LEFT JOIN dwh.d_vendor V                
       ON s.supplier_code  = V.vendor_id 
        AND s.tran_ou        = V.vendor_ou
    WHERE t.tran_no = s.tran_no
    AND t.tran_ou = s.tran_ou
    AND t.tran_type = s.tran_type
    AND t.tax_type = s.tax_type
    AND t.tax_community = s.tax_community
    AND t.tax_region = s.tax_region
    AND t.tax_category = s.tax_category
    AND t.tax_class = s.tax_class;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_suppthresholdtrans
    (
       supp_key,date_key,tran_no, tran_ou, tran_type, tran_amount, tran_status, supplier_code, tax_type, tax_community, tax_region, tax_category, tax_class, tran_date, tax_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
 		 COALESCE(v.vendor_key,-1),COALESCE(d.datekey,-1),  s.tran_no, s.tran_ou, s.tran_type, s.tran_amount, s.tran_status, s.supplier_code, s.tax_type, s.tax_community, s.tax_region, s.tax_category, s.tax_class, s.tran_date, s.tax_code, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_supp_threshold_trans s
	LEFT JOIN dwh.d_date d     
    	ON s.tran_date::date     = d.dateactual
	LEFT JOIN dwh.d_vendor V                
       ON s.supplier_code  = V.vendor_id 
        AND s.tran_ou        = V.vendor_ou
    LEFT JOIN dwh.F_suppthresholdtrans t
    ON s.tran_no = t.tran_no
    AND s.tran_ou = t.tran_ou
    AND s.tran_type = t.tran_type
    AND s.tax_type = t.tax_type
    AND s.tax_community = t.tax_community
    AND s.tax_region = t.tax_region
    AND s.tax_category = t.tax_category
    AND s.tax_class = t.tax_class
    WHERE t.tran_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_supp_threshold_trans
    (
        tran_no, tran_ou, tran_type, tran_amount, tran_status, supplier_code, tax_type, tax_community, tax_region, tax_category, tax_class, tran_date, tax_code, etlcreateddatetime
    )
    SELECT
        tran_no, tran_ou, tran_type, tran_amount, tran_status, supplier_code, tax_type, tax_community, tax_region, tax_category, tax_class, tran_date, tax_code, etlcreateddatetime
    FROM stg.stg_supp_threshold_trans;
    
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
ALTER PROCEDURE dwh.usp_f_suppthresholdtrans(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
