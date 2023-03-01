-- PROCEDURE: ods.usp_updateetldateweekly()

-- DROP PROCEDURE IF EXISTS ods.usp_updateetldateweekly();

CREATE OR REPLACE PROCEDURE ods.usp_updateetldateweekly(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN

update  ods.controldetail 
set  etllastrundate = (CURRENT_DATE - INTERVAL '15 days')::DATE
where sourceid in 
(
	'wms_outbound_sch_dtl'				, 'sin_item_dtl'				,
	'wms_outbound_lot_ser_dtl'			, 'wms_outbound_doc_detail'		,
	'wms_bin_plan_item_dtl'				, 'wms_outbound_sch_dtl_h'		,
	'tms_dds_dispatch_document_signature', 'wms_gr_exec_item_dtl'		,
	'wms_putaway_bin_capacity_dtl'		, 'wms_outbound_lot_ser_dtl_h'	,
	'wms_outbound_vas_hdr'				, 'wms_outbound_item_detail'	,
	'wms_put_exec_item_dtl'				, 'wms_ex_itm_su_conversion_dtl',
	'wms_pick_plan_dtl'					, 'wms_bin_exec_item_dtl'		,
	'wms_outbound_item_detail_h'		, 'wms_bin_exec_item_detail'	,
	'tms_brsd_shipment_details'			, 'spy_voucher_hdr'				,
	'wms_contract_dtl_h'				, 'wms_dispatch_dtl'			,
	'wms_pack_exec_thu_hdr'				, 'wms_asn_add_dtl'				,
	'wms_pack_exec_thu_dtl'				, 'wms_gr_thu_dtl'				,
	'wms_contract_transfer_inv_dtl'		, 'wms_gr_po_item_dtl'			,
	'wms_stock_conversion_dtl'			, 'wms_loading_exec_dtl'		,
	'si_line_dtl'						, 'wms_put_serial_dtl'			, 
	'snp_voucher_dtl'					, 'wms_inbound_item_detail'		, 		
	'wms_inbound_sch_item_detail'		, 'wms_pick_exec_dtl'			, 			
	'wms_inbound_sch_item_detail_h'		, 'wms_int_ord_bin_dtl'			, 			
	'wms_put_exec_serial_dtl'			, 'wms_inbound_header_h'		, 
	'sin_invoice_hdr'					, 'jv_voucher_trn_dtl'			,
	'snp_fbposting_dtl'					, 'snp_voucher_dtl'				,
	'snp_voucher_hdr'					, 'wms_pack_plan_dtl'			,
	'wms_asn_detail'					, 'wms_wave_dtl'				,
	'wms_inbound_item_detail_h'			, 'spy_paybatch_dtl'			,	
	'sin_ap_postings_dtl'				, 'wms_put_plan_item_dtl'		,
    'wms_outbound_header_h'             , 'ci_doc_hdr'                  ,
    'ainq_cwip_accounting_info'
) 
 and dataflowflag = 'SRCtoStg';
 
update  ods.controldetail 
set  etllastrundate = (CURRENT_DATE - INTERVAL '45 days')::DATE
where sourceid in 
(
	'wms_asn_header_h', 'wms_asn_detail_h','wms_contract_transfer_inv_dtl','cbadj_adjv_crdoc_dtl','sad_adjv_drdoc_dtl','sad_adjv_crdoc_dtl'
)
and dataflowflag = 'SRCtoStg';
 
update  ods.controldetail 
set  etllastrundate = (CURRENT_DATE - INTERVAL '365 days')::DATE
where sourceid in 
(
 'wms_contract_hdr_h'
)
and dataflowflag = 'SRCtoStg';
 
 update  ods.controldetail 
set  etllastrundate = (CURRENT_DATE - INTERVAL '180 days')::DATE
where sourceid in 
(
	'cbadj_adjv_drdoc_dtl'
)
and dataflowflag = 'SRCtoStg';

 update  ods.controldetail 
set  etllastrundate = (CURRENT_DATE - INTERVAL '90 days')::DATE
where sourceid in 
(
	'cdi_payment_dtl','sdin_payment_dtl'
)
and dataflowflag = 'SRCtoStg';
 
 
END;
$BODY$;
ALTER PROCEDURE ods.usp_updateetldateweekly()
    OWNER TO proconnect;
