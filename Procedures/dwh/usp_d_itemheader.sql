CREATE OR REPLACE PROCEDURE dwh.usp_d_itemheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
        
    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_item_hdr;

    UPDATE dwh.d_itemHeader t
    SET 

        itm_short_desc                  = s. wms_itm_short_desc,
        itm_long_desc                   = s. wms_itm_long_desc,
        itm_mas_unit                    = s. wms_itm_mas_unit,
        itm_customer                    = s. wms_itm_customer,
        itm_class                       = s. wms_itm_class,
        itm_status                      = s. wms_itm_status,  
        itm_ref_no                      = s. wms_itm_ref_no,
        itm_subs_item1                  = s. wms_itm_subs_item1,
        itm_hs_code                     = s. wms_itm_hs_code,
        itm_price                       = s. wms_itm_price,
        itm_currency                    = s. wms_itm_currency,
        itm_tracking                    = s. wms_itm_tracking,
        itm_lot_numbering               = s. wms_itm_lot_numbering,
        itm_serial_numbering            = s. wms_itm_serial_numbering,
        itm_remarks                     = s. wms_itm_remarks,
        itm_instructions                = s. wms_itm_instructions,
        itm_hazardous                   = s. wms_itm_hazardous,
        itm_length                      = s. wms_itm_length,
        itm_breadth                     = s. wms_itm_breadth,
        itm_height                      = s. wms_itm_height,
        itm_uom                         = s. wms_itm_uom,
        itm_volume                      = s. wms_itm_volume,
        itm_volume_uom                  = s. wms_itm_volume_uom,
		itm_volume_calc					= (s.wms_itm_length * s.wms_itm_breadth * s.wms_itm_height),
        itm_weight                      = s. wms_itm_weight,
        itm_weight_uom                  = s. wms_itm_weight_uom,
        itm_storage_from_temp           = s. wms_itm_storage_from_temp,
        itm_storage_to_temp             = s. wms_itm_storage_to_temp,
        itm_storage_temp_uom            = s. wms_itm_storage_temp_uom,
        itm_shelf_life                  = s. wms_itm_shelf_life,
        itm_shelf_life_uom              = s. wms_itm_shelf_life_uom,
        itm_timestamp                   = s. wms_itm_timestamp,
        itm_created_by                  = s. wms_itm_created_by,
        itm_created_dt                  = s. wms_itm_created_dt,
        itm_modified_by                 = s. wms_itm_modified_by,
        itm_modified_dt                 = s. wms_itm_modified_dt,
        itm_reason_code                 = s. wms_itm_reason_code,
        itm_type                        = s. wms_itm_type,
        itm_user_defined1               = s. wms_itm_user_defined1,
        itm_user_defined2               = s. wms_itm_user_defined2,
        itm_itemgroup                   = s. wms_itm_itemgroup,
        itm_criticaldays                = s. wms_itm_criticaldays,
        itm_criticaldays_uom            = s. wms_itm_criticaldays_uom,
        itm_movement_type               = s. wms_itm_movement_type,
        itm_volume_factor               = s. wms_itm_volume_factor,
        itm_volume_weight               = s. wms_itm_volume_weight,
        itm_item_url                    = s. wms_itm_item_url,
        itm_compilance                  = s. wms_itm_compilance,
        itm_new_item                    = s. wms_itm_new_item,
        itm_customer_serial_no          = s. wms_itm_customer_serial_no,
        itm_warranty_serial_no          = s. wms_itm_warranty_serial_no,
        itm_gift_card_serial_no         = s. wms_itm_gift_card_serial_no,
        itm_oe_serial_no                = s. wms_itm_oe_serial_no,
        itm_oub_customer_serial_no      = s. wms_itm_oub_customer_serial_no,
        itm_oub_warranty_serial_no      = s. wms_itm_oub_warranty_serial_no,
        itm_oub_gift_card_serial_no     = s. wms_itm_oub_gift_card_serial_no,
        itm_oub_oe_serial_no            = s. wms_itm_oub_oe_serial_no,
        itm_inbound                     = s. wms_itm_inbound,
        itm_outbound                    = s. wms_itm_outbound,
        etlactiveind           			= 1,
        etljobname             			= p_etljobname,
        envsourcecd            			= p_envsourcecd,
        datasourcecd           			= p_datasourcecd,
        etlupdatedatetime      			= NOW()  
    FROM stg.stg_wms_item_hdr s
    WHERE t.itm_code     = s.wms_itm_code
    AND   t.itm_ou    = s.wms_itm_ou;

    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_itemHeader

    (
    	itm_ou					, itm_code				, itm_short_desc			, itm_long_desc				, itm_mas_unit,
		itm_customer			, itm_class				, itm_status				, itm_ref_no				, itm_subs_item1,
		itm_hs_code				, itm_price				, itm_currency				, itm_tracking				, itm_lot_numbering,
		itm_serial_numbering	, itm_remarks			, itm_instructions			, itm_hazardous				, itm_length,
		itm_breadth				, itm_height			, itm_uom					, itm_volume				, itm_volume_uom,
		itm_weight				, itm_weight_uom		, itm_volume_calc			,
		itm_storage_from_temp	, itm_storage_to_temp	, itm_storage_temp_uom		, itm_shelf_life			, itm_shelf_life_uom,
		itm_timestamp			, itm_created_by		, itm_created_dt			, itm_modified_by			, itm_modified_dt,
		itm_reason_code			, itm_type				, itm_user_defined1			, itm_user_defined2			, itm_itemgroup,
		itm_criticaldays		, itm_criticaldays_uom	, itm_movement_type			, itm_volume_factor			, itm_volume_weight,
		itm_item_url			, itm_compilance		, itm_new_item				, itm_customer_serial_no	, itm_warranty_serial_no,
		itm_gift_card_serial_no	, itm_oe_serial_no		, itm_oub_customer_serial_no, itm_oub_warranty_serial_no, itm_oub_gift_card_serial_no,
		itm_oub_oe_serial_no	, itm_inbound			, itm_outbound				,
		etlactiveind			, etljobname			, envsourcecd				, datasourcecd				, etlcreatedatetime
    )
    
    SELECT 
       s.wms_itm_ou					, s.wms_itm_code			, s.wms_itm_short_desc				, s.wms_itm_long_desc			, s.wms_itm_mas_unit,
	   s.wms_itm_customer			, s.wms_itm_class			, s.wms_itm_status					, s.wms_itm_ref_no				, s.wms_itm_subs_item1,
	   s.wms_itm_hs_code			, s.wms_itm_price			, s.wms_itm_currency				, s.wms_itm_tracking			, s.wms_itm_lot_numbering,
	   s.wms_itm_serial_numbering	, s.wms_itm_remarks			, s.wms_itm_instructions			, s.wms_itm_hazardous			, s.wms_itm_length,
	   s.wms_itm_breadth			, s.wms_itm_height			, s.wms_itm_uom						, s.wms_itm_volume				, s.wms_itm_volume_uom,
	   s.wms_itm_weight				, s.wms_itm_weight_uom		, (s.wms_itm_length * s.wms_itm_breadth * s.wms_itm_height),
	   s.wms_itm_storage_from_temp	, s.wms_itm_storage_to_temp	, s.wms_itm_storage_temp_uom		, s.wms_itm_shelf_life			, s.wms_itm_shelf_life_uom,
	   s.wms_itm_timestamp			, s.wms_itm_created_by		, s.wms_itm_created_dt				, s.wms_itm_modified_by			, s.wms_itm_modified_dt,
	   s.wms_itm_reason_code		, s.wms_itm_type			, s.wms_itm_user_defined1			, s.wms_itm_user_defined2		, s.wms_itm_itemgroup,
	   s.wms_itm_criticaldays		, s.wms_itm_criticaldays_uom, s.wms_itm_movement_type			, s.wms_itm_volume_factor		, s.wms_itm_volume_weight,
	   s.wms_itm_item_url			, s.wms_itm_compilance		, s.wms_itm_new_item				, s.wms_itm_customer_serial_no	, s.wms_itm_warranty_serial_no,
	   s.wms_itm_gift_card_serial_no, s.wms_itm_oe_serial_no	, s.wms_itm_oub_customer_serial_no	, s.wms_itm_oub_warranty_serial_no, s.wms_itm_oub_gift_card_serial_no,
	   s.wms_itm_oub_oe_serial_no	, s.wms_itm_inbound			, s.wms_itm_outbound				,
        			1				, p_etljobname				, p_envsourcecd						,      p_datasourcecd		,         now()
    FROM stg.stg_wms_item_hdr s
    LEFT JOIN dwh.d_itemHeader t
    ON s.wms_itm_code     = t.itm_code  
    AND   s.wms_itm_ou    = t.itm_ou
    WHERE t.itm_code IS NULL;
    

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN

    INSERT INTO raw.raw_wms_item_hdr

    (
        wms_itm_ou, wms_itm_code, wms_itm_short_desc, wms_itm_long_desc, wms_itm_mas_unit, wms_itm_customer, 
        wms_itm_class, wms_itm_status, wms_itm_ref_no, wms_itm_subs_item1, wms_itm_subs_item2, 
        wms_itm_hs_code, wms_itm_price, wms_itm_currency, wms_itm_tracking, wms_itm_lot_numbering, 
        wms_itm_serial_numbering, wms_itm_remarks, wms_itm_instructions, wms_itm_hazardous, wms_itm_hazmat_no, 
        wms_itm_hazard_class, wms_itm_length, wms_itm_breadth, wms_itm_height, wms_itm_uom, wms_itm_volume, 
        wms_itm_volume_uom, wms_itm_weight, wms_itm_weight_uom, wms_itm_storage_from_temp, 
        wms_itm_storage_to_temp, wms_itm_storage_temp_uom, wms_itm_shelf_life, wms_itm_shelf_life_uom, 
        wms_itm_timestamp, wms_itm_created_by, wms_itm_created_dt, wms_itm_modified_by, wms_itm_modified_dt, 
        wms_itm_reason_code, wms_itm_type, wms_itm_user_defined1, wms_itm_user_defined2, wms_itm_user_defined3, 
        wms_itm_itemgroup, wms_itm_criticaldays, wms_itm_criticaldays_uom, wms_itm_movement_type, 
        wms_itm_volume_factor, wms_itm_volume_weight, wms_itm_item_url, wms_itm_compilance, 
        wms_itm_operation_type, wms_itm_new_item, wms_itm_customer_serial_no, wms_itm_warranty_serial_no, 
        wms_itm_gift_card_serial_no, wms_itm_oe_serial_no, wms_itm_oub_customer_serial_no, 
        wms_itm_oub_warranty_serial_no, wms_itm_oub_gift_card_serial_no, wms_itm_oub_oe_serial_no,
        wms_itm_inbound, wms_itm_outbound, etlcreateddatetime
    )
    SELECT
        wms_itm_ou, wms_itm_code, wms_itm_short_desc, wms_itm_long_desc, wms_itm_mas_unit, wms_itm_customer, 
        wms_itm_class, wms_itm_status, wms_itm_ref_no, wms_itm_subs_item1, wms_itm_subs_item2, 
        wms_itm_hs_code, wms_itm_price, wms_itm_currency, wms_itm_tracking, wms_itm_lot_numbering, 
        wms_itm_serial_numbering, wms_itm_remarks, wms_itm_instructions, wms_itm_hazardous, wms_itm_hazmat_no, 
        wms_itm_hazard_class, wms_itm_length, wms_itm_breadth, wms_itm_height, wms_itm_uom, wms_itm_volume, 
        wms_itm_volume_uom, wms_itm_weight, wms_itm_weight_uom, wms_itm_storage_from_temp, 
        wms_itm_storage_to_temp, wms_itm_storage_temp_uom, wms_itm_shelf_life, wms_itm_shelf_life_uom, 
        wms_itm_timestamp, wms_itm_created_by, wms_itm_created_dt, wms_itm_modified_by, wms_itm_modified_dt, 
        wms_itm_reason_code, wms_itm_type, wms_itm_user_defined1, wms_itm_user_defined2, wms_itm_user_defined3, 
        wms_itm_itemgroup, wms_itm_criticaldays, wms_itm_criticaldays_uom, wms_itm_movement_type, 
        wms_itm_volume_factor, wms_itm_volume_weight, wms_itm_item_url, wms_itm_compilance, 
        wms_itm_operation_type, wms_itm_new_item, wms_itm_customer_serial_no, wms_itm_warranty_serial_no, 
        wms_itm_gift_card_serial_no, wms_itm_oe_serial_no, wms_itm_oub_customer_serial_no, 
        wms_itm_oub_warranty_serial_no, wms_itm_oub_gift_card_serial_no, wms_itm_oub_oe_serial_no,
        wms_itm_inbound, wms_itm_outbound, etlcreateddatetime
    FROM stg.stg_wms_item_hdr;
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
    
    --SELECT COUNT(*) INTO InsCnt FROM dwh.usp_d_itemHeader;
END;
$$;