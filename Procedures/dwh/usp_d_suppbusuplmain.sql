-- PROCEDURE: dwh.usp_d_suppbusuplmain(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_suppbusuplmain(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_suppbusuplmain(
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
    FROM stg.stg_supp_bu_suplmain;

    UPDATE dwh.D_suppbusuplmain t
    SET
        supp_bu_loid                   = s.supp_bu_loid,
        supp_bu_buid                   = s.supp_bu_buid,
        supp_bu_supcode                = s.supp_bu_supcode,
        supp_bu_currency               = s.supp_bu_currency,
        supp_bu_language               = s.supp_bu_language,
        supp_bu_deforderto             = s.supp_bu_deforderto,
        supp_bu_defshipfrom            = s.supp_bu_defshipfrom,
        supp_bu_defpayto               = s.supp_bu_defpayto,
        supp_bu_incoterm               = s.supp_bu_incoterm,
        supp_bu_payterm                = s.supp_bu_payterm,
        supp_bu_advpayable             = s.supp_bu_advpayable,
        supp_bu_advtolerance           = s.supp_bu_advtolerance,
        supp_bu_autoinvoice            = s.supp_bu_autoinvoice,
        supp_bu_ddchargeborneby        = s.supp_bu_ddchargeborneby,
        supp_bu_pregrinvoice           = s.supp_bu_pregrinvoice,
        supp_bu_supinvmand             = s.supp_bu_supinvmand,
        supp_bu_matlreconcby           = s.supp_bu_matlreconcby,
        supp_bu_contcdliablity         = s.supp_bu_contcdliablity,
        supp_bu_invoiceou              = s.supp_bu_invoiceou,
        supp_bu_insliability           = s.supp_bu_insliability,
        supp_bu_createdby              = s.supp_bu_createdby,
        supp_bu_createdate             = s.supp_bu_createdate,
        supp_bu_modifiedby             = s.supp_bu_modifiedby,
        supp_bu_modifieddate           = s.supp_bu_modifieddate,
        supp_bu_groption               = s.supp_bu_groption,
        supp_bu_allowinv               = s.supp_bu_allowinv,
        supp_bu_refdby                 = s.supp_bu_refdby,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_supp_bu_suplmain s
    WHERE t.supp_bu_loid = s.supp_bu_loid
    AND t.supp_bu_buid = s.supp_bu_buid
    AND t.supp_bu_supcode = s.supp_bu_supcode;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_suppbusuplmain
    (
        supp_bu_loid, supp_bu_buid, supp_bu_supcode, supp_bu_currency, supp_bu_language, supp_bu_deforderto, supp_bu_defshipfrom, supp_bu_defpayto, supp_bu_incoterm, supp_bu_payterm, supp_bu_advpayable, supp_bu_advtolerance, supp_bu_autoinvoice, supp_bu_ddchargeborneby, supp_bu_pregrinvoice, supp_bu_supinvmand, supp_bu_matlreconcby, supp_bu_contcdliablity, supp_bu_invoiceou, supp_bu_insliability, supp_bu_createdby, supp_bu_createdate, supp_bu_modifiedby, supp_bu_modifieddate, supp_bu_groption, supp_bu_allowinv, supp_bu_refdby, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.supp_bu_loid, s.supp_bu_buid, s.supp_bu_supcode, s.supp_bu_currency, s.supp_bu_language, s.supp_bu_deforderto, s.supp_bu_defshipfrom, s.supp_bu_defpayto, s.supp_bu_incoterm, s.supp_bu_payterm, s.supp_bu_advpayable, s.supp_bu_advtolerance, s.supp_bu_autoinvoice, s.supp_bu_ddchargeborneby, s.supp_bu_pregrinvoice, s.supp_bu_supinvmand, s.supp_bu_matlreconcby, s.supp_bu_contcdliablity, s.supp_bu_invoiceou, s.supp_bu_insliability, s.supp_bu_createdby, s.supp_bu_createdate, s.supp_bu_modifiedby, s.supp_bu_modifieddate, s.supp_bu_groption, s.supp_bu_allowinv, s.supp_bu_refdby, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_supp_bu_suplmain s
    LEFT JOIN dwh.D_suppbusuplmain t
    ON s.supp_bu_loid = t.supp_bu_loid
    AND s.supp_bu_buid = t.supp_bu_buid
    AND s.supp_bu_supcode = t.supp_bu_supcode
    WHERE t.supp_bu_loid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_supp_bu_suplmain
    (
        supp_bu_loid, supp_bu_buid, supp_bu_supcode, supp_bu_currency, supp_bu_language, supp_bu_deforderto, supp_bu_defshipfrom, supp_bu_defpayto, supp_bu_incoterm, supp_bu_incoplace, supp_bu_payterm, supp_bu_advpayable, supp_bu_advtolerance, supp_bu_autoinvoice, supp_bu_ddchargeborneby, supp_bu_pregrinvoice, supp_bu_supinvmand, supp_bu_matlreconcby, supp_bu_idagency, supp_bu_idno, supp_bu_contcdliablity, supp_bu_invoiceou, supp_bu_insliability, supp_bu_insuranceterm, supp_bu_inheritou, supp_bu_createdby, supp_bu_createdate, supp_bu_modifiedby, supp_bu_modifieddate, supp_bu_groption, supp_bu_allowinv, supp_bu_refdby, supp_bu_refdby_code, supp_bu_refdby_name, etlcreateddatetime
    )
    SELECT
        supp_bu_loid, supp_bu_buid, supp_bu_supcode, supp_bu_currency, supp_bu_language, supp_bu_deforderto, supp_bu_defshipfrom, supp_bu_defpayto, supp_bu_incoterm, supp_bu_incoplace, supp_bu_payterm, supp_bu_advpayable, supp_bu_advtolerance, supp_bu_autoinvoice, supp_bu_ddchargeborneby, supp_bu_pregrinvoice, supp_bu_supinvmand, supp_bu_matlreconcby, supp_bu_idagency, supp_bu_idno, supp_bu_contcdliablity, supp_bu_invoiceou, supp_bu_insliability, supp_bu_insuranceterm, supp_bu_inheritou, supp_bu_createdby, supp_bu_createdate, supp_bu_modifiedby, supp_bu_modifieddate, supp_bu_groption, supp_bu_allowinv, supp_bu_refdby, supp_bu_refdby_code, supp_bu_refdby_name, etlcreateddatetime
    FROM stg.stg_supp_bu_suplmain;
    
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
ALTER PROCEDURE dwh.usp_d_suppbusuplmain(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
