-- PROCEDURE: dwh.usp_f_sinpogrmapweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sinpogrmapweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sinpogrmapweekly(
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
    FROM stg.Stg_sin_po_gr_map;

    UPDATE dwh.F_sinpogrmap t
    SET
        tran_type                   = s.tran_type,
        tran_ou                     = s.tran_ou,
        tran_no                     = s.tran_no,
        line_no                     = s.line_no,
        ref_doc_ou                  = s.ref_doc_ou,
        ref_doc_no                  = s.ref_doc_no,
        ref_doc_line_no             = s.ref_doc_line_no,
        pors_type                   = s.pors_type,
        po_ou                       = s.po_ou,
        po_no                       = s.po_no,
        po_line_no                  = s.po_line_no,
        po_amendment_no             = s.po_amendment_no,
        item_type                   = s.item_type,
        item_tcd_code               = s.item_tcd_code,
        item_tcd_var                = s.item_tcd_var,
        recd_qty                    = s.recd_qty,
        recd_amount                 = s.recd_amount,
        acc_qty                     = s.acc_qty,
        acc_amount                  = s.acc_amount,
        billed_qty                  = s.billed_qty,
        billed_amount               = s.billed_amount,
        matching_type               = s.matching_type,
        tolerance_type              = s.tolerance_type,
        tolreance_perc              = s.tolreance_perc,
        proposed_qty                = s.proposed_qty,
        proposed_rate               = s.proposed_rate,
        proposed_amount             = s.proposed_amount,
        matched_qty                 = s.matched_qty,
        matched_amount              = s.matched_amount,
        match_status                = s.match_status,
        positivematch_status        = s.positivematch_status,
        negativematch_status        = s.negativematch_status,
        createdby                   = s.createdby,
        createddate                 = s.createddate,
        modifiedby                  = s.modifiedby,
        modifieddate                = s.modifieddate,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.Stg_sin_po_gr_map s
    WHERE t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.line_no = s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sinpogrmap
    (
        tran_type, tran_ou, tran_no, line_no, ref_doc_ou, ref_doc_no, ref_doc_line_no, pors_type, po_ou, po_no, po_line_no, po_amendment_no, item_type, item_tcd_code, item_tcd_var, recd_qty, recd_amount, acc_qty, acc_amount, billed_qty, billed_amount, matching_type, tolerance_type, tolreance_perc, proposed_qty, proposed_rate, proposed_amount, matched_qty, matched_amount, match_status, positivematch_status, negativematch_status, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.line_no, s.ref_doc_ou, s.ref_doc_no, s.ref_doc_line_no, s.pors_type, s.po_ou, s.po_no, s.po_line_no, s.po_amendment_no, s.item_type, s.item_tcd_code, s.item_tcd_var, s.recd_qty, s.recd_amount, s.acc_qty, s.acc_amount, s.billed_qty, s.billed_amount, s.matching_type, s.tolerance_type, s.tolreance_perc, s.proposed_qty, s.proposed_rate, s.proposed_amount, s.matched_qty, s.matched_amount, s.match_status, s.positivematch_status, s.negativematch_status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_sin_po_gr_map s
    LEFT JOIN dwh.F_sinpogrmap t
    ON s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.line_no = t.line_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
--Updating etlactiveind for Deleted source data 
	
	UPDATE dwh.F_sinpogrmap t1
	SET	  etlactiveind		=  0,
	      etlupdatedatetime	= Now()::TIMESTAMP
	FROM  dwh.F_sinpogrmap t
	LEFT  JOIN stg.Stg_sin_po_gr_map s
	ON    s.tran_ou = t.tran_ou
    AND   s.tran_no = t.tran_no
    AND   s.line_no = t.line_no
	WHERE t.sinpogrmap_key=t1.sinpogrmap_key
	AND	  COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
	AND	  s.tran_ou IS NULL;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sin_po_gr_map
    (
        tran_type, tran_ou, tran_no, line_no, ref_doc_ou, ref_doc_no, ref_doc_line_no, timestamp, pors_type, po_ou, po_no, po_line_no, po_amendment_no, item_type, item_tcd_code, item_tcd_var, recd_qty, recd_amount, acc_qty, acc_amount, billed_qty, billed_amount, matching_type, tolerance_type, tolreance_perc, proposed_qty, proposed_rate, proposed_amount, matched_qty, matched_amount, match_status, positivematch_status, negativematch_status, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, line_no, ref_doc_ou, ref_doc_no, ref_doc_line_no, timestamp, pors_type, po_ou, po_no, po_line_no, po_amendment_no, item_type, item_tcd_code, item_tcd_var, recd_qty, recd_amount, acc_qty, acc_amount, billed_qty, billed_amount, matching_type, tolerance_type, tolreance_perc, proposed_qty, proposed_rate, proposed_amount, matched_qty, matched_amount, match_status, positivematch_status, negativematch_status, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.Stg_sin_po_gr_map;
    
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
ALTER PROCEDURE dwh.usp_f_sinpogrmapweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
