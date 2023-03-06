-- PROCEDURE: click.usp_f_sla_shipment()

-- DROP PROCEDURE IF EXISTS click.usp_f_sla_shipment();

CREATE OR REPLACE PROCEDURE click.usp_f_sla_shipment(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	declare 
		p_errorid integer;
		p_errordesc character varying;
        p_depsource VARCHAR(100);
begin

SELECT 	depsource
		INTO 	p_depsource
		FROM 	ods.dwhtoclickcontroldtl
		WHERE 	objectname = 'usp_f_sla_shipment'; 

	IF EXISTS 
		 (
			 SELECT 1 FROM ods.dwhtoclickcontroldtl
			 WHERE	objectname = p_depsource
			 AND	status = 'completed'
			 AND	CAST(COALESCE(loadenddatetime,loadstartdatetime) AS DATE) >= NOW()::DATE
		 )
	THEN
    
    DELETE FROM click.f_sla_shipment 
    WHERE trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;

--     create temp table f_sla_shipment_pick_tmp
--     as select ouinstance,trip_plan_id,br_customer_id,br_request_id,br_customer_ref_no,actual_departed,activeindicator
--     from click.f_shipment_details
--     where leg_behaviour = 'pick'
--     and trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE
--     and actual_departed is not null;
     
    TRUNCATE TABLE tmp.f_sla_shipment_trackingstatus_tmp;
    
    with sas as 
    (
    select ord_sono, max(cust_id) sa
    from  click.f_clientservicelog a
    group by ord_sono
    )   
    insert into tmp.f_sla_shipment_trackingstatus_tmp(ord_sono,cust_id,trackingstatus)
    select a.ord_sono, a.cust_id, a.trackingstatus
    from   sas
    inner join click.f_clientservicelog a
    on         a.ord_sono = sas.ord_sono
    and        a.cust_id = sas.sa;

	insert into click.f_sla_shipment
	(
		shipment_dtl_key,				customer_key,					br_key,							loc_key,			        
		vendor_key,						activeindicator,
		sla_ou,                         sla_customer_id,                sla_br_id,                      sla_cust_ref_no,        
		sla_service_type,               sla_sub_service_type,           sla_location,                   agent_id,                                          
		agent_name,						opening_time,                   cutofftime,                     order_confirmed_date_time,
        dispatch_tat,                   actual_dispatched_date_time,    actual_delivered_date_time,     dispatch_exptd_date_time,       
        delivery_exptd_date_time,		trip_plan_createddate,          tracking_status,                br_order_type,    order_qualified_date,      podflag,      createddate
	)
	select 
		coalesce(a.shipment_dtl_key,-1),coalesce(a.ship_customer_key,-1),coalesce(a.br_key,-1),			coalesce(a.ship_loc_key,-1),
		coalesce(e.vendor_key,-1),		max(a.activeindicator),
		a.ouinstance,					a.br_customer_id,				a.br_request_id,				a.br_customer_ref_no,
		a.service_type,					a.sub_service_type,				a.loc,							a.agent_id,
		e.vendor_name,					max(d.openingtime),				max(d.cutofftime),				max(coalesce(b.oub_modified_date , b.oub_orderdate))::timestamp,
        max(c.disptat),                 /*tmp.actual_departed::timestamp*/  NULL , a.actual_departed::timestamp,
		(case 
		when max(coalesce(b.oub_modified_date,b.oub_created_date))::time < max(d.cutofftime)
		then 
		max(coalesce(b.oub_modified_date,b.oub_created_date))::timestamp + (max(c.disptat) || ' minutes')::interval
		else 
		((max(coalesce(b.oub_modified_date,b.oub_created_date))+ interval '1 day')::date ||' '||(max(d.openingtime)))::timestamp + (max(c.disptat) || ' minutes')::interval 
		end 
		),
		a.expected_datetodeliver,       a.trip_plan_createddate,        tmp1.trackingstatus,            a.br_order_type,    co.oub_orderqualifieddate,  a.podflag,
        now()::timestamp
	from click.f_shipment_details a
--     join f_sla_shipment_pick_tmp tmp
--     on  a.ouinstance     = tmp.ouinstance
--     and a.trip_plan_id   = tmp.trip_plan_id
--     and a.br_request_id  = tmp.br_request_id
	left join dwh.f_outboundheader b
	on  a.ouinstance        = b.oub_ou
	and a.loc               = left(b.oub_loc_code,6)
	and a.br_customer_ref_no= b.oub_prim_rf_dc_no
    left join click.f_outboundheader co
	on  a.ouinstance        = co.oub_ou
	and a.loc               = left(co.oub_loc_code,6)
	and a.br_customer_ref_no= co.oub_prim_rf_dc_no
	left join dwh.d_outboundtat c
	on  c.ou           = b.oub_ou
	and c.locationcode = b.oub_loc_code
	and c.ordertype    = b.oub_order_type 
	and c.servicetype  = b.oub_shipment_type
	left join dwh.d_outboundlocshiftdetail d
	on  c.ou            = d.ou
	and c.locationcode  = d.locationcode
	and c.ordertype     = d.ordertype 
	and c.servicetype   = d.servicetype
    left join tmp.f_sla_shipment_trackingstatus_tmp tmp1
    on a.br_customer_ref_no = tmp1.ord_sono
	left join dwh.d_vendor e
	on  a.ouinstance	= e.vendor_ou
	and a.agent_id		= e.vendor_id
    where a.leg_behaviour='dvry'
    and trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE
	group by 	coalesce(a.shipment_dtl_key,-1),    coalesce(a.ship_customer_key,-1),   coalesce(a.br_key,-1),	coalesce(a.ship_loc_key,-1),    coalesce(e.vendor_key,-1),
                a.ouinstance,				        a.br_customer_id,		            a.br_request_id,		a.br_customer_ref_no,		    a.service_type,
				a.sub_service_type,			        a.loc,					            a.agent_id,				e.vendor_name,				    a.leg_behaviour,			
				/*tmp.actual_departed,*/                a.actual_departed,			        a.expected_datetodeliver,a.trip_plan_createddate,       tmp1.trackingstatus,         a.br_order_type,   co.oub_orderqualifieddate,  a.podflag;

-----------------------------------------------------------------------------------------------------------------------------
	
    

--     update click.f_sla_shipment d
--     set actual_dispatched_date_time = a1.actual_departed::timestamp
--     from f_sla_shipment_pick_tmp  a1
--     where d.sla_ou              =    a1.ouinstance    
--     and   d.sla_customer_id     =    a1.br_customer_id
--     and   d.sla_br_id           =    a1.br_request_id
--     and   d.sla_cust_ref_no     =    a1.br_customer_ref_no;
   -- and extract(year from trip_plan_createddate::date) = 2019;
    
    
        
	update click.f_sla_shipment sla
	set 	dispatch_ontime_flag = (case  when actual_dispatched_date_time::date <= dispatch_exptd_date_time then 1
										  when actual_dispatched_date_time::date >  dispatch_exptd_date_time then 0 
										  else null
									 end),
			deliver_ontime_flag =	(case when actual_delivered_date_time::date <= delivery_exptd_date_time then 1 
										  when actual_delivered_date_time::date >  delivery_exptd_date_time then 0 
										  else null
									 end)
	where trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;

	
	
    update click.f_sla_shipment sla
	set sla_category 	= (case when deliver_ontime_flag is null  and now()::date <= delivery_exptd_date_time then 'in transit'
								when deliver_ontime_flag is null  and now()::date >  delivery_exptd_date_time then 'un delivered'
						   end)
	where sla_category is null
	and trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;
	
	

    update click.f_sla_shipment sla
	set sla_category 	= (case when deliver_ontime_flag = 0  then 'breach'
								when deliver_ontime_flag = 1  then 'achieved'
						   end)
	where sla_category is null
	and trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;
    
    
    update click.f_sla_shipment
    set podflag = 0 
    where podflag IS NULL
    AND trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;
	
    
	ELSE	
	p_errorid   := 0;
		IF p_depsource IS NULL
			THEN 
			 	p_errordesc := 'The Dependent source cannot be NULL.';
			ELSE
				p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source.';
			END IF;
		call ods.usp_etlerrorinsert('click','f_sla_shipment','click',null,'de-normalized','sp_exceptionhandling',p_errorid,p_errordesc,null);

    END IF;
    
    exception when others then       
 	get stacked diagnostics p_errorid = returned_sqlstate, p_errordesc = message_text;
 	call ods.usp_etlerrorinsert('click','f_sla_shipment','click',null,'de-normalized','sp_exceptionhandling',p_errorid,p_errordesc,null);
	
end;
$BODY$;
ALTER PROCEDURE click.usp_f_sla_shipment()
    OWNER TO proconnect;
