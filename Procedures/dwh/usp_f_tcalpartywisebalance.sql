-- PROCEDURE: dwh.usp_f_tcalpartywisebalance(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tcalpartywisebalance(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tcalpartywisebalance(
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
    FROM stg.stg_tcal_partywise_balance;

    UPDATE dwh.f_tcalpartywisebalance t
    SET
        tcalpartywisebalance_company_key	= COALESCE(c.company_key,-1),
		tax_community 		  	  = s.tax_community,
        cum_tran_amt_dr           = s.cum_tran_amt_dr,
        cum_taxable_amt_dr        = s.cum_taxable_amt_dr,
        cum_tax_amt_dr            = s.cum_tax_amt_dr,
        cum_tran_amt_cr           = s.cum_tran_amt_cr,
        cum_taxable_amt_cr        = s.cum_taxable_amt_cr,
        cum_tax_amt_cr            = s.cum_tax_amt_cr,
        timestamp                 = s.timestamp,
        tax_dedection_flag        = s.tax_dedection_flag,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_tcal_partywise_balance s
	LEFT JOIN dwh.d_company c     
    ON 	  s.company_code          = c.company_code
    WHERE t.company_code 		  = s.company_code
    AND   t.party_type 			  = s.party_type
    AND   t.party_code 			  = s.party_code
    AND   t.tax_type 			  = s.tax_type
    AND   t.assessee_type         = s.assessee_type
    AND   t.tax_class 			  = s.tax_class
    AND   t.tax_category 		  = s.tax_category
    AND   t.tax_year 			  = s.tax_year
	AND	  t.contract_no           = s.contract_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_tcalpartywisebalance
    (
		tcalpartywisebalance_company_key,
        company_code, 		party_type, 		party_code, 		tax_type, 			tax_community, 
		tax_class, 			tax_category, 		tax_year, 			assessee_type, 		cum_tran_amt_dr, 
		cum_taxable_amt_dr, cum_tax_amt_dr, 	cum_tran_amt_cr, 	cum_taxable_amt_cr, cum_tax_amt_cr, 
		timestamp, 			contract_no, 		tax_dedection_flag, etlactiveind, 		etljobname, 
		envsourcecd, 		datasourcecd, 		etlcreatedatetime
    )

    SELECT
		COALESCE(c.company_key,-1),
        s.company_code, 		s.party_type, 		s.party_code, 			s.tax_type, 			s.tax_community, 
		s.tax_class, 			s.tax_category, 	s.tax_year, 			s.assessee_type, 		s.cum_tran_amt_dr, 
		s.cum_taxable_amt_dr, 	s.cum_tax_amt_dr, 	s.cum_tran_amt_cr, 		s.cum_taxable_amt_cr, 	s.cum_tax_amt_cr, 
		s.timestamp, 			s.contract_no, 		s.tax_dedection_flag, 	1, 						p_etljobname, 
		p_envsourcecd, 			p_datasourcecd, 	NOW()
    FROM stg.stg_tcal_partywise_balance s
	LEFT JOIN dwh.d_company c     
    ON 	  s.company_code          = c.company_code
    LEFT JOIN dwh.f_tcalpartywisebalance t
    ON 	  s.company_code 		  = t.company_code
    AND   s.party_type 			  = t.party_type
    AND   s.party_code 			  = t.party_code
    AND   s.tax_type 			  = t.tax_type
    AND   s.tax_community 		  = t.tax_community
    AND   s.tax_class 			  = t.tax_class
    AND   s.tax_category 		  = t.tax_category
    AND   s.tax_year 			  = t.tax_year
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tcal_partywise_balance
    (
        company_code, 		party_type, 		party_code, 		tax_type, 			tax_community, 
		tax_class, 			tax_category, 		tax_year, 			assessee_type, 		cum_tran_amt_dr, 
		cum_taxable_amt_dr, cum_tax_amt_dr, 	cum_tran_amt_cr, 	cum_taxable_amt_cr, cum_tax_amt_cr, 
		timestamp, 			contract_no, 		tax_dedection_flag, tax_group, 			etlcreateddatetime
    )
    SELECT
		company_code, 		party_type, 		party_code, 		tax_type, 			tax_community, 
		tax_class, 			tax_category, 		tax_year, 			assessee_type, 		cum_tran_amt_dr, 
		cum_taxable_amt_dr, cum_tax_amt_dr, 	cum_tran_amt_cr, 	cum_taxable_amt_cr, cum_tax_amt_cr, 
		timestamp, 			contract_no, 		tax_dedection_flag, tax_group, 			etlcreateddatetime
    FROM stg.stg_tcal_partywise_balance;
    
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
ALTER PROCEDURE dwh.usp_f_tcalpartywisebalance(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
