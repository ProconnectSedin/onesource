-- PROCEDURE: dwh.usp_d_suppspmnsuplmain(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_suppspmnsuplmain(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_suppspmnsuplmain(
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
    FROM stg.stg_supp_spmn_suplmain;

    UPDATE dwh.D_suppspmnsuplmain t
    SET
        supp_spmn_loid                   = s.supp_spmn_loid,
        supp_spmn_supcode                = s.supp_spmn_supcode,
        supp_spmn_supname                = s.supp_spmn_supname,
        supp_spmn_supname_shd            = s.supp_spmn_supname_shd,
        supp_spmn_suptype                = s.supp_spmn_suptype,
        supp_spmn_suplevel               = s.supp_spmn_suplevel,
        supp_spmn_classification         = s.supp_spmn_classification,
        supp_spmn_companycode            = s.supp_spmn_companycode,
        supp_spmn_customercode           = s.supp_spmn_customercode,
        supp_spmn_createdou              = s.supp_spmn_createdou,
        supp_spmn_taxexempt              = s.supp_spmn_taxexempt,
        supp_spmn_createdby              = s.supp_spmn_createdby,
        supp_spmn_createdate             = s.supp_spmn_createdate,
        supp_spmn_modifiedby             = s.supp_spmn_modifiedby,
        supp_spmn_modifieddate           = s.supp_spmn_modifieddate,
        supp_spmn_timestamp              = s.supp_spmn_timestamp,
        supp_spmn_cagent                 = s.supp_spmn_cagent,
        supp_spmn_carr                   = s.supp_spmn_carr,
        supp_spmn_contst                 = s.supp_spmn_contst,
        supp_spmn_1099app                = s.supp_spmn_1099app,
        supp_spmn_nuseries               = s.supp_spmn_nuseries,
        Supp_spmn_appointedfrom          = s.Supp_spmn_appointedfrom,
        Supp_spmn_Approvaldate           = s.Supp_spmn_Approvaldate,
        Supp_spmn_Approved_status        = s.Supp_spmn_Approved_status,
        Supp_spmn_purpose                = s.Supp_spmn_purpose,
        supp_spmn_broker_type            = s.supp_spmn_broker_type,
        supp_spmn_class                  = s.supp_spmn_class,
        supp_spmn_supcategory            = s.supp_spmn_supcategory,
        supp_spmn_suppdesc               = s.supp_spmn_suppdesc,
        supp_revision_no                 = s.supp_revision_no,
        supp_msme_flag                   = s.supp_msme_flag,
        supp_msme_regno                  = s.supp_msme_regno,
        supp_msme_type                   = s.supp_msme_type,
        supp_msme_regtype                = s.supp_msme_regtype,
        supp_msme_datefrom               = s.supp_msme_datefrom,
        etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
    FROM stg.stg_supp_spmn_suplmain s
    WHERE t.supp_spmn_loid = s.supp_spmn_loid
    AND t.supp_spmn_supcode = s.supp_spmn_supcode;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_suppspmnsuplmain
    (
        supp_spmn_loid, supp_spmn_supcode, supp_spmn_supname, supp_spmn_supname_shd, supp_spmn_suptype, supp_spmn_suplevel, supp_spmn_classification, supp_spmn_companycode, supp_spmn_customercode, supp_spmn_createdou, supp_spmn_taxexempt, supp_spmn_createdby, supp_spmn_createdate, supp_spmn_modifiedby, supp_spmn_modifieddate, supp_spmn_timestamp, supp_spmn_cagent, supp_spmn_carr, supp_spmn_contst, supp_spmn_1099app, supp_spmn_nuseries, Supp_spmn_appointedfrom, Supp_spmn_Approvaldate, Supp_spmn_Approved_status, Supp_spmn_purpose, supp_spmn_broker_type, supp_spmn_class, supp_spmn_supcategory, supp_spmn_suppdesc, supp_revision_no, supp_msme_flag, supp_msme_regno, supp_msme_type, supp_msme_regtype, supp_msme_datefrom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.supp_spmn_loid, s.supp_spmn_supcode, s.supp_spmn_supname, s.supp_spmn_supname_shd, s.supp_spmn_suptype, s.supp_spmn_suplevel, s.supp_spmn_classification, s.supp_spmn_companycode, s.supp_spmn_customercode, s.supp_spmn_createdou, s.supp_spmn_taxexempt, s.supp_spmn_createdby, s.supp_spmn_createdate, s.supp_spmn_modifiedby, s.supp_spmn_modifieddate, s.supp_spmn_timestamp, s.supp_spmn_cagent, s.supp_spmn_carr, s.supp_spmn_contst, s.supp_spmn_1099app, s.supp_spmn_nuseries, s.Supp_spmn_appointedfrom, s.Supp_spmn_Approvaldate, s.Supp_spmn_Approved_status, s.Supp_spmn_purpose, s.supp_spmn_broker_type, s.supp_spmn_class, s.supp_spmn_supcategory, s.supp_spmn_suppdesc, s.supp_revision_no, s.supp_msme_flag, s.supp_msme_regno, s.supp_msme_type, s.supp_msme_regtype, s.supp_msme_datefrom, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_supp_spmn_suplmain s
    LEFT JOIN dwh.D_suppspmnsuplmain t
    ON s.supp_spmn_loid = t.supp_spmn_loid
    AND s.supp_spmn_supcode = t.supp_spmn_supcode
    WHERE t.supp_spmn_loid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_supp_spmn_suplmain
    (
        supp_spmn_loid, supp_spmn_supcode, supp_spmn_supname, supp_spmn_supname_shd, supp_spmn_suptype, supp_spmn_suplevel, supp_spmn_classification, supp_spmn_companycode, supp_spmn_bucode, supp_spmn_parentsupcode, supp_spmn_customercode, supp_spmn_createdou, supp_spmn_taxexempt, supp_spmn_certificateno, supp_spmn_createdby, supp_spmn_createdate, supp_spmn_modifiedby, supp_spmn_modifieddate, supp_spmn_timestamp, supp_spmn_qs_cer, supp_spmn_sei_cer, supp_spmn_iso_cer, supp_spmn_iecode, supp_spmn_rbicode, supp_spmn_impreg, supp_spmn_expreg, supp_spmn_cagent, supp_spmn_carr, supp_spmn_contst, supp_spmn_1099app, supp_spmn_ssn, supp_spmn_fein, supp_spmn_nuseries, Supp_spmn_appointedfrom, Supp_spmn_appointedto, Supp_spmn_Approvaldate, Supp_spmn_Approved_status, Supp_spmn_purpose, supp_licenseno, supp_spmn_broker_type, supp_spmn_class, supp_spmn_supcategory, supp_spmn_typ1099, supp_spmn_suppdesc, supp_revision_no, supp_msme_flag, supp_msme_regno, supp_msme_type, supp_msme_regtype, supp_msme_datefrom, supp_msme_dateto, etlcreateddatetime
    )
    SELECT
        supp_spmn_loid, supp_spmn_supcode, supp_spmn_supname, supp_spmn_supname_shd, supp_spmn_suptype, supp_spmn_suplevel, supp_spmn_classification, supp_spmn_companycode, supp_spmn_bucode, supp_spmn_parentsupcode, supp_spmn_customercode, supp_spmn_createdou, supp_spmn_taxexempt, supp_spmn_certificateno, supp_spmn_createdby, supp_spmn_createdate, supp_spmn_modifiedby, supp_spmn_modifieddate, supp_spmn_timestamp, supp_spmn_qs_cer, supp_spmn_sei_cer, supp_spmn_iso_cer, supp_spmn_iecode, supp_spmn_rbicode, supp_spmn_impreg, supp_spmn_expreg, supp_spmn_cagent, supp_spmn_carr, supp_spmn_contst, supp_spmn_1099app, supp_spmn_ssn, supp_spmn_fein, supp_spmn_nuseries, Supp_spmn_appointedfrom, Supp_spmn_appointedto, Supp_spmn_Approvaldate, Supp_spmn_Approved_status, Supp_spmn_purpose, supp_licenseno, supp_spmn_broker_type, supp_spmn_class, supp_spmn_supcategory, supp_spmn_typ1099, supp_spmn_suppdesc, supp_revision_no, supp_msme_flag, supp_msme_regno, supp_msme_type, supp_msme_regtype, supp_msme_datefrom, supp_msme_dateto, etlcreateddatetime
    FROM stg.stg_supp_spmn_suplmain;
    
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
ALTER PROCEDURE dwh.usp_d_suppspmnsuplmain(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
