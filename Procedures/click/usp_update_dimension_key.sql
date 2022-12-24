CREATE OR REPLACE PROCEDURE click.usp_update_dimension_key()
    LANGUAGE plpgsql
    AS $$

BEGIN

UPDATE dwh.f_goodsreceiptitemdetails t
SET    gr_itm_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1),
       gr_item = Trim(t.gr_item)
FROM   dwh.d_itemheader i
WHERE  Trim(t.gr_item) = i.itm_code
       AND t.gr_exec_ou = i.itm_ou
       AND t.gr_itm_dtl_itm_hdr_key = -1;

UPDATE dwh.f_putawayplanitemdetail t
SET    pway_pln_itm_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.pway_item = i.itm_code
       AND t.pway_pln_ou = i.itm_ou
       AND t.pway_pln_itm_dtl_itm_hdr_key = -1;

UPDATE dwh.f_binexecitemdetail t
SET    bin_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.bin_item = i.itm_code
       AND t.bin_exec_ou = i.itm_ou
       AND t.bin_itm_hdr_key = -1;

UPDATE dwh.f_binexecdetail t
SET    bin_exec_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.bin_item = i.itm_code
       AND t.bin_exec_ou = i.itm_ou
       AND t.bin_exec_itm_hdr_key = -1;

UPDATE dwh.f_putawaybincapacity t
SET    pway_bin_cap_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.pway_item = i.itm_code
       AND t.pway_pln_ou = i.itm_ou
       AND t.pway_bin_cap_itm_hdr_key = -1;

UPDATE dwh.f_allocitemdetailshistory t
SET    allc_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.allc_item_code = i.itm_code
       AND t.allc_ouinstid = i.itm_ou
       AND t.allc_itm_hdr_key = -1;

UPDATE dwh.f_asndetails t
SET    asn_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.asn_itm_code = i.itm_code
       AND t.asn_ou = i.itm_ou
       AND t.asn_dtl_itm_hdr_key = -1;

UPDATE dwh.f_draftbillexecdetail t
SET    draft_bill_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.exec_item_code = i.itm_code
       AND t.exec_ou = i.itm_ou
       AND t.draft_bill_itm_hdr_key = -1;

UPDATE dwh.f_gritemtrackingdetail t
SET    gr_itm_tk_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.stk_item = i.itm_code
       AND t.stk_ou = i.itm_ou
       AND t.gr_itm_tk_dtl_itm_hdr_key = -1;

UPDATE dwh.f_grthulotdetail t
SET    gr_lot_thu_item_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.gr_item_code = i.itm_code
       AND t.gr_exec_ou = i.itm_ou
       AND t.gr_lot_thu_item_key = -1;

UPDATE dwh.f_inbounddetail t
SET    inb_itm_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.inb_item_code = i.itm_code
       AND t.inb_ou = i.itm_ou
       AND t.inb_itm_dtl_itm_hdr_key = -1;

UPDATE dwh.f_inbounditemamenddetail t
SET    inb_itm_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.inb_item_code = i.itm_code
       AND t.inb_ou = i.itm_ou
       AND t.inb_itm_key = -1;

UPDATE dwh.f_inboundscheduleitemamenddetail t
SET    inb_itm_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.inb_item_code = i.itm_code
       AND t.inb_ou = i.itm_ou
       AND t.inb_itm_key = -1;

UPDATE dwh.f_inboundscheduleitemdetail t
SET    inb_itm_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.inb_item_code = i.itm_code
       AND t.inb_ou = i.itm_ou
       AND t.inb_itm_key = -1;

UPDATE dwh.f_itemallocdetail t
SET    allc_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.allc_item_code = i.itm_code
       AND t.allc_ouinstid = i.itm_ou
       AND t.allc_itm_hdr_key = -1;

UPDATE dwh.f_lotmasterdetail t
SET    lot_mst_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.lm_item_code = i.itm_code
       AND t.lm_lotno_ou = i.itm_ou
       AND t.lot_mst_dtl_itm_hdr_key = -1;

UPDATE dwh.f_lottrackingdetail t
SET    stk_item_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.stk_item = i.itm_code
       AND t.stk_ou = i.itm_ou
       AND t.stk_item_key = -1;

UPDATE dwh.f_outbounditemdetail t
SET    obd_itm_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.oub_item_code = i.itm_code
       AND t.oub_itm_ou = i.itm_ou
       AND t.obd_itm_key = -1;

UPDATE dwh.f_outboundlotsrldetail t
SET    oub_itm_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.oub_item_code = i.itm_code
       AND t.oub_lotsl_ou = i.itm_ou
       AND t.oub_itm_key = -1;

UPDATE dwh.f_outboundschdetail t
SET    oub_itm_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.oub_sch_item_code = i.itm_code
       AND t.oub_sch_ou = i.itm_ou
       AND t.oub_itm_key = -1;

UPDATE dwh.f_pickplandetails t
SET    pick_pln_item_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.pick_item_code = i.itm_code
       AND t.pick_pln_ou = i.itm_ou
       AND t.pick_pln_item_key = -1;

UPDATE dwh.f_putawayitemdetail t
SET    pway_itm_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.pway_item = i.itm_code
       AND t.pway_exec_ou = i.itm_ou
       AND t.pway_itm_dtl_itm_hdr_key = -1;

UPDATE dwh.f_stockbalanceseriallevel t
SET    sbs_level_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.sbs_item_code = i.itm_code
       AND t.sbs_ouinstid = i.itm_ou
       AND t.sbs_level_itm_hdr_key = -1;

UPDATE dwh.f_stockbalancestorageunitlotlevel t
SET    sbl_lot_level_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.sbl_item_code = i.itm_code
       AND t.sbl_ouinstid = i.itm_ou
       AND t.sbl_lot_level_itm_hdr_key = -1;

UPDATE dwh.f_stockbinhistorydetail t
SET    stock_item_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.stock_item = i.itm_code
       AND t.stock_ou = i.itm_ou
       AND t.stock_item_key = -1;

UPDATE dwh.f_stockconversiondetail t
SET    stk_con_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.stk_con_item_code = i.itm_code
       AND t.stk_con_proposal_ou = i.itm_ou
       AND t.stk_con_dtl_itm_hdr_key = -1;

UPDATE dwh.f_stock_lottrackingdaywise_detail t
SET    stk_item_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.stk_item = i.itm_code
       AND t.stk_ou = i.itm_ou
       AND t.stk_item_key = -1;

UPDATE dwh.f_stockuiditemtrackingdetail t
SET    stk_itm_dtl_itm_hdr_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.stk_item = i.itm_code
       AND t.stk_ou = i.itm_ou
       AND t.stk_itm_dtl_itm_hdr_key = -1;

UPDATE dwh.f_wavedetail t
SET    wave_item_key = COALESCE(i.itm_hdr_key, -1)
FROM   dwh.d_itemheader i
WHERE  t.wave_item_code = i.itm_code
       AND t.wave_ou = i.itm_ou
       AND t.wave_item_key = -1; 
	   
	   
--VENDOR 

UPDATE dwh.f_asnheader t
SET    asn_supp_key = COALESCE(v.vendor_key, -1),
       asn_supp_code = Trim(t.asn_supp_code)
FROM   dwh.d_vendor V
WHERE  Trim(t.asn_supp_code) = V.vendor_id
       AND t.asn_ou = V.vendor_ou
       AND t.asn_supp_key = -1;

UPDATE dwh.f_grheader t
SET    gr_vendor_key = COALESCE(v.vendor_key, -1),
       suppcode = Trim(t.suppcode)
FROM   dwh.d_vendor V
WHERE  Trim(t.suppcode) = v.vendor_id
       AND t.ouinstid = v.vendor_ou
       AND t.gr_vendor_key = -1;

UPDATE dwh.f_purchaseheader t
SET    po_supp_key = COALESCE(v.vendor_key, -1),
       suppliercode = Trim(t.suppliercode)
FROM   dwh.d_vendor V
WHERE  Trim(t.suppliercode) = V.vendor_id
       AND t.poou = V.vendor_ou
       AND t.po_supp_key = -1;

UPDATE dwh.f_purchasereqdetail t
SET    preqm_dtl_vendor_key = COALESCE(v.vendor_key, -1),
       prqit_pref_supplier_code = Trim(t.prqit_pref_supplier_code)
FROM   dwh.d_vendor V
WHERE  Trim(t.prqit_pref_supplier_code) = v.vendor_id
       AND t.prqit_prou = v.vendor_ou
       AND t.preqm_dtl_vendor_key = -1;

UPDATE dwh.f_sadadjvoucherhdr t
SET    sadadjvoucherhdr_vendor_key = COALESCE(v.vendor_key, -1),
       supp_code = Trim(t.supp_code)
FROM   dwh.d_vendor V
WHERE  Trim(t.supp_code) = v.vendor_id
       AND t.ou_id = v.vendor_ou
       AND t.sadadjvoucherhdr_vendor_key = -1;

