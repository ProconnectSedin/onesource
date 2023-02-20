-- PROCEDURE: click.usp_f_wmsoperations()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmsoperations();

CREATE OR REPLACE PROCEDURE click.usp_f_wmsoperations(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	p_depsource VARCHAR(100);
	
BEGIN
			TRUNCATE TABLE click.f_wmpoperations;
			INSERT INTO click.f_wmpoperations
			(orderqualifieddate,orderqualifieddatekey,ouid,locationcode,customerid,attributecode,attributeweightpercnt,totalreceivedorders)
			select a.sla_orderqualifieddate::DATE,a.sla_orderqualifieddatekey,a.sla_ouid,a.sla_loccode,a.sla_customerid,b.attribute_code,b.attribute_prcnt,
			count(distinct a.sla_prefdocno)
			from click.f_inboundsladetail a
			LEFT join click.d_wmpcustattrimap b
			on customer_id = sla_customerid
			where b.attribute_code = 'INB'
			and a.sla_orderqualifieddate::DATE >= (NOW() - INTERVAL '6 Months')::DATE
-- 			and extract(month from a.sla_orderqualifieddate) = 12
-- 			and extract(year from a.sla_orderqualifieddate) = 2022
			group by a.sla_orderqualifieddate::DATE,a.sla_orderqualifieddatekey,a.sla_ouid,a.sla_loccode,a.sla_customerid,b.attribute_code,b.attribute_prcnt;
			 
		insert into click.f_wmpoperations
		(
		ouid ,orderqualifieddate ,orderqualifieddatekey,locationcode ,customerid , attributecode ,attributeweightpercnt ,totalreceivedorders
		)
		select
		a.sla_ou,a.sla_orderqualifieddate::date,sla_orderqualifieddatekey,a.sla_loccode,a.sla_customercode,
				b.attribute_code,b.attribute_prcnt, count(distinct sla_sono)
		from click.f_outboundsladetail a
		inner join click.d_wmpcustattrimap b
		on a.sla_customercode = b.customer_id
		where b.attribute_code = 'OUB'
		and a.sla_orderqualifieddate::DATE >= (NOW() - INTERVAL '6 Months')::DATE
-- 		and extract(year from sla_orderqualifieddate) = 2022
-- 		and extract(month from sla_orderqualifieddate) = 12
		group by distinct a.sla_ou,a.sla_orderqualifieddate::date,sla_orderqualifieddatekey,a.sla_loccode,a.sla_customercode,
		b.attribute_code,b.attribute_prcnt;
		
		UPDATE click.f_wmpoperations wop
		SET ordcompletedontime  = ordercompletedonetime
		FROM (
		select a.sla_ouid,a.sla_orderqualifieddatekey,a.sla_loccode,a.sla_customerid,b.attribute_code,b.attribute_prcnt,
			count(distinct a.sla_prefdocno) as ordercompletedonetime
			from click.f_inboundsladetail a
			LEFT join click.d_wmpcustattrimap b
			on customer_id = sla_customerid
			where b.attribute_code = 'INB'
			and a.sla_orderqualifieddate::DATE >= (NOW() - INTERVAL '6 Months')::DATE
-- 			and extract(month from a.sla_orderqualifieddate) = 12
-- 			and extract(year from a.sla_orderqualifieddate) = 2022
			and a.sla_category in ('Achieved','Premium','Remarks')
			group by a.sla_ouid,a.sla_orderqualifieddatekey,a.sla_loccode,a.sla_customerid,b.attribute_code,b.attribute_prcnt
			)td
		WHERE td.sla_ouid		=	wop.ouid
		AND td.sla_orderqualifieddatekey = wop.orderqualifieddatekey
		AND td.sla_loccode		  = wop.locationcode
		AND td.sla_customerid	  = wop.customerid
		AND wop.attributecode	= 'INB';
	
	update click.f_wmpoperations cwmp
	set ordcompletedontime= wm.ordcompletedontime
	from (	select a.sla_ou,sla_orderqualifieddatekey,a.sla_loccode,a.sla_customercode,
				b.attribute_code,b.attribute_prcnt, count(distinct sla_sono) as ordcompletedontime
	from click.f_outboundsladetail a
	inner join click.d_wmpcustattrimap b
	on a.sla_customercode = b.customer_id
	where b.attribute_code = 'OUB'
	and a.sla_orderqualifieddate::DATE >= (NOW() - INTERVAL '6 Months')::DATE
-- 	and extract(year from sla_orderqualifieddate) = 2022
-- 	and extract(month from sla_orderqualifieddate) = 12
	and a.sla_category in ('Achieved','Premium','Remarks')
	group by distinct a.sla_ou,sla_orderqualifieddatekey,a.sla_loccode,a.sla_customercode,b.attribute_code,b.attribute_prcnt
	   ) wm
	  where cwmp.ouid	= wm.sla_ou
	  and cwmp.locationcode	= wm.sla_loccode
	  and cwmp.orderqualifieddatekey = wm.sla_orderqualifieddatekey
	  and cwmp.attributecode = 'OUB';
	
	UPDATE click.f_wmpoperations wop
		SET totalprocessedorders  = ordercompletedonetime
		FROM (
		select a.sla_ouid,a.sla_orderqualifieddatekey,a.sla_loccode,a.sla_customerid,b.attribute_code,b.attribute_prcnt,
			count(distinct a.sla_prefdocno) as ordercompletedonetime
			from click.f_inboundsladetail a
			LEFT join click.d_wmpcustattrimap b
			on customer_id = sla_customerid
			where b.attribute_code = 'INB'
			and a.sla_orderqualifieddate::DATE >= (NOW() - INTERVAL '6 Months')::DATE
-- 			and extract(month from a.sla_orderqualifieddate) = 12
-- 			and extract(year from a.sla_orderqualifieddate) = 2022
			and a.sla_category in ('Achieved','Premium','Remarks','Breach')
			group by a.sla_ouid,a.sla_orderqualifieddatekey,a.sla_loccode,a.sla_customerid,b.attribute_code,b.attribute_prcnt
			)td
		WHERE td.sla_ouid		=	wop.ouid
		AND td.sla_orderqualifieddatekey = wop.orderqualifieddatekey
		AND td.sla_loccode		  = wop.locationcode
		AND td.sla_customerid	  = wop.customerid
		AND wop.attributecode	= 'INB';
	
	update click.f_wmpoperations cwmp
	set totalprocessedorders= wm.ordcompletedontime
	from (	select a.sla_ou,sla_orderqualifieddatekey,a.sla_loccode,a.sla_customercode,
				b.attribute_code,b.attribute_prcnt, count(distinct sla_sono) as ordcompletedontime
	from click.f_outboundsladetail a
	inner join click.d_wmpcustattrimap b
	on a.sla_customercode = b.customer_id
	where b.attribute_code = 'OUB'
	and a.sla_orderqualifieddate::DATE >= (NOW() - INTERVAL '6 Months')::DATE
-- 	and extract(year from sla_orderqualifieddate) = 2022
-- 	and extract(month from sla_orderqualifieddate) = 12
	and a.sla_category in ('Achieved','Premium','Remarks','Breach')
	group by distinct a.sla_ou,sla_orderqualifieddatekey,a.sla_loccode,a.sla_customercode,b.attribute_code,b.attribute_prcnt
	   ) wm
	  where cwmp.ouid	= wm.sla_ou
	  and cwmp.locationcode	= wm.sla_loccode
	  and cwmp.orderqualifieddatekey = wm.sla_orderqualifieddatekey
	  and cwmp.attributecode = 'OUB';		
		/*
		UPDATE click.f_wmpoperations wop
		SET totalreceivedlines  = receivedline
		FROM (
			select a.ou_id,a.asnqualifieddatekey,a.loc_code,a.customer_id,
			SUM(receivedlinecount) as receivedline
			from click.f_wmsinboundsummary a
			LEFT join click.d_wmpcustattrimap b
			on a.customer_id = b.customer_id
			where b.attribute_code = 'INB'
			and asnqualifieddatekey >= 20221201
			and asnqualifieddatekey <= 20221231
			group by a.ou_id,a.asnqualifieddatekey,a.loc_code,a.customer_id
			)td
		WHERE td.ou_id		=	wop.ouid
		AND td.asnqualifieddatekey = wop.orderqualifieddatekey
		AND td.loc_code		  = wop.locationcode
		AND td.customer_id	  = wop.customerid
		AND wop.attributecode	= 'INB';
		
	update click.f_wmpoperations a
	set totalreceivedlines = ab.receivedline
	from (	select a.oub_ou,orderqualifieddatekey,a.oub_loccode,a.oub_custcode,
					SUM(oub_totoutboundline) as receivedline
		from click.f_wmsoutboundsummary a
		inner join click.d_wmpcustattrimap b
		on a.oub_custcode = b.customer_id		
		where b.attribute_code = 'OUB' and
		extract(year from orderqualifieddate) = 2022
		and extract(month from orderqualifieddate) = 12
		group by a.oub_ou,orderqualifieddatekey,a.oub_loccode,a.oub_custcode
	  ) ab
	 where a.ouid	= ab.oub_ou
	and a.orderqualifieddatekey	= ab.orderqualifieddatekey
	and a.locationcode	= ab.oub_loccode
	and a.customerid	= ab.oub_custcode
	and a.attributecode = 'OUB';	
		
		UPDATE click.f_wmpoperations wop
		SET totalprocessedlines  = pwayline
		FROM (
			select a.ou_id,a.asnqualifieddatekey,a.loc_code,a.customer_id,
			SUM(receivedlinecount) as pwayline
			from click.f_wmsinboundsummary a
			LEFT join click.d_wmpcustattrimap b
			on a.customer_id = b.customer_id
			where b.attribute_code = 'INB'
			and asnqualifieddatekey >= 20221201
			and asnqualifieddatekey <= 20221231
			and a.pway_status in ('CMPLTD','SHTCLS')
			group by a.ou_id,a.asnqualifieddatekey,a.loc_code,a.customer_id
			)td
		WHERE td.ou_id		=	wop.ouid
		AND td.asnqualifieddatekey = wop.orderqualifieddatekey
		AND td.loc_code		  = wop.locationcode
		AND td.customer_id	  = wop.customerid
		AND wop.attributecode	= 'INB';
		
		update click.f_wmpoperations a
		set totalprocessedlines = coalesce(ab.receivedline, 0)
		from (select
		 	a.oub_ou,orderqualifieddatekey,a.oub_loccode,a.oub_custcode
					,coalesce( SUM(oub_totoutboundline), 0) as receivedline
		from click.f_wmsoutboundsummary a
		inner join click.d_wmpcustattrimap b
		on a.oub_custcode = b.customer_id		
		where b.attribute_code = 'OUB' and
		extract(year from orderqualifieddate) = 2022
		and extract(month from orderqualifieddate) = 12
	  	and oub_packexecstatus in ('CMPD', 'STCLS')	
		group by a.oub_ou,orderqualifieddatekey,a.oub_loccode,a.oub_custcode
	  ) ab
	 where a.ouid	= ab.oub_ou
	and a.orderqualifieddatekey	= ab.orderqualifieddatekey
	and a.locationcode	= ab.oub_loccode
	and a.customerid	= ab.oub_custcode
	and a.attributecode = 'OUB';
	*/	
	UPDATE click.f_wmpoperations 
	SET	orderfullfillmentpercnt   = ((COALESCE(cast(totalprocessedorders as numeric(21,2)),0)/COALESCE(cast(totalreceivedorders as numeric(21,2)),0))*100),
		slapercnt	=	(((COALESCE(cast(ordcompletedontime as numeric(21,2)),0)/COALESCE(cast(totalreceivedorders as numeric(21,2)),0))*100)*COALESCE(attributeweightpercnt,0))/100,
		ontimecompletedpercnt	= ((COALESCE(cast(ordcompletedontime as numeric(21,2)),0)/COALESCE(cast(totalreceivedorders as numeric(21,2)),0))*100);
	
	/*,
		orderfullfillmentpercnt	= (COALESCE(totalprocessedlines,0)/COALESCE(totalreceivedlines,0))*100,
		slapercnt	=	(((COALESCE(ordcompletedontime,0)/COALESCE(totalorders,0))*100)*COALESCE(attributeweightpercnt,0))/100;
	*/
	
	UPDATE click.f_wmpoperations 
	SET	locationname = loc_desc,
		locationcity = city,
		locationstate = state		
	FROM click.d_location
	WHERE locationcode = loc_code;
	
	UPDATE click.f_wmpoperations 
	SET	customername = customer_name
	FROM click.d_customer 
	WHERE customerid = customer_id
	AND   ouid	=	customer_ou;

	UPDATE click.f_wmpoperations 
	SET divisioncode = div_code
	FROM click.d_divloclist
	WHERE locationcode = div_loc_code;

	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('click','usp_f_wmsoperations','click',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmsoperations()
    OWNER TO proconnect;
