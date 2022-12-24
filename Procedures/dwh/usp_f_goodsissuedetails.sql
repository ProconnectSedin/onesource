CREATE OR REPLACE PROCEDURE dwh.usp_f_goodsissuedetails(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(*) INTO srccnt
    FROM stg.stg_wms_goods_issue_dtl;

    UPDATE dwh.F_GoodsIssueDetails t
    SET

        gi_loc_key     = COALESCE(l.loc_key,-1),    
        gi_status = s.wms_gi_status,
        gi_date = s.wms_gi_date,
        gi_execution_no = s.wms_gi_execution_no,
        gi_execution_stage = s.wms_gi_execution_stage,
        gi_outbound_date = s.wms_gi_outbound_date,
        gi_customer_id = s.wms_gi_customer_id,
        gi_prim_ref_doc_no = s.wms_gi_prim_ref_doc_no,
        gi_prim_ref_doc_date = s.wms_gi_prim_ref_doc_date,
        gi_outbound_ord_line_no = s.wms_gi_outbound_ord_line_no,
        gi_outbound_ord_sch_no = s.wms_gi_outbound_ord_sch_no,
        gi_outbound_ord_item = s.wms_gi_outbound_ord_item,
        gi_issue_qty = s.wms_gi_issue_qty,
        gi_lot_no = s.wms_gi_lot_no,
        gi_item_serial_no = s.wms_gi_item_serial_no,
        gi_sup_batch_no = s.wms_gi_sup_batch_no,
        gi_mfg_date = s.wms_gi_mfg_date,
        gi_exp_date = s.wms_gi_exp_date,
        gi_item_status = s.wms_gi_item_status,
        gi_su = s.wms_gi_su,
        gi_su_type = s.wms_gi_su_type,
        gi_su_serial_no = s.wms_gi_su_serial_no,
        gi_created_date = s.wms_gi_created_date,
        gi_created_by = s.wms_gi_created_by,
        gi_tolerance_qty = s.wms_gi_tolerance_qty,
        gi_stock_status = s.wms_gi_stock_status,
        etlactiveind = 1,
        etljobname = p_etljobname,
        envsourcecd = p_envsourcecd ,
        datasourcecd = p_datasourcecd ,
        etlupdatedatetime = NOW()    
    FROM stg.stg_wms_goods_issue_dtl s
     LEFT JOIN dwh.d_location L         
        ON s.wms_gi_loc_code   = L.loc_code 
        AND s.wms_gi_ou          = L.loc_ou


    WHERE t.gi_no = s.wms_gi_no
    AND   t.gi_ou = s.wms_gi_ou
    AND   t.gi_loc_code = s.wms_gi_loc_code
    AND   t.gi_outbound_ord_no = s.wms_gi_outbound_ord_no
    AND   t.gi_line_no = s.wms_gi_line_no;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_GoodsIssueDetails 
    (
          gi_loc_key,gi_no, gi_ou, gi_status, gi_loc_code, gi_outbound_ord_no, gi_line_no, gi_date, gi_execution_no, gi_execution_stage, gi_outbound_date, gi_customer_id, gi_prim_ref_doc_no, gi_prim_ref_doc_date, gi_outbound_ord_line_no, gi_outbound_ord_sch_no, gi_outbound_ord_item, gi_issue_qty, gi_lot_no, gi_item_serial_no, gi_sup_batch_no, gi_mfg_date, gi_exp_date, gi_item_status, gi_su, gi_su_type, gi_su_serial_no, gi_created_date, gi_created_by, gi_tolerance_qty, gi_stock_status, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )
    
    SELECT
          COALESCE(l.loc_key,-1),s.wms_gi_no, s.wms_gi_ou, s.wms_gi_status, s.wms_gi_loc_code, s.wms_gi_outbound_ord_no, s.wms_gi_line_no, s.wms_gi_date, s.wms_gi_execution_no, s.wms_gi_execution_stage, s.wms_gi_outbound_date, s.wms_gi_customer_id, s.wms_gi_prim_ref_doc_no, s.wms_gi_prim_ref_doc_date, s.wms_gi_outbound_ord_line_no, s.wms_gi_outbound_ord_sch_no, s.wms_gi_outbound_ord_item, s.wms_gi_issue_qty, s.wms_gi_lot_no, s.wms_gi_item_serial_no, s.wms_gi_sup_batch_no, s.wms_gi_mfg_date, s.wms_gi_exp_date, s.wms_gi_item_status, s.wms_gi_su, s.wms_gi_su_type, s.wms_gi_su_serial_no, s.wms_gi_created_date, s.wms_gi_created_by, s.wms_gi_tolerance_qty, s.wms_gi_stock_status, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_goods_issue_dtl s

        LEFT JOIN dwh.d_location L         
        ON s.wms_gi_loc_code   = L.loc_code 
        AND s.wms_gi_ou          = L.loc_ou


    LEFT JOIN dwh.F_GoodsIssueDetails t
    ON s.wms_gi_no = t.gi_no
    AND s.wms_gi_ou = t.gi_ou
    AND s.wms_gi_loc_code = t.gi_loc_code
    AND s.wms_gi_outbound_ord_no = t.gi_outbound_ord_no
    AND s.wms_gi_line_no = t.gi_line_no
    WHERE t.gi_no IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_goods_issue_dtl
    (   
        wms_gi_no, wms_gi_ou, wms_gi_status, wms_gi_loc_code, wms_gi_outbound_ord_no, wms_gi_line_no, wms_gi_date, wms_gi_execution_no, wms_gi_execution_stage, wms_gi_outbound_date, wms_gi_customer_id, wms_gi_prim_ref_doc_no, wms_gi_prim_ref_doc_date, wms_gi_outbound_ord_line_no, wms_gi_outbound_ord_sch_no, wms_gi_outbound_ord_item, wms_gi_issue_qty, wms_gi_lot_no, wms_gi_item_serial_no, wms_gi_sup_batch_no, wms_gi_wh_batch_no, wms_gi_mfg_date, wms_gi_exp_date, wms_gi_item_status, wms_gi_su, wms_gi_su_type, wms_gi_su_serial_no, wms_gi_created_date, wms_gi_created_by, wms_gi_modified_date, wms_gi_modified_by, wms_gi_billing_status, wms_gi_bill_value, wms_gi_tolerance_qty, wms_gi_hdochpvl_bil_status, wms_gi_lblcthut_bil_status, wms_gi_hdofsupk_bil_status, wms_gi_stock_status
    )
    SELECT 
        wms_gi_no, wms_gi_ou, wms_gi_status, wms_gi_loc_code, wms_gi_outbound_ord_no, wms_gi_line_no, wms_gi_date, wms_gi_execution_no, wms_gi_execution_stage, wms_gi_outbound_date, wms_gi_customer_id, wms_gi_prim_ref_doc_no, wms_gi_prim_ref_doc_date, wms_gi_outbound_ord_line_no, wms_gi_outbound_ord_sch_no, wms_gi_outbound_ord_item, wms_gi_issue_qty, wms_gi_lot_no, wms_gi_item_serial_no, wms_gi_sup_batch_no, wms_gi_wh_batch_no, wms_gi_mfg_date, wms_gi_exp_date, wms_gi_item_status, wms_gi_su, wms_gi_su_type, wms_gi_su_serial_no, wms_gi_created_date, wms_gi_created_by, wms_gi_modified_date, wms_gi_modified_by, wms_gi_billing_status, wms_gi_bill_value, wms_gi_tolerance_qty, wms_gi_hdochpvl_bil_status, wms_gi_lblcthut_bil_status, wms_gi_hdofsupk_bil_status, wms_gi_stock_status
    FROM stg.stg_wms_goods_issue_dtl;
    END IF;  
    
    EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);
    
        
       select 0 into inscnt;
       select 0 into updcnt;   
       
    
    
END;
$$;