UPDATE dwh.f_sidochdr t
SET    sidochdr_vendor_key = COALESCE(v.vendor_key, -1),
       supplier_code = Trim(t.supplier_code)
FROM   dwh.d_vendor V
WHERE  Trim(t.supplier_code) = v.vendor_id
       AND t.tran_ou = v.vendor_ou
       AND t.sidochdr_vendor_key = -1;

UPDATE dwh.f_triplogthudetail t
SET    tltd_vendor_key = COALESCE(v.vendor_key, -1),
       tltd_vendor_id = Trim(t.tltd_vendor_id)
FROM   dwh.d_vendor V
WHERE  Trim(t.tltd_vendor_id) = v.vendor_id
       AND t.tltd_ouinstance = v.vendor_ou
       AND t.tltd_vendor_key = -1;

UPDATE dwh.f_tripresourcescheduledetail t
SET    trsd_vendor_key = COALESCE(v.vendor_key, -1),
       trsd_vendor_id = Trim(t.trsd_vendor_id)
FROM   dwh.d_vendor V
WHERE  Trim(t.trsd_vendor_id) = v.vendor_id
       AND t.trsd_ouinstance = v.vendor_ou
       AND t.trsd_vendor_key = -1;

UPDATE dwh.f_vehicleequiplicensedetail t
SET    vrvel_vendor_key = COALESCE(v.vendor_key, -1),
       vrvel_vendor_id = Trim(t.vrvel_vendor_id)
FROM   dwh.d_vendor V
WHERE  Trim(t.vrvel_vendor_id) = v.vendor_id
       AND t.vrvel_ouinstance = v.vendor_ou
       AND t.vrvel_vendor_key = -1;

UPDATE dwh.f_vehicleequipresponsedetail t
SET    vrve_vendor_key = COALESCE(v.vendor_key, -1),
       vrve_vendor_id = Trim(t.vrve_vendor_id)
FROM   dwh.d_vendor V
WHERE  Trim(t.vrve_vendor_id) = v.vendor_id
       AND t.vrve_ouinstance = v.vendor_ou
       AND t.vrve_vendor_key = -1;

--EQUIPMENT 
UPDATE dwh.f_gateexecdetail t
SET    gate_exec_dtl_eqp_key = COALESCE(eq.eqp_key, -1),
       gate_equip_no = Trim(t.gate_equip_no)
FROM   dwh.d_equipment eq
WHERE  Trim(t.gate_equip_no) = eq.eqp_equipment_id
       AND t.gate_exec_ou = eq.eqp_ou
       AND t.gate_exec_dtl_eqp_key = -1;

UPDATE dwh.f_gateplandetail t
SET    gate_pln_dtl_eqp_key = COALESCE(e.eqp_key, -1),
       gate_equip_no = Trim(t.gate_equip_no)
FROM   dwh.d_equipment e
WHERE  Trim(t.gate_equip_no) = e.eqp_equipment_id
       AND t.gate_pln_ou = e.eqp_ou
       AND t.gate_pln_dtl_eqp_key = -1;

UPDATE dwh.f_loadingheader t
SET    loading_hdr_eqp_key = COALESCE(eq.eqp_key, -1),
       loading_equip_no = Trim(t.loading_equip_no)
FROM   dwh.d_equipment eq
WHERE  Trim(t.loading_equip_no) = eq.eqp_equipment_id
       AND t.loading_exec_ou = eq.eqp_ou
       AND t.loading_hdr_eqp_key = -1;

UPDATE dwh.f_putawayempequipmap t
SET    pway_eqp_map_eqp_key = COALESCE(eq.eqp_key, -1),
       putaway_euip_code = Trim(t.putaway_euip_code)
FROM   dwh.d_equipment eq
WHERE  Trim(t.putaway_euip_code) = eq.eqp_equipment_id
       AND t.putaway_ou = eq.eqp_ou
       AND t.pway_eqp_map_eqp_key = -1;

UPDATE dwh.f_putawayexecdetail t
SET    pway_exe_dtl_eqp_key = COALESCE(eq.eqp_key, -1),
       pway_mhe_id = Trim(t.pway_mhe_id)
FROM   dwh.d_equipment eq
WHERE  Trim(t.pway_mhe_id) = eq.eqp_equipment_id
       AND t.pway_pln_ou = eq.eqp_ou
       AND t.pway_exe_dtl_eqp_key = -1;

--WAREHOUSE 
UPDATE dwh.f_allocitemdetailshistory t
SET    allc_wh_key = COALESCE(w.wh_key, -1),
       allc_wh_no = Trim(t.allc_wh_no)
FROM   dwh.d_warehouse w
WHERE  Trim(t.allc_wh_no) = w.wh_code
       AND t.allc_ouinstid = w.wh_ou
       AND t.allc_doc_ou = w.wh_ou
       AND t.allc_wh_key = -1;

UPDATE dwh.f_itemallocdetail t
SET    allc_wh_key = COALESCE(w.wh_key, -1),
       allc_wh_no = Trim(t.allc_wh_no)
FROM   dwh.d_warehouse w
WHERE  Trim(t.allc_wh_no) = w.wh_code
       AND t.allc_ouinstid = w.wh_ou
       AND t.allc_doc_ou = w.wh_ou
       AND t.allc_wh_key = -1;

UPDATE dwh.f_lotmasterdetail t
SET    lot_mst_dtl_wh_key = COALESCE(w.wh_key, -1),
       lm_wh_code = Trim(t.lm_wh_code)
FROM   dwh.d_warehouse w
WHERE  Trim(t.lm_wh_code) = w.wh_code
       AND t.lm_lotno_ou = w.wh_ou
       AND t.lot_mst_dtl_wh_key = -1;

UPDATE dwh.f_purchasedetails t
SET    po_dtl_wh_key = COALESCE(w.wh_key, -1),
       warehousecode = Trim(t.warehousecode)
FROM   dwh.d_warehouse w
WHERE  Trim(t.warehousecode) = w.wh_code
       AND t.poou = w.wh_ou
       AND t.po_dtl_wh_key = -1;

UPDATE dwh.f_purchasereqdetail t
SET    preqm_dtl_wh_key = COALESCE(w.wh_key, -1),
       prqit_warehousecode = Trim(t.prqit_warehousecode)
FROM   dwh.d_warehouse w
WHERE  Trim(t.prqit_warehousecode) = w.wh_code
       AND t.prqit_prou = w.wh_ou
       AND t.preqm_dtl_wh_key = -1;

UPDATE dwh.f_stockbalanceseriallevel t
SET    sbs_level_wh_key = COALESCE(w.wh_key, -1),
       sbs_wh_code = Trim(t.sbs_wh_code)
FROM   dwh.d_warehouse w
WHERE  Trim(t.sbs_wh_code) = w.wh_code
       AND t.sbs_ouinstid = w.wh_ou
       AND t.sbs_level_wh_key = -1;

UPDATE dwh.f_stockbalancestorageunitlotlevel t
SET    sbl_lot_level_wh_key = COALESCE(w.wh_key, -1),
       sbl_wh_code = Trim(t.sbl_wh_code)
FROM   dwh.d_warehouse w
WHERE  Trim(t.sbl_wh_code) = w.wh_code
       AND t.sbl_ouinstid = w.wh_ou
       AND t.sbl_lot_level_wh_key = -1;

--UOM 
UPDATE dwh.f_asndetails t
SET    asn_dtl_uom_key = COALESCE(u.uom_key, -1),
       asn_order_uom = Trim(t.asn_order_uom)
FROM   dwh.d_uom u
WHERE  Trim(t.asn_order_uom) = u.mas_uomcode
       AND t.asn_ou = u.mas_ouinstance
       AND t.asn_dtl_uom_key = -1;

UPDATE dwh.f_goodsreceiptitemdetails t
SET    gr_itm_dtl_uom_key = COALESCE(u.uom_key, -1),
       gr_mas_uom = Trim(t.gr_mas_uom)
FROM   dwh.d_uom u
WHERE  Trim(t.gr_mas_uom) = u.mas_uomcode
       AND t.gr_exec_ou = u.mas_ouinstance
       AND t.gr_itm_dtl_uom_key = -1;

UPDATE dwh.f_itemallocdetail t
SET    allc_uom_key = COALESCE(u.uom_key, -1),
       allc_mas_uom = Trim(t.allc_mas_uom)
FROM   dwh.d_uom u
WHERE  Trim(t.allc_mas_uom) = u.mas_uomcode
       AND t.allc_ouinstid = u.mas_ouinstance
       AND t.allc_doc_ou = u.mas_ouinstance
       AND t.allc_uom_key = -1;

UPDATE dwh.f_purchasedetails t
SET    po_dtl_uom_key = COALESCE(u.uom_key, -1),
       puom = Trim(t.puom)
FROM   dwh.d_uom u
WHERE  Trim(t.puom) = u.mas_uomcode
       AND t.poou = u.mas_ouinstance
       AND t.po_dtl_uom_key = -1;

