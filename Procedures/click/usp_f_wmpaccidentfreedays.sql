
CREATE OR REPLACE PROCEDURE click.usp_f_wmpaccidentfreedays(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN

			Truncate table click.f_wmpaccidentfreedays
			Restart identity;
			
		INSERT INTO click.f_wmpaccidentfreedays
		(
			wafc_ou, wafc_date, division_code, location_code,
			customer_id, Score, etlactiveind,	etljobname,
			envsourcecd, datasourcecd, etlcreatedatetime
		)
		
		select 
		
			wafc_ou, wafc_date, division_code, location_code,
			customer_id, Score, etlactiveind,	etljobname,
			envsourcecd, datasourcecd, now()
			
			from dwh.f_wmpaccidentfreedays;
			END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpaccidentfreedays()
    OWNER TO proconnect;