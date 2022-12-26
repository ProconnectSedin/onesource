-- PROCEDURE: dwh.usp_f_sinitemdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sinitemdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sinitemdtl(
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
	p_depsource VARCHAR(100);

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_sin_item_dtl;

    UPDATE dwh.f_sinitemdtl t
    SET
	    si_sinitm_inv_key            = fh.si_inv_key,
        timestamp                    = s.timestamp,
        po_amendment_no              = s.po_amendment_no,
        visible_line_no              = s.visible_line_no,
        ref_doc_type                 = s.ref_doc_type,
        ref_doc_no                   = s.ref_doc_no,
        ref_doc_date                 = s.ref_doc_date,
        pors_type                    = s.pors_type,
        po_no                        = s.po_no,
        po_ou                        = s.po_ou,
        item_tcd_code                = s.item_tcd_code,
        item_tcd_var                 = s.item_tcd_var,
        uom                          = s.uom,
        rate_per                     = s.rate_per,
        invoice_qty                  = s.invoice_qty,
        invoice_rate                 = s.invoice_rate,
        proposed_qty                 = s.proposed_qty,
        proposed_rate                = s.proposed_rate,
        proposed_amount              = s.proposed_amount,
        remarks                      = s.remarks,
        cost_center                  = s.cost_center,
        analysis_code                = s.analysis_code,
        subanalysis_code             = s.subanalysis_code,
        ref_doc_ou                   = s.ref_doc_ou,
        tax_amount                   = s.tax_amount,
        disc_amount                  = s.disc_amount,
        line_amount                  = s.line_amount,
        item_amount                  = s.item_amount,
        base_amount                  = s.base_amount,
        original_proposed_amt        = s.original_proposed_amt,
        original_proposed_qty        = s.original_proposed_qty,
        po_line_no                   = s.po_line_no,
        ref_doc_line_no              = s.ref_doc_line_no,
        base_value                   = s.base_value,
        matching_type                = s.matching_type,
        orderno_instname             = s.orderno_instname,
        refdocno_instname            = s.refdocno_instname,
        orderno_cur                  = s.orderno_cur,
        po_date                      = s.po_date,
        po_categ                     = s.po_categ,
        gr_opt                       = s.gr_opt,
        po_qty                       = s.po_qty,
        imports_flag                 = s.imports_flag,
        retention_amt                = s.retention_amt,
        retentionml                  = s.retentionml,
        holdml                       = s.holdml,
        acusage                      = s.acusage,
        own_tax_region               = s.own_tax_region,
        party_tax_region             = s.party_tax_region,
        decl_tax_region              = s.decl_tax_region,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_sin_item_dtl s
	INNER JOIN dwh.f_sininvoicehdr fh
	ON  s.tran_no     =		fh.tran_no
	AND s.tran_ou     =		fh.tran_ou
	AND s.tran_type   =     fh.tran_type
    WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.line_no = s.line_no
    AND t.ipv_flag = s.ipv_flag
    AND t.epv_flag = s.epv_flag;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_sinitemdtl
    (
        si_sinitm_inv_key,tran_type, tran_ou, tran_no, line_no, timestamp, po_amendment_no, visible_line_no, ref_doc_type, 
		ref_doc_no, ref_doc_date, pors_type, po_no, po_ou, item_tcd_code, item_tcd_var, uom, rate_per, invoice_qty, 
		invoice_rate, proposed_qty, proposed_rate, proposed_amount, remarks, cost_center, analysis_code, subanalysis_code, 
		ref_doc_ou, tax_amount, disc_amount, line_amount, item_amount, base_amount, original_proposed_amt, original_proposed_qty, 
		po_line_no, ref_doc_line_no, base_value, matching_type, orderno_instname, refdocno_instname, orderno_cur, po_date, 
		po_categ, gr_opt, po_qty, imports_flag, retention_amt, ipv_flag, epv_flag, retentionml, holdml, acusage, own_tax_region, 
		party_tax_region, decl_tax_region, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.si_inv_key,s.tran_type, s.tran_ou, s.tran_no, s.line_no, s.timestamp, s.po_amendment_no, s.visible_line_no, s.ref_doc_type, 
		s.ref_doc_no, s.ref_doc_date, s.pors_type, s.po_no, s.po_ou, s.item_tcd_code, s.item_tcd_var, s.uom, s.rate_per, s.invoice_qty,
		s.invoice_rate, s.proposed_qty, s.proposed_rate, s.proposed_amount, s.remarks, s.cost_center, s.analysis_code, s.subanalysis_code, 
		s.ref_doc_ou, s.tax_amount, s.disc_amount, s.line_amount, s.item_amount, s.base_amount, s.original_proposed_amt, s.original_proposed_qty,
		s.po_line_no, s.ref_doc_line_no, s.base_value, s.matching_type, s.orderno_instname, s.refdocno_instname, s.orderno_cur, s.po_date, 
		s.po_categ, s.gr_opt, s.po_qty, s.imports_flag, s.retention_amt, s.ipv_flag, s.epv_flag, s.retentionml, s.holdml, s.acusage, s.own_tax_region,
		s.party_tax_region, s.decl_tax_region, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sin_item_dtl s
	INNER JOIN dwh.f_sininvoicehdr fh
	ON  s.tran_no     =		fh.tran_no
	AND s.tran_ou     =		fh.tran_ou
	AND s.tran_type   =     fh.tran_type
    LEFT JOIN dwh.f_sinitemdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.line_no = t.line_no
    AND s.ipv_flag = t.ipv_flag
    AND s.epv_flag = t.epv_flag
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sin_item_dtl
    (
        tran_type, tran_ou, tran_no, line_no, timestamp, po_amendment_no, visible_line_no, ref_doc_type, ref_doc_no, ref_doc_date, pors_type, po_no, po_ou, item_tcd_code, item_tcd_var, uom, rate_per, invoice_qty, invoice_rate, invoice_amount, proposed_qty, proposed_rate, proposed_amount, tran_amount, remarks, cost_center, analysis_code, subanalysis_code, ref_doc_ou, unmatched_amount, unmatched_perc, tax_amount, disc_amount, line_amount, item_amount, base_amount, original_proposed_amt, original_proposed_qty, po_line_no, ref_doc_line_no, par_base_amount, base_value, createdby, createddate, modifiedby, modifieddate, item_desc, matching_type, reconciled_qty, orderno_instname, refdocno_instname, orderno_cur, po_date, po_categ, gr_opt, po_qty, imports_flag, project_ou, Project_code, tms_ou, tms_no, tms_type, retention_amt, retentionperc, ret_postol, ret_negtol, ipv_flag, epv_flag, retentionml, holdml, acusage, boe_no, boe_date, Dest_comp, destou, destfb, destusageid, interfbjvno, dest_cost_center, dest_sub_analysis_code, dest_analysis_code, Dest_Account_code, Itercomp_Account_code, port_code, own_tax_region, party_tax_region, decl_tax_region, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, line_no, timestamp, po_amendment_no, visible_line_no, ref_doc_type, ref_doc_no, ref_doc_date, pors_type, po_no, po_ou, item_tcd_code, item_tcd_var, uom, rate_per, invoice_qty, invoice_rate, invoice_amount, proposed_qty, proposed_rate, proposed_amount, tran_amount, remarks, cost_center, analysis_code, subanalysis_code, ref_doc_ou, unmatched_amount, unmatched_perc, tax_amount, disc_amount, line_amount, item_amount, base_amount, original_proposed_amt, original_proposed_qty, po_line_no, ref_doc_line_no, par_base_amount, base_value, createdby, createddate, modifiedby, modifieddate, item_desc, matching_type, reconciled_qty, orderno_instname, refdocno_instname, orderno_cur, po_date, po_categ, gr_opt, po_qty, imports_flag, project_ou, Project_code, tms_ou, tms_no, tms_type, retention_amt, retentionperc, ret_postol, ret_negtol, ipv_flag, epv_flag, retentionml, holdml, acusage, boe_no, boe_date, Dest_comp, destou, destfb, destusageid, interfbjvno, dest_cost_center, dest_sub_analysis_code, dest_analysis_code, Dest_Account_code, Itercomp_Account_code, port_code, own_tax_region, party_tax_region, decl_tax_region, etlcreateddatetime
    FROM stg.stg_sin_item_dtl;
    
    END IF;
    
	ELSE	
		 p_errorid   := 0;
		 select 0 into inscnt;
       	 select 0 into updcnt;
		 select 0 into srccnt;	
		 
		 IF p_depsource IS NULL
		 THEN 
		 p_errordesc := 'The Dependent source cannot be NULL.';
		 ELSE
		 p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
		 END IF;
		 CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
	END IF;	
	
	EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_sinitemdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