UPDATE dwh.f_purchasereqdetail t
SET    preqm_dtl_uom_key = COALESCE(u.uom_key, -1),
       prqit_puom = Trim(t.prqit_puom)
FROM   dwh.d_uom u
WHERE  Trim(t.prqit_puom) = u.mas_uomcode
       AND t.prqit_prou = u.mas_ouinstance
       AND t.preqm_dtl_uom_key = -1;

UPDATE dwh.f_sdinexpensedtl t
SET    uom_key = COALESCE(u.uom_key, -1),
       uom = Trim(t.uom)
FROM   dwh.d_uom u
WHERE  Trim(t.uom) = u.mas_uomcode
       AND t.uom_key = -1;

--STAGE 
UPDATE dwh.f_draftbillexecdetail t
SET    draft_bill_stg_mas_key = COALESCE(st.stg_mas_key, -1),
       exec_stage = Trim(t.exec_stage)
FROM   dwh.d_stage st
WHERE  Trim(t.exec_stage) = st.stg_mas_id
       AND t.exec_ou = st.stg_mas_ou
       AND t.draft_bill_stg_mas_key = -1;

UPDATE dwh.f_goodsreceiptdetails t
SET    gr_stg_mas_key = COALESCE(st.stg_mas_key, -1),
       gr_staging_id = Trim(t.gr_staging_id)
FROM   dwh.d_stage st
WHERE  Trim(t.gr_staging_id) = st.stg_mas_id
       AND t.gr_loc_code = st.stg_mas_loc
       AND t.gr_pln_ou = st.stg_mas_ou
       AND t.gr_stg_mas_key = -1;

UPDATE dwh.f_goodsreceiptitemdetails t
SET    gr_itm_dtl_stg_mas_key = COALESCE(st.stg_mas_key, -1),
       gr_stag_id = Trim(t.gr_stag_id)
FROM   dwh.d_stage st
WHERE  Trim(t.gr_stag_id) = st.stg_mas_id
       AND t.gr_loc_code = st.stg_mas_loc
       AND t.gr_exec_ou = st.stg_mas_ou
       AND t.gr_itm_dtl_stg_mas_key = -1;

UPDATE dwh.f_itemallocdetail t
SET    allc_stg_mas_key = COALESCE(st.stg_mas_key, -1),
       allc_staging_id_crosdk = Trim(t.allc_staging_id_crosdk)
FROM   dwh.d_stage st
WHERE  Trim(t.allc_staging_id_crosdk) = st.stg_mas_id
       AND t.allc_ouinstid = st.stg_mas_ou
       AND t.allc_doc_ou = st.stg_mas_ou
       AND t.allc_wh_no = st.stg_mas_loc
       AND t.allc_stg_mas_key = -1;

UPDATE dwh.f_loadingdetail t
SET    loading_dtl_stg_mas_key = COALESCE(st.stg_mas_key, -1)
FROM   dwh.d_stage st
WHERE  Trim(t.loading_stage) = st.stg_mas_id
       AND t.loading_exec_ou = st.stg_mas_ou
       AND t.loading_loc_code = st.stg_mas_loc
       AND t.loading_dtl_stg_mas_key = -1;

UPDATE dwh.f_putawayexecdetail t
SET    pway_exe_dtl_stg_mas_key = COALESCE(st.stg_mas_key, -1),
       pway_stag_id = Trim(t.pway_stag_id)
FROM   dwh.d_stage st
WHERE  Trim(t.pway_stag_id) = st.stg_mas_id
       AND t.pway_pln_ou = st.stg_mas_ou
       AND t.pway_loc_code = st.stg_mas_loc
       AND t.pway_exe_dtl_stg_mas_key = -1;

UPDATE dwh.f_putawayplandetail t
SET    pway_pln_dtl_stg_mas_key = COALESCE(st.stg_mas_key, -1),
       pway_stag_id = Trim(t.pway_stag_id)
FROM   dwh.d_stage st
WHERE  Trim(t.pway_stag_id) = st.stg_mas_id
       AND t.pway_pln_ou = st.stg_mas_ou
       AND t.pway_loc_code = st.stg_mas_loc
       AND t.pway_pln_dtl_stg_mas_key = -1;

--CONSIGNEE 
UPDATE dwh.f_brconsignmentconsigneedetail t
SET    brccd_consignee_hdr_key = COALESCE(c.consignee_hdr_key, -1),
       ccd_consignee_id = Trim(t.ccd_consignee_id)
FROM   dwh.d_consignee c
WHERE  Trim(t.ccd_consignee_id) = c.consignee_id
       AND t.ccd_ouinstance = c.consignee_ou
       AND t.brccd_consignee_hdr_key = -1;

UPDATE dwh.f_dispatchdocheader t
SET    ddh_consignee_hdr_key = COALESCE(c.consignee_hdr_key, -1),
       ddh_consignee_id = Trim(t.ddh_consignee_id)
FROM   dwh.d_consignee c
WHERE  Trim(t.ddh_consignee_id) = c.consignee_id
       AND t.ddh_ouinstance = c.consignee_ou
       AND t.ddh_consignee_hdr_key = -1;

--VECHILE 
UPDATE dwh.f_dispatchheader t
SET    dispatch_hdr_veh_key = COALESCE(v.veh_key, -1),
       dispatch_vehicle_code = Trim(t.dispatch_vehicle_code)
FROM   dwh.d_vehicle v
WHERE  Trim(t.dispatch_vehicle_code) = v.veh_id
       AND t.dispatch_ld_sheet_ou = v.veh_ou
       AND t.dispatch_hdr_veh_key = -1;

UPDATE dwh.f_gateexecdetail t
SET    gate_exec_dtl_veh_key = COALESCE(v.veh_key, -1),
       gate_vehicle_no = Trim(t.gate_vehicle_no)
FROM   dwh.d_vehicle v
WHERE  Trim(t.gate_vehicle_no) = v.veh_id
       AND t.gate_exec_ou = v.veh_ou
       AND t.gate_exec_dtl_veh_key = -1;

UPDATE dwh.f_gateplandetail t
SET    gate_pln_dtl_veh_key = COALESCE(v.veh_key, -1),
       gate_vehicle_no = Trim(t.gate_vehicle_no)
FROM   dwh.d_vehicle v
WHERE  Trim(t.gate_vehicle_no) = v.veh_id
       AND t.gate_pln_ou = v.veh_ou
       AND t.gate_pln_dtl_veh_key = -1;

UPDATE dwh.f_loadingheader t
SET    loading_hdr_veh_key = COALESCE(v.veh_key, -1),
       loading_veh_no = Trim(t.loading_veh_no)
FROM   dwh.d_vehicle v
WHERE  Trim(t.loading_veh_no) = v.veh_id
       AND t.loading_exec_ou = v.veh_ou
       AND t.loading_hdr_veh_key = -1;

--ROUTE 
UPDATE dwh.f_bookingrequest t
SET    br_rou_key = COALESCE(r.rou_key, -1),
       br_route_id = Trim(t.br_route_id)
FROM   dwh.d_route r
WHERE  Trim(t.br_route_id) = r.rou_route_id
       AND t.br_ouinstance = r.rou_ou
       AND t.br_rou_key = -1; 

--d_thu;

UPDATE dwh.f_allocitemdetailshistory f
SET     allc_thu_key  	   = COALESCE(th.thu_key,-1),
        allc_thu_id        = TRIM(f.allc_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.allc_thu_id)   = th.thu_id 
AND     f.allc_ouinstid       = th.thu_ou
AND     f.allc_doc_ou     	  = th.thu_ou
AND     f.allc_thu_key = -1;

UPDATE dwh.f_asndetails f
SET     asn_dtl_thu_key  	   = COALESCE(th.thu_key,-1),
        asn_thu_id             = TRIM(f.asn_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.asn_thu_id)   = th.thu_id 
AND     f.asn_ou       		 = th.thu_ou
AND     f.asn_dtl_thu_key = -1;

UPDATE dwh.f_binexecdetail f
SET     bin_exec_thu_key  	   = COALESCE(th.thu_key,-1),
        bin_thu_id             = TRIM(f.bin_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.bin_thu_id)   = th.thu_id 
AND     f.bin_exec_ou        = th.thu_ou
AND     f.bin_exec_thu_key = -1;

UPDATE dwh.f_binexecitemdetail f									--- bin_thu_id is added 
SET     bin_thu_key  	   = COALESCE(th.thu_key,-1),
        bin_thu_id         = TRIM(f.bin_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.bin_thu_id)  = th.thu_id 
AND     f.bin_exec_ou       = th.thu_ou
AND     f.bin_thu_key = -1;

UPDATE dwh.f_brconsignmentdetail f
SET     brcd_thu_key  	   = COALESCE(th.thu_key,-1),
        cd_thu_id          = TRIM(f.cd_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.cd_thu_id)   = th.thu_id 
AND     f.cd_ouinstance     = th.thu_ou
AND     f.brcd_thu_key = -1;

