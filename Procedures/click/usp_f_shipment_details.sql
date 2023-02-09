-- PROCEDURE: click.usp_f_shipment_details()

-- DROP PROCEDURE IF EXISTS click.usp_f_shipment_details();

CREATE OR REPLACE PROCEDURE click.usp_f_shipment_details(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
    p_errorid integer;
	p_errordesc character varying;

BEGIN

--TRUNCATE ONLY click.f_shipment_details RESTART IDENTITY;
DELETE FROM click.f_shipment_details
WHERE trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;

INSERT INTO click.f_shipment_details
(		br_key,						ship_loc_key,				ship_customer_key,
	    ouinstance,			     	br_request_id,			    br_customer_id,			        br_customer_ref_no,				   br_status,
	    service_type,			    sub_service_type,		    trip_plan_id,			        trip_plan_status,				   vehicle_type,
	    vehicle_id,			     	agent_id,				    agent_resource,			        loc,							   from_city,
	    from_state,			     	to_city,				    to_state,				        leg_behaviour,					   trip_plan_date,
	    trip_plan_end_date,	     	trip_plan_seq,			    dispatch_doc_no,		        dispatch_doc_type,				   veh_in_dim_uom,
	    Veh_Volume,			     	Planned_TripStart,		    Planned_Arrived,		        Planned_TakenOver_HandedOver,	   Planned_Departed,
	    Planned_TripEnd,		    Actual_TripStart,		    Actual_Arrived,			        Actual_TakenOver_HandedOver,	   Actual_Departed,
	    Actual_TripEnd,		     	br_invoice_value,		    OnTime_Pickup_Delivery,	        ShipmentDays,					   createddatetime,					
	  	trip_plan_DateKey,		    trip_Exec_DateKey,			Trip_Volume,					Trip_Volume_uom,
		trip_plan_createddate,		from_pincode,				to_pincode,
 		activeindicator
)
 SELECT   
		 br_key,					 br_loc_key,				br_customer_key,
		 br_ouinstance,				 br_request_id,			    br_customer_id,				    br_customer_ref_no,					br_status,
		 br_service_type,		     br_sub_service_type,	    plpth_trip_plan_id,			    plpth_trip_plan_status,				plpth_vehicle_type,		
		 plpth_vehicle_id,		     plpth_agent_id,		    plpth_agent_resource,	    	plpth_location,						brsd_from_city,
		 brsd_from_state,		     brsd_to_city,			    brsd_to_state,				    plptd_leg_behaviour,				plpth_trip_plan_date,
		 plpth_trip_plan_end_date,	 plptd_trip_plan_seq,		ddh_dispatch_doc_no,			ddh_dispatch_doc_type,				veh_in_dim_uom,
		 VehicleVolumne,			 PlannedTripStart,			PlannedArrived,					Planned_TakenOver_HandedOver,		Planned_Departed,
		 Planned_TripEnd,			 ActualTripStart,			ActualArrived,					Actual_TakenOver_HandedOver,		Actual_Departed,
		 Actual_TripEnd,			 br_invoice_value,			CASE WHEN Actual_TakenOver_HandedOver  <= Planned_TakenOver_HandedOver THEN 1 ELSE 0 END AS OnTime_Pickup_Delivery,
		 NULL AS ShipmentDays,		 CURRENT_DATE AS CreatedDate,								trip_plan_DateKey,					COALESCE(TO_CHAR(Actual_TakenOver_HandedOver, 'YYYYMMDD')::INTEGER,-1) as trip_exec_DateKey,
		 tltd_volume,				 tltd_volume_uom,			
		 trip_plan_createddate,		 brsd_from_postal_code,		brsd_to_postal_code,
		 activeindicator
FROM(
	SELECT 	 
		 a.br_key,					 a.br_loc_key,				a.br_customer_key,
		 a.br_ouinstance,			 a.br_request_id,			a.br_customer_id,				a.br_customer_ref_no,				a.br_status,
		 a.br_service_type,			 a.br_sub_service_type  
		,H.plpth_trip_plan_id,           H.plpth_trip_plan_status,			H.plpth_vehicle_type,
		 H.plpth_vehicle_id,		 CASE WHEN a.br_service_type = 'DD' THEN f.veh_agency_id ELSE H.plpth_agent_id END,
		 H.plpth_agent_resource,			H.plpth_location,					b.brsd_from_city,
		 b.brsd_from_state,			 b.brsd_to_city,			b.brsd_to_state,				d.plptd_leg_behaviour, 				plpth_start_time::DATE AS plpth_trip_plan_date , 
		 H.plpth_trip_plan_end_date::DATE AS plpth_trip_plan_end_date,
		 d.plptd_trip_plan_seq,		 c.ddh_dispatch_doc_no,		c.ddh_dispatch_doc_type,		f.veh_in_dim_uom,
		 COALESCE(veh_in_length,0)*COALESCE(veh_in_width,0)*COALESCE(veh_in_height,0) AS VehicleVolumne,
		 PlannedTripStart AS PlannedTripStart,			PlannedArrived AS PlannedArrived,
		 CASE WHEN plptd_leg_behaviour = 'Pick' THEN PlannedTakenOver
			  WHEN plptd_leg_behaviour = 'Dvry' THEN PlannedHandedOver
			  END AS Planned_TakenOver_HandedOver,
		 CASE WHEN plptd_leg_behaviour = 'Pick' THEN PlannedPickDepart
			  WHEN plptd_leg_behaviour = 'Dvry' THEN PlannedDeliveryDepart
			  END AS Planned_Departed,
		PlannedTripEnd::DATE AS Planned_TripEnd,               ActualTripStart AS ActualTripStart,							ActualArrived::DATE AS ActualArrived,
		CASE  WHEN plptd_leg_behaviour = 'Pick' THEN ActualTakenOver
			  WHEN plptd_leg_behaviour = 'Dvry' THEN ActualHandedOver
			  END AS Actual_TakenOver_HandedOver,
		CASE  WHEN plptd_leg_behaviour = 'Pick' THEN ActualPickDepart
			  WHEN plptd_leg_behaviour = 'Dvry' THEN ActualDeliveryDepart
			  END AS Actual_Departed,
		ActualTripEnd AS Actual_TripEnd,					a.br_invoice_value,
		COALESCE(H.plpth_trip_plan_DateKey,-1)	trip_plan_datekey,
		tlog.tltd_volume,tlog.tltd_volume_uom,
		COALESCE(plpth_last_modified_date,plpth_created_date) as trip_plan_createddate,
		b.brsd_from_postal_code as brsd_from_postal_code	,	b.brsd_to_postal_code as brsd_to_postal_code,
		(h.etlactiveind * D.etlactiveind * a.etlactiveind * b.etlactiveind * c.etlactiveind) as activeindicator
	FROM dwh.F_tripplanningheader H
	INNER JOIN dwh.f_tripplanningdetail D
	ON  D.plpth_hdr_key = H.plpth_hdr_key
	INNER JOIN dwh.f_bookingrequest a 
	ON  a.br_ouinstance		=	D.plptd_ouinstance
	AND a.br_request_id		=	D.plptd_bk_req_id
	INNER JOIN dwh.f_brshipmentdetail b 
	ON	a.br_key		=	b.brsd_br_key
	INNER JOIN dwh.f_dispatchdocheader c 
	ON  D.plptd_ouinstance		=	c.ddh_ouinstance
	AND D.plptd_bk_req_id		=	c.ddh_reference_doc_no
	LEFT JOIN dwh.d_vehicle f 
	ON  H.plpth_vehicle_key =  f.veh_key 			
	LEFT JOIN tmp.f_triplogthudetail_tmp tlog
	ON	d.plptd_ouinstance 			=	tlog.tltd_ouinstance 
	AND	d.plptd_trip_plan_id		=	tlog.tltd_trip_plan_id 
	AND	d.plptd_trip_plan_seq		=	tlog.tltd_trip_sequence 
	AND d.plptd_trip_plan_line_no	=	tlog.tltd_trip_plan_line_id
	LEFT JOIN tmp.f_triplogeventdetail_Act g	
	ON	G.tled_ouinstance	 =  D.plptd_ouinstance 
	AND G.tled_trip_plan_id	 =	D.plptd_trip_plan_id
	AND G.tled_leg_no		 =	D.plptd_trip_plan_seq
	LEFT JOIN tmp.f_triplogeventdetail_pln P
	ON	P.tled_ouinstance	 =  D.plptd_ouinstance 
	AND P.tled_trip_plan_id	 =	D.plptd_trip_plan_id
	AND P.tled_leg_no		 =	D.plptd_trip_plan_seq
	WHERE plpth_trip_plan_status NOT IN ('DL')
	AND COALESCE(plpth_last_modified_date,plpth_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE
	--AND EXTRACT(YEAR FROM COALESCE(plpth_last_modified_date::DATE,plpth_created_date::DATE)) = 2019 -->= (CURRENT_DATE - INTERVAL '1 YEARS')::DATE
	--limit 10--AND tlog.tltd_trip_plan_id = 'TP/GAW/22/00001721'	
)a1;
	
-- For Updating the agent id
--For PTL trips
/*
UPDATE click.f_shipment_details_test d 
set agent_id = a.plpth_agent_id
from dwh.f_tripplanningheader a 
where  d.ouinstance		=	a.plpth_ouinstance	
and   d.trip_plan_id	=	a.plpth_trip_plan_id
and COALESCE(a.plpth_agent_id,'') <> ''
and d.service_type 		= 'PTL';

--For DD Trips

UPDATE click.f_shipment_details_test d 
set agent_id = b.veh_agency_id
from  dwh.f_tripplanningheader a 
join dwh.d_vehicle b 
on	  b.veh_ou		= a.plpth_ouinstance
and	  b.veh_id		= a.plpth_vehicle_id
Where d.ouinstance		=	a.plpth_ouinstance	
and   d.trip_plan_id	=	a.plpth_trip_plan_id
and COALESCE(a.plpth_vehicle_id,'') <> ''
and COALESCE(b.veh_agency_id,'') <> ''
and d.service_type 		= 'DD';
*/
--For FTL Trips
/*
UPDATE click.f_shipment_details_test f 
set agent_id = c.vrvel_vendor_id
from click.f_shipment_details_test f 
JOIN dwh.F_TenderRequirementDetail a 
on	  f.ouinstance		=	a.trd_ouinstance
and   f.trip_plan_id	=	a.trd_ref_doc_no
JOIN dwh.F_VehicleRequirements   
on    trd_ouinstance    = trvr_ouinstance
and   trd_tender_req_no = trvr_tender_req_no  
and   trd_ref_doc_no    = trvr_ref_doc_no
join dwh.F_VehicleEquipResponseDetail 
on    trd_ouinstance      = vrve_ouinstance
and   trvr_tender_req_no  = vrve_tend_req_no          
join dwh.F_VehicleEquipLicenseDetail 
on    vrve_ouinstance     = vrvel_ouinstance
and   vrve_tend_req_no    = vrvel_tend_req_no
and   vrve_line_no        = vrvel_resp_line_no
and   vrve_vendor_id      = vrvel_vendor_id
where COALESCE(vrve_confirm_qty,0)  <> 0
AND   vrve_resp_for        = 'vehicle'
and   trvr_ref_doc_type    in ('TP','Trip Plan')
and	  service_type = 'FTL'
*/

-- For Updating the shipment days 
	TRUNCATE TABLE tmp.f_shipment_details_pick_tmp;
	INSERT INTO tmp.f_shipment_details_pick_tmp(
	ouinstance, trip_plan_id, trip_plan_seq, br_request_Id, Actual_Departed, agent_id, from_pincode, to_pincode
	)
	SELECT ouinstance, trip_plan_id, trip_plan_seq, br_request_Id, Actual_Departed, agent_id, from_pincode, to_pincode
	FROM click.f_shipment_details 
	WHERE trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE
	--WHERE EXTRACT(YEAR FROM trip_plan_createddate::DATE) =  2019
	AND leg_behaviour = 'pick'; 

	UPDATE click.f_shipment_details d
	SET ShipmentDays = DATE_PART('day', d.Actual_Departed::timestamp - a1.Actual_Departed::timestamp) + 1
	FROM tmp.f_shipment_details_pick_tmp  a1
	WHERE d.ouinstance		=	a1.ouinstance	
	AND   d.trip_plan_id	=	a1.trip_plan_id
	AND   d.br_request_Id	=	a1.br_request_Id
	AND   trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE
	--AND EXTRACT(YEAR FROM trip_plan_createddate::DATE) = 2019
	AND d.leg_behaviour = 'Dvry';

/*
UPDATE click.f_shipment_details_test d
SET trip_Exec_DateKey = COALESCE(trip_Exec_DateKey.DateKey,-1)
FROM dwh.d_date trip_Exec_DateKey
WHERE d.Actual_TakenOver_HandedOver = trip_Exec_DateKey.dateactual;
*/
/*

UPDATE click.f_shipment_details_test d
SET Trip_Volume	= tlog.tltd_volume,	Trip_Volume_uom	= tlog.tltd_volume_uom
FROM tmp.f_triplogthudetail_tmp tlog
/*(
		SELECT a.tltd_ouinstance,	a.tltd_trip_plan_id,	a.tltd_trip_sequence,	 a.tltd_dispatch_doc_no,		
			   SUM(tltd_volume) AS tltd_volume,				a.tltd_volume_uom
		FROM dwh.f_triplogthudetail a 	
			JOIN click.f_shipment_details_test d
				ON  d.ouinstance			=	a.tltd_ouinstance 
				AND	d.trip_plan_id			=	a.tltd_trip_plan_id 
				AND	d.trip_plan_seq			=	a.tltd_trip_sequence 
				AND d.dispatch_doc_no		=	a.tltd_dispatch_doc_no 
		GROUP BY a.tltd_ouinstance,a.tltd_trip_plan_id,a.tltd_trip_sequence,a.tltd_dispatch_doc_no,a.tltd_volume_uom 
	)a
	*/
WHERE 	d.ouinstance			=	tlog.tltd_ouinstance 
AND	d.trip_plan_id			=	tlog.tltd_trip_plan_id 
AND	d.trip_plan_seq			=	tlog.tltd_trip_sequence 
AND d.dispatch_doc_no		=	tlog.tltd_dispatch_doc_no;
*/

UPDATE click.f_shipment_details d
SET draft_bill_total_value		=	e.draft_bill_total_value,
    draft_bill_approved_date	=   e.draft_bill_approved_date::DATE,
	draft_bill_no				=	e.draft_bill_no,			
	draft_bill_volume			=	e.draft_bill_volume,		
	draft_bill_contract			=	f.draft_bill_contract_id,	
	draft_bill_line_status		=	e.draft_bill_line_status
FROM dwh.f_triplogagentdetail a
	JOIN dwh.f_draftbilldetail e
			ON	a.tlad_ag_ref_doc_no	=	e.draft_bill_triggerring_no
			AND	a.tlad_trip_plan_id		=	e.draft_bill_ref_doc_no
			AND	a.tlad_ouinstance		=	e.draft_bill_ou
	JOIN dwh.f_draftbillheader f
			ON	e.draft_bill_hdr_key			=	f.draft_bill_hdr_key		
	JOIN dwh.f_contractheader c
			ON  c.cont_ou 			    =	f.draft_bill_ou
			AND	c.cont_id			    =	f.draft_bill_cONtract_id
			AND c.cont_vendor_id	    =	f.draft_bill_supplier
			AND c.cont_type			    =	'buy'
WHERE  d.ouinstance			=	a.tlad_ouinstance 
		AND	d.trip_plan_id			=	a.tlad_trip_plan_id 
		AND d.dispatch_doc_no		=	a.tlad_dispatch_doc_no
		--AND EXTRACT(YEAR FROM trip_plan_createddate::DATE) = 2019;
		AND   trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;

UPDATE click.f_shipment_details d
SET podflag = CASE WHEN tpad_attachment_file_name IS NOT NULL THEN 1 ELSE 0 END,
podfilename = COALESCE (a.tpad_hdn_file_name,a.tpad_attachment_file_name)
FROM dwh.f_trippodattachmentdetail a
WHERE	d.ouinstance 			= a.tpad_ouinstance
AND 	d.trip_plan_id 			= a.tpad_Trip_id
AND 	d.dispatch_doc_no 		= COALESCE(a.tpad_dispatch_doc_no,a.tpad_doc_no)
--AND EXTRACT(YEAR FROM trip_plan_createddate::DATE) = 2019;
AND trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;

update click.f_shipment_details
set podflag = 0 
where podflag IS NULL
AND trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;

--UPDATING Expected_DatetoDeliver OPEN
		
	UPDATE	click.f_shipment_details sh
	SET		Expected_DatetoDeliver	= a1.Actual_Departed + (interval '1' day * tms.tat) + (interval '1' day)
	FROM	tmp.f_shipment_details_pick_tmp a1
	INNER JOIN dwh.D_TMSDeliveryTAT tms
	ON		a1.agent_id			= tms.agent_code
	AND		a1.from_pincode		= tms.shipfrom_pincode
	AND		a1.to_pincode		= tms.shipto_pincode
	WHERE	a1.ouinstance		= sh.ouinstance
	AND		a1.trip_plan_id		= sh.trip_plan_id
	AND		a1.br_request_Id	= sh.br_request_Id
	--AND EXTRACT(YEAR FROM trip_plan_createddate::DATE) = 2019
	AND		sh.trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE
	AND		sh.leg_behaviour	= 'Dvry';

	UPDATE	click.f_shipment_details sh
	SET		Expected_DatetoDeliver	= a1.Actual_Departed + (interval '1' day * tms.tat) + (interval '1' day)
	FROM	tmp.f_shipment_details_pick_tmp a1
	INNER JOIN dwh.D_TMSDeliveryTAT tms
	ON		a1.agent_id			= tms.agent_code
	AND		a1.from_pincode		= tms.shipfrom_pincode::character varying
	AND		a1.to_pincode		= tms.shipto_pincode::character varying
	WHERE	a1.ouinstance		= sh.ouinstance
	AND		a1.trip_plan_id		= sh.trip_plan_id
	AND		a1.br_request_Id	= sh.br_request_Id
	AND		tms.agent_code		= 'SCM00085'
	AND		sh.Expected_DatetoDeliver is null
	--AND EXTRACT(YEAR FROM trip_plan_createddate::DATE) = 2019
	AND		sh.trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE
	AND		sh.leg_behaviour	= 'Dvry';
	
	UPDATE	click.f_shipment_details sh
	SET		Expected_DatetoDeliver		= a1.actual_departed + (interval '2' day)
	FROM	tmp.f_shipment_details_pick_tmp a1
	WHERE	a1.ouinstance		= sh.ouinstance
	AND		a1.trip_plan_id		= sh.trip_plan_id
	AND		a1.br_request_Id	= sh.br_request_Id
	--AND EXTRACT(YEAR FROM trip_plan_createddate::DATE) = 2019
	AND		trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE
	AND		Expected_DatetoDeliver is null
	AND		sh.leg_behaviour	= 'Dvry';
	
--UPDATING Expected_DatetoDeliver CLOSED

--ON_TIME_DELIVERY_FLAG UPDATE OPEN

	UPDATE	click.f_shipment_details
	SET		OnTimeDelvry_count	= CASE WHEN
										( leg_behaviour = 'Dvry' AND Expected_DatetoDeliver >= Actual_Departed )
										THEN 1
										ELSE 0
										END
	--WHERE EXTRACT(YEAR FROM trip_plan_createddate::DATE) = 2019									
	WHERE	trip_plan_createddate::DATE >= (CURRENT_DATE - INTERVAL '90 DAYS')::DATE;
	
--ON_TIME_DELIVERY_FLAG UPDATE CLOSED

	
	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','usp_f_shipment_details','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

  

END;
$BODY$;
ALTER PROCEDURE click.usp_f_shipment_details()
    OWNER TO proconnect;
