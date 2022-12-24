CREATE OR REPLACE PROCEDURE dwh.usp_f_lotmasterdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_lnm_lm_lotmaster;

    UPDATE dwh.f_lotmasterdetail t
    SET
        lot_mst_dtl_itm_hdr_key			= COALESCE(i.itm_hdr_key,-1),
		lot_mst_dtl_wh_key				= COALESCE(w.wh_key,-1),
        lm_trans_type                   = s.lm_trans_type,
        lm_trans_date                   = s.lm_trans_date,
        lm_manufacturing_date           = s.lm_manufacturing_date,
        lm_expiry_date                  = s.lm_expiry_date,
        lm_created_date                 = s.lm_created_date,
        lm_created_by                   = s.lm_created_by,
        lm_supp_batch_no                = s.lm_supp_batch_no,
        lm_asn_srl_no                   = s.wms_lm_asn_srl_no,
        lm_asn_uid                      = s.wms_lm_asn_uid,
        lm_asn_cust_sl_no               = s.wms_lm_asn_cust_sl_no,
        lm_asn_ref_doc_no1              = s.wms_lm_asn_ref_doc_no1,
        lm_asn_consignee                = s.wms_lm_asn_consignee,
        lm_asn_outboundorder_no         = s.wms_lm_asn_outboundorder_no,
        lm_asn_outboundorder_qty        = s.wms_lm_asn_outboundorder_qty,
        lm_asn_bestbeforedate           = s.wms_lm_asn_bestbeforedate,
        lm_asn_remarks                  = s.wms_lm_asn_remarks,
        lm_gr_plan_no                   = s.wms_lm_gr_plan_no,
        lm_gr_execution_date            = s.wms_lm_gr_execution_date,
        lm_exp_flg                      = s.wms_lm_exp_flg,
        lm_gr_cust_sno                  = s.wms_lm_gr_cust_sno,
        lm_gr_3pl_sno                   = s.wms_lm_gr_3pl_sno,
        lm_gr_warranty_sno              = s.wms_lm_gr_warranty_sno,
        lm_gr_coo                       = s.wms_lm_gr_coo,
        lm_gr_product_status            = s.wms_lm_gr_product_status,
        lm_gr_inv_type                  = s.wms_lm_gr_inv_type,
        lm_gr_item_attribute1           = s.wms_lm_gr_item_attribute1,
        lm_gr_item_attribute2           = s.wms_lm_gr_item_attribute2,
        lm_gr_item_attribute3           = s.wms_lm_gr_item_attribute3,
        lm_giftcard_sno                 = s.wms_lm_giftcard_sno,
        lm_gr_item_attribute7           = s.wms_lm_gr_item_attribute7,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_wms_lnm_lm_lotmaster s
    LEFT JOIN dwh.d_itemheader i 
		ON  s.lm_item_code				= i.itm_code
		AND s.lm_lotno_ou 				= i.itm_ou 
	LEFT JOIN dwh.d_warehouse w 
		ON  s.lm_wh_code				= w.wh_code
		AND s.lm_lotno_ou 				= w.wh_ou 
    WHERE 	t.lm_lotno_ou 				= s.lm_lotno_ou
    AND 	t.lm_wh_code 				= s.lm_wh_code
    AND 	t.lm_item_code 				= s.lm_item_code
    AND 	t.lm_lot_no 				= s.lm_lot_no
    AND 	t.lm_serial_no 				= s.lm_serial_no
    AND 	t.lm_trans_no	 			= s.lm_trans_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_lotmasterdetail
    (
        lot_mst_dtl_itm_hdr_key, lot_mst_dtl_wh_key,
        lm_lotno_ou, lm_wh_code, lm_item_code, lm_lot_no, lm_serial_no, lm_trans_no, lm_trans_type, lm_trans_date, lm_manufacturing_date, lm_expiry_date, lm_created_date, lm_created_by, lm_supp_batch_no, lm_asn_srl_no, lm_asn_uid, lm_asn_cust_sl_no, lm_asn_ref_doc_no1, lm_asn_consignee, lm_asn_outboundorder_no, lm_asn_outboundorder_qty, lm_asn_bestbeforedate, lm_asn_remarks, lm_gr_plan_no, lm_gr_execution_date, lm_exp_flg, lm_gr_cust_sno, lm_gr_3pl_sno, lm_gr_warranty_sno, lm_gr_coo, lm_gr_product_status, lm_gr_inv_type, lm_gr_item_attribute1, lm_gr_item_attribute2, lm_gr_item_attribute3, lm_giftcard_sno, lm_gr_item_attribute7, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(i.itm_hdr_key,-1), COALESCE(w.wh_key,-1),
        s.lm_lotno_ou, s.lm_wh_code, s.lm_item_code, s.lm_lot_no, s.lm_serial_no, s.lm_trans_no, s.lm_trans_type, s.lm_trans_date, s.lm_manufacturing_date, s.lm_expiry_date, s.lm_created_date, s.lm_created_by, s.lm_supp_batch_no, s.wms_lm_asn_srl_no, s.wms_lm_asn_uid, s.wms_lm_asn_cust_sl_no, s.wms_lm_asn_ref_doc_no1, s.wms_lm_asn_consignee, s.wms_lm_asn_outboundorder_no, s.wms_lm_asn_outboundorder_qty, s.wms_lm_asn_bestbeforedate, s.wms_lm_asn_remarks, s.wms_lm_gr_plan_no, s.wms_lm_gr_execution_date, s.wms_lm_exp_flg, s.wms_lm_gr_cust_sno, s.wms_lm_gr_3pl_sno, s.wms_lm_gr_warranty_sno, s.wms_lm_gr_coo, s.wms_lm_gr_product_status, s.wms_lm_gr_inv_type, s.wms_lm_gr_item_attribute1, s.wms_lm_gr_item_attribute2, s.wms_lm_gr_item_attribute3, s.wms_lm_giftcard_sno, s.wms_lm_gr_item_attribute7, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_lnm_lm_lotmaster s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.lm_item_code				= i.itm_code
		AND s.lm_lotno_ou 				= i.itm_ou 
	LEFT JOIN dwh.d_warehouse w 
		ON  s.lm_wh_code				= w.wh_code
		AND s.lm_lotno_ou 				= w.wh_ou 
    LEFT JOIN dwh.f_lotmasterdetail t
    ON 		s.lm_lotno_ou 				= t.lm_lotno_ou
    AND 	s.lm_wh_code 				= t.lm_wh_code
    AND 	s.lm_item_code	 			= t.lm_item_code
    AND 	s.lm_lot_no 				= t.lm_lot_no
    AND 	s.lm_serial_no 				= t.lm_serial_no
    AND 	s.lm_trans_no 				= t.lm_trans_no
    WHERE t.lm_lotno_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_lnm_lm_lotmaster
    (
        lm_lotno_ou, lm_wh_code, lm_item_code, lm_lot_no, lm_serial_no, lm_trans_no, lm_trans_type, lm_trans_date, lm_manufacturing_date, lm_expiry_date, lm_created_date, lm_created_by, lm_supp_batch_no, wms_lm_asn_srl_no, wms_lm_asn_uid, wms_lm_asn_cust_sl_no, wms_lm_asn_ref_doc_no1, wms_lm_asn_consignee, wms_lm_asn_outboundorder_no, wms_lm_asn_outboundorder_qty, wms_lm_asn_outboundorder_lineno, wms_lm_asn_bestbeforedate, wms_lm_asn_remarks, wms_lm_gr_plan_no, wms_lm_gr_execution_date, wms_lm_exp_flg, wms_lm_gr_cust_sno, wms_lm_gr_3pl_sno, wms_lm_gr_warranty_sno, wms_lm_gr_coo, wms_lm_gr_product_status, wms_lm_gr_inv_type, wms_lm_gr_item_attribute1, wms_lm_gr_item_attribute2, wms_lm_gr_item_attribute3, wms_lm_gr_item_attribute4, wms_lm_gr_item_attribute5, wms_lm_giftcard_sno, wms_lm_gr_item_attribute6, wms_lm_gr_item_attribute7, wms_lm_gr_item_attribute8, wms_lm_gr_item_attribute9, wms_lm_gr_item_attribute10, wms_lm_new_lottables1, wms_lm_new_lottables2, wms_lm_new_lottables3, wms_lm_new_lottables4, wms_lm_new_lottables5, wms_lm_new_lottables6, wms_lm_new_lottables7, wms_lm_new_lottables8, wms_lm_new_lottables9, wms_lm_new_lottables10, etlcreateddatetime
    )
    SELECT
        lm_lotno_ou, lm_wh_code, lm_item_code, lm_lot_no, lm_serial_no, lm_trans_no, lm_trans_type, lm_trans_date, lm_manufacturing_date, lm_expiry_date, lm_created_date, lm_created_by, lm_supp_batch_no, wms_lm_asn_srl_no, wms_lm_asn_uid, wms_lm_asn_cust_sl_no, wms_lm_asn_ref_doc_no1, wms_lm_asn_consignee, wms_lm_asn_outboundorder_no, wms_lm_asn_outboundorder_qty, wms_lm_asn_outboundorder_lineno, wms_lm_asn_bestbeforedate, wms_lm_asn_remarks, wms_lm_gr_plan_no, wms_lm_gr_execution_date, wms_lm_exp_flg, wms_lm_gr_cust_sno, wms_lm_gr_3pl_sno, wms_lm_gr_warranty_sno, wms_lm_gr_coo, wms_lm_gr_product_status, wms_lm_gr_inv_type, wms_lm_gr_item_attribute1, wms_lm_gr_item_attribute2, wms_lm_gr_item_attribute3, wms_lm_gr_item_attribute4, wms_lm_gr_item_attribute5, wms_lm_giftcard_sno, wms_lm_gr_item_attribute6, wms_lm_gr_item_attribute7, wms_lm_gr_item_attribute8, wms_lm_gr_item_attribute9, wms_lm_gr_item_attribute10, wms_lm_new_lottables1, wms_lm_new_lottables2, wms_lm_new_lottables3, wms_lm_new_lottables4, wms_lm_new_lottables5, wms_lm_new_lottables6, wms_lm_new_lottables7, wms_lm_new_lottables8, wms_lm_new_lottables9, wms_lm_new_lottables10, etlcreateddatetime
    FROM stg.stg_wms_lnm_lm_lotmaster;
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