UPDATE dwh.f_dispatchdetail f
SET     dispatch_dtl_thu_key  	   = COALESCE(th.thu_key,-1),
        dispatch_thu_id            = TRIM(f.dispatch_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.dispatch_thu_id)   = th.thu_id 
AND     f.dispatch_ld_sheet_ou    = th.thu_ou
AND     f.dispatch_dtl_thu_key = -1;

UPDATE dwh.f_dispatchdocthudetail f
SET     ddh_thu_key  	   = COALESCE(th.thu_key,-1),
        ddtd_thu_id        = TRIM(f.ddtd_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.ddtd_thu_id)   = th.thu_id 
AND     f.ddtd_ouinstance       = th.thu_ou
AND     f.ddh_thu_key = -1;

UPDATE dwh.f_draftbillexecdetail f
SET     draft_bill_thu_key  	= COALESCE(th.thu_key,-1),
        exec_thu_id             = TRIM(f.exec_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.exec_thu_id)   = th.thu_id 
AND     f.exec_ou       	  = th.thu_ou
AND     f.draft_bill_thu_key = -1;

UPDATE dwh.f_goodsreceiptitemdetails f
SET     gr_itm_dtl_thu_key    = COALESCE(th.thu_key,-1),
        gr_thu_id             = TRIM(f.gr_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.gr_thu_id)   = th.thu_id 
AND     f.gr_exec_ou        = th.thu_ou
AND     f.gr_itm_dtl_thu_key = -1;

UPDATE dwh.f_grthuheader f
SET     gr_thu_key  	   = COALESCE(th.thu_key,-1),
        gr_thu_id          = TRIM(f.gr_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.gr_thu_id)   = th.thu_id 
AND     f.gr_exec_ou        = th.thu_ou
AND     f.gr_thu_key = -1;

UPDATE dwh.f_grthulotdetail f
SET     gr_lot_thu_key  	   = COALESCE(th.thu_key,-1),
        gr_thu_id              = TRIM(f.gr_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.gr_thu_id)   = th.thu_id 
AND     f.gr_exec_ou        = th.thu_ou
AND     f.gr_lot_thu_key = -1;

UPDATE dwh.f_itemallocdetail f
SET     allc_thu_key  	   = COALESCE(th.thu_key,-1),
        allc_thu_id        = TRIM(f.allc_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.allc_thu_id)    = th.thu_id 
AND     f.allc_ouinstid        = th.thu_ou
AND     f.allc_doc_ou          = th.thu_ou
AND     f.allc_thu_key = -1;

UPDATE dwh.f_loadingdetail f
SET     loading_dtl_thu_key  	   = COALESCE(th.thu_key,-1),
        loading_thu_id             = TRIM(f.loading_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.loading_thu_id)   = th.thu_id 
AND     f.loading_exec_ou        = th.thu_ou
AND     f.loading_dtl_thu_key = -1;

UPDATE dwh.f_pickplandetails f
SET     pick_pln_thu_key  	   = COALESCE(th.thu_key,-1),
        pick_thu_id        = TRIM(f.pick_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.pick_thu_id)   = th.thu_id 
AND     f.pick_pln_ou       = th.thu_ou
AND     f.pick_pln_thu_key = -1;

UPDATE dwh.f_stockbalancestorageunitlotlevel f
SET     sbl_lot_level_thu_key  	= COALESCE(th.thu_key,-1),
        sbl_thu_id              = TRIM(f.sbl_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.sbl_thu_id)   = th.thu_id 
AND     f.sbl_ouinstid       = th.thu_ou
AND     f.sbl_lot_level_thu_key = -1;

UPDATE dwh.f_stockbinhistorydetail f
SET     stock_thu_key            = COALESCE(th.thu_key,-1),
        stock_thu_id             = TRIM(f.stock_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.stock_thu_id)   = th.thu_id 
AND     f.stock_ou             = th.thu_ou
AND     f.stock_thu_key = -1;

UPDATE dwh.f_stockrejecteddetail f
SET     rejstk_dtl_thu_key    = COALESCE(th.thu_key,-1),
        rejstk_thuid          = TRIM(f.rejstk_thuid)
FROM dwh.d_thu th       
WHERE   TRIM(f.rejstk_thuid)   = th.thu_id 
AND     f.rejstk_ou            = th.thu_ou
AND     f.rejstk_dtl_thu_key = -1;

UPDATE dwh.f_stockuiditemtrackingdetail f
SET     stk_itm_dtl_thu_key  	= COALESCE(th.thu_key,-1),
        stk_thu_id              = TRIM(f.stk_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.stk_thu_id)   = th.thu_id 
AND     f.stk_ou             = th.thu_ou
AND     f.stk_itm_dtl_thu_key = -1;

UPDATE dwh.f_stockuidtrackingdetail f
SET     stk_trc_dtl_thu_key  	   = COALESCE(th.thu_key,-1),
        stk_thu_id        		   = TRIM(f.stk_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.stk_thu_id)     = th.thu_id 
AND     f.stk_ou        	   = th.thu_ou
AND     f.stk_trc_dtl_thu_key = -1;

UPDATE dwh.f_tripthudetail f
SET     plttd_thu_key  	   = COALESCE(th.thu_key,-1),
        plttd_thu_id       = TRIM(f.plttd_thu_id)
FROM dwh.d_thu th       
WHERE   TRIM(f.plttd_thu_id)   = th.thu_id 
AND     f.plttd_ouinstance     = th.thu_ou
AND     f.plttd_thu_key = -1;

--currency;

UPDATE dwh.f_aplanacqproposalhdr f
SET     pln_pro_curr_key  	 = COALESCE(c.curr_key,-1),
        currency_code        = TRIM(f.currency_code)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency_code)  = c.iso_curr_code 
AND     f.pln_pro_curr_key = -1;

UPDATE dwh.f_bookingrequest f
SET     br_curr_key  	 	= COALESCE(c.curr_key,-1),
        br_currency         = TRIM(f.br_currency)
FROM dwh.d_currency c      
WHERE   TRIM(f.br_currency)  = c.iso_curr_code 
AND     f.br_curr_key = -1;

UPDATE dwh.f_brconsignmentdetail f
SET     brcd_curr_key  	   = COALESCE(c.curr_key,-1),
        cd_currency        = TRIM(f.cd_currency)
FROM dwh.d_currency c      
WHERE   TRIM(f.cd_currency)  = c.iso_curr_code 
AND     f.brcd_curr_key = -1;

UPDATE dwh.f_dispatchdocheader f
SET     ddh_curr_key  	    = COALESCE(c.curr_key,-1),
        ddh_currency        = TRIM(f.ddh_currency)
FROM dwh.d_currency c      
WHERE   TRIM(f.ddh_currency)  = c.iso_curr_code 
AND     f.ddh_curr_key = -1;

UPDATE dwh.f_draftbillheader f
SET     draft_curr_key  	 = COALESCE(c.curr_key,-1),
        draft_bill_currency  = TRIM(f.draft_bill_currency)
FROM dwh.d_currency c      
WHERE   TRIM(f.draft_bill_currency)  = c.iso_curr_code 
AND     f.draft_curr_key = -1;

UPDATE dwh.f_fbpaccountbalance f
SET     fbp_act_curr_key  	 	= COALESCE(c.curr_key,-1),
        currency_code           = TRIM(f.currency_code)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency_code)  = c.iso_curr_code 
AND     f.fbp_act_curr_key = -1;

UPDATE dwh.f_fbppostedtrndtl f
SET     fbp_trn_curr_key  	   = COALESCE(c.curr_key,-1),
        currency_code        = TRIM(f.currency_code)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency_code)  = c.iso_curr_code 
AND     f.fbp_trn_curr_key = -1;

UPDATE dwh.f_grheader f
SET     gr_curr_key  	    = COALESCE(c.curr_key,-1),
        currency            = TRIM(f.currency)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency)  = c.iso_curr_code 
AND     f.gr_curr_key = -1;

UPDATE dwh.f_purchaseheader f
SET     po_cur_key  	  = COALESCE(c.curr_key,-1),
        pocurrency        = TRIM(f.pocurrency)
FROM dwh.d_currency c      
WHERE   TRIM(f.pocurrency)  = c.iso_curr_code 
AND     f.po_cur_key = -1;

UPDATE dwh.f_purchasereqheader f
SET     preqm_hr_curr_key  	 	= COALESCE(c.curr_key,-1),
        preqm_currency          = TRIM(f.preqm_currency)
FROM dwh.d_currency c      
WHERE   TRIM(f.preqm_currency)  = c.iso_curr_code 
AND     f.preqm_hr_curr_key = -1;

UPDATE dwh.f_rppostingsdtl f
SET     rppostingsdtl_curr_key  	   = COALESCE(c.curr_key,-1),
        currency_code        		   = TRIM(f.currency_code)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency_code)  = c.iso_curr_code 
AND     f.rppostingsdtl_curr_key = -1;

