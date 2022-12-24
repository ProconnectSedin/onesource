-- PROCEDURE: click.usp_f_sla_shipment()

-- DROP PROCEDURE IF EXISTS click.usp_f_sla_shipment();

CREATE OR REPLACE PROCEDURE click.usp_f_sla_shipment(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	declare 
		p_errorid integer;
		p_errordesc character varying;
begin

	insert into click.f_sla_shipment
	(
		shipment_dtl_key,				customer_key,					br_key,							loc_key,			vendor_key,
		sla_ou,                         sla_customer_id,                sla_br_id,                      sla_cust_ref_no,        
		sla_service_type,               sla_sub_service_type,           sla_location,                   agent_id,                                          
		agent_name,						opening_time,                   cutofftime,                     order_confirmed_date_time,
        dispatch_tat,
		actual_delivered_date_time,     dispatch_exptd_date_time,       delivery_exptd_date_time,		
		createddate
	)
	select 
		coalesce(a.shipment_dtl_key,-1),coalesce(a.ship_customer_key,-1),coalesce(a.br_key,-1),			coalesce(a.ship_loc_key,-1),					coalesce(e.vendor_key,-1),
		a.ouinstance,					a.br_customer_id,				a.br_request_id,				a.br_customer_ref_no,
		a.service_type,					a.sub_service_type,				a.loc,							a.agent_id,
		e.vendor_name,					max(d.openingtime),				max(d.cutofftime),				max(coalesce(b.oub_modified_date , b.oub_orderdate))::timestamp as order_confirmed_date_time,
        max(c.disptat) as dispatch_tat,
		a.actual_departed::timestamp as actual_delivered_date_time,
		(case 
		when max(coalesce(b.oub_modified_date,b.oub_created_date))::time < max(d.cutofftime)
		then 
		max(coalesce(b.oub_modified_date,b.oub_created_date))::timestamp + (max(c.disptat) || ' minutes')::interval
		else 
		((max(coalesce(b.oub_modified_date,b.oub_created_date))+ interval '1 day')::date ||' '||(max(d.openingtime)))::timestamp + (max(c.disptat) || ' minutes')::interval 
		end 
		)as dis_expected_closure_time ,
		a.expected_datetodeliver as del_expected_closure_time,			now()::timestamp
	from click.f_shipment_details_bkb22122022 a
	inner join dwh.f_outboundheader b
	on  a.ouinstance        = b.oub_ou
	and a.loc               = left(b.oub_loc_code,6)
	and a.br_customer_ref_no= b.oub_prim_rf_dc_no
	left join dwh.d_wmsoutboundtat c
	on  c.ou           = b.oub_ou
	and c.locationcode = b.oub_loc_code
	and c.ordertype    = b.oub_order_type 
	and c.servicetype  = b.oub_shipment_type
	left join dwh.d_outboundlocshiftdetail d
	on  c.ou            = d.ou
	and c.locationcode  = d.locationcode
	and c.ordertype     = d.ordertype 
	and c.servicetype   = d.servicetype
	left join dwh.d_vendor e
	on  a.ouinstance	= e.vendor_ou
	and a.agent_id		= e.vendor_id
    where a.leg_behaviour='dvry'
	group by 	coalesce(a.shipment_dtl_key,-1),    coalesce(a.ship_customer_key,-1),   coalesce(a.br_key,-1),	coalesce(a.ship_loc_key,-1),    coalesce(e.vendor_key,-1),
                a.ouinstance,				        a.br_customer_id,		            a.br_request_id,		a.br_customer_ref_no,		    a.service_type,
				a.sub_service_type,			        a.loc,					            a.agent_id,				e.vendor_name,				    a.leg_behaviour,			
				a.actual_departed,			        a.expected_datetodeliver;

-----------------------------------------------------------------------------------------------------------------------------
	
    CREATE TEMP TABLE f_sla_shipment_pick_tmp
    AS SELECT ouinstance,br_customer_id,br_request_id,br_customer_ref_no,actual_departed
    FROM click.f_shipment_details 
    WHERE leg_behaviour = 'pick';
    --AND EXTRACT(YEAR FROM trip_plan_createddate::DATE) =  2019; 

    UPDATE click.f_sla_shipment d
    SET actual_dispatched_date_time = a1.Actual_Departed::timestamp
    FROM f_sla_shipment_pick_tmp  a1
    WHERE d.sla_ou              =    a1.ouinstance    
    AND   d.sla_customer_id     =    a1.br_customer_id
    AND   d.sla_br_id           =    a1.br_request_id
    and   d.sla_cust_ref_no     =    a1.br_customer_ref_no;
   -- AND EXTRACT(YEAR FROM trip_plan_createddate::DATE) = 2019;
    
    
        
	update click.f_sla_shipment sla
	set 	dispatch_ontime_flag = (case when actual_dispatched_date_time::date <= dispatch_exptd_date_time then 1
										  when actual_dispatched_date_time::date >  dispatch_exptd_date_time then 0 
										  else null
									 end),
			deliver_ontime_flag =	(case when actual_delivered_date_time::date <= delivery_exptd_date_time then 1 
										  when actual_delivered_date_time::date >  delivery_exptd_date_time then 0 
										  else null
									 end)
	where extract(year from order_confirmed_date_time::date)  = 2022;
	--where sla.order_date_time >= (now() - interval '3 months')::date;
	
	
	update click.f_sla_shipment sla
	set sla_category 	= (case when deliver_ontime_flag is null and dispatch_ontime_flag is not null and now()::date <= delivery_exptd_date_time then 'in transit'
								when deliver_ontime_flag is null and dispatch_ontime_flag is not null and now()::date >  delivery_exptd_date_time then 'un delivered'
						   end)
	where extract(year from order_confirmed_date_time::date)  = 2022
	and sla_category is null;
	--where sla.order_date_time >= (now() - interval '3 months')::date;
	

	update click.f_sla_shipment sla
	set sla_category 	= (case when deliver_ontime_flag = 0  then 'breach'
								when deliver_ontime_flag = 1  then 'achieved'
						   end)
	where extract(year from order_confirmed_date_time::date)  = 2022
	and sla_category is null;
	--where sla.sla_orderdate >= (now() - interval '3 months')::date;
	
	
	exception when others then       
	get stacked diagnostics p_errorid = returned_sqlstate, p_errordesc = message_text;
 	call ods.usp_etlerrorinsert('click','f_sla_shipment','click',null,'de-normalized','sp_exceptionhandling',p_errorid,p_errordesc,null);
	
end;
$BODY$;
ALTER PROCEDURE click.usp_f_sla_shipment()
    OWNER TO proconnect;
