-- PROCEDURE: click.usp_f_wh_space_detail()

-- DROP PROCEDURE IF EXISTS click.usp_f_wh_space_detail();

CREATE OR REPLACE PROCEDURE click.usp_f_wh_space_detail(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
    
BEGIN

        TRUNCATE TABLE click.f_wh_space_detail
		RESTART IDENTITY;
        
        
        INSERT INTO click.f_wh_space_detail
	    (
			loc_key,                div_key,            OU,               		Division,                   Division_Name,          
            Location_Name,          Location_code,      Customer_Name,    		Customer_Code,              Super_BuildUp,          
            CarpeT_Area,            IB_staging_area,    OB_staging_area,  		Office_area,                Others,                 
            Storage_area,           Area_UOM,           Customer_IB_area, 		Customer_OB_area,           Customer_Office_area,   
            Customer_storage_area,  Customer_other_area,Customer_Total_area,	Customer_area_uom,	        Not_Allocated,          
            Status, 			    createddate
		)
		select 
			COALESCE(a.loc_pop_loc_key,-1), COALESCE(b.div_key,-1),a.loc_pop_ou,				e.div_code,					d.div_desc,				
            b.loc_desc,				a.loc_pop_code,             g.clo_cust_name,		g.clo_cust_code,			e.div_tot_area,			
            e.div_storg_area,		e.div_tot_stag_area,        e.div_outbound_area,	e.div_office_area,			e.div_other_area,
			(COALESCE(e.div_storg_area,0))-(COALESCE(e.div_tot_stag_area,0)+COALESCE(e.div_outbound_area,0)+COALESCE(e.div_office_area,0)+COALESCE(e.div_other_area,0)) as Storage_Area,
			e.div_area_uom,			a.loc_pop_tot_stag_area,	a.loc_outbound_area,	a.loc_office_area,			a.loc_pop_storg_area,
			a.loc_other_area,		(COALESCE(a.loc_pop_storg_area,0)+COALESCE(a.loc_other_area,0))as Customer_Total_Area,
			a.loc_pop_area_uom,		((COALESCE(e.div_storg_area,0))-(COALESCE(a.loc_pop_storg_area,0)+COALESCE(a.loc_other_area,0))) as Not_Allocated,
			(CASE
				WHEN (((COALESCE(e.div_storg_area,0))-(COALESCE(a.loc_pop_storg_area,0)+COALESCE(a.loc_other_area,0))))=0 Then 'Good'
				WHEN (((COALESCE(e.div_storg_area,0))-(COALESCE(a.loc_pop_storg_area,0)+COALESCE(a.loc_other_area,0))))<0 Then 'Conflict'
				WHEN (((COALESCE(e.div_storg_area,0))-(COALESCE(a.loc_pop_storg_area,0)+COALESCE(a.loc_other_area,0))))>0 Then 'Free Space'
			END) as Status, 		NOW()::TIMESTAMP
		from  dwh.f_locationareadetail a
		left join  dwh.d_location b
		on    a.loc_pop_loc_key = b.loc_key
		left join  dwh.d_division d
		on    d.div_key         = b.div_key
		left join  dwh.f_divisionareadetail e
		on    d.div_key         = e.div_key
		left join  dwh.d_customerLocDiv f
		on    b.loc_ou 			= f.wms_customer_ou
		and   b.loc_code 		= f.wms_customer_code
		left join  dwh.d_customerlocationinfo g
		on    g.clo_cust_code 	= f.wms_customer_id;
        
    EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_wh_space_detail','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_wh_space_detail()
    OWNER TO proconnect;