UPDATE dwh.f_rptacctinfodtl f
SET     rptacctinfodtl_curr_key  	    = COALESCE(c.curr_key,-1),
        currency        				= TRIM(f.currency)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency)  = c.iso_curr_code 
AND     f.rptacctinfodtl_curr_key = -1;

UPDATE dwh.f_sadadjvcrdocdtl f
SET     sadadjvcrdocdtl_curr_key  	 = COALESCE(c.curr_key,-1),
        au_cr_doc_cur  				 = TRIM(f.au_cr_doc_cur)
FROM dwh.d_currency c      
WHERE   TRIM(f.au_cr_doc_cur)  = c.iso_curr_code 
AND     f.sadadjvcrdocdtl_curr_key = -1;

UPDATE dwh.f_sadadjvdrdocdtl f
SET     sadadjvdrdocdtl_curr_key  	 	= COALESCE(c.curr_key,-1),
        au_dr_doc_cur           		= TRIM(f.au_dr_doc_cur)
FROM dwh.d_currency c      
WHERE   TRIM(f.au_dr_doc_cur)  = c.iso_curr_code 
AND     f.sadadjvdrdocdtl_curr_key = -1;

UPDATE dwh.f_sadadjvoucherhdr f
SET     sadadjvoucherhdr_curr_key  	   = COALESCE(c.curr_key,-1),
        currency_code        		   = TRIM(f.currency_code)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency_code)  = c.iso_curr_code 
AND     f.sadadjvoucherhdr_curr_key = -1;

UPDATE dwh.f_sidochdr f
SET     sidochdr_currency_key  	    = COALESCE(c.curr_key,-1),
        tran_currency               = TRIM(f.tran_currency)
FROM dwh.d_currency c      
WHERE   TRIM(f.tran_currency)  = c.iso_curr_code 
AND     f.sidochdr_currency_key = -1;

UPDATE dwh.f_surfbpostingsdtl f
SET     surf_trn_curr_key  	 	= COALESCE(c.curr_key,-1),
        currency_code           = TRIM(f.currency_code)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency_code)  = c.iso_curr_code 
AND     f.surf_trn_curr_key = -1;

UPDATE dwh.f_surreceiptdtl f
SET     surreceiptdtl_curr_key  	   = COALESCE(c.curr_key,-1),
        currency_code        		   = TRIM(f.currency_code)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency_code)  = c.iso_curr_code 
AND     f.surreceiptdtl_curr_key = -1;

UPDATE dwh.f_surreceipthdr f
SET     surreceipthdr_curr_key  	    = COALESCE(c.curr_key,-1),
        currency_code            		= TRIM(f.currency_code)
FROM dwh.d_currency c      
WHERE   TRIM(f.currency_code)  = c.iso_curr_code 
AND     f.surreceipthdr_curr_key = -1;

--d_location;

UPDATE dwh.f_asnadditionaldetail f
SET     asn_pop_loc_key  = COALESCE(l.loc_key,-1),
        asn_pop_loc      = TRIM(f.asn_pop_loc)
FROM dwh.d_location l        
WHERE   TRIM(f.asn_pop_loc)      = l.loc_code 
AND     f.asn_pop_ou     		 = l.loc_ou
AND     f.asn_pop_loc_key = -1;

UPDATE dwh.f_asndetails f
SET     asn_dtl_loc_key   = COALESCE(l.loc_key,-1),
        asn_location      = TRIM(f.asn_location)
FROM dwh.d_location l        
WHERE   TRIM(f.asn_location) = l.loc_code 
AND     f.asn_ou     		 = l.loc_ou
AND     f.asn_dtl_loc_key = -1;

UPDATE dwh.f_asnheader f
SET     asn_loc_key      = COALESCE(l.loc_key,-1),
        asn_location      = TRIM(f.asn_location)
FROM dwh.d_location l        
WHERE   TRIM(f.asn_location)     = l.loc_code 
AND     f.asn_ou     		 	 = l.loc_ou
AND     f.asn_loc_key = -1;

UPDATE dwh.f_bindetails f
SET     bin_loc_key  = COALESCE(l.loc_key,-1),
        bin_loc_code      = TRIM(f.bin_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.bin_loc_code)      = l.loc_code 
AND     f.bin_ou     		 = l.loc_ou
AND     f.bin_loc_key = -1;

UPDATE dwh.f_binexecdetail f
SET     bin_exec_loc_key  = COALESCE(l.loc_key,-1),
        bin_loc_code      = TRIM(f.bin_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.bin_loc_code)     = l.loc_code 
AND     f.bin_exec_ou     		 = l.loc_ou
AND     f.bin_exec_loc_key = -1;

UPDATE dwh.f_binexechdr f
SET     bin_loc_key   = COALESCE(l.loc_key,-1),
        bin_loc_code      = TRIM(f.bin_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.bin_loc_code) = l.loc_code 
AND     f.bin_exec_ou     		 = l.loc_ou
AND     f.bin_loc_key = -1;

UPDATE dwh.f_binexecitemdetail f
SET     bin_loc_key      = COALESCE(l.loc_key,-1),
        bin_loc_code      = TRIM(f.bin_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.bin_loc_code)     = l.loc_code 
AND     f.bin_exec_ou     		 = l.loc_ou
AND     f.bin_loc_key = -1;

UPDATE dwh.f_binplandetails f
SET     bin_loc_dl_key  = COALESCE(l.loc_key,-1),
        bin_loc_code      = TRIM(f.bin_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.bin_loc_code)      = l.loc_code 
AND     f.bin_pln_ou     		  = l.loc_ou
AND     f.bin_loc_dl_key = -1;

UPDATE dwh.f_binplanheader f
SET     bin_loc_key  	  = COALESCE(l.loc_key,-1),
        bin_loc_code      = TRIM(f.bin_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.bin_loc_code)     = l.loc_code 
AND     f.bin_pln_ou     		 = l.loc_ou
AND     f.bin_loc_key = -1;

UPDATE dwh.f_bookingrequest f
SET     br_loc_key   			  = COALESCE(l.loc_key,-1),
        br_customer_location      = TRIM(f.br_customer_location)
FROM dwh.d_location l        
WHERE   TRIM(f.br_customer_location) = l.loc_code 
AND     f.br_ouinstance     		 = l.loc_ou
AND     f.br_loc_key = -1;

UPDATE dwh.f_brplanningprofiledetail f
SET     brppd_loc_key      = COALESCE(l.loc_key,-1),
        brppd_ship_from_id = TRIM(f.brppd_ship_from_id)
FROM dwh.d_location l        
WHERE   TRIM(f.brppd_ship_from_id)     = l.loc_code 
AND     f.brppd_ouinstance     		   = l.loc_ou
AND     f.brppd_loc_key = -1;

UPDATE dwh.f_dispatchconsdetail f
SET     disp_con_loc_key  = COALESCE(l.loc_key,-1),
        disp_location      = TRIM(f.disp_location)
FROM dwh.d_location l        
WHERE   TRIM(f.disp_location)      = l.loc_code 
AND     f.disp_ou     		 = l.loc_ou
AND     f.disp_con_loc_key = -1;

UPDATE dwh.f_dispatchdetail f
SET     dispatch_dtl_loc_key  = COALESCE(l.loc_key,-1),
        dispatch_loc_code      = TRIM(f.dispatch_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.dispatch_loc_code)     = l.loc_code 
AND     f.dispatch_ld_sheet_ou     	  = l.loc_ou
AND     f.dispatch_dtl_loc_key = -1;

UPDATE dwh.f_dispatchdocheader f
SET     ddh_loc_key  	  = COALESCE(l.loc_key,-1),
        ddh_location      = TRIM(f.ddh_location)
FROM dwh.d_location l        
WHERE   TRIM(f.ddh_location) = l.loc_code 
AND     f.ddh_ouinstance     = l.loc_ou
AND     f.ddh_loc_key = -1;

UPDATE dwh.f_dispatchheader f
SET     dispatch_hdr_loc_key      = COALESCE(l.loc_key,-1),
        dispatch_loc_code         = TRIM(f.dispatch_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.dispatch_loc_code)     = l.loc_code 
AND     f.dispatch_ld_sheet_ou     	  = l.loc_ou
AND     f.dispatch_hdr_loc_key = -1;

UPDATE dwh.f_dispatchloaddetail f
SET     disp_load_loc_key  = COALESCE(l.loc_key,-1),
        disp_location      = TRIM(f.disp_location)
FROM dwh.d_location l        
WHERE   TRIM(f.disp_location)      = l.loc_code 
AND     f.disp_ou     		  	   = l.loc_ou
AND     f.disp_load_loc_key = -1;

UPDATE dwh.f_draftbillexecdetail f
SET     draft_bill_loc_key  = COALESCE(l.loc_key,-1),
        exec_loc_code       = TRIM(f.exec_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.exec_loc_code)   = l.loc_code 
AND     f.exec_ou     		 	= l.loc_ou
AND     f.draft_bill_loc_key = -1;

