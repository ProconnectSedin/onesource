-- PROCEDURE: click.usp_f_binmaster()

-- DROP PROCEDURE IF EXISTS click.usp_f_binmaster();

CREATE OR REPLACE PROCEDURE click.usp_f_binmaster(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	
	BEGIN
	
-- 		update click.f_binmaster bm
-- 		set
-- 			  OU						= bt.bin_typ_ou			
-- 			, Division					= bt.bin_typ_div_code			
-- 			, bin_location				= bt.bin_typ_loc_code		
-- 			, Bin_type					= bt.bin_typ_code				
-- 			, Bin_count					= count(bt.bin_typ_code)	
-- 			, Bin_length				= MAX(bt.bin_typ_height)		
-- 			, Bin_breadth				= MAX(bt.bin_typ_width)		
-- 			, Bin_height				= MAX(bt.bin_typ_depth)			
-- 			, bin_typ_dim_uom			= MAX(bt.bin_typ_dim_uom)	
-- 			, Actual_bin_volume			= MAX(bt.bin_typ_vol_actual)	
-- 			, Calculated_bin_volume		= MAX(bt.bin_typ_vol_calc)	
-- 			, Volume_uom				= MAX(bt.bin_typ_vol_uom)	
-- 		FROM 	dwh.d_bintypes bt
-- 		INNER JOIN dwh.f_bindetails bd
-- 			ON	bt.bin_typ_key = bd.bin_typ_key;

		TRUNCATE TABLE click.f_binmaster
		RESTART IDENTITY;

		INSERT INTO click.f_binmaster
			(
			bin_div_key			, bin_typ_key			, bin_dtl_key			, bin_loc_key	,
			OU					, Division				, bin_location			, Bin_type		,
			Bin_count			, Bin_length			, Bin_breadth			, Bin_height	,
			bin_typ_dim_uom		, Actual_bin_volume		, Calculated_bin_volume	,
			Volume_uom			, createddate
			)

		SELECT
			bt.bin_div_key		, bt.bin_typ_key		, bd.bin_dtl_key		, bd.bin_loc_key	,
			bt.bin_typ_ou		, bt.bin_typ_div_code	, bt.bin_typ_loc_code	, bt.bin_typ_code	,		
			count(bd.bin_code)	, bt.bin_typ_height		, bt.bin_typ_width		, bt.bin_typ_depth	,		
			bt.bin_typ_dim_uom	, bt.bin_typ_vol_actual	, bt.bin_typ_vol_calc	,
			bt.bin_typ_vol_uom	, NOW()::TIMESTAMP
			
		FROM dwh.d_bintypes bt
		INNER JOIN dwh.f_bindetails bd
		ON	bt.bin_typ_key = bd.bin_typ_key
		WHERE 1=1
		GROUP BY 
			bt.bin_div_key		, bt.bin_typ_key		, bd.bin_dtl_key		, bd.bin_loc_key	,
			bt.bin_typ_ou		, bt.bin_typ_div_code	, bt.bin_typ_loc_code	, bt.bin_typ_code	,
			bt.bin_typ_height	, bt.bin_typ_width		, bt.bin_typ_depth		,		
			bt.bin_typ_dim_uom	, bt.bin_typ_vol_actual	, bt.bin_typ_vol_calc	,
			bt.bin_typ_vol_uom	;
	
	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_binmaster','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

	END;
	
$BODY$;
ALTER PROCEDURE click.usp_f_binmaster()
    OWNER TO proconnect;
