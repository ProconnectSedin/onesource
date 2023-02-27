-- PROCEDURE: dwh.usp_F_sadcustdrdocadjdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_F_sadcustdrdocadjdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_F_sadcustdrdocadjdtl(
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
    FROM stg.Stg_sad_custdrdocadj_dtl;

    UPDATE dwh.F_sadcustdrdocadjdtl t
    SET
		customer_key  				= COALESCE(cu.customer_key, -1),  
        ou_id                      = s.ou_id,
        adjustment_no              = s.adjustment_no,
        dr_doc_ou                  = s.dr_doc_ou,
        dr_doc_type                = s.dr_doc_type,
        dr_doc_no                  = s.dr_doc_no,
        term_no                    = s.term_no,
        au_due_date                = s.au_due_date,
        au_dr_doc_unadj_amt        = s.au_dr_doc_unadj_amt,
        au_cust_code               = s.au_cust_code,
        au_dr_doc_cur              = s.au_dr_doc_cur,
        au_crosscur_erate          = s.au_crosscur_erate,
        discount                   = s.discount,
        charges                    = s.charges,
        writeoff_amount            = s.writeoff_amount,
        dr_doc_adj_amt             = s.dr_doc_adj_amt,
        proposed_discount          = s.proposed_discount,
        proposed_charges           = s.proposed_charges,
        au_discount_date           = s.au_discount_date,
        au_billing_point           = s.au_billing_point,
        au_dr_doc_date             = s.au_dr_doc_date,
        au_fb_id                   = s.au_fb_id,
        guid                       = s.guid,
        au_base_exrate             = s.au_base_exrate,
        au_par_base_exrate         = s.au_par_base_exrate,
        au_disc_available          = s.au_disc_available,
        adjustment_amt             = s.adjustment_amt,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.Stg_sad_custdrdocadj_dtl s
	LEFT JOIN dwh.d_customer cu
        ON      cu.customer_id          = s.au_cust_code
        AND cu.customer_ou              = s.ou_id
      
    WHERE t.ou_id = s.ou_id
    AND t.adjustment_no = s.adjustment_no
    AND t.dr_doc_ou = s.dr_doc_ou
    AND t.dr_doc_type = s.dr_doc_type
    AND t.dr_doc_no = s.dr_doc_no
    AND t.term_no = s.term_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sadcustdrdocadjdtl
    (
        customer_key,ou_id, adjustment_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no, au_due_date, au_dr_doc_unadj_amt, au_cust_code, au_dr_doc_cur, au_crosscur_erate, discount, charges, writeoff_amount, dr_doc_adj_amt, proposed_discount, proposed_charges, au_discount_date, au_billing_point, au_dr_doc_date, au_fb_id, guid, au_base_exrate, au_par_base_exrate, au_disc_available, adjustment_amt, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(cu.customer_key, -1), s.ou_id, s.adjustment_no, s.dr_doc_ou, s.dr_doc_type, s.dr_doc_no, s.term_no, s.au_due_date, s.au_dr_doc_unadj_amt, s.au_cust_code, s.au_dr_doc_cur, s.au_crosscur_erate, s.discount, s.charges, s.writeoff_amount, s.dr_doc_adj_amt, s.proposed_discount, s.proposed_charges, s.au_discount_date, s.au_billing_point, s.au_dr_doc_date, s.au_fb_id, s.guid, s.au_base_exrate, s.au_par_base_exrate, s.au_disc_available, s.adjustment_amt, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_sad_custdrdocadj_dtl s
		LEFT JOIN dwh.d_customer cu
        ON      cu.customer_id          = s.au_cust_code
        AND cu.customer_ou              = s.ou_id
      
    LEFT JOIN dwh.F_sadcustdrdocadjdtl t
    ON s.ou_id = t.ou_id
    AND s.adjustment_no = t.adjustment_no
    AND s.dr_doc_ou = t.dr_doc_ou
    AND s.dr_doc_type = t.dr_doc_type
    AND s.dr_doc_no = t.dr_doc_no
    AND s.term_no = t.term_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sad_custdrdocadj_dtl
    (
        ou_id, adjustment_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no, au_due_date, au_dr_doc_unadj_amt, au_cust_code, au_dr_doc_cur, au_crosscur_erate, discount, charges, writeoff_amount, dr_doc_adj_amt, proposed_discount, proposed_charges, au_discount_date, au_billing_point, au_dr_doc_date, au_fb_id, cost_center, analysis_code, subanalysis_code, guid, au_base_exrate, au_par_base_exrate, au_disc_available, adjustment_amt, etlcreateddatetime
    )
    SELECT
        ou_id, adjustment_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no, au_due_date, au_dr_doc_unadj_amt, au_cust_code, au_dr_doc_cur, au_crosscur_erate, discount, charges, writeoff_amount, dr_doc_adj_amt, proposed_discount, proposed_charges, au_discount_date, au_billing_point, au_dr_doc_date, au_fb_id, cost_center, analysis_code, subanalysis_code, guid, au_base_exrate, au_par_base_exrate, au_disc_available, adjustment_amt, etlcreateddatetime
    FROM stg.Stg_sad_custdrdocadj_dtl;
    
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

ALTER PROCEDURE dwh.usp_F_sadcustdrdocadjdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