UPDATE dwh.f_draftbillheader f
SET     draft_loc_key   		= COALESCE(l.loc_key,-1),
        draft_bill_location     = TRIM(f.draft_bill_location)
FROM dwh.d_location l        
WHERE   TRIM(f.draft_bill_location) = l.loc_code 
AND     f.draft_bill_ou     		= l.loc_ou
AND     f.draft_loc_key = -1;

UPDATE dwh.f_draftbillsuppliercontractdetail f
SET     draft_bill_location_key      = COALESCE(l.loc_key,-1),
        draft_bill_location          = TRIM(f.draft_bill_location)
FROM dwh.d_location l        
WHERE   TRIM(f.draft_bill_location)     = l.loc_code 
AND     f.draft_bill_ou     		 	= l.loc_ou
AND     f.draft_bill_location_key = -1;

UPDATE dwh.f_gateexecdetail f
SET     gate_exec_dtl_loc_key  = COALESCE(l.loc_key,-1),
        gate_loc_code      	   = TRIM(f.gate_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gate_loc_code)      = l.loc_code 
AND     f.gate_exec_ou     		   = l.loc_ou
AND     f.gate_exec_dtl_loc_key = -1;

UPDATE dwh.f_gateplandetail f
SET     gate_pln_dtl_loc_key  = COALESCE(l.loc_key,-1),
        gate_loc_code      = TRIM(f.gate_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gate_loc_code)     = l.loc_code 
AND     f.gate_pln_ou     		  = l.loc_ou
AND     f.gate_pln_dtl_loc_key = -1;

UPDATE dwh.f_goodsempequipmap f
SET     gr_loc_key   	= COALESCE(l.loc_key,-1),
        gr_loc_cod      = TRIM(f.gr_loc_cod)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_cod) 		 = l.loc_code 
AND     f.gr_ou     		 	 = l.loc_ou
AND     f.gr_loc_key = -1;

UPDATE dwh.f_goodsissuedetails f
SET     gi_loc_key      = COALESCE(l.loc_key,-1),
        gi_loc_code     = TRIM(f.gi_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gi_loc_code)     = l.loc_code 
AND     f.gi_ou     		    = l.loc_ou
AND     f.gi_loc_key = -1;

UPDATE dwh.f_goodsreceiptdetails f
SET     gr_loc_key  	 = COALESCE(l.loc_key,-1),
        gr_loc_code      = TRIM(f.gr_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_code)      = l.loc_code 
AND     f.gr_exec_ou     		 = l.loc_ou
AND     f.gr_loc_key = -1;

UPDATE dwh.f_goodsreceiptitemdetails f
SET     gr_itm_dtl_loc_key  	  = COALESCE(l.loc_key,-1),
        gr_loc_code      		  = TRIM(f.gr_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_code)     = l.loc_code 
AND     f.gr_exec_ou     		= l.loc_ou
AND     f.gr_itm_dtl_loc_key = -1;

UPDATE dwh.f_gritemtrackingdetail f
SET     gr_itm_tk_dtl_loc_key   	= COALESCE(l.loc_key,-1),
        stk_location      			= TRIM(f.stk_location)
FROM dwh.d_location l        
WHERE   TRIM(f.stk_location) = l.loc_code 
AND     f.stk_ou      		 = l.loc_ou
AND     f.gr_itm_tk_dtl_loc_key = -1;

UPDATE dwh.f_grplandetail f
SET     gr_loc_key      = COALESCE(l.loc_key,-1),
        gr_loc_code 	= TRIM(f.gr_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_code)     = l.loc_code 
AND     f.gr_pln_ou      		= l.loc_ou
AND     f.gr_loc_key = -1;

UPDATE dwh.f_grserialinfo f
SET     gr_loc_key  	 = COALESCE(l.loc_key,-1),
        gr_loc_code      = TRIM(f.gr_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_code)      = l.loc_code 
AND     f.gr_exec_ou     		 = l.loc_ou
AND     f.gr_loc_key = -1;

UPDATE dwh.f_grthudetail f
SET     gr_loc_key  	 = COALESCE(l.loc_key,-1),
        gr_loc_code      = TRIM(f.gr_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_code)     = l.loc_code 
AND     f.gr_pln_ou     	    = l.loc_ou
AND     f.gr_loc_key = -1;

UPDATE dwh.f_grthuheader f
SET     gr_loc_key  	  = COALESCE(l.loc_key,-1),
        gr_loc_code       = TRIM(f.gr_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_code)  = l.loc_code 
AND     f.gr_exec_ou         = l.loc_ou
AND     f.gr_loc_key = -1;

UPDATE dwh.f_grthulotdetail f
SET     gr_lot_loc_key      = COALESCE(l.loc_key,-1),
        gr_loc_code         = TRIM(f.gr_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_code)     = l.loc_code 
AND     f.gr_exec_ou     	    = l.loc_ou
AND     f.gr_lot_loc_key = -1;

UPDATE dwh.f_inboundamendheader f
SET     inb_loc_key  	  = COALESCE(l.loc_key,-1),
        inb_loc_code      = TRIM(f.inb_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.inb_loc_code)       = l.loc_code 
AND     f.inb_ou     		  	   = l.loc_ou
AND     f.inb_loc_key = -1;

UPDATE dwh.f_inbounddetail f
SET     inb_itm_dtl_loc_key  = COALESCE(l.loc_key,-1),
        inb_loc_code      	 = TRIM(f.inb_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.inb_loc_code)      = l.loc_code 
AND     f.inb_ou     		 	  = l.loc_ou
AND     f.inb_itm_dtl_loc_key = -1;

UPDATE dwh.f_inboundheader f
SET     inb_loc_key   	  = COALESCE(l.loc_key,-1),
        inb_loc_code      = TRIM(f.inb_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.inb_loc_code) = l.loc_code 
AND     f.inb_ou     		 = l.loc_ou
AND     f.inb_loc_key = -1;

UPDATE dwh.f_inbounditemamenddetail f
SET     inb_loc_key      = COALESCE(l.loc_key,-1),
        inb_loc_code     = TRIM(f.inb_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.inb_loc_code)     = l.loc_code 
AND     f.inb_ou     		 	 = l.loc_ou
AND     f.inb_loc_key = -1;

UPDATE dwh.f_inboundorderbindetail f
SET     inb_loc_key  		 = COALESCE(l.loc_key,-1),
        in_ord_location      = TRIM(f.in_ord_location)
FROM dwh.d_location l        
WHERE   TRIM(f.in_ord_location)  = l.loc_code 
AND     f.in_ord_ou     		 = l.loc_ou
AND     f.inb_loc_key = -1;

UPDATE dwh.f_inboundscheduleitemamenddetail f
SET     inb_loc_key  	  = COALESCE(l.loc_key,-1),
        inb_loc_code      = TRIM(f.inb_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.inb_loc_code)     = l.loc_code 
AND     f.inb_ou     		 	 = l.loc_ou
AND     f.inb_loc_key = -1;

UPDATE dwh.f_inboundscheduleitemdetail f
SET     inb_loc_key   = COALESCE(l.loc_key,-1),
        inb_loc_code      = TRIM(f.inb_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.inb_loc_code) = l.loc_code 
AND     f.inb_ou     		 = l.loc_ou
AND     f.inb_loc_key = -1;

UPDATE dwh.f_internalorderheader f
SET     in_ord_hdr_loc_key      = COALESCE(l.loc_key,-1),
        in_ord_location      = TRIM(f.in_ord_location)
FROM dwh.d_location l        
WHERE   TRIM(f.in_ord_location)  = l.loc_code 
AND     f.in_ord_ou     		 = l.loc_ou
AND     f.in_ord_hdr_loc_key = -1;

UPDATE dwh.f_loadingdetail f
SET     loading_dtl_loc_key  = COALESCE(l.loc_key,-1),
        loading_loc_code      = TRIM(f.loading_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.loading_loc_code)      = l.loc_code 
AND     f.loading_exec_ou     		  = l.loc_ou
AND     f.loading_dtl_loc_key = -1;

UPDATE dwh.f_loadingheader f
SET     loading_hdr_loc_key   = COALESCE(l.loc_key,-1),
        loading_loc_code      = TRIM(f.loading_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.loading_loc_code)     = l.loc_code 
AND     f.loading_exec_ou     		 = l.loc_ou
AND     f.loading_hdr_loc_key = -1;

UPDATE dwh.f_lottrackingdetail f
SET     stk_loc_key   			  = COALESCE(l.loc_key,-1),
        stk_location      		  = TRIM(f.stk_location)
FROM dwh.d_location l        
WHERE   TRIM(f.stk_location) = l.loc_code 
AND     f.stk_ou     		 = l.loc_ou
AND     f.stk_loc_key = -1;

UPDATE dwh.f_outbounddocdetail f
SET     obd_loc_key      = COALESCE(l.loc_key,-1),
        oub_doc_loc_code = TRIM(f.oub_doc_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.oub_doc_loc_code)     = l.loc_code 
