-- PROCEDURE: dwh.usp_f_asndetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_asndetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_asndetails(
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
    p_batchid INTEGER;
	p_taskname VARCHAR(100);
	p_packagename  VARCHAR(100);
    p_errorid INTEGER;
	p_errordesc character varying;
	p_errorline INTEGER;
	p_depsource VARCHAR(100);
    p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag,h.depsource
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN
	
		SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_asn_detail;

		UPDATE dwh.f_asndetails t
		SET 
			  asn_hr_key					= fh.asn_hr_key
			, asn_dtl_loc_key				= COALESCE(l.loc_key,-1)
			, asn_dtl_itm_hdr_key			= COALESCE(it.itm_hdr_key,-1)
			, asn_dtl_thu_key				= COALESCE(dt.thu_key,-1)
			, asn_dtl_uom_key				= COALESCE(u.uom_key,-1)
			, asn_line_status 				= s.wms_asn_line_status
			, asn_itm_code 					= s.wms_asn_itm_code
			, asn_qty 						= s.wms_asn_qty
			, asn_batch_no 					= s.wms_asn_batch_no
			, asn_srl_no 					= s.wms_asn_srl_no
			, asn_manfct_date 				= s.wms_asn_manfct_date
			, asn_exp_date 					= s.wms_asn_exp_date
			, asn_thu_id 					= s.wms_asn_thu_id
			, asn_thu_desc 					= s.wms_asn_thu_desc
			, asn_thu_qty 					= s.wms_asn_thu_qty
			, po_lineno 					= s.wms_po_lineno
			, gr_flag 						= s.wms_gr_flag
			, asn_rec_qty 					= s.wms_asn_rec_qty
			, asn_acc_qty 					= s.wms_asn_acc_qty
			, asn_rej_qty 					= s.wms_asn_rej_qty
			, asn_thu_srl_no 				= s.wms_asn_thu_srl_no
			, asn_rem 						= s.wms_asn_rem
			, asn_itm_height 				= s.wms_asn_itm_height
			, asn_itm_volume 				= s.wms_asn_itm_volume
			, asn_itm_weight 				= s.wms_asn_itm_weight
			, asn_order_uom 				= s.wms_asn_order_uom
			, asn_master_uom_qty 			= s.wms_asn_master_uom_qty
			, asn_cust_sl_no 				= s.wms_asn_cust_sl_no
			, asn_ref_doc_no1 				= s.wms_asn_ref_doc_no1
			, asn_outboundorder_qty 		= s.wms_asn_outboundorder_qty
			, asn_bestbeforedate 			= s.wms_asn_bestbeforedate
			, asn_itm_length 				= s.wms_asn_itm_length
			, asn_itm_breadth 				= s.wms_asn_itm_breadth
			, asn_heightuom 				= s.wms_asn_heightuom
			, asn_weightuom 				= s.wms_asn_weightuom
			, asn_volumeuom 				= s.wms_asn_volumeuom
			, asn_user_def_1 				= s.wms_asn_user_def_1
			, asn_user_def_2 				= s.wms_asn_user_def_2
			, asn_user_def_3 				= s.wms_asn_user_def_3
			, asn_hold 						= s.wms_asn_hold
			, asn_stock_status 				= s.wms_asn_stock_status
			, asn_product_status 			= s.wms_asn_product_status
			, asn_coo 						= s.wms_asn_coo
			, asn_item_attribute1 			= s.wms_asn_item_attribute1
			, asn_item_attribute2 			= s.wms_asn_item_attribute2
			, asn_item_attribute3 			= s.wms_asn_item_attribute3
			, asn_itm_cust 					= s.wms_asn_itm_cust
			, asn_cust_po_lineno 			= s.wms_asn_cust_po_lineno
			, inb_wr_serial_no 				= s.wms_inb_wr_serial_no
			, asn_lottable1 				= s.wms_asn_lottable1
			, asn_lottable2 				= s.wms_asn_lottable2
			, asn_lottable3 				= s.wms_asn_lottable3
			, asn_item_attribute6 			= s.wms_asn_item_attribute6
			, asn_item_attribute7 			= s.wms_asn_item_attribute7
			, asn_item_attribute9 			= s.wms_asn_item_attribute9
			, asn_component 				= s.wms_asn_component
			, etlactiveind 					= 1
			, etljobname 					= p_etljobname
			, envsourcecd 					= p_envsourcecd
			, datasourcecd 					= p_datasourcecd
			, etlupdatedatetime 			= NOW()	
		FROM stg.stg_wms_asn_detail s
		INNER JOIN 	dwh.f_asnheader fh 
			ON  s.wms_asn_ou 				= fh.asn_ou 
			AND s.wms_asn_location 			= fh.asn_location 
			AND s.wms_asn_no 				= fh.asn_no
		LEFT JOIN dwh.d_location L 		
			ON s.wms_asn_location 			= L.loc_code 
			AND s.wms_asn_ou        		= L.loc_ou
		LEFT JOIN dwh.d_itemheader it 			
			ON s.wms_asn_itm_code 			= it.itm_code
			AND s.wms_asn_ou        		= it.itm_ou
		LEFT JOIN dwh.d_thu dt 		
			ON s.wms_asn_thu_id  			= dt.thu_id 
			AND s.wms_asn_ou        		= dt.thu_ou
		LEFT JOIN dwh.d_uom u 		
			ON s.wms_asn_order_uom  		= u.mas_uomcode 
			AND s.wms_asn_ou        		= u.mas_ouinstance	
		WHERE t.asn_ou 						= s.wms_asn_ou
			AND	t.asn_location 				= s.wms_asn_location
			AND	t.asn_no 					= s.wms_asn_no
			AND	t.asn_lineno 				= s.wms_asn_lineno;
		
		
		GET DIAGNOSTICS updcnt = ROW_COUNT;
/*

		DELETE FROM dwh.f_asndetails fd
		USING 	stg.stg_wms_asn_detail s
			where  s.wms_asn_ou 		= fd.asn_ou 
			AND s.wms_asn_location 		= fd.asn_location 
			AND s.wms_asn_no 			= fd.asn_no
			and s.wms_asn_lineno       	= fd.asn_lineno;
-- 	AND 	COALESCE(fh.asn_modified_date,fh.asn_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
	
*/	
		INSERT INTO dwh.f_asndetails
		(
			  asn_hr_key				, asn_dtl_loc_key			, asn_dtl_itm_hdr_key		, asn_dtl_thu_key			, asn_dtl_uom_key 		
			, asn_itm_itemgroup			, asn_itm_class			
			, asn_ou					, asn_location				, asn_no					, asn_lineno
			, asn_line_status			, asn_itm_code				, asn_qty					, asn_batch_no				, asn_srl_no
			, asn_manfct_date			, asn_exp_date				, asn_thu_id				, asn_thu_desc				, asn_thu_qty
			, po_lineno					, gr_flag					, asn_rec_qty				, asn_acc_qty				, asn_rej_qty
			, asn_thu_srl_no			, asn_rem					, asn_itm_height			, asn_itm_volume			, asn_itm_weight
			, asn_order_uom				, asn_master_uom_qty		, asn_cust_sl_no			, asn_ref_doc_no1			, asn_outboundorder_qty
			, asn_bestbeforedate		, asn_itm_length			, asn_itm_breadth			, asn_heightuom				, asn_weightuom
			, asn_volumeuom				, asn_user_def_1			, asn_user_def_2			, asn_user_def_3			, asn_hold
			, asn_stock_status			, asn_product_status		, asn_coo					, asn_item_attribute1		, asn_item_attribute2
			, asn_item_attribute3		, asn_itm_cust				, asn_cust_po_lineno		, inb_wr_serial_no			, asn_lottable1
			, asn_lottable2				, asn_lottable3				, asn_item_attribute6		, asn_item_attribute7		, asn_item_attribute9
			, asn_component				, etlactiveind				, etljobname				, envsourcecd				, datasourcecd	, etlcreatedatetime
		)
		

		SELECT 
			  fh.asn_hr_key				, COALESCE(l.loc_key,-1)	,COALESCE(it.itm_hdr_key,-1),COALESCE(dt.thu_key,-1)	,COALESCE(u.uom_key,-1) 		
			, it.itm_itemgroup			, it.itm_class
			, s.wms_asn_ou				, s.wms_asn_location		, s.wms_asn_no				, s.wms_asn_lineno
			, s.wms_asn_line_status		, s.wms_asn_itm_code		, s.wms_asn_qty				, s.wms_asn_batch_no		, s.wms_asn_srl_no
			, s.wms_asn_manfct_date		, s.wms_asn_exp_date		, s.wms_asn_thu_id			, s.wms_asn_thu_desc		, s.wms_asn_thu_qty
			, s.wms_po_lineno			, s.wms_gr_flag				, s.wms_asn_rec_qty			, s.wms_asn_acc_qty			, s.wms_asn_rej_qty
			, s.wms_asn_thu_srl_no		, s.wms_asn_rem				, s.wms_asn_itm_height		, s.wms_asn_itm_volume		, s.wms_asn_itm_weight
			, s.wms_asn_order_uom		, s.wms_asn_master_uom_qty	, s.wms_asn_cust_sl_no		, s.wms_asn_ref_doc_no1		, s.wms_asn_outboundorder_qty
			, s.wms_asn_bestbeforedate	, s.wms_asn_itm_length		, s.wms_asn_itm_breadth		, s.wms_asn_heightuom		, s.wms_asn_weightuom
			, s.wms_asn_volumeuom		, s.wms_asn_user_def_1		, s.wms_asn_user_def_2		, s.wms_asn_user_def_3		, s.wms_asn_hold
			, s.wms_asn_stock_status	, s.wms_asn_product_status	, s.wms_asn_coo				, s.wms_asn_item_attribute1	, s.wms_asn_item_attribute2
			, s.wms_asn_item_attribute3	, s.wms_asn_itm_cust		, s.wms_asn_cust_po_lineno	, s.wms_inb_wr_serial_no	, s.wms_asn_lottable1
			, s.wms_asn_lottable2		, s.wms_asn_lottable3		, s.wms_asn_item_attribute6	, s.wms_asn_item_attribute7	, s.wms_asn_item_attribute9
			, s.wms_asn_component		, 1 AS etlactiveind			, p_etljobname				, p_envsourcecd				, p_datasourcecd	, NOW()
		FROM stg.stg_wms_asn_detail s
		INNER JOIN dwh.f_asnheader fh 
			ON  s.wms_asn_location 			= fh.asn_location
			AND s.wms_asn_ou 				= fh.asn_ou 
			AND s.wms_asn_no 				= fh.asn_no
		LEFT JOIN dwh.d_location L 		
			ON s.wms_asn_location 			= L.loc_code 
			AND s.wms_asn_ou        		= L.loc_ou
		LEFT JOIN dwh.d_itemheader it 			
			ON s.wms_asn_itm_code 			= it.itm_code
			AND s.wms_asn_ou        		= it.itm_ou
		LEFT JOIN dwh.d_thu dt 		
			ON s.wms_asn_thu_id  			= dt.thu_id 
			AND s.wms_asn_ou        		= dt.thu_ou
		LEFT JOIN dwh.d_uom u 		
			ON s.wms_asn_order_uom  		= u.mas_uomcode 
			AND s.wms_asn_ou        		= u.mas_ouinstance
		LEFT JOIN dwh.f_asndetails fd  	
			ON  s.wms_asn_ou 					= fd.asn_ou 
			AND s.wms_asn_location 				= fd.asn_location 
			AND s.wms_asn_no 					= fd.asn_no
			and s.wms_asn_lineno       			= fd.asn_lineno
		WHERE fd.asn_no IS NULL;
		
		GET DIAGNOSTICS inscnt = ROW_COUNT;
/*
    SELECT 0 INTO updcnt;
		
		update dwh.f_asndetails a
		set asn_hr_key			=	b.asn_hr_key,
		 	etlupdatedatetime	=	now()
		from dwh.f_asnheader b
		where 	b.asn_ou			=	a.asn_ou
		and 	b.asn_location		=	a.asn_location
		and 	b.asn_no			=	a.asn_no
		and COALESCE(b.asn_modified_date,b.asn_created_date)::DATE>=(CURRENT_DATE - INTERVAL '90 days')::DATE;
*/		
    IF p_rawstorageflag = 1
    THEN
		
		INSERT INTO raw.raw_wms_asn_detail
		(
			wms_asn_ou					, wms_asn_location			, wms_asn_no				, wms_asn_lineno				, wms_asn_line_status, 
			wms_asn_itm_code			, wms_asn_qty				, wms_asn_batch_no			, wms_asn_srl_no				, wms_asn_manfct_date, 
			wms_asn_exp_date			, wms_asn_thu_id			, wms_asn_thu_desc			, wms_asn_thu_qty				, wms_po_lineno, 
			wms_gr_flag					, wms_asn_rec_qty			, wms_asn_acc_qty			, wms_asn_rej_qty				, wms_asn_thu_srl_no, 
			wms_asn_uid					, wms_asn_rem				, wms_asn_itm_height		, wms_asn_itm_volume			, wms_asn_itm_weight, 
			wms_asn_customer_item_code	, wms_asn_order_uom			, wms_asn_master_uom_qty	, wms_asn_cust_sl_no			, wms_asn_ref_doc_no1, 
			wms_asn_outboundorder_no	, wms_asn_outboundorder_qty	, wms_asn_consignee			, wms_asn_outboundorder_lineno	, wms_asn_bestbeforedate, 
			wms_asn_itm_length			, wms_asn_itm_breadth		, wms_asn_heightuom			, wms_asn_weightuom				, wms_asn_volumeuom, 
			wms_asn_user_def_1			, wms_asn_user_def_2		, wms_asn_user_def_3		, wms_asn_hold					, wms_asn_stock_status, 
			wms_asn_inv_type			, wms_asn_product_status	, wms_asn_coo				, wms_asn_item_attribute1		, wms_asn_item_attribute2, 
			wms_asn_item_attribute3		, wms_asn_item_attribute4	, wms_asn_item_attribute5	, wms_asn_itm_cust				, wms_asn_cust_po_lineno, 
			wms_inb_wr_serial_no		, wms_asn_item_lineno		, wms_asn_ratio				, wms_asn_lottable1				, wms_asn_lottable2, 
			wms_asn_lottable3			, wms_asn_lottable4			, wms_asn_lottable5			, wms_asn_item_attribute6		, wms_asn_item_attribute7, 
			wms_asn_item_attribute8		, wms_asn_item_attribute9	, wms_asn_item_attribute10	, wms_asn_component				, wms_asn_uid2, 
			wms_asn_su1					, wms_asn_su2				, wms_asn_lottable10		, wms_asn_lottable9				, wms_asn_lottable8, 
			wms_asn_lottable7			, wms_asn_lottable6			, etlcreateddatetime
		
		)
		SELECT 
			wms_asn_ou					, wms_asn_location			, wms_asn_no				, wms_asn_lineno				, wms_asn_line_status, 
			wms_asn_itm_code			, wms_asn_qty				, wms_asn_batch_no			, wms_asn_srl_no				, wms_asn_manfct_date, 
			wms_asn_exp_date			, wms_asn_thu_id			, wms_asn_thu_desc			, wms_asn_thu_qty				, wms_po_lineno, 
			wms_gr_flag					, wms_asn_rec_qty			, wms_asn_acc_qty			, wms_asn_rej_qty				, wms_asn_thu_srl_no, 
			wms_asn_uid					, wms_asn_rem				, wms_asn_itm_height		, wms_asn_itm_volume			, wms_asn_itm_weight, 
			wms_asn_customer_item_code	, wms_asn_order_uom			, wms_asn_master_uom_qty	, wms_asn_cust_sl_no			, wms_asn_ref_doc_no1, 
			wms_asn_outboundorder_no	, wms_asn_outboundorder_qty	, wms_asn_consignee			, wms_asn_outboundorder_lineno	, wms_asn_bestbeforedate, 
			wms_asn_itm_length			, wms_asn_itm_breadth		, wms_asn_heightuom			, wms_asn_weightuom				, wms_asn_volumeuom, 
			wms_asn_user_def_1			, wms_asn_user_def_2		, wms_asn_user_def_3		, wms_asn_hold					, wms_asn_stock_status, 
			wms_asn_inv_type			, wms_asn_product_status	, wms_asn_coo				, wms_asn_item_attribute1		, wms_asn_item_attribute2, 
			wms_asn_item_attribute3		, wms_asn_item_attribute4	, wms_asn_item_attribute5	, wms_asn_itm_cust				, wms_asn_cust_po_lineno, 
			wms_inb_wr_serial_no		, wms_asn_item_lineno		, wms_asn_ratio				, wms_asn_lottable1				, wms_asn_lottable2, 
			wms_asn_lottable3			, wms_asn_lottable4			, wms_asn_lottable5			, wms_asn_item_attribute6		, wms_asn_item_attribute7, 
			wms_asn_item_attribute8		, wms_asn_item_attribute9	, wms_asn_item_attribute10	, wms_asn_component				, wms_asn_uid2, 
			wms_asn_su1					, wms_asn_su2				, wms_asn_lottable10		, wms_asn_lottable9				, wms_asn_lottable8, 
			wms_asn_lottable7			, wms_asn_lottable6			, etlcreateddatetime
		FROM stg.stg_wms_asn_detail;
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
		
	EXCEPTION WHEN others THEN       
		   
	GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate,p_errordesc = message_text;
			
	CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
			
	SELECT 0 INTO inscnt;
	SELECT 0 INTO updcnt;	
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_asndetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
