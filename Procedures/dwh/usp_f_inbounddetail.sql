-- PROCEDURE: dwh.usp_f_inbounddetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_inbounddetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_inbounddetail(
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
	p_depsource VARCHAR(100);

    p_rawstorageflag integer;

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
    FROM stg.stg_wms_inbound_item_detail;

    UPDATE dwh.F_InboundDetail t
    SET
         inb_hdr_key                    = oh.inb_hdr_key,
         inb_itm_dtl_loc_key            = COALESCE(l.loc_key,-1),
        inb_itm_dtl_itm_hdr_key        = COALESCE(i.itm_hdr_key,-1),    
        inb_item_code              = s.wms_inb_item_code,
        inb_order_qty              = s.wms_inb_order_qty,
        inb_alt_uom                = s.wms_inb_alt_uom,
        inb_sch_type               = s.wms_inb_sch_type,
        inb_receipt_date           = s.wms_inb_receipt_date,
        inb_item_inst              = s.wms_inb_item_inst,
        inb_supp_code              = s.wms_inb_supp_code,
        inb_balqty                 = s.wms_inb_balqty,
        inb_linestatus             = s.wms_inb_linestatus,
        inb_recdqty                = s.wms_inb_recdqty,
        inb_accpdqty               = s.wms_inb_accpdqty,
        inb_itm_grrejdqty          = s.wms_inb_itm_grrejdqty,
        inb_master_uom_qty         = s.wms_inb_master_uom_qty,
        inb_Stock_status           = s.wms_inb_Stock_status,
        inb_itm_cust               = s.wms_inb_itm_cust,
        inb_cust_po_lineno         = s.wms_inb_cust_po_lineno,
        inb_batch_no               = s.wms_inb_batch_no,
        inb_oe_serial_no           = s.wms_inb_oe_serial_no,
        inb_expiry_date            = s.wms_inb_expiry_date,
        inb_manu_date              = s.wms_inb_manu_date,
        inb_thu_id                 = s.wms_inb_thu_id,
        inb_thu_qty                = s.wms_inb_thu_qty,
        inb_user_def_1             = s.wms_inb_user_def_1,
        inb_user_def_2             = s.wms_inb_user_def_2,
        inb_user_def_3             = s.wms_inb_user_def_3,
        inb_lottable1              = s.wms_inb_lottable1,
        inb_lottable2              = s.wms_inb_lottable2,
        inb_lottable3              = s.wms_inb_lottable3,
        inb_lottable6              = s.wms_inb_lottable6,
        inb_lottable7              = s.wms_inb_lottable7,
        inb_lottable9              = s.wms_inb_lottable9,
        inb_component              = s.wms_inb_component,
        asn_Kit_item_lineno        = s.wms_asn_Kit_item_lineno,
        asn_lineno                 = s.wms_asn_lineno,
        asn_item_po_lineno         = s.wms_asn_item_po_lineno,
        inb_uid1                   = s.wms_inb_uid1,
        inb_item_attribute7        = s.wms_inb_item_attribute7,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_wms_inbound_item_detail s
	
	INNER JOIN dwh.f_inboundheader oh
     ON  s.wms_inb_loc_code = oh.inb_loc_code  
     and s.wms_inb_orderno =oh.inb_orderno 
     and s.wms_inb_ou = oh.inb_ou

    LEFT JOIN dwh.d_location l      
        ON  s.wms_inb_loc_code           = l.loc_code 
        AND s.wms_inb_ou            = l.loc_ou      
    LEFT JOIN dwh.d_itemheader i        
        ON  s.wms_inb_item_code               = i.itm_code 
        AND s.wms_inb_ou            = i.itm_ou  

    WHERE t.inb_loc_code = s.wms_inb_loc_code
    AND t.inb_orderno = s.wms_inb_orderno
    AND t.inb_lineno = s.wms_inb_lineno
    AND t.inb_ou = s.wms_inb_ou
    AND  t.inb_hdr_key  = oh.inb_hdr_key;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_InboundDetail
    (
        inb_hdr_key, inb_itm_dtl_loc_key, inb_itm_dtl_itm_hdr_key, inb_loc_code, inb_orderno, inb_lineno, inb_ou, inb_item_code, inb_order_qty, inb_alt_uom, inb_sch_type, inb_receipt_date, inb_item_inst, inb_supp_code, inb_balqty, inb_linestatus, inb_recdqty, inb_accpdqty, inb_itm_grrejdqty, inb_master_uom_qty, inb_Stock_status, inb_itm_cust, inb_cust_po_lineno, inb_batch_no, inb_oe_serial_no, inb_expiry_date, inb_manu_date, inb_thu_id, inb_thu_qty, inb_user_def_1, inb_user_def_2, inb_user_def_3, inb_lottable1, inb_lottable2, inb_lottable3, inb_lottable6, inb_lottable7, inb_lottable9, inb_component, asn_Kit_item_lineno, asn_lineno, asn_item_po_lineno, inb_uid1, inb_item_attribute7, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        oh.inb_hdr_key , COALESCE(l.loc_key,-1),COALESCE(i.itm_hdr_key,-1),s.wms_inb_loc_code, s.wms_inb_orderno, s.wms_inb_lineno, s.wms_inb_ou, s.wms_inb_item_code, s.wms_inb_order_qty, s.wms_inb_alt_uom, s.wms_inb_sch_type, s.wms_inb_receipt_date, s.wms_inb_item_inst, s.wms_inb_supp_code, s.wms_inb_balqty, s.wms_inb_linestatus, s.wms_inb_recdqty, s.wms_inb_accpdqty, s.wms_inb_itm_grrejdqty, s.wms_inb_master_uom_qty, s.wms_inb_Stock_status, s.wms_inb_itm_cust, s.wms_inb_cust_po_lineno, s.wms_inb_batch_no, s.wms_inb_oe_serial_no, s.wms_inb_expiry_date, s.wms_inb_manu_date, s.wms_inb_thu_id, s.wms_inb_thu_qty, s.wms_inb_user_def_1, s.wms_inb_user_def_2, s.wms_inb_user_def_3, s.wms_inb_lottable1, s.wms_inb_lottable2, s.wms_inb_lottable3, s.wms_inb_lottable6, s.wms_inb_lottable7, s.wms_inb_lottable9, s.wms_inb_component, s.wms_asn_Kit_item_lineno, s.wms_asn_lineno, s.wms_asn_item_po_lineno, s.wms_inb_uid1, s.wms_inb_item_attribute7, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_inbound_item_detail s
	
	INNER JOIN dwh.f_inboundheader oh
     ON  s.wms_inb_loc_code = oh.inb_loc_code  
     and s.wms_inb_orderno =oh.inb_orderno 
     and s.wms_inb_ou = oh.inb_ou
	 
    LEFT JOIN dwh.d_location l      
        ON  s.wms_inb_loc_code           = l.loc_code 
        AND s.wms_inb_ou            = l.loc_ou      
    LEFT JOIN dwh.d_itemheader i        
        ON  s.wms_inb_item_code               = i.itm_code 
        AND s.wms_inb_ou            = i.itm_ou  

    LEFT JOIN dwh.F_InboundDetail t
    ON s.wms_inb_loc_code = t.inb_loc_code
    AND s.wms_inb_orderno = t.inb_orderno
    AND s.wms_inb_lineno = t.inb_lineno
    AND s.wms_inb_ou = t.inb_ou
	AND  t.inb_hdr_key  = oh.inb_hdr_key
    WHERE t.inb_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_inbound_item_detail
    (
        wms_inb_loc_code, wms_inb_orderno, wms_inb_lineno, wms_inb_ou, wms_inb_item_code, wms_inb_order_qty, wms_inb_alt_uom, wms_inb_sch_type, wms_inb_receipt_date, wms_inb_item_inst, wms_inb_supp_code, wms_inb_addressid, wms_inb_balqty, wms_inb_linestatus, wms_inb_recdqty, wms_inb_accpdqty, wms_inb_returnedqty, wms_inb_itm_grrejdqty, wms_inb_itm_grmovdqty, wms_inb_operation_status, wms_inb_cust_item_code, wms_inb_master_uom_qty, wms_inb_Stock_status, wms_inb_itm_cust, wms_inb_cust_po_lineno, wms_inb_batch_no, wms_inb_oe_serial_no, wms_inb_wr_serial_no, wms_inb_expiry_date, wms_inb_manu_date, wms_inb_best_before_date, wms_inb_thu_id, wms_inb_thu_desc, wms_inb_thu_qty, wms_inb_user_def_1, wms_inb_user_def_2, wms_inb_user_def_3, wms_inb_lottable1, wms_inb_lottable2, wms_inb_lottable3, wms_inb_lottable4, wms_inb_lottable5, wms_inb_lottable6, wms_inb_lottable7, wms_inb_lottable8, wms_inb_lottable9, wms_inb_lottable10, wms_inb_component, wms_inb_retnlabl_bil_status, wms_inb_retnhand_bil_status, wms_asn_Kit_item_lineno, wms_asn_lineno, wms_asn_item_po_lineno, wms_inb_su1, wms_inb_uid1, wms_inb_su2, wms_inb_uid2, wms_inb_hilnitgr_bil_status, wms_inb_item_attribute1, wms_inb_item_attribute2, wms_inb_item_attribute3, wms_inb_item_attribute4, wms_inb_item_attribute5, wms_inb_item_attribute6, wms_inb_item_attribute7, wms_inb_item_attribute8, wms_inb_item_attribute9, wms_inb_item_attribute10, etlcreateddatetime
    )
    SELECT
        wms_inb_loc_code, wms_inb_orderno, wms_inb_lineno, wms_inb_ou, wms_inb_item_code, wms_inb_order_qty, wms_inb_alt_uom, wms_inb_sch_type, wms_inb_receipt_date, wms_inb_item_inst, wms_inb_supp_code, wms_inb_addressid, wms_inb_balqty, wms_inb_linestatus, wms_inb_recdqty, wms_inb_accpdqty, wms_inb_returnedqty, wms_inb_itm_grrejdqty, wms_inb_itm_grmovdqty, wms_inb_operation_status, wms_inb_cust_item_code, wms_inb_master_uom_qty, wms_inb_Stock_status, wms_inb_itm_cust, wms_inb_cust_po_lineno, wms_inb_batch_no, wms_inb_oe_serial_no, wms_inb_wr_serial_no, wms_inb_expiry_date, wms_inb_manu_date, wms_inb_best_before_date, wms_inb_thu_id, wms_inb_thu_desc, wms_inb_thu_qty, wms_inb_user_def_1, wms_inb_user_def_2, wms_inb_user_def_3, wms_inb_lottable1, wms_inb_lottable2, wms_inb_lottable3, wms_inb_lottable4, wms_inb_lottable5, wms_inb_lottable6, wms_inb_lottable7, wms_inb_lottable8, wms_inb_lottable9, wms_inb_lottable10, wms_inb_component, wms_inb_retnlabl_bil_status, wms_inb_retnhand_bil_status, wms_asn_Kit_item_lineno, wms_asn_lineno, wms_asn_item_po_lineno, wms_inb_su1, wms_inb_uid1, wms_inb_su2, wms_inb_uid2, wms_inb_hilnitgr_bil_status, wms_inb_item_attribute1, wms_inb_item_attribute2, wms_inb_item_attribute3, wms_inb_item_attribute4, wms_inb_item_attribute5, wms_inb_item_attribute6, wms_inb_item_attribute7, wms_inb_item_attribute8, wms_inb_item_attribute9, wms_inb_item_attribute10, etlcreateddatetime
    FROM stg.stg_wms_inbound_item_detail;
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

   EXCEPTION
        WHEN others THEN
        get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt; 
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_inbounddetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
