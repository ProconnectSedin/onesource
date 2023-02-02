-- PROCEDURE: click.usp_f_locationholiday()

-- DROP PROCEDURE IF EXISTS click.usp_f_locationholiday();

CREATE OR REPLACE PROCEDURE click.usp_f_locationholiday(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	p_depsource VARCHAR(100);
	
BEGIN

	CREATE TEMP TABLE f_locholidaylist
	as
	SELECT b.locationcode,b.holidaydate,b.nextworkingdate,to_char( b.nextworkingdate , 'Day' ) as nextworkingday
	FROM (
	SELECT a.locationcode,a.holidaydate,
	CASE WHEN a.Leaddate IS NULL THEN  (a.holidaydate::date + interval '1 day')
		WHEN (EXTRACT(DAY FROM (a.Leaddate)-(a.holidaydate))) > 1 THEN (a.holidaydate::date + interval '1 day')
		ELSE (a.Leaddate + interval '1 day') END AS nextworkingdate
	FROM 
	(SELECT locationcode,holidaydate,
			LEAD(holidaydate,1) OVER(partition by locationcode order by holidaydate) as Leaddate
	FROM dwh.d_locationholiday
	--where locationcode = 'TN038P0027'
	--AND EXTRACT(YEAR FROM holidaydate) = 2022
	)a
	)b;

	CREATE TEMP TABLE f_locoperatinglist
	AS
	SELECT t.loc_opr_loc_code, days, flag
	FROM dwh.d_locationoperationsdetail  t
	JOIN LATERAL (VALUES('sunday', t.loc_opr_sun_day),('monday', t.loc_opr_mon_day),('tuesday',t.loc_opr_tue_day),
	('wednesday',t.loc_opr_wed_day),('thursday',t.loc_opr_thu_day),('friday',t.loc_opr_fri_day),
	('saturday',t.loc_opr_sat_day)) s(days, flag) ON TRUE;
	
	
	UPDATE f_locholidaylist 
	SET nextworkingdate	= (nextworkingdate::date + interval '1 day')
	FROM f_locoperatinglist
	WHERE locationcode = loc_opr_loc_code
	AND nextworkingday = days
	AND flag = 0;
	
	TRUNCATE TABLE click.f_locationholiday;
	INSERT INTO click.f_locationholiday
	(locationcode,holidaydate,nextworkingdate,nextworkingday)
	SELECT locationcode,holidaydate,nextworkingdate,nextworkingday
	FROM f_locholidaylist;
			
	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','usp_f_wmsibsummary','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_locationholiday()
    OWNER TO proconnect;