AND     f.oub_doc_ou     		     = l.loc_ou
AND     f.obd_loc_key = -1;

UPDATE dwh.f_outboundheader f
SET     obh_loc_key  	  = COALESCE(l.loc_key,-1),
        oub_loc_code      = TRIM(f.oub_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.oub_loc_code) = l.loc_code 
AND     f.oub_ou     		 = l.loc_ou
AND     f.obh_loc_key = -1;

UPDATE dwh.f_outbounditemdetail f
SET     obd_loc_key  		  = COALESCE(l.loc_key,-1),
        oub_itm_loc_code      = TRIM(f.oub_itm_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.oub_itm_loc_code)     = l.loc_code 
AND     f.oub_itm_ou     	  		 = l.loc_ou
AND     f.obd_loc_key = -1;

UPDATE dwh.f_outboundlotsrldetail f
SET     oub_loc_key  	  		= COALESCE(l.loc_key,-1),
        oub_lotsl_loc_code      = TRIM(f.oub_lotsl_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.oub_lotsl_loc_code)  = l.loc_code 
AND     f.oub_lotsl_ou     			= l.loc_ou
AND     f.oub_loc_key = -1;

UPDATE dwh.f_outboundschdetail f
SET     oub_loc_key      		 = COALESCE(l.loc_key,-1),
        oub_sch_loc_code         = TRIM(f.oub_sch_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.oub_sch_loc_code)      = l.loc_code 
AND     f.oub_sch_ou     	  		  = l.loc_ou
AND     f.oub_loc_key = -1;

UPDATE dwh.f_outboundvasheader f
SET     oub_loc_key  	  = COALESCE(l.loc_key,-1),
        oub_loc_code      = TRIM(f.oub_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.oub_loc_code)       = l.loc_code 
AND     f.oub_ou     		  	   = l.loc_ou
AND     f.oub_loc_key = -1;

UPDATE dwh.f_pickingdetail f
SET     pick_loc_key  		= COALESCE(l.loc_key,-1),
        pick_loc_code       = TRIM(f.pick_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pick_loc_code)   = l.loc_code 
AND     f.pick_exec_ou     		= l.loc_ou
AND     f.pick_loc_key = -1;

UPDATE dwh.f_pickingheader f
SET     pick_loc_key   		= COALESCE(l.loc_key,-1),
        pick_loc_code       = TRIM(f.pick_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pick_loc_code)   = l.loc_code 
AND     f.pick_exec_ou     		= l.loc_ou
AND     f.pick_loc_key = -1;

UPDATE dwh.f_pickplandetails f
SET     pick_pln_loc_key       = COALESCE(l.loc_key,-1),
        pick_loc_code          = TRIM(f.pick_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pick_loc_code)       = l.loc_code 
AND     f.pick_pln_ou     		 	= l.loc_ou
AND     f.pick_pln_loc_key = -1;

UPDATE dwh.f_pickplanheader f
SET     pick_pln_loc_key  		= COALESCE(l.loc_key,-1),
        pick_loc_code      	    = TRIM(f.pick_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pick_loc_code)      = l.loc_code 
AND     f.pick_pln_ou     		   = l.loc_ou
AND     f.pick_pln_loc_key = -1;

UPDATE dwh.f_pickrulesheader f
SET     pick_loc_key  	   = COALESCE(l.loc_key,-1),
        pick_loc_code      = TRIM(f.pick_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pick_loc_code)     = l.loc_code 
AND     f.pick_ou     		  	  = l.loc_ou
AND     f.pick_loc_key = -1;

UPDATE dwh.f_planningheader f
SET     plph_loc_key   			   = COALESCE(l.loc_key,-1),
        plph_plan_location_no      = TRIM(f.plph_plan_location_no)
FROM dwh.d_location l        
WHERE   TRIM(f.plph_plan_location_no) 	 = l.loc_code 
AND     f.plph_ouinstance     		 	 = l.loc_ou
AND     f.plph_loc_key = -1;

UPDATE dwh.f_pogritemdetail f
SET     gr_po_loc_key      = COALESCE(l.loc_key,-1),
        gr_loc_code        = TRIM(f.gr_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.gr_loc_code)     = l.loc_code 
AND     f.gr_pln_ou     		= l.loc_ou
AND     f.gr_po_loc_key = -1;

UPDATE dwh.f_purchasedetails f
SET     po_dtl_loc_key  	 = COALESCE(l.loc_key,-1),
        location      		 = TRIM(f.location)
FROM dwh.d_location l        
WHERE   TRIM(f.location)      = l.loc_code 
AND     f.poou     		 	  = l.loc_ou
AND     f.po_dtl_loc_key = -1;

UPDATE dwh.f_purchaseheader f
SET     po_loc_key  	  	  = COALESCE(l.loc_key,-1),
        location      		  = TRIM(f.location)
FROM dwh.d_location l        
WHERE   TRIM(f.location)     = l.loc_code 
AND     f.poou     			 = l.loc_ou
AND     f.po_loc_key = -1;

UPDATE dwh.f_purchasereqdetail f
SET     preqm_dtl_loc_key   	= COALESCE(l.loc_key,-1),
        prqit_location      	= TRIM(f.prqit_location)
FROM dwh.d_location l        
WHERE   TRIM(f.prqit_location)   = l.loc_code 
AND     f.prqit_prou      		 = l.loc_ou
AND     f.preqm_dtl_loc_key = -1;

UPDATE dwh.f_putawaybincapacity f
SET     pway_bin_cap_loc_key      = COALESCE(l.loc_key,-1),
        pway_loc_code 			  = TRIM(f.pway_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pway_loc_code)     = l.loc_code 
AND     f.pway_pln_ou      		  = l.loc_ou
AND     f.pway_bin_cap_loc_key = -1;

UPDATE dwh.f_putawayempequipmap f
SET     pway_eqp_map_loc_key  	 = COALESCE(l.loc_key,-1),
        putaway_loc_code      	 = TRIM(f.putaway_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.putaway_loc_code)      = l.loc_code 
AND     f.putaway_ou     		 	  = l.loc_ou
AND     f.pway_eqp_map_loc_key = -1;

UPDATE dwh.f_putawayexecdetail f
SET     pway_exe_dtl_loc_key  	 = COALESCE(l.loc_key,-1),
        pway_loc_code            = TRIM(f.pway_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pway_loc_code)     = l.loc_code 
AND     f.pway_exec_ou     	      = l.loc_ou
AND     f.pway_exe_dtl_loc_key = -1;

UPDATE dwh.f_putawayexecserialdetail f
SET     pway_exec_serial_dtl_loc_key  	  = COALESCE(l.loc_key,-1),
        pway_loc_code       			  = TRIM(f.pway_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pway_loc_code)  = l.loc_code 
AND     f.pway_exec_ou         = l.loc_ou
AND     f.pway_exec_serial_dtl_loc_key = -1;

UPDATE dwh.f_putawayitemdetail f
SET     pway_itm_dtl_loc_key      = COALESCE(l.loc_key,-1),
        pway_loc_code             = TRIM(f.pway_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pway_loc_code)     = l.loc_code 
AND     f.pway_exec_ou     	      = l.loc_ou
AND     f.pway_itm_dtl_loc_key = -1;

UPDATE dwh.f_putawayplandetail f
SET     pway_pln_dtl_loc_key  	  = COALESCE(l.loc_key,-1),
        pway_loc_code      		  = TRIM(f.pway_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pway_loc_code)          = l.loc_code 
AND     f.pway_pln_ou     		  	   = l.loc_ou
AND     f.pway_pln_dtl_loc_key = -1;

UPDATE dwh.f_putawayplanitemdetail f
SET     pway_pln_itm_dtl_loc_key  = COALESCE(l.loc_key,-1),
        pway_loc_code      		  = TRIM(f.pway_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pway_loc_code)    = l.loc_code 
AND     f.pway_pln_ou     		 = l.loc_ou
AND     f.pway_pln_itm_dtl_loc_key = -1;

UPDATE dwh.f_putawayserialdetail f
SET     pway_serial_dtl_loc_key   = COALESCE(l.loc_key,-1),
        pway_loc_code      		  = TRIM(f.pway_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.pway_loc_code) 	 = l.loc_code 
AND     f.pway_pln_ou     		 = l.loc_ou
AND     f.pway_serial_dtl_loc_key = -1;

UPDATE dwh.f_stockbinhistorydetail f
SET     stock_loc_key       = COALESCE(l.loc_key,-1),
        stock_location      = TRIM(f.stock_location)
FROM dwh.d_location l        
WHERE   TRIM(f.stock_location)     = l.loc_code 
AND     f.stock_ou     		 	   = l.loc_ou
AND     f.stock_loc_key = -1;

UPDATE dwh.f_stockconversiondetail f
SET     stk_con_dtl_loc_key   = COALESCE(l.loc_key,-1),
        stk_con_loc_code      = TRIM(f.stk_con_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.stk_con_loc_code)      = l.loc_code 
