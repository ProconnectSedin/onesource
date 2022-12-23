CREATE PROCEDURE dwh.usp_d_customerouinfo(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

    SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag

    INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag

    FROM ods.controldetail d 
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE   d.sourceid      = p_sourceId 
        AND d.dataflowflag  = p_dataflowflag
        AND d.targetobject  = p_targetobject;
        
    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_cust_ou_info

;

    UPDATE dwh.d_customerOUinfo
 t
    SET 
        cou_dflt_billto_id    = s.cou_dflt_billto_id,
        cou_dflt_shipto_id    = s.cou_dflt_shipto_id,
        cou_order_from_id    = s.cou_order_from_id,
        cou_dflt_billto_cust    = s.cou_dflt_billto_cust,
        cou_dflt_shipto_cust    = s.cou_dflt_shipto_cust,
        cou_dflt_pricelist    = s.cou_dflt_pricelist,
        cou_dflt_ship_pt    = s.cou_dflt_ship_pt,
        cou_language    = s.cou_language,
        cou_transport_mode    = s.cou_transport_mode,
        cou_sales_chnl    = s.cou_sales_chnl,
        cou_order_type    = s.cou_order_type,
        cou_process_actn    = s.cou_process_actn,
        cou_partshp_flag    = s.cou_partshp_flag,
        cou_freight_term    = s.cou_freight_term,
        cou_prfrd_carrier    = s.cou_prfrd_carrier,
        cou_secstk_flag    = s.cou_secstk_flag,
        cou_cons_sales    = s.cou_cons_sales,
        cou_cons_bill    = s.cou_cons_bill,
        cou_trnshp_flag    = s.cou_trnshp_flag,
        cou_inv_appl_flag    = s.cou_inv_appl_flag,
        cou_auto_invauth_flag    = s.cou_auto_invauth_flag,
        cou_frtbillable_flag    = s.cou_frtbillable_flag,
        cou_no_of_invcopies    = s.cou_no_of_invcopies,
        cou_elgble_for_rebate    = s.cou_elgble_for_rebate,
        cou_reason_code    = s.cou_reason_code,
        cou_cr_status    = s.cou_cr_status,
        cou_status    = s.cou_status,
        cou_prev_status    = s.cou_prev_status,
        cou_created_by    = s.cou_created_by,
        cou_created_date    = s.cou_created_date,
        cou_modified_by    = s.cou_modified_by,
        cou_modified_date    = s.cou_modified_date,
        cou_timestamp_value    = s.cou_timestamp_value,
        cou_company_code    = s.cou_company_code,
        cou_cust_priority    = s.cou_cust_priority,
        cou_sales_person    = s.cou_sales_person,
        cou_cust_frequency    = s.cou_cust_frequency,
        cou_wf_status    = s.cou_wf_status,
        cou_revision_no    = s.cou_revision_no,
        cou_trade_type    = s.cou_trade_type,
        cou_frt_Appl    = s.cou_frt_Appl,
        cou_cust_category    = s.cou_cust_category,
        etlactiveind           =     1,
        etljobname             =     p_etljobname,
        envsourcecd            =     p_envsourcecd,
        datasourcecd           =     p_datasourcecd,
        etlupdatedatetime      =     NOW()  
        FROM stg.stg_cust_ou_info s
    WHERE t.cou_cust_code     = s.cou_cust_code
    AND   t.cou_lo    = s.cou_lo
    AND   t.cou_bu = s.cou_bu
    AND   t.cou_ou = s.cou_ou;

    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_customerOUinfo

    (cou_lo,
cou_bu,
cou_ou,
cou_cust_code,
cou_dflt_billto_id,
cou_dflt_shipto_id,
cou_order_from_id,
cou_dflt_billto_cust,
cou_dflt_shipto_cust,
cou_dflt_pricelist,
cou_dflt_ship_pt,
cou_language,
cou_transport_mode,
cou_sales_chnl,
cou_order_type,
cou_process_actn,
cou_partshp_flag,
cou_freight_term,
cou_prfrd_carrier,
cou_secstk_flag,
cou_cons_sales,
cou_cons_bill,
cou_trnshp_flag,
cou_inv_appl_flag,
cou_auto_invauth_flag,
cou_frtbillable_flag,
cou_no_of_invcopies,
cou_elgble_for_rebate,
cou_reason_code,
cou_cr_status,
cou_status,
cou_prev_status,
cou_created_by,
cou_created_date,
cou_modified_by,
cou_modified_date,
cou_timestamp_value,
cou_company_code,
cou_cust_priority,
cou_sales_person,
cou_cust_frequency,
cou_wf_status,
cou_revision_no,
cou_trade_type,
cou_frt_Appl,
cou_cust_category,
etlactiveind,
etljobname,
envsourcecd,
datasourcecd ,
etlcreatedatetime )
    
    SELECT 
   s.cou_lo,
s.cou_bu,
s.cou_ou,
s.cou_cust_code,
s.cou_dflt_billto_id,
s.cou_dflt_shipto_id,
s.cou_order_from_id,
s.cou_dflt_billto_cust,
s.cou_dflt_shipto_cust,
s.cou_dflt_pricelist,
s.cou_dflt_ship_pt,
s.cou_language,
s.cou_transport_mode,
s.cou_sales_chnl,
s.cou_order_type,
s.cou_process_actn,
s.cou_partshp_flag,
s.cou_freight_term,
s.cou_prfrd_carrier,
s.cou_secstk_flag,
s.cou_cons_sales,
s.cou_cons_bill,
s.cou_trnshp_flag,
s.cou_inv_appl_flag,
s.cou_auto_invauth_flag,
s.cou_frtbillable_flag,
s.cou_no_of_invcopies,
s.cou_elgble_for_rebate,
s.cou_reason_code,
s.cou_cr_status,
s.cou_status,
s.cou_prev_status,
s.cou_created_by,
s.cou_created_date,
s.cou_modified_by,
s.cou_modified_date,
s.cou_timestamp_value,
s.cou_company_code,
s.cou_cust_priority,
s.cou_sales_person,
s.cou_cust_frequency,
s.cou_wf_status,
s.cou_revision_no,
s.cou_trade_type,
s.cou_frt_Appl,
s.cou_cust_category,
1,
p_etljobname,
p_envsourcecd,
p_datasourcecd,
now()

    FROM stg.stg_cust_ou_info s
    LEFT JOIN dwh.d_customerOUinfo t
    ON s.cou_cust_code     = t.cou_cust_code 
    AND  s.cou_lo    = t.cou_lo
    AND   s.cou_bu = t.cou_bu
    AND   s.cou_ou = t.cou_ou
    WHERE t.cou_cust_code   IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN

    INSERT INTO raw.raw_cust_ou_info

    (
       cou_lo, cou_bu, cou_ou, cou_cust_code, cou_dflt_billto_id, cou_dflt_shipto_id, 
        cou_order_from_id, cou_dflt_billto_cust, cou_dflt_shipto_cust, cou_dflt_pricelist,
        cou_dflt_ship_pt, cou_language, cou_transport_mode, cou_sales_chnl, cou_order_type,
        cou_process_actn, cou_partshp_flag, cou_freight_term, cou_prfrd_carrier, cou_secstk_flag,
        cou_cons_sales, cou_cons_bill, cou_trnshp_flag, cou_inv_appl_flag, cou_auto_invauth_flag, 
        cou_frtbillable_flag, cou_shiptol_pos, cou_shiptol_neg, cou_no_of_invcopies, cou_elgble_for_rebate, 
        cou_reason_code, cou_penalrate_perc, cou_shpment_delay_days, cou_cr_status, cou_status, cou_prev_status, 
        cou_created_by, cou_created_date, cou_modified_by, cou_modified_date, cou_timestamp_value, cou_addnl1, 
        cou_addnl2, cou_addnl3, cou_company_code, cou_cust_priority, cou_sales_person, cou_templ_cust_code, 
        cou_gen_from, cou_cust_loyalty, cou_cust_preference, cou_cust_frequency, cou_cust_cont_frequency, 
        cou_cust_cont_preference, cou_wf_status, cou_revision_no, cou_trade_type, cou_frt_appl, cou_cust_category, 
        etlcreateddatetime
    )
    SELECT
        cou_lo, cou_bu, cou_ou, cou_cust_code, cou_dflt_billto_id, cou_dflt_shipto_id, 
        cou_order_from_id, cou_dflt_billto_cust, cou_dflt_shipto_cust, cou_dflt_pricelist,
        cou_dflt_ship_pt, cou_language, cou_transport_mode, cou_sales_chnl, cou_order_type,
        cou_process_actn, cou_partshp_flag, cou_freight_term, cou_prfrd_carrier, cou_secstk_flag,
        cou_cons_sales, cou_cons_bill, cou_trnshp_flag, cou_inv_appl_flag, cou_auto_invauth_flag, 
        cou_frtbillable_flag, cou_shiptol_pos, cou_shiptol_neg, cou_no_of_invcopies, cou_elgble_for_rebate, 
        cou_reason_code, cou_penalrate_perc, cou_shpment_delay_days, cou_cr_status, cou_status, cou_prev_status, 
        cou_created_by, cou_created_date, cou_modified_by, cou_modified_date, cou_timestamp_value, cou_addnl1, 
        cou_addnl2, cou_addnl3, cou_company_code, cou_cust_priority, cou_sales_person, cou_templ_cust_code, 
        cou_gen_from, cou_cust_loyalty, cou_cust_preference, cou_cust_frequency, cou_cust_cont_frequency, 
        cou_cust_cont_preference, cou_wf_status, cou_revision_no, cou_trade_type, cou_frt_appl, cou_cust_category, 
        etlcreateddatetime
    FROM stg.stg_cust_ou_info; 
	
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