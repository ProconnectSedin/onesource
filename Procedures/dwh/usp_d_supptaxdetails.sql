-- PROCEDURE: dwh.usp_d_supptaxdetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_supptaxdetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_supptaxdetails(
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
    FROM stg.stg_supp_tax_details;

    UPDATE dwh.D_supptaxdetails t
    SET
        supp_tax_loid                = s.supp_tax_loid,
        supp_tax_companycode         = s.supp_tax_companycode,
        supp_tax_supcode             = s.supp_tax_supcode,
        supp_tax_type                = s.supp_tax_type,
        supp_tax_community           = s.supp_tax_community,
        supp_tax_serialno            = s.supp_tax_serialno,
        supp_tax_option              = s.supp_tax_option,
        supp_tax_assesseetype        = s.supp_tax_assesseetype,
        supp_tax_regiontype          = s.supp_tax_regiontype,
        supp_tax_region              = s.supp_tax_region,
        supp_tax_regdno              = s.supp_tax_regdno,
        supp_tax_category            = s.supp_tax_category,
        supp_tax_class               = s.supp_tax_class,
        supp_tax_taxrateappl         = s.supp_tax_taxrateappl,
        supp_tax_code                = s.supp_tax_code,
        supp_tax_splrate             = s.supp_tax_splrate,
        supp_tax_certno              = s.supp_tax_certno,
        supp_tax_placeissue          = s.supp_tax_placeissue,
        supp_tax_dateissue           = s.supp_tax_dateissue,
        supp_tax_validupto           = s.supp_tax_validupto,
        supp_tax_remarks             = s.supp_tax_remarks,
        supp_tax_default             = s.supp_tax_default,
        supp_tax_createdby           = s.supp_tax_createdby,
        supp_tax_createddate         = s.supp_tax_createddate,
        supp_tax_modifiedby          = s.supp_tax_modifiedby,
        supp_tax_modifieddate        = s.supp_tax_modifieddate,
        supp_tax_value               = s.supp_tax_value,
        Supp_Cumm_Val                = s.Supp_Cumm_Val,
        PAN_NO                       = s.PAN_NO,
        return_frequency             = s.return_frequency,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_supp_tax_details s
    WHERE t.supp_tax_loid = s.supp_tax_loid
    AND t.supp_tax_companycode = s.supp_tax_companycode
    AND t.supp_tax_supcode = s.supp_tax_supcode
    AND t.supp_tax_type = s.supp_tax_type
    AND t.supp_tax_community = s.supp_tax_community
    AND t.supp_tax_serialno = s.supp_tax_serialno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_supptaxdetails
    (
        supp_tax_loid, supp_tax_companycode, supp_tax_supcode, supp_tax_type, supp_tax_community, supp_tax_serialno, supp_tax_option, supp_tax_assesseetype, supp_tax_regiontype, supp_tax_region, supp_tax_regdno, supp_tax_category, supp_tax_class, supp_tax_taxrateappl, supp_tax_code, supp_tax_splrate, supp_tax_certno, supp_tax_placeissue, supp_tax_dateissue, supp_tax_validupto, supp_tax_remarks, supp_tax_default, supp_tax_createdby, supp_tax_createddate, supp_tax_modifiedby, supp_tax_modifieddate, supp_tax_value, Supp_Cumm_Val, PAN_NO, return_frequency, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.supp_tax_loid, s.supp_tax_companycode, s.supp_tax_supcode, s.supp_tax_type, s.supp_tax_community, s.supp_tax_serialno, s.supp_tax_option, s.supp_tax_assesseetype, s.supp_tax_regiontype, s.supp_tax_region, s.supp_tax_regdno, s.supp_tax_category, s.supp_tax_class, s.supp_tax_taxrateappl, s.supp_tax_code, s.supp_tax_splrate, s.supp_tax_certno, s.supp_tax_placeissue, s.supp_tax_dateissue, s.supp_tax_validupto, s.supp_tax_remarks, s.supp_tax_default, s.supp_tax_createdby, s.supp_tax_createddate, s.supp_tax_modifiedby, s.supp_tax_modifieddate, s.supp_tax_value, s.Supp_Cumm_Val, s.PAN_NO, s.return_frequency, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_supp_tax_details s
    LEFT JOIN dwh.D_supptaxdetails t
    ON s.supp_tax_loid = t.supp_tax_loid
    AND s.supp_tax_companycode = t.supp_tax_companycode
    AND s.supp_tax_supcode = t.supp_tax_supcode
    AND s.supp_tax_type = t.supp_tax_type
    AND s.supp_tax_community = t.supp_tax_community
    AND s.supp_tax_serialno = t.supp_tax_serialno
    WHERE t.supp_tax_loid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_supp_tax_details
    (
        supp_tax_loid, supp_tax_companycode, supp_tax_supcode, supp_tax_type, supp_tax_community, supp_tax_serialno, supp_tax_option, supp_tax_assesseetype, supp_tax_regiontype, supp_tax_region, supp_tax_regdno, supp_tax_category, supp_tax_class, supp_tax_taxrateappl, supp_tax_code, supp_tax_splrate, supp_tax_certno, supp_tax_placeissue, supp_tax_dateissue, supp_tax_validupto, supp_tax_remarks, supp_tax_default, supp_tax_createdby, supp_tax_createddate, supp_tax_modifiedby, supp_tax_modifieddate, supp_tax_value, supp_tax_gstverdate, Supp_Cumm_Val, PAN_NO, Aadhaar_No, tax_status, return_frequency, tax_regno_status, etlcreateddatetime
    )
    SELECT
        supp_tax_loid, supp_tax_companycode, supp_tax_supcode, supp_tax_type, supp_tax_community, supp_tax_serialno, supp_tax_option, supp_tax_assesseetype, supp_tax_regiontype, supp_tax_region, supp_tax_regdno, supp_tax_category, supp_tax_class, supp_tax_taxrateappl, supp_tax_code, supp_tax_splrate, supp_tax_certno, supp_tax_placeissue, supp_tax_dateissue, supp_tax_validupto, supp_tax_remarks, supp_tax_default, supp_tax_createdby, supp_tax_createddate, supp_tax_modifiedby, supp_tax_modifieddate, supp_tax_value, supp_tax_gstverdate, Supp_Cumm_Val, PAN_NO, Aadhaar_No, tax_status, return_frequency, tax_regno_status, etlcreateddatetime
    FROM stg.stg_supp_tax_details;
    
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
ALTER PROCEDURE dwh.usp_d_supptaxdetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