AND     f.stk_con_proposal_ou     	  = l.loc_ou
AND     f.stk_con_dtl_loc_key = -1;

UPDATE dwh.f_stockconversionheader f
SET     stk_con_loc_key  	  = COALESCE(l.loc_key,-1),
        stk_con_loc_code      = TRIM(f.stk_con_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.stk_con_loc_code)     = l.loc_code 
AND     f.stk_con_proposal_ou     	 = l.loc_ou
AND     f.stk_con_loc_key = -1;

UPDATE dwh.f_stock_lottrackingdaywise_detail f
SET     stk_loc_key   		= COALESCE(l.loc_key,-1),
        stk_location        = TRIM(f.stk_location)
FROM dwh.d_location l        
WHERE   TRIM(f.stk_location) = l.loc_code 
AND     f.stk_ou     		 = l.loc_ou
AND     f.stk_loc_key = -1;

UPDATE dwh.f_stockrejecteddetail f
SET     rejstk_dtl_loc_key      = COALESCE(l.loc_key,-1),
        rejstk_loc_code      	= TRIM(f.rejstk_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.rejstk_loc_code)     = l.loc_code 
AND     f.rejstk_ou     		 	= l.loc_ou
AND     f.rejstk_dtl_loc_key = -1;

UPDATE dwh.f_stockstoragebalancedetail f
SET     stk_su_loc_key 	  = COALESCE(l.loc_key,-1),
        stk_location      = TRIM(f.stk_location)
FROM dwh.d_location l        
WHERE   TRIM(f.stk_location)      = l.loc_code 
AND     f.stk_ou     		  	  = l.loc_ou
AND     f.stk_su_loc_key = -1;

UPDATE dwh.f_stockuiditemtrackingdetail f
SET     stk_itm_dtl_loc_key  	  = COALESCE(l.loc_key,-1),
        stk_location      		  = TRIM(f.stk_location)
FROM dwh.d_location l        
WHERE   TRIM(f.stk_location)     = l.loc_code 
AND     f.stk_ou     		     = l.loc_ou
AND     f.stk_itm_dtl_loc_key = -1;

UPDATE dwh.f_stockuidtrackingdetail f
SET     stk_trc_dtl_loc_key   	= COALESCE(l.loc_key,-1),
        stk_location      		= TRIM(f.stk_location)
FROM dwh.d_location l        
WHERE   TRIM(f.stk_location) = l.loc_code 
AND     f.stk_ou     		 = l.loc_ou
AND     f.stk_trc_dtl_loc_key = -1;

UPDATE dwh.f_wavedetail f
SET     wave_loc_key        = COALESCE(l.loc_key,-1),
        wave_loc_code 		= TRIM(f.wave_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.wave_loc_code)     = l.loc_code 
AND     f.wave_ou     		      = l.loc_ou
AND     f.wave_loc_key = -1;

UPDATE dwh.f_waveheader f
SET     wave_loc_key  		= COALESCE(l.loc_key,-1),
        wave_loc_code       = TRIM(f.wave_loc_code)
FROM dwh.d_location l        
WHERE   TRIM(f.wave_loc_code)      = l.loc_code 
AND     f.wave_ou     		 	   = l.loc_ou
AND     f.wave_loc_key = -1;

--d_zone;

UPDATE dwh.f_allocitemdetailshistory f
SET     allc_zone_key  	    = COALESCE(z.zone_key,-1),
        allc_zone_no        = TRIM(f.allc_zone_no),
		allc_wh_no     	  	= TRIM(allc_wh_no)
FROM dwh.d_zone z      
WHERE   TRIM(f.allc_zone_no)  = z.zone_code 
AND     f.allc_ouinstid       = z.zone_ou
AND     f.allc_doc_ou     	  = z.zone_ou
AND     TRIM(f.allc_wh_no) 	  = z.zone_loc_code
AND     f.allc_zone_key = -1;

UPDATE dwh.f_bindetails f
SET     bin_zone_key  	     = COALESCE(z.zone_key,-1),
        bin_zone             = TRIM(f.bin_zone)
FROM dwh.d_zone z       
WHERE   TRIM(f.bin_zone)     = z.zone_code 
AND     f.bin_ou       		 = z.zone_ou
AND     f.bin_loc_code     	 = z.zone_loc_code
AND     f.bin_zone_key = -1;

UPDATE dwh.f_itemallocdetail f
SET     allc_zone_key  	     = COALESCE(z.zone_key,-1),
        allc_zone_no             = TRIM(f.allc_zone_no)
FROM dwh.d_zone z       
WHERE   TRIM(f.allc_zone_no)     = z.zone_code 
AND     f.allc_ouinstid       	 = z.zone_ou
AND     f.allc_doc_ou     	     = z.zone_ou
AND     f.allc_wh_no     	     = z.zone_loc_code
AND     f.allc_zone_key = -1;

UPDATE dwh.f_putawayempequipmap f
SET     pway_eqp_map_zone_key  	 = COALESCE(z.zone_key,-1),
        putaway_zone             = TRIM(f.putaway_zone)
FROM dwh.d_zone z       
WHERE   TRIM(f.putaway_zone)     = z.zone_code 
AND     f.putaway_ou       		 = z.zone_ou
AND     f.pway_eqp_map_zone_key = -1;

UPDATE dwh.f_putawayexecserialdetail f
SET     pway_exec_serial_dtl_zone_key  	    = COALESCE(z.zone_key,-1),
        pway_zone                           = TRIM(f.pway_zone)
FROM dwh.d_zone z      
WHERE   TRIM(f.pway_zone)   = z.zone_code 
AND     f.pway_exec_ou      = z.zone_ou
AND     f.pway_loc_code     = z.zone_loc_code
AND     f.pway_exec_serial_dtl_zone_key = -1;

UPDATE dwh.f_putawayitemdetail f
SET     pway_itm_dtl_zone_key  	     = COALESCE(z.zone_key,-1),
        pway_zone             		 = TRIM(f.pway_zone)
FROM dwh.d_zone z       
WHERE   TRIM(f.pway_zone)     = z.zone_code 
AND     f.pway_exec_ou        = z.zone_ou
AND     f.pway_loc_code       = z.zone_loc_code
AND     f.pway_itm_dtl_zone_key = -1;

UPDATE dwh.f_putawayplanitemdetail f
SET     pway_pln_itm_dtl_zone_key  	     = COALESCE(z.zone_key,-1),
        pway_zone             			 = TRIM(f.pway_zone)
FROM dwh.d_zone z       
WHERE   TRIM(f.pway_zone)        = z.zone_code 
AND     f.pway_pln_ou       	 = z.zone_ou
AND     f.pway_loc_code     	 = z.zone_loc_code
AND     f.pway_pln_itm_dtl_zone_key = -1;

UPDATE dwh.f_putawayserialdetail f
SET     pway_serial_dtl_zone_key  	 = COALESCE(z.zone_key,-1),
        pway_zone                    = TRIM(f.pway_zone)
FROM dwh.d_zone z       
WHERE   TRIM(f.pway_zone)     = z.zone_code 
AND     f.pway_pln_ou         = z.zone_ou
AND     f.pway_serial_dtl_zone_key = -1;

UPDATE dwh.f_stockbalanceseriallevel f
SET     sbs_level_zone_key  	    = COALESCE(z.zone_key,-1),
        sbs_zone                    = TRIM(f.sbs_zone)
FROM dwh.d_zone z      
WHERE   TRIM(f.sbs_zone)    = z.zone_code 
AND     f.sbs_ouinstid      = z.zone_ou
AND     f.sbs_level_zone_key = -1;

UPDATE dwh.f_stockbalancestorageunitlotlevel f
SET     sbl_lot_level_zone_key  	 = COALESCE(z.zone_key,-1),
        sbl_zone             		 = TRIM(f.sbl_zone)
FROM dwh.d_zone z       
WHERE   TRIM(f.sbl_zone)      = z.zone_code 
AND     f.sbl_ouinstid        = z.zone_ou
AND     f.sbl_lot_level_zone_key = -1;

UPDATE dwh.f_stockconversiondetail f
SET     stk_con_dtl_zone_key  	     = COALESCE(z.zone_key,-1),
        stk_con_zone             	 = TRIM(f.stk_con_zone)
FROM dwh.d_zone z       
WHERE   TRIM(f.stk_con_zone)        = z.zone_code 
AND     f.stk_con_proposal_ou       = z.zone_ou
AND     f.stk_con_loc_code     	    = z.zone_loc_code
AND     f.stk_con_dtl_zone_key = -1;

UPDATE dwh.f_stockuidtrackingdetail f
SET     stk_trc_dtl_zone_key  	 = COALESCE(z.zone_key,-1),
        stk_zone                 = TRIM(f.stk_zone)
FROM dwh.d_zone z       
WHERE   TRIM(f.stk_zone)     = z.zone_code 
AND     f.stk_ou             = z.zone_ou
AND     f.stk_location     	 = z.zone_loc_code
AND     f.stk_trc_dtl_zone_key = -1;


END;
$$;