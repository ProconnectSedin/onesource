-- PROCEDURE: dwh.usp_f_draftbillexecdetailweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_draftbillexecdetailweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_draftbillexecdetailweekly(
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
    FROM stg.stg_wms_draft_bill_exec_dtl;

    UPDATE dwh.f_draftbillexecdetail t
    SET
        draft_bill_loc_key			= COALESCE(l.loc_key,-1),
		draft_bill_customer_key		= COALESCE(c.customer_key,-1),
		draft_bill_thu_key			= COALESCE(th.thu_key,-1),
		draft_bill_itm_hdr_key		= COALESCE(i.itm_hdr_key,-1),
		draft_bill_stg_mas_key		= COALESCE(st.stg_mas_key,-1),	
        exec_executed_on            = s.wms_exec_executed_on,
        exec_customer_id            = s.wms_exec_customer_id,
        exec_ref_doc_type           = s.wms_exec_ref_doc_type,
        exec_ref_doc_no             = s.wms_exec_ref_doc_no,
        exec_ref_doc_line_no        = s.wms_exec_ref_doc_line_no,
        exec_ref_doc_sch_no         = s.wms_exec_ref_doc_sch_no,
        exec_tran_qty               = s.wms_exec_tran_qty,
        exec_item_lot_no            = s.wms_exec_item_lot_no,
        exec_item_batch_no          = s.wms_exec_item_batch_no,
        exec_item_serial_no         = s.wms_exec_item_serial_no,
        exec_thu_id                 = s.wms_exec_thu_id,
        exec_thu_ser_no             = s.wms_exec_thu_ser_no,
        exec_uid_ser_no             = s.wms_exec_uid_ser_no,
        exec_item_code              = s.wms_exec_item_code,
        exec_su                     = s.wms_exec_su,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_wms_draft_bill_exec_dtl s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.wms_exec_item_code		= i.itm_code
		AND s.wms_exec_ou 				= i.itm_ou 
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_exec_loc_code 		= l.loc_code 
		AND s.wms_exec_ou 				= l.loc_ou 
	LEFT JOIN dwh.d_customer c 			
		ON  s.wms_exec_customer_id 		= c.customer_id
		AND s.wms_exec_ou 				= c.customer_ou 
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_exec_thu_id		  	= th.thu_id 
		AND s.wms_exec_ou 				= th.thu_ou  	
	LEFT JOIN dwh.d_stage st 		
		ON  s.wms_exec_stage  			= st.stg_mas_id 
		AND s.wms_exec_ou 				= st.stg_mas_ou 			
    WHERE 	t.exec_loc_code = s.wms_exec_loc_code
    AND 	t.exec_ou 		= s.wms_exec_ou
    AND 	t.exec_no 		= s.wms_exec_no
    AND 	t.exec_stage 	= s.wms_exec_stage
    AND 	t.exec_line_no 	= s.wms_exec_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_draftbillexecdetail
    (
        draft_bill_loc_key,		draft_bill_customer_key,	draft_bill_thu_key,			draft_bill_itm_hdr_key,  	draft_bill_stg_mas_key,
		exec_loc_code, 			exec_ou, 					exec_no, 					exec_stage, 				exec_line_no, 
		exec_executed_on, 		exec_customer_id, 			exec_ref_doc_type, 			exec_ref_doc_no, 			exec_ref_doc_line_no, 
		exec_ref_doc_sch_no, 	exec_tran_qty, 				exec_item_lot_no, 			exec_item_batch_no, 		exec_item_serial_no, 
		exec_thu_id, 			exec_thu_ser_no, 			exec_uid_ser_no, 			exec_item_code, 			exec_su, 
		etlactiveind, 			etljobname, 				envsourcecd, 				datasourcecd, 				etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1),		COALESCE(c.customer_key,-1),	COALESCE(th.thu_key,-1),	COALESCE(i.itm_hdr_key,-1),	COALESCE(st.stg_mas_key,-1),
		s.wms_exec_loc_code, 		s.wms_exec_ou, 					s.wms_exec_no, 				s.wms_exec_stage, 			s.wms_exec_line_no, 
		s.wms_exec_executed_on, 	s.wms_exec_customer_id, 		s.wms_exec_ref_doc_type, 	s.wms_exec_ref_doc_no, 		s.wms_exec_ref_doc_line_no, 
		s.wms_exec_ref_doc_sch_no, 	s.wms_exec_tran_qty, 			s.wms_exec_item_lot_no, 	s.wms_exec_item_batch_no, 	s.wms_exec_item_serial_no, 
		s.wms_exec_thu_id, 			s.wms_exec_thu_ser_no, 			s.wms_exec_uid_ser_no, 		s.wms_exec_item_code, 		s.wms_exec_su, 
		1, 							p_etljobname, 					p_envsourcecd, 				p_datasourcecd, 			NOW()
    FROM stg.stg_wms_draft_bill_exec_dtl s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.wms_exec_item_code		= i.itm_code
		AND s.wms_exec_ou 				= i.itm_ou 
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_exec_loc_code 		= l.loc_code 
		AND s.wms_exec_ou 				= l.loc_ou 
	LEFT JOIN dwh.d_customer c 			
		ON  s.wms_exec_customer_id 		= c.customer_id
		AND s.wms_exec_ou 				= c.customer_ou 
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_exec_thu_id		  	= th.thu_id 
		AND s.wms_exec_ou 				= th.thu_ou  	
	LEFT JOIN dwh.d_stage st 		
		ON  s.wms_exec_stage  			= st.stg_mas_id 
		AND s.wms_exec_ou 				= st.stg_mas_ou 	
    LEFT JOIN dwh.f_draftbillexecdetail t
    ON 	s.wms_exec_loc_code 			= t.exec_loc_code
    AND s.wms_exec_ou 					= t.exec_ou
    AND s.wms_exec_no 					= t.exec_no
    AND s.wms_exec_stage 				= t.exec_stage
    AND s.wms_exec_line_no 				= t.exec_line_no
    WHERE t.exec_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	UPDATE dwh.f_draftbillexecdetail t1
	set etlactiveind =  0,
	etlupdatedatetime = Now()::timestamp
	from dwh.f_draftbillexecdetail t
	left join stg.stg_wms_draft_bill_exec_dtl s
	 ON 	s.wms_exec_loc_code 			= t.exec_loc_code
    AND s.wms_exec_ou 					= t.exec_ou
    AND s.wms_exec_no 					= t.exec_no
    AND s.wms_exec_stage 				= t.exec_stage
    AND s.wms_exec_line_no 				= t.exec_line_no
	where t.draft_bill_exec_dtl_key=t1.draft_bill_exec_dtl_key
	and COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
	and  s.wms_exec_ou  is null;
	
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_draft_bill_exec_dtl
    (
        wms_exec_loc_code, 					wms_exec_ou, 						wms_exec_no, 						wms_exec_stage, 					wms_exec_line_no, 
		wms_exec_executed_on, 				wms_exec_customer_id, 				wms_exec_ref_doc_type, 				wms_exec_ref_doc_no, 				wms_exec_ref_doc_line_no, 
		wms_exec_ref_doc_sch_no, 			wms_exec_tran_qty, 					wms_exec_item_lot_no, 				wms_exec_item_batch_no, 			wms_exec_item_serial_no, 
		wms_exec_thu_id, 					wms_exec_thu_ser_no, 				wms_exec_uid, 						wms_exec_uid_ser_no, 				wms_exec_billing_status, 
		wms_exec_bill_value, 				wms_exec_item_code, 				wms_exec_su, 						wms_exec_lbchprhr_bil_status, 		wms_exec_pickchrg_bil_status, 
		wms_exec_pkpalthu_bil_status, 		wms_exec_tchpalpk_bil_status, 		wms_exec_thupkchr_bil_status, 		wms_exec_kmsslbpr_bil_status, 		wms_exec_pkmxitm_bil_status, 
		wms_exec_unitpunp_bil_status, 		wms_exec_palrestk_bil_status, 		wms_exec_conschrg_bil_status, 		wms_exec_cstchcon_bil_status, 		wms_exec_flherffn_bil_status, 
		wms_exec_hdlopick_bil_status, 		wms_exec_hdochwt_bil_status, 		wms_exec_lodtpalc_bil_status, 		wms_exec_hdochitm_bil_status, 		wms_exec_hdipitrb_bil_status, 
		wms_exec_hdipsurb_bil_status,		wms_exec_damagadj_bil_status, 		wms_exec_shpcbitq_bil_status, 		wms_exec_vaschrg_bil_status, 		wms_exec_hdlomuom_bil_status, 
		wms_exec_rfpcexwh_bil_status, 		wms_exec_rfwcexwh_bil_status, 		wms_exec_whtrchpk_bil_status, 		wms_exec_hdimugr_bil_status, 		wms_exec_hdomupk_bil_status, 
		wms_exec_cupakchr_bil_status, 		wms_exec_consbchg_bil_status, 		wms_exec_hdimetr_bil_status, 		wms_exec_hdomepk_bil_status, 		wms_exec_hdlioutc_bil_status, 
		wms_exec_damagadj_buy_bil_status, 	wms_exec_hdomuld_bil_status, 		wms_exec_hdomeld_sell_bil_status, 	wms_exec_hdiochvl_sell_bil_status, 	wms_exec_pkchrgui_bil_status, 
		wms_exec_hdchincbm_sell_bil_status, wms_exec_hcdeinqt_sell_bil_status, 	wms_exec_hdchinqt_sell_bil_status, 	wms_exec_hdchinpt_sell_bil_status, 	wms_exec_whobferb_sell_bil_status, 
		wms_exec_pthuc_status, 				wms_exec_PIKPAKQT_bil_status, 		wms_exec_himluogr_sell_bil_status, 	wms_exec_homstpld_sell_bil_status, 	wms_exec_hiochvol_sell_bil_status, 
		wms_exec_houpmton_sell_bil_status, 	wms_exec_pisamfee_bil_status, 		wms_exec_pklicnt_bil_status, 		wms_exec_hdichgei_sell_bil_status, 	wms_exec_HDOQCLD_status, 
		wms_exec_CUSBSDCG_bil_status, 		wms_exec_CUSPAKCG_sell_bil_status, 	wms_exec_HOTHUPKQ_bil_status, 		wms_exec_hdovcld_bill_status, 		wms_exec_HCOQUMOT_bil_status, 
		wms_exec_houtptld_sell_bil_status, 	wms_exec_hdlncopt_bil_status, 		etlcreateddatetime
    )
    SELECT
        wms_exec_loc_code, 					wms_exec_ou, 						wms_exec_no, 						wms_exec_stage, 					wms_exec_line_no, 
		wms_exec_executed_on, 				wms_exec_customer_id, 				wms_exec_ref_doc_type, 				wms_exec_ref_doc_no, 				wms_exec_ref_doc_line_no, 
		wms_exec_ref_doc_sch_no, 			wms_exec_tran_qty, 					wms_exec_item_lot_no, 				wms_exec_item_batch_no, 			wms_exec_item_serial_no, 
		wms_exec_thu_id, 					wms_exec_thu_ser_no, 				wms_exec_uid, 						wms_exec_uid_ser_no, 				wms_exec_billing_status, 
		wms_exec_bill_value, 				wms_exec_item_code, 				wms_exec_su, 						wms_exec_lbchprhr_bil_status, 		wms_exec_pickchrg_bil_status, 
		wms_exec_pkpalthu_bil_status, 		wms_exec_tchpalpk_bil_status, 		wms_exec_thupkchr_bil_status, 		wms_exec_kmsslbpr_bil_status, 		wms_exec_pkmxitm_bil_status, 
		wms_exec_unitpunp_bil_status, 		wms_exec_palrestk_bil_status, 		wms_exec_conschrg_bil_status, 		wms_exec_cstchcon_bil_status, 		wms_exec_flherffn_bil_status, 
		wms_exec_hdlopick_bil_status, 		wms_exec_hdochwt_bil_status, 		wms_exec_lodtpalc_bil_status, 		wms_exec_hdochitm_bil_status, 		wms_exec_hdipitrb_bil_status, 
		wms_exec_hdipsurb_bil_status,		wms_exec_damagadj_bil_status, 		wms_exec_shpcbitq_bil_status, 		wms_exec_vaschrg_bil_status, 		wms_exec_hdlomuom_bil_status, 
		wms_exec_rfpcexwh_bil_status, 		wms_exec_rfwcexwh_bil_status, 		wms_exec_whtrchpk_bil_status, 		wms_exec_hdimugr_bil_status, 		wms_exec_hdomupk_bil_status, 
		wms_exec_cupakchr_bil_status, 		wms_exec_consbchg_bil_status, 		wms_exec_hdimetr_bil_status, 		wms_exec_hdomepk_bil_status, 		wms_exec_hdlioutc_bil_status, 
		wms_exec_damagadj_buy_bil_status, 	wms_exec_hdomuld_bil_status, 		wms_exec_hdomeld_sell_bil_status, 	wms_exec_hdiochvl_sell_bil_status, 	wms_exec_pkchrgui_bil_status, 
		wms_exec_hdchincbm_sell_bil_status, wms_exec_hcdeinqt_sell_bil_status, 	wms_exec_hdchinqt_sell_bil_status, 	wms_exec_hdchinpt_sell_bil_status, 	wms_exec_whobferb_sell_bil_status, 
		wms_exec_pthuc_status, 				wms_exec_PIKPAKQT_bil_status, 		wms_exec_himluogr_sell_bil_status, 	wms_exec_homstpld_sell_bil_status, 	wms_exec_hiochvol_sell_bil_status, 
		wms_exec_houpmton_sell_bil_status, 	wms_exec_pisamfee_bil_status, 		wms_exec_pklicnt_bil_status, 		wms_exec_hdichgei_sell_bil_status, 	wms_exec_HDOQCLD_status, 
		wms_exec_CUSBSDCG_bil_status, 		wms_exec_CUSPAKCG_sell_bil_status, 	wms_exec_HOTHUPKQ_bil_status, 		wms_exec_hdovcld_bill_status, 		wms_exec_HCOQUMOT_bil_status, 
		wms_exec_houtptld_sell_bil_status, 	wms_exec_hdlncopt_bil_status, 		etlcreateddatetime
    FROM stg.stg_wms_draft_bill_exec_dtl;
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
ALTER PROCEDURE dwh.usp_f_draftbillexecdetailweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
