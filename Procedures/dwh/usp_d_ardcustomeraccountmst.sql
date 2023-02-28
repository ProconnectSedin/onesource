-- PROCEDURE: dwh.usp_d_ardcustomeraccountmst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_ardcustomeraccountmst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_ardcustomeraccountmst(
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
    FROM stg.stg_ard_customer_account_mst;

    UPDATE dwh.D_ardcustomeraccountmst t
    SET
	   	company_key 			  = Coalesce (c.company_key,-1),
		opcoa_key				  = Coalesce (o.opcoa_key,-1),
	    curr_key				  = Coalesce (cu.curr_key,-1),
		company_code              = s.company_code,
        customer_group            = s.customer_group,
        fb_id                     = s.fb_id,
        currency_code             = s.currency_code,
        effective_from            = s.effective_from,
        sequence_no               = s.sequence_no,
        timestamps                = s.timestamps,
        custctrl_account          = s.custctrl_account,
        custprepay_account        = s.custprepay_account,
        custnonar_account         = s.custnonar_account,
        effective_to              = s.effective_to,
        resou_id                  = s.resou_id,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_ard_customer_account_mst s
	LEFT JOIN dwh.d_company c
	ON s.company_code 		= c.company_code
	LEFT JOIN  dwh.d_operationalaccountdetail o
	ON s.custctrl_account	= o.account_code
	LEFT JOIN dwh.d_currency cu
	ON s.currency_code		= cu.iso_curr_code
    WHERE t.company_code	= s.company_code
    AND	  t.customer_group	= s.customer_group
    AND	  t.fb_id			= s.fb_id
    AND	  t.effective_from	= s.effective_from
	AND	  t.currency_code	= s.currency_code
	AND	  t.sequence_no		= s.sequence_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_ardcustomeraccountmst
    (
        company_key, opcoa_key,	curr_key,
		company_code, customer_group, fb_id, 
		currency_code, effective_from, sequence_no, 
		timestamps, custctrl_account, custprepay_account, 
		custnonar_account, effective_to, resou_id, 
		createdby, createddate, modifiedby, 
		modifieddate, etlactiveind, etljobname, 
		envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        Coalesce (c.company_key,-1), Coalesce(o.opcoa_key,-1), Coalesce (cu.curr_key,-1),
		s.company_code, s.customer_group, s.fb_id, 
		s.currency_code, s.effective_from, s.sequence_no, 
		s.timestamps, s.custctrl_account, s.custprepay_account, 
		s.custnonar_account, s.effective_to, s.resou_id, 
		s.createdby, s.createddate, s.modifiedby, 
		s.modifieddate, 1, p_etljobname, 
		p_envsourcecd, p_datasourcecd, NOW()
		
    FROM stg.stg_ard_customer_account_mst s
	LEFT JOIN dwh.d_company c
	ON s.company_code 		= c.company_code
	LEFT JOIN  dwh.d_operationalaccountdetail o
	ON s.custctrl_account	= o.account_code
	LEFT JOIN dwh.d_currency cu
	ON s.currency_code		= cu.iso_curr_code
    LEFT JOIN dwh.D_ardcustomeraccountmst t
    ON s.company_code 		= t.company_code
    AND s.customer_group 	= t.customer_group
    AND s.fb_id 			= t.fb_id
    AND s.effective_from 	= t.effective_from
	AND	s.currency_code		= t.currency_code
	AND	s.sequence_no		= t.sequence_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ard_customer_account_mst
    (
        company_code, customer_group, fb_id, currency_code, effective_from, sequence_no, timestamps, custctrl_account, custprepay_account, custnonar_account, effective_to, resou_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        company_code, customer_group, fb_id, currency_code, effective_from, sequence_no, timestamps, custctrl_account, custprepay_account, custnonar_account, effective_to, resou_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_ard_customer_account_mst;
    
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
ALTER PROCEDURE dwh.usp_d_ardcustomeraccountmst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
