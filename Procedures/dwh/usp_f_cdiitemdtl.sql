CREATE OR REPLACE PROCEDURE dwh.usp_f_cdiitemdtl(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_cdi_item_dtl;

    UPDATE dwh.F_cdiitemdtl t
    SET
        uom_key						= COALESCE(u.uom_key,-1),
        ctimestamp                	= s.ctimestamp,
        visible_line_no           	= s.visible_line_no,
        item_tcd_code             	= s.item_tcd_code,
        item_tcd_var              	= s.item_tcd_var,
        usage_id                  	= s.usage_id,
        item_type                 	= s.item_type,
        uom                       	= s.uom,
        item_qty                  	= s.item_qty,
        unit_price                	= s.unit_price,
        base_value                	= s.base_value,
        item_amount               	= s.item_amount,
        line_amount               	= s.line_amount,
        base_amount               	= s.base_amount,
        sale_purpose              	= s.sale_purpose,
        alloc_method              	= s.alloc_method,
        attr_alloc                	= s.attr_alloc,
        proposal_no               	= s.proposal_no,
        ship_to_cust              	= s.ship_to_cust,
        ship_to_id                	= s.ship_to_id,
        remarks                   	= s.remarks,
        cost_center               	= s.cost_center,
        createdby                 	= s.createdby,
        createddate               	= s.createddate,
        modifiedby                	= s.modifiedby,
        modifieddate              	= s.modifieddate,
        item_desc                 	= s.item_desc,
        usage_desc                	= s.usage_desc,
        draft_bill_line_no        	= s.draft_bill_line_no,
        nature                    	= s.nature,
        draft_bill_no             	= s.draft_bill_no,
        line_account              	= s.line_account,
        own_tax_region            	= s.own_tax_region,
        decl_tax_region           	= s.decl_tax_region,
        party_tax_region          	= s.party_tax_region,
        etlactiveind              	= 1,
        etljobname                	= p_etljobname,
        envsourcecd               	= p_envsourcecd,
        datasourcecd              	= p_datasourcecd,
        etlupdatedatetime         	= NOW()
    FROM stg.stg_cdi_item_dtl s
	LEFT JOIN dwh.d_uom u
		ON  s.uom					= u.mas_uomcode
		AND s.tran_ou				= u.mas_ouinstance	
    WHERE t.tran_type 				= s.tran_type
    AND t.tran_ou 					= s.tran_ou
    AND t.tran_no 					= s.tran_no
    AND t.line_no 					= s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_cdiitemdtl
    (
        uom_key, tran_type, tran_ou, tran_no, line_no, ctimestamp, visible_line_no, item_tcd_code, item_tcd_var, usage_id, item_type, uom, item_qty, unit_price, base_value, item_amount, line_amount, base_amount, sale_purpose, alloc_method, attr_alloc, proposal_no, ship_to_cust, ship_to_id, remarks, cost_center, createdby, createddate, modifiedby, modifieddate, item_desc, usage_desc, draft_bill_line_no, nature, draft_bill_no, line_account, own_tax_region, decl_tax_region, party_tax_region, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(u.uom_key,-1), s.tran_type, s.tran_ou, s.tran_no, s.line_no, s.ctimestamp, s.visible_line_no, s.item_tcd_code, s.item_tcd_var, s.usage_id, s.item_type, s.uom, s.item_qty, s.unit_price, s.base_value, s.item_amount, s.line_amount, s.base_amount, s.sale_purpose, s.alloc_method, s.attr_alloc, s.proposal_no, s.ship_to_cust, s.ship_to_id, s.remarks, s.cost_center, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.item_desc, s.usage_desc, s.draft_bill_line_no, s.nature, s.draft_bill_no, s.line_account, s.own_tax_region, s.decl_tax_region, s.party_tax_region, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_cdi_item_dtl s
	LEFT JOIN dwh.d_uom u
		ON  s.uom					= u.mas_uomcode
		AND s.tran_ou				= u.mas_ouinstance	
    LEFT JOIN dwh.F_cdiitemdtl t
    ON s.tran_type = t.tran_type
    AND s.tran_ou = t.tran_ou
    AND s.tran_no = t.tran_no
    AND s.line_no = t.line_no
    WHERE t.tran_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cdi_item_dtl
    (
        tran_type, tran_ou, tran_no, line_no, ctimestamp, visible_line_no, item_tcd_code, item_tcd_var, usage_id, item_type, uom, item_qty, unit_price, base_value, item_amount, tax_amount, disc_amount, line_amount, base_amount, par_base_amount, sale_purpose, warehouse_code, alloc_method, attr_alloc, proposal_no, shipping_ou, ship_to_cust, ship_to_id, packslip_no, packslip_ou, packslip_line_no, remarks, cost_center, analysis_code, subanalysis_code, createdby, createddate, modifiedby, modifieddate, item_desc, cdi_sales_person, cdi_sales_team, alt_uom, alt_tran_qty, usage_desc, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, draft_bill_date, draft_bill_line_no, trnsfr_bill_lineno, location, region, partytype, partycode, line_of_business, department, product, equip_type, service_type, order_type, vehicle_type, activity_type, party_group, nature, currency, draft_bill_no, draft_bill_ref_docno, dest_comp, dest_ou, dest_fbid, dest_costcenter, dest_analysis_code, dest_sub_analysis_code, dest_usageid, Intrfb_jv_no, accountcode_destusage, accountcode_interfb, accountcode_cdi, line_account, fbidml, zoneml, binml, dpi_agreedprice, orginal_item_value, serviceitem, ifb_recon_jvno, own_tax_region, decl_tax_region, party_tax_region, BILLINGPRDFROM, BILLINGPRDTO, BILLINGMILESTONE, MILESTONEDESC, ORDERBOOK_CURRENCY, BILL_LINE_NO, BILL_SCH_SLNO, etlcreateddatetime
    )
    SELECT
        tran_type, tran_ou, tran_no, line_no, ctimestamp, visible_line_no, item_tcd_code, item_tcd_var, usage_id, item_type, uom, item_qty, unit_price, base_value, item_amount, tax_amount, disc_amount, line_amount, base_amount, par_base_amount, sale_purpose, warehouse_code, alloc_method, attr_alloc, proposal_no, shipping_ou, ship_to_cust, ship_to_id, packslip_no, packslip_ou, packslip_line_no, remarks, cost_center, analysis_code, subanalysis_code, createdby, createddate, modifiedby, modifieddate, item_desc, cdi_sales_person, cdi_sales_team, alt_uom, alt_tran_qty, usage_desc, cfs_refdoc_ou, cfs_refdoc_no, cfs_refdoc_type, draft_bill_date, draft_bill_line_no, trnsfr_bill_lineno, location, region, partytype, partycode, line_of_business, department, product, equip_type, service_type, order_type, vehicle_type, activity_type, party_group, nature, currency, draft_bill_no, draft_bill_ref_docno, dest_comp, dest_ou, dest_fbid, dest_costcenter, dest_analysis_code, dest_sub_analysis_code, dest_usageid, Intrfb_jv_no, accountcode_destusage, accountcode_interfb, accountcode_cdi, line_account, fbidml, zoneml, binml, dpi_agreedprice, orginal_item_value, serviceitem, ifb_recon_jvno, own_tax_region, decl_tax_region, party_tax_region, BILLINGPRDFROM, BILLINGPRDTO, BILLINGMILESTONE, MILESTONEDESC, ORDERBOOK_CURRENCY, BILL_LINE_NO, BILL_SCH_SLNO, etlcreateddatetime
    FROM stg.stg_cdi_item_dtl;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;