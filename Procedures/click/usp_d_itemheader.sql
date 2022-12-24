-- PROCEDURE: click.usp_d_itemheader()

-- DROP PROCEDURE IF EXISTS click.usp_d_itemheader();

CREATE OR REPLACE PROCEDURE click.usp_d_itemheader(
	)
LANGUAGE 'plpgsql'
AS $BODY$
Declare p_etllastrundate date;
BEGIN

	SELECT max(COALESCE(etlupdatedatetime,etlcreatedatetime)):: DATE as p_etllastrundate
	INTO p_etllastrundate
	FROM click.d_itemheader;
	
    UPDATE click.d_itemheader t
    SET
        itm_hdr_key = s.itm_hdr_key,
        itm_ou = s.itm_ou,
        itm_code = s.itm_code,
        itm_short_desc = s.itm_short_desc,
        itm_long_desc = s.itm_long_desc,
        itm_mas_unit = s.itm_mas_unit,
        itm_customer = s.itm_customer,
        itm_class = s.itm_class,
        itm_status = s.itm_status,
        itm_ref_no = s.itm_ref_no,
        itm_subs_item1 = s.itm_subs_item1,
        itm_hs_code = s.itm_hs_code,
        itm_price = s.itm_price,
        itm_currency = s.itm_currency,
        itm_tracking = s.itm_tracking,
        itm_lot_numbering = s.itm_lot_numbering,
        itm_serial_numbering = s.itm_serial_numbering,
        itm_remarks = s.itm_remarks,
        itm_instructions = s.itm_instructions,
        itm_hazardous = s.itm_hazardous,
        itm_length = s.itm_length,
        itm_breadth = s.itm_breadth,
        itm_height = s.itm_height,
        itm_uom = s.itm_uom,
        itm_volume = s.itm_volume,
        itm_volume_uom = s.itm_volume_uom,
        itm_weight = s.itm_weight,
        itm_weight_uom = s.itm_weight_uom,
        itm_storage_from_temp = s.itm_storage_from_temp,
        itm_storage_to_temp = s.itm_storage_to_temp,
        itm_storage_temp_uom = s.itm_storage_temp_uom,
        itm_shelf_life = s.itm_shelf_life,
        itm_shelf_life_uom = s.itm_shelf_life_uom,
        itm_timestamp = s.itm_timestamp,
        itm_created_by = s.itm_created_by,
        itm_created_dt = s.itm_created_dt,
        itm_modified_by = s.itm_modified_by,
        itm_modified_dt = s.itm_modified_dt,
        itm_reason_code = s.itm_reason_code,
        itm_type = s.itm_type,
        itm_user_defined1 = s.itm_user_defined1,
        itm_user_defined2 = s.itm_user_defined2,
        itm_itemgroup = s.itm_itemgroup,
        itm_criticaldays = s.itm_criticaldays,
        itm_criticaldays_uom = s.itm_criticaldays_uom,
        itm_movement_type = s.itm_movement_type,
        itm_volume_factor = s.itm_volume_factor,
        itm_volume_weight = s.itm_volume_weight,
        itm_item_url = s.itm_item_url,
        itm_compilance = s.itm_compilance,
        itm_new_item = s.itm_new_item,
        itm_customer_serial_no = s.itm_customer_serial_no,
        itm_warranty_serial_no = s.itm_warranty_serial_no,
        itm_gift_card_serial_no = s.itm_gift_card_serial_no,
        itm_oe_serial_no = s.itm_oe_serial_no,
        itm_oub_customer_serial_no = s.itm_oub_customer_serial_no,
        itm_oub_warranty_serial_no = s.itm_oub_warranty_serial_no,
        itm_oub_gift_card_serial_no = s.itm_oub_gift_card_serial_no,
        itm_oub_oe_serial_no = s.itm_oub_oe_serial_no,
        itm_inbound = s.itm_inbound,
        itm_outbound = s.itm_outbound,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = s.etlupdatedatetime
    FROM dwh.d_itemheader s
    WHERE t.itm_ou = s.itm_ou
    AND t.itm_code = s.itm_code
	AND COALESCE(s.etlupdatedatetime,s.etlcreatedatetime)::DATE >= p_etllastrundate;

    INSERT INTO click.d_itemheader(itm_hdr_key, itm_ou, itm_code, itm_short_desc, itm_long_desc, itm_mas_unit, itm_customer, itm_class, itm_status, itm_ref_no, itm_subs_item1, itm_hs_code, itm_price, itm_currency, itm_tracking, itm_lot_numbering, itm_serial_numbering, itm_remarks, itm_instructions, itm_hazardous, itm_length, itm_breadth, itm_height, itm_uom, itm_volume, itm_volume_uom, itm_weight, itm_weight_uom, itm_storage_from_temp, itm_storage_to_temp, itm_storage_temp_uom, itm_shelf_life, itm_shelf_life_uom, itm_timestamp, itm_created_by, itm_created_dt, itm_modified_by, itm_modified_dt, itm_reason_code, itm_type, itm_user_defined1, itm_user_defined2, itm_itemgroup, itm_criticaldays, itm_criticaldays_uom, itm_movement_type, itm_volume_factor, itm_volume_weight, itm_item_url, itm_compilance, itm_new_item, itm_customer_serial_no, itm_warranty_serial_no, itm_gift_card_serial_no, itm_oe_serial_no, itm_oub_customer_serial_no, itm_oub_warranty_serial_no, itm_oub_gift_card_serial_no, itm_oub_oe_serial_no, itm_inbound, itm_outbound, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.itm_hdr_key, s.itm_ou, s.itm_code, s.itm_short_desc, s.itm_long_desc, s.itm_mas_unit, s.itm_customer, s.itm_class, s.itm_status, s.itm_ref_no, s.itm_subs_item1, s.itm_hs_code, s.itm_price, s.itm_currency, s.itm_tracking, s.itm_lot_numbering, s.itm_serial_numbering, s.itm_remarks, s.itm_instructions, s.itm_hazardous, s.itm_length, s.itm_breadth, s.itm_height, s.itm_uom, s.itm_volume, s.itm_volume_uom, s.itm_weight, s.itm_weight_uom, s.itm_storage_from_temp, s.itm_storage_to_temp, s.itm_storage_temp_uom, s.itm_shelf_life, s.itm_shelf_life_uom, s.itm_timestamp, s.itm_created_by, s.itm_created_dt, s.itm_modified_by, s.itm_modified_dt, s.itm_reason_code, s.itm_type, s.itm_user_defined1, s.itm_user_defined2, s.itm_itemgroup, s.itm_criticaldays, s.itm_criticaldays_uom, s.itm_movement_type, s.itm_volume_factor, s.itm_volume_weight, s.itm_item_url, s.itm_compilance, s.itm_new_item, s.itm_customer_serial_no, s.itm_warranty_serial_no, s.itm_gift_card_serial_no, s.itm_oe_serial_no, s.itm_oub_customer_serial_no, s.itm_oub_warranty_serial_no, s.itm_oub_gift_card_serial_no, s.itm_oub_oe_serial_no, s.itm_inbound, s.itm_outbound, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, s.etlcreatedatetime
    FROM dwh.d_itemheader s
    LEFT JOIN click.d_itemheader t
    ON t.itm_ou = s.itm_ou
    AND t.itm_code = s.itm_code
    WHERE t.itm_ou IS NULL
	AND COALESCE(s.etlupdatedatetime,s.etlcreatedatetime)::DATE >= p_etllastrundate;
END;
$BODY$;
ALTER PROCEDURE click.usp_d_itemheader()
    OWNER TO proconnect;
