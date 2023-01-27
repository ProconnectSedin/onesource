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
				sla_lockey, 		sla_loccode, 		sla_preftype, 		sla_asntype,						
				sla_prefdocno,		sla_supasnno,
				sla_grexpclstime,	sla_pwayexpclstime,	sla_prexpclstime,	sla_ordtime,
				sla_cutofftime,sla_openingtime,		sla_Putawayexecdate,sla_grexecdate,		sla_Equipmentflag,	activeindicator,
				sla_orderaccountdate,sla_orderaccountdatekey,sla_grtat,sla_pwaytat,sla_processtat	
			)
		SELECT
				fa.asn_ou,		fa.asn_cust_key,	fa.asn_cust_code,	d.datekey,	MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01')),      
				fa.asn_loc_key, fa.asn_location,	fa.asn_prefdoc_type,fa.asn_type,
				fa.asn_prefdoc_no, fa.asn_sup_asn_no,
			/*(CASE WHEN MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::TIME < MAX(cutofftime)
			THEN 
			MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp + (MAX(grtat) || ' Minutes')::INTERVAL
			ELSE 
			((MAX(COALESCE(fa.asn_modified_date,fa.asn_date))+ INTERVAL '1 DAY')::DATE ||' '||(MAX(openingtime)))::TIMESTAMP + (MAX(grtat) || ' Minutes')::INTERVAL 
			END )
			*/
			MAX(asn_qualifieddate)::TIMESTAMP + (MAX(grtat) || ' Minutes')::INTERVAL  as GRExpectedClosureTime,
			/*(CASE WHEN MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::TIME < MAX(cutofftime)
			THEN 
			MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp + (MAX(putawaytat) || ' Minutes')::INTERVAL
			ELSE 
			((MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))+ INTERVAL '1 DAY')::DATE ||' '||(MAX(openingtime)))::TIMESTAMP + (MAX(putawaytat) || ' Minutes')::INTERVAL 
			END )
			*/
			MAX(asn_qualifieddate)::TIMESTAMP + (MAX(putawaytat) || ' Minutes')::INTERVAL  as PAExpectedClosureTime ,
			(CASE WHEN MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::TIME < MAX(cutofftime) AND MAX(processtat)::INT = 0 
				THEN (MAX(asn_qualifieddate)::DATE || (' 23:59:00.000'))::TIMESTAMP
				WHEN  MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::TIME >= MAX(cutofftime) AND MAX(processtat)::INT = 0 
				THEN ((MAX(asn_qualifieddate))::DATE + MAX(cutofftime))::TIMESTAMP 
			 	WHEN  MAX(processtat)::INT <> 0 
				THEN MAX(asn_qualifieddate)::TIMESTAMP + (MAX(processtat) || ' Minutes')::INTERVAL
				END)ExpClosureDateTime,
				MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01'))::TIME,
				MAX(tat.cutofftime),MAX(tat.openingtime),	MAX(fp.pway_exec_end_date)::timestamp,	MAX(COALESCE(fg.gr_end_date,fg.gr_modified_date))::timestamp,
			CASE WHEN MAX(pway_mhe_id) IS NOT NULL THEN 1 ELSE 0 END, MAX(fa.activeindicator*fg.activeindicator*fp.activeindicator),
			MAX(asn_qualifieddate),MAX(asn_qualifieddatekey),MAX(grtat),MAX(putawaytat),MAX(processtat)
		FROM click.f_asn fa
		INNER JOIN click.d_date d
		ON dateactual = (COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE
		LEFT JOIN click.f_grn fg
			ON  fa.asn_key				= fg.asn_key
		LEFT JOIN dwh.d_inboundtat tat
			ON  fa.asn_location			= tat.locationcode
			AND fa.asn_ou				= tat.ou
			AND fa.asn_prefdoc_type		= tat.ordertype
			AND fa.asn_type				= tat.servicetype
		LEFT JOIN click.f_putaway fp
			ON  fg.grn_key 				= fp.grn_key
		WHERE fa.asn_status 		NOT IN('FR','UA','CNL')
-- 		COALESCE(fa.asn_modified_date,fa.asn_created_date)::DATE 		>= (NOW() - INTERVAL '12 MONTHS')::DATE 
-- 		AND 
		GROUP BY
			fa.asn_ou,		fa.asn_cust_key,	fa.asn_cust_code,	d.datekey,      
			fa.asn_loc_key, fa.asn_location,	fa.asn_prefdoc_type,fa.asn_type,
			fa.asn_prefdoc_no, fa.asn_sup_asn_no;
		/*
		UPDATE click.f_inboundsladetail
		SET sla_orderaccountdate = 	(CASE WHEN sla_ordtime <= sla_cutofftime THEN sla_dateactual
										  WHEN sla_ordtime > sla_cutofftime  AND sla_Putawayexecdate::DATE = sla_dateactual
									 	  THEN sla_dateactual
										  WHEN sla_ordtime > sla_cutofftime  
									 	  AND (sla_Putawayexecdate IS NULL OR sla_Putawayexecdate::DATE > sla_dateactual)
									 	  THEN ((sla_dateactual + INTERVAL '1 DAY')::DATE + (sla_openingtime))::TIMESTAMP  ELSE sla_dateactual END);
		
		UPDATE click.f_inboundsladetail
		SET sla_orderaccountdatekey = d.datekey
		FROM click.d_date d	
		WHERE dateactual = sla_orderaccountdate::DATE;
		*/
			
		UPDATE click.f_inboundsladetail wis
		SET asn_timediff_inmin	= 	asntime,
			grn_timediff_inmin	=	grntime,
			pway_timediff_inmin	=	pwaytime 
		FROM (
			SELECT fa.asn_ou,		fa.asn_cust_key,	fa.asn_cust_code,	d.datekey,	MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date,'1900-01-01')),      
				fa.asn_loc_key, fa.asn_location,	fa.asn_prefdoc_type,fa.asn_type,
				fa.asn_prefdoc_no, fa.asn_sup_asn_no,
					ABS(CASE WHEN MIN(fa.asn_gate_no) IS NOT NULL 
					THEN (EXTRACT(epoch from( MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp - MAX(fa.gate_actual_date)::timestamp))/60) 
					ELSE (EXTRACT(epoch from( MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp - MAX(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp))/60) END) AS asntime,
					ABS(CASE WHEN MAX(COALESCE(fg.gr_end_date,fg.gr_modified_date)) IS NOT NULL
					THEN (EXTRACT(epoch from( MAX(COALESCE(fg.gr_end_date,fg.gr_modified_date))::timestamp - MIN(COALESCE(fa.asn_modified_date,fa.asn_created_date))::timestamp))/60) 
					ELSE 0 END) AS grntime,
					ABS(CASE WHEN MAX(fp.pway_exec_end_date) IS NOT NULL 
					THEN (EXTRACT(epoch from( MAX(fp.pway_exec_end_date)::timestamp - MAX(COALESCE(fg.gr_end_date,fg.gr_modified_date))::timestamp))/60) 
					ELSE 0 END) AS pwaytime
			FROM click.f_asn fa
		INNER JOIN click.d_date d
		ON dateactual = (COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE
		LEFT JOIN click.f_grn fg
			ON  fa.asn_key				= fg.asn_key
		LEFT JOIN dwh.d_inboundtat tat
			ON  fa.asn_location			= tat.locationcode
			AND fa.asn_ou				= tat.ou
			AND fa.asn_prefdoc_type		= tat.ordertype
			AND fa.asn_type				= tat.servicetype
		LEFT JOIN click.f_putaway fp
			ON  fg.grn_key 				= fp.grn_key
		WHERE fa.asn_status 		NOT IN('FR','UA','CNL')
		GROUP BY
			fa.asn_ou,		fa.asn_cust_key,	fa.asn_cust_code,	d.datekey,      
			fa.asn_loc_key, fa.asn_location,	fa.asn_prefdoc_type,fa.asn_type,
			fa.asn_prefdoc_no, fa.asn_sup_asn_no
		)td
		WHERE sla_ouid 		= 	asn_ou
		AND sla_customerkey = 	asn_cust_key
		--AND	sla_customerid  =   asn_cust_code
		AND	sla_datekey		= 	datekey
		AND	sla_lockey	    = 	asn_loc_key
		--AND	sla_loccode     = 	asn_location
		--AND	sla_preftype    = 	asn_prefdoc_type
		--AND	sla_asntype		= 	asn_type			
		AND	sla_prefdocno   = 	asn_prefdoc_no;
		--AND	sla_supasnno    = 	asn_sup_asn_no
			
			
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
								CASE WHEN sla_prontime IN (0,1) THEN 'Remarks'
								END
								)				
		FROM dwh.f_deliverydelayreason dr
		WHERE wis.sla_lockey			= dr.wms_loc_key
		AND  wis.sla_supasnno		= dr.invoiceno;
