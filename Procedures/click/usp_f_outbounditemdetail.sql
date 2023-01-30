-- PROCEDURE: click.usp_f_outbounditemdetail()

-- DROP PROCEDURE IF EXISTS click.usp_f_outbounditemdetail();

CREATE OR REPLACE PROCEDURE click.usp_f_outbounditemdetail(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	v_maxdate date;
BEGIN

	SELECT COALESCE(MAX(etlcreatedatetime),'1900-01-01')::DATE	
	INTO v_maxdate
	FROM CLICK.f_outboundItemDetail;

	IF v_maxdate = '1900-01-01'

	THEN
	
	INSERT INTO click.f_outboundItemDetail
	(  
		obd_idl_key				, obh_hr_key			, obd_itm_key			, obd_loc_key  ,
		oub_itm_volume 			,
		oub_itm_weight			, oub_itm_loc_code		, oub_itm_ou			, oub_outbound_ord		,
		oub_itm_lineno			, oub_item_code			, oub_itm_order_qty		, oub_itm_sch_type		,
		oub_itm_balqty			, oub_itm_issueqty		, oub_itm_processqty	, oub_itm_masteruom		,
		oub_itm_deliverydate	, oub_itm_plan_gd_iss_dt, oub_itm_sub_rules		, oub_itm_pack_remarks	,
		oub_itm_mas_qty			, oub_itm_order_item	, oub_itm_lotsl_batchno	, oub_itm_cus_srno		,
		oub_itm_refdocno1		, oub_itm_refdocno2		, oub_itm_serialno		, oub_itm_thu_id		,
		oub_itm_thu_srno		, oub_itm_inst			, oub_itm_user_def_1	, oub_itm_user_def_2	,
		oub_itm_user_def_3		, oub_itm_stock_sts		, oub_itm_cust			, oub_itm_coo_ml		,
		oub_itm_arribute1		, oub_itm_arribute2		, oub_itm_cancel		, oub_itm_cancel_code	,
		oub_itm_component		, etlactiveind			, etljobname			, envsourcecd			,
		datasourcecd			, etlcreatedatetime		, etlupdatedatetime		, createddate
	)
	
	SELECT 
		oid.obd_idl_key				, oid.obh_hr_key			, oid.obd_itm_key			, oid.obd_loc_key  		,
		oid.oub_itm_volume 			,
		oid.oub_itm_weight			, oid.oub_itm_loc_code		, oid.oub_itm_ou			, oid.oub_outbound_ord		,
		oid.oub_itm_lineno			, oid.oub_item_code			, oid.oub_itm_order_qty		, oid.oub_itm_sch_type		,
		oid.oub_itm_balqty			, oid.oub_itm_issueqty		, oid.oub_itm_processqty	, oid.oub_itm_masteruom		,
		oid.oub_itm_deliverydate	, oid.oub_itm_plan_gd_iss_dt, oid.oub_itm_sub_rules		, oid.oub_itm_pack_remarks	,
		oid.oub_itm_mas_qty			, oid.oub_itm_order_item	, oid.oub_itm_lotsl_batchno	, oid.oub_itm_cus_srno		,
		oid.oub_itm_refdocno1		, oid.oub_itm_refdocno2		, oid.oub_itm_serialno		, oid.oub_itm_thu_id		,
		oid.oub_itm_thu_srno		, oid.oub_itm_inst			, oid.oub_itm_user_def_1	, oid.oub_itm_user_def_2	,
		oid.oub_itm_user_def_3		, oid.oub_itm_stock_sts		, oid.oub_itm_cust			, oid.oub_itm_coo_ml		,
		oid.oub_itm_arribute1		, oid.oub_itm_arribute2		, oid.oub_itm_cancel		, oid.oub_itm_cancel_code	,
		oid.oub_itm_component		, oid.etlactiveind			, oid.etljobname			, oid.envsourcecd			,
		oid.datasourcecd			, oid.etlcreatedatetime		, oid.etlupdatedatetime		, NOW()
	FROM dwh.f_outboundItemDetail oid;

	ELSE

	UPDATE click.f_outboundItemDetail coit
    SET 
	    oub_outbound_ord			= oid.oub_outbound_ord,
		oub_itm_ou					= oid.oub_itm_ou,
		oub_itm_lineno				= oid.oub_itm_lineno,
		obd_idl_key					= oid.obd_idl_key,
		obh_hr_key       			= oid.obh_hr_key,
    	obd_itm_key             	= oid.obd_itm_key,
    	obd_loc_key             	= oid.obd_loc_key,
    	oub_item_code           	= oid.oub_item_code,
    	oub_itm_order_qty       	= oid.oub_itm_order_qty,
    	oub_itm_sch_type        	= oid.oub_itm_sch_type,
    	oub_itm_balqty          	= oid.oub_itm_balqty,
    	oub_itm_issueqty        	= oid.oub_itm_issueqty,
    	oub_itm_processqty      	= oid.oub_itm_processqty,
    	oub_itm_masteruom       	= oid.oub_itm_masteruom,
    	oub_itm_deliverydate    	= oid.oub_itm_deliverydate,
    	oub_itm_plan_gd_iss_dt  	= oid.oub_itm_plan_gd_iss_dt,
    	oub_itm_sub_rules       	= oid.oub_itm_sub_rules,
    	oub_itm_pack_remarks    	= oid.oub_itm_pack_remarks,
    	oub_itm_mas_qty         	= oid.oub_itm_mas_qty,
    	oub_itm_order_item      	= oid.oub_itm_order_item,
    	oub_itm_lotsl_batchno   	= oid.oub_itm_lotsl_batchno,
    	oub_itm_cus_srno        	= oid.oub_itm_cus_srno,
    	oub_itm_refdocno1       	= oid.oub_itm_refdocno1,
    	oub_itm_refdocno2       	= oid.oub_itm_refdocno2,
    	oub_itm_serialno        	= oid.oub_itm_serialno,
    	oub_itm_thu_id          	= oid.oub_itm_thu_id,
    	oub_itm_thu_srno        	= oid.oub_itm_thu_srno,
    	oub_itm_inst            	= oid.oub_itm_inst,
    	oub_itm_user_def_1      	= oid.oub_itm_user_def_1,
    	oub_itm_user_def_2      	= oid.oub_itm_user_def_2,
    	oub_itm_user_def_3      	= oid.oub_itm_user_def_3,
    	oub_itm_stock_sts       	= oid.oub_itm_stock_sts,
    	oub_itm_cust            	= oid.oub_itm_cust,
    	oub_itm_coo_ml          	= oid.oub_itm_coo_ml,
    	oub_itm_arribute1       	= oid.oub_itm_arribute1,
    	oub_itm_arribute2       	= oid.oub_itm_arribute2,
    	oub_itm_cancel          	= oid.oub_itm_cancel,
    	oub_itm_cancel_code     	= oid.oub_itm_cancel_code,
    	oub_itm_component       	= oid.oub_itm_component,
		etlactiveind 				= oid.etlactiveind,
		etljobname 					= oid.etljobname,
		envsourcecd 				= oid.envsourcecd,
		datasourcecd 				= oid.datasourcecd,
		etlcreatedatetime			= oid.etlcreatedatetime,
		etlupdatedatetime 			= oid.etlupdatedatetime,
		updatedatetime				= NOW()
    FROM dwh.f_outboundItemDetail oid
	WHERE oid.obd_idl_key		= coit.obd_idl_key
	and oid.obh_hr_key			= coit.obh_hr_key
	AND COALESCE(oid.etlupdatedatetime,oid.etlcreatedatetime) >= v_maxdate;
	
	INSERT INTO click.f_outboundItemDetail
	(
		obd_idl_key				, obh_hr_key			, obd_itm_key			, obd_loc_key  ,
		oub_itm_volume 			,
		oub_itm_weight			, oub_itm_loc_code		, oub_itm_ou			, oub_outbound_ord		,
		oub_itm_lineno			, oub_item_code			, oub_itm_order_qty		, oub_itm_sch_type		,
		oub_itm_balqty			, oub_itm_issueqty		, oub_itm_processqty	, oub_itm_masteruom		,
		oub_itm_deliverydate	, oub_itm_plan_gd_iss_dt, oub_itm_sub_rules		, oub_itm_pack_remarks	,
		oub_itm_mas_qty			, oub_itm_order_item	, oub_itm_lotsl_batchno	, oub_itm_cus_srno		,
		oub_itm_refdocno1		, oub_itm_refdocno2		, oub_itm_serialno		, oub_itm_thu_id		,
		oub_itm_thu_srno		, oub_itm_inst			, oub_itm_user_def_1	, oub_itm_user_def_2	,
		oub_itm_user_def_3		, oub_itm_stock_sts		, oub_itm_cust			, oub_itm_coo_ml		,
		oub_itm_arribute1		, oub_itm_arribute2		, oub_itm_cancel		, oub_itm_cancel_code	,
		oub_itm_component		, etlactiveind			, etljobname			, envsourcecd			,
		datasourcecd			, etlcreatedatetime		, etlupdatedatetime		, createddate
	)
	
	SELECT 
		oid.obd_idl_key				, oid.obh_hr_key			, oid.obd_itm_key			, oid.obd_loc_key  		,
		oid.oub_itm_volume 			,
		oid.oub_itm_weight			, oid.oub_itm_loc_code		, oid.oub_itm_ou			, oid.oub_outbound_ord		,
		oid.oub_itm_lineno			, oid.oub_item_code			, oid.oub_itm_order_qty		, oid.oub_itm_sch_type		,
		oid.oub_itm_balqty			, oid.oub_itm_issueqty		, oid.oub_itm_processqty	, oid.oub_itm_masteruom		,
		oid.oub_itm_deliverydate	, oid.oub_itm_plan_gd_iss_dt, oid.oub_itm_sub_rules		, oid.oub_itm_pack_remarks	,
		oid.oub_itm_mas_qty			, oid.oub_itm_order_item	, oid.oub_itm_lotsl_batchno	, oid.oub_itm_cus_srno		,
		oid.oub_itm_refdocno1		, oid.oub_itm_refdocno2		, oid.oub_itm_serialno		, oid.oub_itm_thu_id		,
		oid.oub_itm_thu_srno		, oid.oub_itm_inst			, oid.oub_itm_user_def_1	, oid.oub_itm_user_def_2	,
		oid.oub_itm_user_def_3		, oid.oub_itm_stock_sts		, oid.oub_itm_cust			, oid.oub_itm_coo_ml		,
		oid.oub_itm_arribute1		, oid.oub_itm_arribute2		, oid.oub_itm_cancel		, oid.oub_itm_cancel_code	,
		oid.oub_itm_component		, oid.etlactiveind			, oid.etljobname			, oid.envsourcecd			,
		oid.datasourcecd			, oid.etlcreatedatetime		, oid.etlupdatedatetime		, NOW()
    FROM dwh.f_outboundItemDetail oid
	LEFT JOIN click.f_outboundItemDetail coit
	ON oid.obd_idl_key			= coit.obd_idl_key
	and oid.obh_hr_key			= coit.obh_hr_key
	WHERE COALESCE(oid.etlupdatedatetime,oid.etlcreatedatetime) >= v_maxdate
	AND coit.obh_hr_key IS NULL;
	
	END IF;
	
	EXCEPTION WHEN others THEN       

    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert('DWH','f_outboundItemDetail','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_outbounditemdetail()
    OWNER TO proconnect;
