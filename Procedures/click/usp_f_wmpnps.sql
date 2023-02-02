CREATE OR REPLACE PROCEDURE click.usp_f_wmpnps(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN

			Truncate table click.f_wmpnps
			Restart identity;
			
	insert into click.f_wmpnps
	(
		wn_ou, 			wn_date,		division_code,	location_code,
		customer_id,	Score, 			etlactiveind, 	etljobname,
		envsourcecd,	datasourcecd,   etlcreatedatetime
	)
	
	SELECT 
		wn_ou,			 wn_date,		division_code,	location_code,
		customer_id,	 Score,				1,		etljobname,
		envsourcecd,	 datasourcecd,  NOW()
		
	FROM dwh.f_wmpnps;	
	END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpnps()
    OWNER TO proconnect;
