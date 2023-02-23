-- PROCEDURE: dwh.usp_d_ardtaxaddnacctmst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_ardtaxaddnacctmst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_ardtaxaddnacctmst(
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
    FROM stg.stg_ard_tax_addn_acct_mst;

    UPDATE dwh.D_ardtaxaddnacctmst t
    SET
        tax_region              = s.tax_region,
        finance_book            = s.finance_book,
        account_code            = s.account_code,
        cost_center             = s.cost_center,
        analysis_code           = s.analysis_code,
        subanalysis_code        = s.subanalysis_code,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.stg_ard_tax_addn_acct_mst s
    WHERE t.company_code 		= s.company_code
    AND   t.tax_type 			= s.tax_type
    AND   t.tax_community 		= s.tax_community
    AND   t.usage_id 			= s.usage_id
    AND   t.effective_from 		= s.effective_from
    AND   t.sequence_no 		= s.sequence_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_ardtaxaddnacctmst
    (
        company_code, 		tax_type, 			tax_community, 		usage_id, 		tax_region, 
		effective_from, 	sequence_no, 		finance_book, 		account_code, 	cost_center, 
		analysis_code, 		subanalysis_code, 	etlactiveind, 		etljobname, 	envsourcecd, 
		datasourcecd, 		etlcreatedatetime
    )

    SELECT
        s.company_code, 	s.tax_type, 		s.tax_community, 	s.usage_id, 	s.tax_region, 
		s.effective_from, 	s.sequence_no, 		s.finance_book, 	s.account_code, s.cost_center, 
		s.analysis_code, 	s.subanalysis_code, 1, 					p_etljobname, 	p_envsourcecd, 
		p_datasourcecd, 	NOW()
    FROM stg.stg_ard_tax_addn_acct_mst s
    LEFT JOIN dwh.D_ardtaxaddnacctmst t
    ON    t.company_code 		= s.company_code
    AND   t.tax_type 			= s.tax_type
    AND   t.tax_community 		= s.tax_community
    AND   t.usage_id 			= s.usage_id
    AND   t.effective_from 		= s.effective_from
    AND   t.sequence_no 		= s.sequence_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ard_tax_addn_acct_mst
    (
        company_code, 		tax_type, 		tax_community, 		usage_id, 			tax_region, 
		effective_from, 	sequence_no, 	finance_book, 		account_code, 		effective_to, 
		cost_center, 		analysis_code, 	subanalysis_code, 	etlcreateddatetime
    )
    SELECT
        company_code, 		tax_type, 		tax_community, 		usage_id, 			tax_region, 
		effective_from, 	sequence_no, 	finance_book, 		account_code, 		effective_to, 
		cost_center, 		analysis_code, 	subanalysis_code, 	etlcreateddatetime
    FROM stg.stg_ard_tax_addn_acct_mst;
    
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
ALTER PROCEDURE dwh.usp_d_ardtaxaddnacctmst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
