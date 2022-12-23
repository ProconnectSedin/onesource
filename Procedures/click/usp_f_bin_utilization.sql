CREATE PROCEDURE click.usp_f_bin_utilization()
    LANGUAGE plpgsql
    AS $$

BEGIN
 
 


INSERT INTO click.f_bin_utilization
(
    ou,	                location,	        customer_code,	       zone,	               bin_id,	
    bin_type,	        bin_volume,	        bin_volume_uom,	       bin_area,	           stock_date,
    item_code,	        bin_on_hand_qty,	item_volume,	       item_volume_uom,	       item_area,
    utilized_volume_pct,utilized_area_pct
)
select 
    a.bin_ou,           a.bin_loc_code,     b.stock_customer,      a.bin_zone,              a.bin_code,
    a.bin_type,         d.bin_typ_volume,   d.bin_typ_vol_uom,
    (d.bin_typ_width)*(d.bin_typ_height) as Bin_Area,              b.stock_date,            b.stock_item,
    b.stock_bin_qty,    (c.itm_volume)*(b.stock_bin_qty) as Item_Volume,                    c.itm_volume_uom ,
    ((c.itm_length)*(c.itm_breadth))*(b.stock_bin_qty) as Item_Area,
    ((((c.itm_volume)*(b.stock_bin_qty))/d.bin_typ_volume)*100) as Utilized_Volume,
    (((c.itm_length)*(c.itm_breadth))/((d.bin_typ_width)*(d.bin_typ_height))*100) as Utilized_Area
from dwh.f_bindetails a
join dwh.f_stockbinhistorydetail b
on  a.bin_dtl_key   = b.bin_dtl_key
join dwh.d_itemheader c
on  b.stock_item_key= c.itm_hdr_key
join dwh.d_bintypes d 
on  a.bin_typ_key  = d.bin_typ_key;

END;
$$;