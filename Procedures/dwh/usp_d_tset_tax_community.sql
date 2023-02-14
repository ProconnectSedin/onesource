-- PROCEDURE: dwh.usp_d_tset_tax_community(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_tset_tax_community(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_tset_tax_community(
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
    FROM stg.stg_tset_tax_community;

    UPDATE dwh.d_tsettaxcommunity t
    SET
        TAX_TYPE                       = s.TAX_TYPE,
        TAX_COMMUNITY                  = s.TAX_COMMUNITY,
        PREDEFINED_TYPE                = s.PREDEFINED_TYPE,
        MULTIPLE_TAX_CODES             = s.MULTIPLE_TAX_CODES,
        SURCHARGE                      = s.SURCHARGE,
        TAX_RATES                      = s.TAX_RATES,
        MULTIPLE_FIN_YEARS             = s.MULTIPLE_FIN_YEARS,
        TAX_RATE_ASSESSEE_TYPE         = s.TAX_RATE_ASSESSEE_TYPE,
        TAXCALC_APPLICABLE_AT          = s.TAXCALC_APPLICABLE_AT,
        TAX_GROUPS                     = s.TAX_GROUPS,
        TAX_CERTIF_APPLICABLE          = s.TAX_CERTIF_APPLICABLE,
        TAX_SETTL_PROCESS              = s.TAX_SETTL_PROCESS,
        TAX_ADJUST_APPLICABLE          = s.TAX_ADJUST_APPLICABLE,
        TAX_REDUCE_AMT                 = s.TAX_REDUCE_AMT,
        TAX_MUL_REG                    = s.TAX_MUL_REG,
        TAX_WH_REG_MAP                 = s.TAX_WH_REG_MAP,
        TAXBASIS_PERCENTAGE            = s.TAXBASIS_PERCENTAGE,
        TAXBASIS_UNIT_RATE             = s.TAXBASIS_UNIT_RATE,
        TAXBASIS_FLAT                  = s.TAXBASIS_FLAT,
        CREATED_AT                     = s.CREATED_AT,
        CREATED_BY                     = s.CREATED_BY,
        CREATED_DATE                   = s.CREATED_DATE,
        MODIFIED_BY                    = s.MODIFIED_BY,
        TAX_CAP_PURCHASE               = s.TAX_CAP_PURCHASE,
        taxableamt_edit                = s.taxableamt_edit,
        quantity_edit                  = s.quantity_edit,
        origin_stamp                   = s.origin_stamp,
        inward_app                     = s.inward_app,
        outward_app                    = s.outward_app,
        centr_declared                 = s.centr_declared,
        taxcls_usage                   = s.taxcls_usage,
        centdecholevel                 = s.centdecholevel,
        tax_credliab                   = s.tax_credliab,
        autogentaxinv                  = s.autogentaxinv,
        clsdoctype                     = s.clsdoctype,
        txdocno_sal                    = s.txdocno_sal,
        tax_adj_app_re                 = s.tax_adj_app_re,
        implement_date                 = s.implement_date,
        AvailInpCronRecon              = s.AvailInpCronRecon,
        FuelTaxCreditAppl              = s.FuelTaxCreditAppl,
        tax_settl_process_cdtyp        = s.tax_settl_process_cdtyp,
        location_reg_map               = s.location_reg_map,
        EWB_App                        = s.EWB_App,
        abatement_app                  = s.abatement_app,
        sametxrgfrdeptxtp              = s.sametxrgfrdeptxtp,
        autogentaxadjvch               = s.autogentaxadjvch,
        ret1_applicability_date        = s.ret1_applicability_date,
        ISD_APP                        = s.ISD_APP,
        DTA_app                        = s.DTA_app,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_TSET_TAX_COMMUNITY s
    WHERE t.TAX_TYPE = s.TAX_TYPE
    AND t.TAX_COMMUNITY = s.TAX_COMMUNITY;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

-- 	TRUNCATE TABLE dwh.d_tsettaxcommunity
-- 	RESTART IDENTITY;
	
    INSERT INTO dwh.d_tsettaxcommunity
    (
        tax_type                , tax_community         , predefined_type			, multiple_tax_codes, 
        surcharge               , tax_rates             , multiple_fin_years		, tax_rate_assessee_type, 
        taxcalc_applicable_at   , tax_groups            , tax_certif_applicable		, tax_settl_process, 
        tax_adjust_applicable   , tax_reduce_amt        , tax_mul_reg				, tax_wh_reg_map,
        taxbasis_percentage     , taxbasis_unit_rate    , taxbasis_flat				, created_at, 
        created_by              , created_date          , modified_by				, tax_cap_purchase, 
        taxableamt_edit         , quantity_edit         , origin_stamp				, inward_app, 
        outward_app             , centr_declared        , taxcls_usage				, centdecholevel, 
        tax_credliab            , autogentaxinv         , clsdoctype				, txdocno_sal, 
        tax_adj_app_re          , implement_date        , availinpcronrecon			, fueltaxcreditappl, 
        tax_settl_process_cdtyp , location_reg_map      , ewb_app					, abatement_app, 
        sametxrgfrdeptxtp       , autogentaxadjvch      , ret1_applicability_date	, isd_app, 
        dta_app					, 
        etlactiveind			, etljobname			, envsourcecd				, datasourcecd, 
        etlcreatedatetime
    )

    SELECT
        s.tax_type					, s.tax_community		, s.predefined_type			, s.multiple_tax_codes,
        s.surcharge					, s.tax_rates			, s.multiple_fin_years		, s.tax_rate_assessee_type,
        s.taxcalc_applicable_at		, s.tax_groups			, s.tax_certif_applicable	, s.tax_settl_process, 
        s.tax_adjust_applicable		, s.tax_reduce_amt		, s.tax_mul_reg				, s.tax_wh_reg_map, 
        s.taxbasis_percentage		, s.taxbasis_unit_rate	, s.taxbasis_flat			, s.created_at, 
        s.created_by				, s.created_date		, s.modified_by				, s.tax_cap_purchase,
        s.taxableamt_edit			, s.quantity_edit		, s.origin_stamp			, s.inward_app,
        s.outward_app				, s.centr_declared		, s.taxcls_usage			, s.centdecholevel,
        s.tax_credliab				, s.autogentaxinv		, s.clsdoctype				, s.txdocno_sal,
        s.tax_adj_app_re			, s.implement_date		, s.availinpcronrecon		, s.fueltaxcreditappl,
        s.tax_settl_process_cdtyp	, s.location_reg_map	, s.ewb_app					, s.abatement_app,
        s.sametxrgfrdeptxtp			, s.autogentaxadjvch	, s.ret1_applicability_date	, s.isd_app,
        s.dta_app					,
        			1				, p_etljobname			, p_envsourcecd				, p_datasourcecd,
        			now()
    FROM stg.stg_tset_tax_community s
    LEFT JOIN dwh.d_tsettaxcommunity t
    ON s.TAX_TYPE = t.TAX_TYPE
    AND s.TAX_COMMUNITY = t.TAX_COMMUNITY
    WHERE t.TAX_TYPE IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tset_tax_community
    (
        tax_type, tax_community, predefined_type, multiple_tax_codes, surcharge, tax_rates,
		multiple_fin_years, tax_rate_assessee_type, taxcalc_applicable_at, tax_groups, tax_certif_applicable,
		tax_settl_process, tax_adjust_applicable, tax_reduce_amt, tax_mul_reg, tax_wh_reg_map, taxbasis_percentage,
		taxbasis_unit_rate, taxbasis_flat, created_at, created_by, addnl_param1, created_date,
		addnl_param2, modified_by, modified_date, timestamp, tax_cap_purchase, taxableamt_edit, 
		quantity_edit, origin_stamp, inward_app, outward_app, centr_declared, taxcls_usage,
		centdecholevel, tax_credliab, autogentaxinv, clsdoctype, txdocno_sal, tax_adj_app_re,
		implement_date, availinpcronrecon, fueltaxcreditappl, tax_settl_process_cdtyp, location_reg_map, ewb_app,
		abatement_app, sametxrgfrdeptxtp, autogentaxadjvch, ret1_applicability_date, isd_app, dta_app,
		etlcreatedatetime
    )
    SELECT
        tax_type, tax_community, predefined_type, multiple_tax_codes, surcharge, tax_rates,
		multiple_fin_years, tax_rate_assessee_type, taxcalc_applicable_at, tax_groups, tax_certif_applicable,
		tax_settl_process, tax_adjust_applicable, tax_reduce_amt, tax_mul_reg, tax_wh_reg_map, taxbasis_percentage,
		taxbasis_unit_rate, taxbasis_flat, created_at, created_by, addnl_param1, created_date,
		addnl_param2, modified_by, modified_date, timestamp, tax_cap_purchase, taxableamt_edit,
		quantity_edit, origin_stamp, inward_app, outward_app, centr_declared, taxcls_usage,
		centdecholevel, tax_credliab, autogentaxinv, clsdoctype, txdocno_sal, tax_adj_app_re,
		implement_date, availinpcronrecon, fueltaxcreditappl, tax_settl_process_cdtyp, location_reg_map, ewb_app,
		abatement_app, sametxrgfrdeptxtp, autogentaxadjvch, ret1_applicability_date, isd_app, dta_app,
		etlcreatedatetime
    FROM stg.stg_tset_tax_community;
    
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
ALTER PROCEDURE dwh.usp_d_tset_tax_community(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
