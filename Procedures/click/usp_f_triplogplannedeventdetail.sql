-- PROCEDURE: click.usp_f_triplogplannedeventdetail()

-- DROP PROCEDURE IF EXISTS click.usp_f_triplogplannedeventdetail();

CREATE OR REPLACE PROCEDURE click.usp_f_triplogplannedeventdetail(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
    p_errorid integer;
	p_errordesc character varying;

BEGIN

TRUNCATE TABLE tmp.f_triplogeventdetail_pln;
INSERT INTO tmp.f_triplogeventdetail_pln (tled_ouinstance,tled_trip_plan_id,tled_trip_plan_line_no,tled_bkr_id,tled_leg_no,
									 PlannedTripStart,PlannedArrived,PlannedHandedOver,PlannedTakenOver,PlannedPickDepart,
									  PlannedDeliveryDepart,PlannedTripEnd)
SELECT  tled_ouinstance,            tled_trip_plan_id,              tled_trip_plan_line_no,
					tled_bkr_id,                tled_leg_no,                    TRIP_START AS PlannedTripStart,
					ARVD AS PlannedArrived,      HANDEDOVER AS PlannedHandedOver,   TAKENOVER AS PlannedTakenOver,
					DEP AS PlannedPickDepart,    DEPTD AS PlannedDeliveryDepart,  TRIP_END AS PlannedTripEnd
			FROM crosstab
			(
			  $$
                SELECT DENSE_RANK() OVER (ORDER BY tled_ouinstance, tled_trip_plan_id, tled_trip_plan_line_no, tled_bkr_id, tled_leg_no )::INT AS row_name,
						tled_ouinstance,	  tled_trip_plan_id,	 tled_trip_plan_line_no, 	  tled_bkr_id, 	  tled_leg_no, 
						tled_event_id, 
						MAX(tled_planned_datetime) AS tled_planned_datetime
                FROM dwh.f_triplogeventdetail log
				INNER JOIN dwh.F_tripplanningheader e 
				ON  log.plpth_hdr_key = e.plpth_hdr_key
				INNER JOIN dwh.f_tripplanningdetail d
				ON  log.plpth_hdr_key = d.plpth_hdr_key
				WHERE COALESCE(plpth_last_modified_date::DATE,plpth_created_date::DATE) >= (CURRENT_DATE - INTERVAL '90 days')::DATE
				AND plpth_trip_plan_status NOT IN ('DL')
                GROUP  BY tled_ouinstance,tled_trip_plan_id,tled_trip_plan_line_no, tled_bkr_id,tled_leg_no,tled_event_id
                ORDER BY 1, 2
			  $$,
			  $$
                VALUES ('TRIP_START'),('ARVD'), ('HANDEDOVER'), ('TAKENOVER'), ('DEP'), ('DEPTD'), ('TRIP_END')
			  $$
			) AS PIVOTTABLE 
			(
				row_name INT,
				tled_ouinstance INT ,
				tled_trip_plan_id CHARACTER VARYING,
				tled_trip_plan_line_no CHARACTER VARYING,
				tled_bkr_id CHARACTER VARYING,
				tled_leg_no INTEGER,
				TRIP_START   TIMESTAMP,
				ARVD TIMESTAMP,
				HANDEDOVER  TIMESTAMP,
				TAKENOVER  TIMESTAMP,
				DEP  TIMESTAMP,
				DEPTD  TIMESTAMP,
				TRIP_END  TIMESTAMP
			);

TRUNCATE TABLE tmp.f_triplogeventdetail_act;
INSERT INTO tmp.f_triplogeventdetail_act (tled_ouinstance,tled_trip_plan_id,tled_trip_plan_line_no,tled_bkr_id,tled_leg_no,
			 ActualTripStart,ActualArrived,ActualHandedOver,ActualTakenOver,ActualPickDepart,
									  ActualDeliveryDepart,ActualTripEnd)
SELECT  tled_ouinstance,            tled_trip_plan_id,              tled_trip_plan_line_no,
					tled_bkr_id,                tled_leg_no,                    TRIP_START AS ActualTripStart,
					ARVD AS ActualArrived,      HANDEDOVER AS ActualHandedOver, TAKENOVER AS ActualTakenOver,
					DEP AS ActualPickDepart,    DEPTD AS ActualDeliveryDepart,  TRIP_END AS ActualTripEnd
			FROM crosstab
			(
			  $$
                SELECT DENSE_RANK() OVER (ORDER BY tled_ouinstance, tled_trip_plan_id, tled_trip_plan_line_no, tled_bkr_id, tled_leg_no )::INT AS row_name,
						tled_ouinstance,	tled_trip_plan_id,		tled_trip_plan_line_no, 	tled_bkr_id,	 tled_leg_no, 
						tled_event_id, 
						MAX(tled_actual_date_time) AS tled_actual_date_time
                FROM dwh.f_triplogeventdetail log
				INNER JOIN dwh.F_tripplanningheader e 
				ON  log.plpth_hdr_key = e.plpth_hdr_key
				INNER JOIN dwh.f_tripplanningdetail d
				ON  log.plpth_hdr_key = d.plpth_hdr_key
				WHERE COALESCE(plpth_last_modified_date::DATE,plpth_created_date::DATE) >= (CURRENT_DATE - INTERVAL '90 days')::DATE
				AND plpth_trip_plan_status NOT IN ('DL')
                GROUP  BY tled_ouinstance,tled_trip_plan_id,tled_trip_plan_line_no,tled_bkr_id,tled_leg_no,tled_event_id
                ORDER BY 1, 2
			  $$,
			  $$
                VALUES ('TRIP_START'),('ARVD'), ('HANDEDOVER'), ('TAKENOVER'), ('DEP'), ('DEPTD'), ('TRIP_END')
			  $$
			) AS PIVOTTABLE 
			(
				row_name INT,
				tled_ouinstance INT ,
				tled_trip_plan_id CHARACTER VARYING,
				tled_trip_plan_line_no CHARACTER VARYING,
				tled_bkr_id CHARACTER VARYING,
				tled_leg_no INTEGER,
				TRIP_START   TIMESTAMP,
				ARVD TIMESTAMP,
				HANDEDOVER  TIMESTAMP,
				TAKENOVER  TIMESTAMP,
				DEP  TIMESTAMP,
				DEPTD  TIMESTAMP,
				TRIP_END  TIMESTAMP 
			);

TRUNCATE TABLE tmp.f_triplogthudetail_tmp;
INSERT INTO tmp.f_triplogthudetail_tmp (tltd_ouinstance,tltd_trip_plan_id,tltd_trip_sequence,tltd_dispatch_doc_no,
										tltd_trip_plan_line_id,tltd_volume,tltd_volume_uom)
	SELECT tl.tltd_ouinstance,	tl.tltd_trip_plan_id,	tl.tltd_trip_sequence,	 tl.tltd_dispatch_doc_no,		
				 tl.tltd_trip_plan_line_id,  SUM(tl.tltd_volume) AS tltd_volume,				tl.tltd_volume_uom
	FROM dwh.f_triplogthudetail tl 
	INNER JOIN dwh.F_tripplanningheader e 
	ON  tl.plpth_hdr_key = e.plpth_hdr_key
	INNER JOIN dwh.f_tripplanningdetail d
	ON  tl.plpth_hdr_key = d.plpth_hdr_key
	WHERE COALESCE(plpth_last_modified_date::DATE,plpth_created_date::DATE) >= (CURRENT_DATE - INTERVAL '90 days')::DATE
	AND plpth_trip_plan_status NOT IN ('DL')
	GROUP BY tl.tltd_ouinstance,tl.tltd_trip_plan_id,tl.tltd_trip_sequence,tl.tltd_dispatch_doc_no,tl.tltd_trip_plan_line_id,tl.tltd_volume_uom;

	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','usp_f_triplogplannedeventdetail','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

  

END;
$BODY$;
ALTER PROCEDURE click.usp_f_triplogplannedeventdetail()
    OWNER TO proconnect;
