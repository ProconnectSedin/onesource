-- PROCEDURE: click.usp_f_skumaster()

-- DROP PROCEDURE IF EXISTS click.usp_f_skumaster();

CREATE OR REPLACE PROCEDURE click.usp_f_skumaster(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	v_maxdate date;
BEGIN

	SELECT (
			CASE WHEN MAX(COALESCE(etlupdatedatetime,etlcreatedatetime)) <> NULL
				 THEN MAX(COALESCE(etlupdatedatetime,etlcreatedatetime))
				 ELSE '1900-01-01' END
		   )::DATE
	INTO v_maxdate
	FROM click.f_skumaster;
	
-- 		UPDATE click.f_skumaster sm
-- 		SET				
-- 				 customer_name			= cus.customer_name
-- 				, sku_code				= it.itm_code
-- 				, customer_code			= it.itm_customer
-- 				, sku_name				= it.itm_long_desc	
-- 				, sku_type				= it.itm_type		
-- 				, sku_length			= it.itm_length		
-- 				, sku_breadth	 		= it.itm_breadth
-- 				, sku_height 			= it.itm_height		
-- 				, lbh_uom				= it.itm_uom		
-- 				, wght_in_kg			= it.Itm_weight		
-- 				, sku_wght_uom	 		= it.itm_weight_uom	
-- 				, actual_vol_wght		= it.itm_volume_weight			--itm_volume_calc	= (itm_length * itm_breadth * itm_height),
-- 				, calc_vol_wght	 		= (it.itm_volume_calc /5000)
-- 				, vol_wght_diff 		= ((it.itm_volume_calc /5000)-it.itm_weight)
-- 				, Wght_diff_percentage	= case when (it.itm_weight <> 0)
-- 											then (((((it.itm_volume_calc /5000)-it.itm_weight))/it.Itm_weight)*100)
-- 											else -99999.99 end
-- 				, stack_height			= ex.ex_itm_stack_height
-- 				, stack_count			= ex.ex_itm_stack_count
-- 				, ex_itm_loc_code		= ex.ex_itm_loc_code
-- 				, etlcreatedatetime		= it.etlcreatedatetime
-- 				, etlupdatedatetime		= it.etlupdatedatetime
-- 				, updateddate			= NOW()::timestamp
-- 		FROM dwh.d_itemheader it
-- 		LEFT JOIN dwh.d_excessitemsuconvdetail ex
-- 			ON	it.itm_hdr_key	= ex.ex_itm_hdr_key
-- 		LEFT JOIN dwh.d_customer cus
-- 			ON	it.itm_ou		= cus.customer_ou
-- 			AND	it.itm_customer	= cus.customer_id
-- 		WHERE	it.itm_ou		= sm.sku_ou
-- 			AND it.itm_hdr_key	= sm.itm_hdr_key
-- 			AND ex.d_ex_itm_key = sm.d_ex_itm_key
-- 			AND ex.ex_itm_line_no	= sm.ex_itm_line_no
-- 			AND cus.customer_key	= sm.customer_key	
-- 			AND (COALESCE(it.etlupdatedatetime,it.etlcreatedatetime))::date >= v_maxdate;
-- 			--ou,item cd,locat,cust,line for unique key.

		Delete from click.f_skumaster sm
		using	dwh.d_itemheader it	,
				dwh.d_excessitemsuconvdetail ex
		where	it.itm_hdr_key	= sm.itm_hdr_key
		and 	ex.d_ex_itm_key	= sm.d_ex_itm_key
		AND		COALESCE(it.itm_modified_dt,it.itm_Created_dt)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;

		INSERT INTO click.f_skumaster
			(
				customer_key		, itm_hdr_key		, ex_location_key,
				ex_itm_loc_code		,
				sku_ou				, customer_code		, customer_name	, sku_code		,
				sku_name			, sku_type			, sku_length	, sku_breadth	, 
				sku_height 			, lbh_uom			, wght_in_kg	, sku_wght_uom	, 
				actual_vol_wght		, 
				calc_vol_wght		, 
				vol_wght_diff		,
				Wght_diff_percentage,
				stack_height	 	, stack_count		,
				d_ex_itm_key		, ex_itm_line_no	,
				etlcreatedatetime	, etlupdatedatetime	, createddate
			)

		SELECT 
				cus.customer_key		, it.itm_hdr_key		, ex.ex_location_key,
				ex.ex_itm_loc_code		,
				it.itm_ou				, it.itm_customer		, cus.customer_name	, it.itm_code		,
				it.itm_long_desc		, it.itm_type			, it.itm_length		, it.itm_breadth	,
				it.itm_height			, it.itm_uom			, it.Itm_weight		, it.itm_weight_uom	, 
				it.Itm_volume_weight	, 
				(it.itm_volume_calc /5000),
				((it.itm_volume_calc /5000)-it.Itm_weight)	,
				case when (it.itm_weight <> 0) then (((((it.itm_volume_calc /5000)-it.itm_weight))/it.Itm_weight)*100) else -99999.99 end case ,
				ex.ex_itm_stack_height	, ex.ex_itm_stack_count	,
				ex.d_ex_itm_key			, ex.ex_itm_line_no		,
				it.etlcreatedatetime	, it.etlupdatedatetime	, NOW()::timestamp
		FROM dwh.d_excessitemsuconvdetail ex
		INNER JOIN dwh.d_itemheader it
			ON	it.itm_hdr_key	= ex.ex_itm_hdr_key
		INNER JOIN dwh.d_customer cus
			ON	it.itm_ou		= cus.customer_ou
			AND	it.itm_customer	= cus.customer_id
		LEFT JOIN click.f_skumaster sm
			ON	it.itm_ou		= sm.sku_ou
			AND it.itm_hdr_key	= sm.itm_hdr_key
			AND ex.d_ex_itm_key = sm.d_ex_itm_key
			AND ex.ex_itm_line_no 	= sm.ex_itm_line_no
			AND cus.customer_key 	= sm.customer_key
			WHERE COALESCE(it.itm_modified_dt,it.itm_Created_dt)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
-- 			AND (COALESCE(it.etlupdatedatetime,it.etlcreatedatetime))::date >= v_maxdate ;
			
			--ou,item cd,locat,cust,line for unique key.

	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_skumaster','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

	END;
	
$BODY$;
ALTER PROCEDURE click.usp_f_skumaster()
    OWNER TO proconnect;
