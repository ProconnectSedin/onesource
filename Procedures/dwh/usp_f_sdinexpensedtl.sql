CREATE OR REPLACE PROCEDURE dwh.usp_f_sdinexpensedtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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
    FROM stg.stg_sdin_expense_dtl;

    UPDATE dwh.F_sdinexpensedtl t
    SET
		account_key				 = oad.opcoa_key,
		uom_key					 = um.uom_key,
        expense                  = s.expense,
        usage                    = s.usage,
        uom                      = s.uom,
        item_qty                 = s.item_qty,
        item_rate                = s.item_rate,
        rate_per                 = s.rate_per,
        item_amount              = s.item_amount,
        remarks                  = s.remarks,
        cost_center              = s.cost_center,
        base_value               = s.base_value,
        accountcode              = s.accountcode,
        destou                   = s.destou,
        visible_line_no          = s.visible_line_no,
        retentionml              = s.retentionml,
        holdml                   = s.holdml,
        trnsfr_inv_no            = s.trnsfr_inv_no,
        trnsfr_inv_date          = s.trnsfr_inv_date,
        trnsfr_inv_ou            = s.trnsfr_inv_ou,
        draft_bill_lineno        = s.draft_bill_lineno,
        draft_bill_no            = s.draft_bill_no,
        draft_bill_ou            = s.draft_bill_ou,
        s_location               = s.location,
        region                   = s.region,
        partytype                = s.partytype,
        line_of_business         = s.line_of_business,
        department               = s.department,
        service_type             = s.service_type,
        order_type               = s.order_type,
        vehicle_type             = s.vehicle_type,
        activity_type            = s.activity_type,
        nature                   = s.nature,
        own_tax_region           = s.own_tax_region,
        party_tax_region         = s.party_tax_region,
        decl_tax_region          = s.decl_tax_region,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_sdin_expense_dtl s
	LEFT JOIN dwh.d_uom um
	ON um.mas_uomcode = s.uom
	LEFT JOIN dwh.d_operationalaccountdetail oad
	ON oad.account_code= s.accountcode
	WHERE t.tran_type = s.tran_type
    AND t.tran_ou = s.tran_ou
    AND t.tran_no = s.tran_no
    AND t.line_no = s.line_no
    AND t.s_timestamp = s.timestamp;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_sdinexpensedtl
    (
        tran_type, tran_ou, tran_no, line_no, s_timestamp, 
		expense, usage, uom, item_qty, item_rate, 
		rate_per, item_amount, remarks, cost_center, base_value, 
		accountcode, destou, visible_line_no, retentionml, holdml, 
		trnsfr_inv_no, trnsfr_inv_date, trnsfr_inv_ou, draft_bill_lineno, draft_bill_no, 
		draft_bill_ou, s_location, region, partytype, line_of_business, 
		department, service_type, order_type, vehicle_type, activity_type, 
		nature, own_tax_region, party_tax_region, decl_tax_region, 
		etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.tran_type, s.tran_ou, s.tran_no, s.line_no, s.timestamp, 
		s.expense, s.usage, s.uom, s.item_qty, s.item_rate, 
		s.rate_per, s.item_amount, s.remarks, s.cost_center, s.base_value, 
		s.accountcode, s.destou, s.visible_line_no, s.retentionml, s.holdml, 
		s.trnsfr_inv_no, s.trnsfr_inv_date, s.trnsfr_inv_ou, s.draft_bill_lineno, s.draft_bill_no, 
		s.draft_bill_ou, s.location, s.region, s.partytype, s.line_of_business, 
		s.department, s.service_type, s.order_type, s.vehicle_type, s.activity_type, 
		s.nature, s.own_tax_region, s.party_tax_region, s.decl_tax_region, 
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sdin_expense_dtl s
	LEFT JOIN dwh.d_uom um
	ON um.mas_uomcode = s.uom
	LEFT JOIN dwh.d_operationalaccountdetail oad
	ON oad.account_code= s.accountcode
    LEFT JOIN dwh.F_sdinexpensedtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.line_no = t.line_no
    AND s.timestamp = t.s_timestamp
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sdin_expense_dtl
    (
        tran_type, tran_ou, tran_no, line_no, timestamp, expense, usage, uom, item_qty, item_rate, rate_per, item_amount, remarks, cost_center, analysis_code, subanalysis_code, base_value, createdby, createddate, modifiedby, modifieddate, accountcode, destou, destfb, destusageid, interfbjvno, accountcode_destusage, accountcode_interfb, analysis_code_dest, sub_analysis_code_dest, costcenter_dest, analysis_code_interfb, sub_analysis_code_interfb, costcenter_interfb, accountcode_sdin, visible_line_no, Dest_comp, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, retentionml, holdml, trnsfr_invoice_no, trnsfr_inv_no, trnsfr_inv_date, trnsfr_inv_ou, draft_bill_lineno, draft_bill_no, trnsfr_bill_date, draft_bill_ou, draft_bill_line_no, trnsfr_bill_lineno, location, region, partytype, partycode, line_of_business, department, product, equip_type, service_type, order_type, vehicle_type, activity_type, party_group, nature, currency, Owner_type, tariff_type, reimburs, ifb_recon_jvno, own_tax_region, party_tax_region, decl_tax_region, subservice_type, leg_behaviour, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, line_no, timestamp, expense, usage, uom, item_qty, item_rate, rate_per, item_amount, remarks, cost_center, analysis_code, subanalysis_code, base_value, createdby, createddate, modifiedby, modifieddate, accountcode, destou, destfb, destusageid, interfbjvno, accountcode_destusage, accountcode_interfb, analysis_code_dest, sub_analysis_code_dest, costcenter_dest, analysis_code_interfb, sub_analysis_code_interfb, costcenter_interfb, accountcode_sdin, visible_line_no, Dest_comp, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, retentionml, holdml, trnsfr_invoice_no, trnsfr_inv_no, trnsfr_inv_date, trnsfr_inv_ou, draft_bill_lineno, draft_bill_no, trnsfr_bill_date, draft_bill_ou, draft_bill_line_no, trnsfr_bill_lineno, location, region, partytype, partycode, line_of_business, department, product, equip_type, service_type, order_type, vehicle_type, activity_type, party_group, nature, currency, Owner_type, tariff_type, reimburs, ifb_recon_jvno, own_tax_region, party_tax_region, decl_tax_region, subservice_type, leg_behaviour, etlcreateddatetime
    FROM stg.stg_sdin_expense_dtl;
    
    END IF;
/*
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
	  */
END;
$$;