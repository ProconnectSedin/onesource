-- PROCEDURE: click.usp_f_wmsinboundsladetail()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmsinboundsladetail();

CREATE OR REPLACE PROCEDURE click.usp_f_wmsinboundsladetail(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
		p_errorid integer;
		p_errordesc character varying;
		p_depsource VARCHAR(100);
BEGIN

SELECT 	depsource
		INTO 	p_depsource
		FROM 	ods.dwhtoclickcontroldtl
		WHERE 	objectname = 'usp_f_wmsinboundsladetail'; 

	IF EXISTS 
		 (
			 SELECT 1 FROM ods.dwhtoclickcontroldtl
			 WHERE	objectname = p_depsource
			 AND	status = 'completed'
			 AND	CAST(COALESCE(loadenddatetime,loadstartdatetime) AS DATE) >= NOW()::DATE
		 )
	THEN

	TRUNCATE TABLE click.f_inboundsladetail RESTART IDENTITY;
		--DELETE FROM click.f_inboundsladetail WHERE sla_dateactual >= (NOW() - INTERVAL '12 MONTHS')::DATE;
		INSERT INTO click.f_inboundsladetail
			(
				sla_ouid, 			sla_customerkey, 	sla_customerid,     sla_datekey, 			sla_dateactual, 	
				sla_lockey, 		sla_loccode, 		sla_preftype, 		sla_asntype,			sla_grnstatus,			
				sla_prefdocno,		sla_pwaystatus,		sla_supasnno,
				sla_grexpclstime,	sla_pwayexpclstime,	sla_prexpclstime,	sla_ordtime,
				sla_cutofftime,		sla_Putawayexecdate,sla_grexecdate,		asn_timediff_inmin,		grn_timediff_inmin,
				pway_timediff_inmin,	sla_Equipmentflag
			)
		SELECT
				fa.asn_ou,		fa.asn_cust_key,	fa.asn_cust_code,	fa.asn_date_key,	MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::DATE,      
				fa.asn_loc_key, fa.asn_location,	fa.asn_prefdoc_type,fa.asn_type,		fg.gr_pln_status,	
				asn_prefdoc_no, fp.pway_pln_status,	fa.asn_sup_asn_no,
			(CASE WHEN MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::TIME < MAX(cutofftime)
			THEN 
			MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp + (MAX(grtat) || ' Minutes')::INTERVAL
			ELSE 
			((MAX(COALESCE(fa.asn_modified_date,fa.asn_date))+ INTERVAL '1 DAY')::DATE ||' '||(MAX(openingtime)))::TIMESTAMP + (MAX(grtat) || ' Minutes')::INTERVAL 
			END )
			GRExpectedClosureTime,
			(CASE WHEN MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::TIME < MAX(cutofftime)
			THEN 
			MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp + (MAX(putawaytat) || ' Minutes')::INTERVAL
			ELSE 
			((MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))+ INTERVAL '1 DAY')::DATE ||' '||(MAX(openingtime)))::TIMESTAMP + (MAX(putawaytat) || ' Minutes')::INTERVAL 
			END )
			PAExpectedClosureTime ,
			(CASE WHEN MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::TIME < MAX(cutofftime) AND MAX(processtat)::INT = 0 
				THEN (MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE || (' 23:59:00.000'))::TIMESTAMP
				WHEN  MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::TIME >= MAX(cutofftime) AND MAX(processtat)::INT = 0 
				THEN ((MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))+ INTERVAL '1 DAY')::DATE + MAX(cutofftime))::TIMESTAMP 
			 	WHEN  MAX(processtat)::INT <> 0 AND MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::TIME < MAX(cutofftime) 
			 THEN MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::TIMESTAMP + (MAX(processtat) || ' Minutes')::INTERVAL 
				WHEN  MAX(processtat)::INT <> 0 AND MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::TIME >= MAX(cutofftime) 
			 THEN 
			 ((MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))+ INTERVAL '1 DAY')::DATE ||' '||(MAX(openingtime)))::TIMESTAMP + (MAX(processtat) || ' Minutes')::INTERVAL 
				END)ExpClosureDateTime,
				MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::TIME,
				MAX(tat.cutofftime),	MAX(fp.pway_exec_end_date)::timestamp,	MAX(fg.gr_itmexecution_date)::timestamp,
			ABS(CASE WHEN MIN(fa.asn_gate_no) IS NOT NULL 
			THEN DATE_PART('minute', MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp - MAX(fa.gate_actual_date)::timestamp) 
			ELSE DATE_PART('minute', MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp - MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp) END) AS asntime,
		ABS(CASE WHEN MAX(fg.gr_itmexecution_date) IS NOT NULL
			THEN DATE_PART('minute', MAX(fg.gr_itmexecution_date)::timestamp - MIN(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp) 
			ELSE 0 END) AS grntime,
		ABS(CASE WHEN MAX(fp.pway_exec_end_date) IS NOT NULL 
			THEN DATE_PART('minute', MAX(fp.pway_exec_end_date)::timestamp - MAX(fg.gr_itmexecution_date)::timestamp) 
			ELSE 0 END) AS pwaytime,
			CASE WHEN pway_mhe_id IS NOT NULL THEN 1 ELSE 0 END
		FROM click.f_asn fa
		LEFT JOIN click.f_grn fg
			ON  fa.asn_key				= fg.asn_key
		LEFT JOIN dwh.d_inboundtat tat
			ON  fa.asn_location			= tat.locationcode
			AND fa.asn_ou				= tat.ou
			AND fa.asn_prefdoc_type		= tat.ordertype
			AND fa.asn_type				= tat.servicetype
		LEFT JOIN click.f_putaway fp
			ON  fg.grn_key 				= fp.grn_key
		WHERE fa.asn_status 				NOT IN('FR','UA','CNL')
-- 		COALESCE(fa.asn_modified_date,fa.asn_created_date)::DATE 		>= (NOW() - INTERVAL '12 MONTHS')::DATE 
-- 		AND 
		GROUP BY
			fa.asn_ou,		fa.asn_cust_key,	fa.asn_cust_code,	fa.asn_date_key,	
			fa.asn_loc_key, fa.asn_location,	fa.asn_prefdoc_type,fa.asn_sup_asn_no,fa.asn_type,		fg.gr_pln_status,	
			asn_prefdoc_no, fp.pway_pln_status;
			
		/*Update grontime, pwayontime and prontime column in Summary Table*/	
		UPDATE click.f_inboundsladetail wis
		SET
		sla_grontime 	= (CASE WHEN sla_grexecdate 	 <= sla_grexpclstime 	THEN 1 
						   WHEN sla_grexecdate 	 > sla_grexpclstime THEN 0 ELSE NULL END),
		sla_pwayontime 	= (CASE WHEN sla_Putawayexecdate <= sla_pwayexpclstime 	THEN 1 
						   WHEN sla_Putawayexecdate > sla_pwayexpclstime 	THEN 0 ELSE NULL END),
		sla_prontime 	= (CASE WHEN sla_Putawayexecdate <= sla_prexpclstime 	THEN 1
						   WHEN sla_Putawayexecdate > sla_prexpclstime THEN 0 ELSE NULL END);	
		--WHERE sla_dateactual >= (NOW() - INTERVAL '12 MONTHS')::DATE;
		
		UPDATE click.f_inboundsladetail wis
		SET
			sla_category 	= (
								CASE WHEN sla_prontime IN (0,1) AND Remarks IS NOT NULL THEN 'Remarks'
								END
								)				
		FROM dwh.f_deliverydelayreason dr
		WHERE wis.sla_lockey			= dr.wms_loc_key
		AND  wis.sla_supasnno		= dr.invoiceno;
-- 		wis.sla_dateactual >= (NOW() - INTERVAL '12 MONTHS')::DATE
-- 		AND 

		
		UPDATE click.f_inboundsladetail wis
		SET	sla_category 	=(CASE WHEN sla_prontime = 1 AND sla_ordtime >= sla_cutofftime THEN 'Premium'
									ELSE 'Achieved' END)
		WHERE sla_category IS NULL;
		--WHERE sla_dateactual >= (NOW() - INTERVAL '12 MONTHS')::DATE;
		
			
		UPDATE click.f_inboundsladetail wis
		SET
			sla_category 	= (
								CASE WHEN sla_prontime = 0 THEN 'Breach'
								END
								)
		WHERE sla_category IS NULL;				
		--WHERE sla_dateactual >= (NOW() - INTERVAL '12 MONTHS')::DATE;

		UPDATE click.f_inboundsladetail 
		SET sla_category 	= 'Achived'	
		WHERE sla_prontime IS NULL
		AND sla_prexpclstime IS NULL
		AND sla_grexecdate IS NOT NULL
		AND sla_category  IS NULL;			
-- 			wis.sla_dateactual >= (NOW() - INTERVAL '12 MONTHS')::DATE

	END IF;
		EXCEPTION WHEN others THEN       

		GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

		CALL ods.usp_etlerrorinsert('CLICK','usp_f_wmsinboundsladetailFull','Click',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);		
			
END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmsinboundsladetail()
    OWNER TO proconnect;
