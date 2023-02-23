-- PROCEDURE: dwh.usp_f_cidocitemdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_cidocitemdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_cidocitemdtl(
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
    FROM stg.stg_ci_doc_item_dtl;

    UPDATE dwh.f_cidocitemdtl t
    SET
		cidocitemdtl_company_key = COALESCE(c.company_key,-1),
        timestamp            = s.timestamp,
        batch_id             = s.batch_id,
        component_id         = s.component_id,
        company_code         = s.company_code,
        lo_id                = s.lo_id,
        item_tcd_code        = s.item_tcd_code,
        item_tcd_var         = s.item_tcd_var,
        uom                  = s.uom,
        item_qty             = s.item_qty,
        unit_price           = s.unit_price,
        item_type            = s.item_type,
        cost_center          = s.cost_center,
        createdby            = s.createdby,
        createddate          = s.createddate,
        modifiedby           = s.modifiedby,
        modifieddate         = s.modifieddate,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.stg_ci_doc_item_dtl s
	LEFT JOIN dwh.d_company c     
    ON 	  s.company_code     = c.company_code
    WHERE t.tran_type 		 = s.tran_type
    AND   t.tran_ou 		 = s.tran_ou
    AND   t.tran_no 		 = s.tran_no
    AND   t.line_no 		 = s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_cidocitemdtl
    (
		cidocitemdtl_company_key,
        tran_type, 			tran_ou, 			tran_no, 			line_no, 		timestamp, 
		batch_id, 			component_id, 		company_code, 		lo_id, 			item_tcd_code, 
		item_tcd_var, 		uom, 				item_qty, 			unit_price, 	item_type, 
		cost_center, 		createdby, 			createddate, 		modifiedby, 	modifieddate, 
		etlactiveind, 		etljobname, 		envsourcecd, 		datasourcecd, 	etlcreatedatetime
    )

    SELECT
		COALESCE(c.company_key,-1),
        s.tran_type, 		s.tran_ou, 			s.tran_no, 			s.line_no, 		s.timestamp, 
		s.batch_id, 		s.component_id, 	s.company_code, 	s.lo_id, 		s.item_tcd_code, 
		s.item_tcd_var, 	s.uom, 				s.item_qty, 		s.unit_price, 	s.item_type, 
		s.cost_center, 		s.createdby, 		s.createddate, 		s.modifiedby, 	s.modifieddate, 
		1, 					p_etljobname, 		p_envsourcecd, 		p_datasourcecd, NOW()
    FROM stg.stg_ci_doc_item_dtl s
	LEFT JOIN dwh.d_company c     
    ON 	  s.company_code     = c.company_code
    LEFT JOIN dwh.f_cidocitemdtl t
    ON 	  s.tran_type 		 = t.tran_type
    AND   s.tran_ou 		 = t.tran_ou
    AND   s.tran_no 		 = t.tran_no
    AND   s.line_no 		 = t.line_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ci_doc_item_dtl
    (
        tran_type, 		tran_ou, 			tran_no, 			line_no, 		timestamp, 
		batch_id, 		component_id, 		company_code, 		lo_id, 			item_tcd_code, 
		item_tcd_var, 	visible_line_no, 	so_no, 				so_ou, 			ref_doc_no, 
		ref_doc_date, 	ref_doc_ou, 		ship_to_cust, 		ship_to_id, 	uom, 
		item_qty, 		unit_price, 		item_amount, 		remarks, 		item_type, 
		tax_amount, 	disc_amount, 		line_amount, 		base_amount, 	par_base_amount, 
		cost_center, 	analysis_code, 		subanalysis_code, 	createdby, 		createddate, 
		modifiedby, 	modifieddate, 		item_tcd_desc, 		sale_purpose, 	warehouse_code, 
		alloc_method, 	attr_alloc, 		proposal_no, 		shipping_ou, 	ship_to_cust_name, 
		packslip_no, 	ref_doc_type, 		po_ou, 				base_value, 	charges_amount, 
		etlcreateddatetime
    )
    SELECT
        tran_type, 		tran_ou, 			tran_no, 			line_no, 		timestamp, 
		batch_id, 		component_id, 		company_code, 		lo_id, 			item_tcd_code, 
		item_tcd_var, 	visible_line_no, 	so_no, 				so_ou, 			ref_doc_no, 
		ref_doc_date, 	ref_doc_ou, 		ship_to_cust, 		ship_to_id, 	uom, 
		item_qty, 		unit_price, 		item_amount, 		remarks, 		item_type, 
		tax_amount, 	disc_amount, 		line_amount, 		base_amount, 	par_base_amount, 
		cost_center, 	analysis_code, 		subanalysis_code, 	createdby, 		createddate, 
		modifiedby, 	modifieddate, 		item_tcd_desc, 		sale_purpose, 	warehouse_code, 
		alloc_method, 	attr_alloc, 		proposal_no, 		shipping_ou, 	ship_to_cust_name, 
		packslip_no, 	ref_doc_type, 		po_ou, 				base_value, 	charges_amount, 
		etlcreateddatetime
    FROM stg.stg_ci_doc_item_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_cidocitemdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