-- 		wis.sla_dateactual >= (NOW() - INTERVAL '12 MONTHS')::DATE
-- 		AND 

		
		UPDATE click.f_inboundsladetail wis
		SET	sla_category 	=(CASE WHEN sla_prontime = 1 AND sla_ordtime >= sla_cutofftime THEN 'Premium'
							WHEN sla_prontime = 1 AND sla_ordtime < sla_cutofftime THEN  'Achieved' ELSE NULL END)
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
		SET sla_category 	= 'Achieved'	
		WHERE sla_prontime IS NULL
		AND sla_prexpclstime IS NULL
		AND sla_grexecdate IS NOT NULL
		AND sla_category  IS NULL;			
-- 			wis.sla_dateactual >= (NOW() - INTERVAL '12 MONTHS')::DATE
	 ELSE	
		p_errorid   := 0;
			IF p_depsource IS NULL
				THEN 
					p_errordesc := 'The Dependent source cannot be NULL.';
				ELSE
					p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source.';
				END IF;
		CALL ods.usp_etlerrorinsert('CLICK','usp_f_wmsinboundsladetail','Click',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
	END IF;
		EXCEPTION WHEN others THEN       

		GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;

		CALL ods.usp_etlerrorinsert('CLICK','usp_f_wmsinboundsladetail','Click',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);		
			
END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmsinboundsladetail()
    OWNER TO proconnect;
