-- PROCEDURE: dwh.usp_f_sadsuppcustadjhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sadsuppcustadjhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sadsuppcustadjhdr(
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
    FROM stg.stg_sad_suppcustadj_hdr;

	UPDATE dwh.F_sadsuppcustadjhdr t
    SET
		curr_key				 = COALESCE(cu.curr_key,-1),
		vendor_key				 = COALESCE(v.vendor_key,-1),
		cust_key				 = COALESCE(cus.customer_key,-1),
        ou_id                    = s.ou_id,
        adjustment_no            = s.adjustment_no,
        trantype                 = s.trantype,
        adjustment_date          = s.adjustment_date,
        status                   = s.status,
        supp_code                = s.supp_code,
        supp_fbid                = s.supp_fbid,
        supp_currcode            = s.supp_currcode,
        scdn_drnote              = s.scdn_drnote,
        supp_adj_no              = s.supp_adj_no,
        supp_cradj_amt           = s.supp_cradj_amt,
        supp_cradj_disc          = s.supp_cradj_disc,
        supp_cradj_totamt        = s.supp_cradj_totamt,
        cust_code                = s.cust_code,
        cust_fbid                = s.cust_fbid,
        cust_currcode            = s.cust_currcode,
        cdcn_crnote              = s.cdcn_crnote,
        cust_adj_no              = s.cust_adj_no,
        cust_dradj_amt           = s.cust_dradj_amt,
        cust_dradj_disc          = s.cust_dradj_disc,
        cust_dradj_charge        = s.cust_dradj_charge,
        cust_dradj_rwoff         = s.cust_dradj_rwoff,
        cust_dradj_totamt        = s.cust_dradj_totamt,
        ctimestamp                = s.timestamp,
        guid                     = s.guid,
        createdby                = s.createdby,
        createddate              = s.createddate,
        modifiedby               = s.modifiedby,
        modifieddate             = s.modifieddate,
        rev_remarks              = s.rev_remarks,
        reversaldate             = s.reversaldate,
        revcustadjno             = s.revcustadjno,
        revcustnoteno            = s.revcustnoteno,
        revsuppadjno             = s.revsuppadjno,
        revsuppnoteno            = s.revsuppnoteno,
        suppproject_ou           = s.suppproject_ou,
        suppProject_code         = s.suppProject_code,
        custproject_ou           = s.custproject_ou,
        custProject_code         = s.custProject_code,
        batch_id                 = s.batch_id,
        workflow_status          = s.workflow_status,
        comments                 = s.comments,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_sad_suppcustadj_hdr s
	LEFT JOIN dwh.d_currency cu
	ON cu.iso_curr_code	= s.supp_currcode
	LEFT JOIN dwh.d_vendor v
	ON v.vendor_id = s.supp_code
	AND v.vendor_ou = s.ou_id
	LEFT JOIN dwh.d_customer cus
	ON cus.customer_id = s.cust_code
	AND cus.customer_ou = s.ou_id
    WHERE t.ou_id = s.ou_id
    AND t.adjustment_no = s.adjustment_no
    AND t.trantype = s.trantype;
	
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sadsuppcustadjhdr
    (
		curr_key, vendor_key, cust_key,
		ou_id, adjustment_no, trantype, adjustment_date, status, 
		supp_code, supp_fbid, supp_currcode, scdn_drnote, supp_adj_no,
		supp_cradj_amt, supp_cradj_disc, supp_cradj_totamt, cust_code, cust_fbid, 
		cust_currcode, cdcn_crnote, cust_adj_no, cust_dradj_amt, cust_dradj_disc,
		cust_dradj_charge, cust_dradj_rwoff, cust_dradj_totamt, ctimestamp, guid, 
		createdby, createddate, modifiedby, modifieddate, rev_remarks, 
		reversaldate, revcustadjno, revcustnoteno, revsuppadjno, revsuppnoteno,
		suppproject_ou, suppProject_code, custproject_ou, custProject_code, batch_id,
		workflow_status, comments,
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(cu.curr_key,-1), COALESCE(v.vendor_key,-1), COALESCE(cus.customer_key,-1),
        s.ou_id, s.adjustment_no, s.trantype, s.adjustment_date, s.status,
		s.supp_code, s.supp_fbid, s.supp_currcode, s.scdn_drnote, s.supp_adj_no, 
		s.supp_cradj_amt, s.supp_cradj_disc, s.supp_cradj_totamt, s.cust_code, s.cust_fbid, 
		s.cust_currcode, s.cdcn_crnote, s.cust_adj_no, s.cust_dradj_amt, s.cust_dradj_disc, 
		s.cust_dradj_charge, s.cust_dradj_rwoff, s.cust_dradj_totamt, s.timestamp, s.guid,
		s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.rev_remarks,
		s.reversaldate, s.revcustadjno, s.revcustnoteno, s.revsuppadjno, s.revsuppnoteno, 
		s.suppproject_ou, s.suppProject_code, s.custproject_ou, s.custProject_code, s.batch_id, 
		s.workflow_status, s.comments,
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
   FROM stg.stg_sad_suppcustadj_hdr s
	LEFT JOIN dwh.d_currency cu
	ON cu.iso_curr_code	= s.supp_currcode
	LEFT JOIN dwh.d_vendor v
	ON v.vendor_id = s.supp_code
	AND v.vendor_ou = s.ou_id
	LEFT JOIN dwh.d_customer cus
	ON cus.customer_id = s.cust_code
	AND cus.customer_ou = s.ou_id
    LEFT JOIN dwh.F_sadsuppcustadjhdr t
    ON s.ou_id = t.ou_id
    AND s.adjustment_no = t.adjustment_no
    AND s.trantype = t.trantype
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sad_suppcustadj_hdr
    (
        ou_id, adjustment_no, trantype, adjustment_date, status, supp_code, supp_fbid, supp_currcode, scdn_drnote, supp_adj_no, supp_cradj_amt, supp_cradj_disc, supp_cradj_totamt, cust_code, cust_fbid, cust_currcode, cdcn_crnote, cust_adj_no, cust_dradj_amt, cust_dradj_disc, cust_dradj_charge, cust_dradj_rwoff, cust_dradj_totamt, timestamp, guid, createdby, createddate, modifiedby, modifieddate, rev_remarks, reversaldate, revcustadjno, revcustnoteno, revsuppadjno, revsuppnoteno, suppproject_ou, suppProject_code, custproject_ou, custProject_code, batch_id, workflow_status, comments, etlcreateddatetime
    )
    SELECT
        ou_id, adjustment_no, trantype, adjustment_date, status, supp_code, supp_fbid, supp_currcode, scdn_drnote, supp_adj_no, supp_cradj_amt, supp_cradj_disc, supp_cradj_totamt, cust_code, cust_fbid, cust_currcode, cdcn_crnote, cust_adj_no, cust_dradj_amt, cust_dradj_disc, cust_dradj_charge, cust_dradj_rwoff, cust_dradj_totamt, timestamp, guid, createdby, createddate, modifiedby, modifieddate, rev_remarks, reversaldate, revcustadjno, revcustnoteno, revsuppadjno, revsuppnoteno, suppproject_ou, suppProject_code, custproject_ou, custProject_code, batch_id, workflow_status, comments, etlcreateddatetime
    FROM stg.stg_sad_suppcustadj_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_sadsuppcustadjhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
