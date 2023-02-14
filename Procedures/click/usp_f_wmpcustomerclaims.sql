CREATE OR REPLACE PROCEDURE click.usp_f_wmpcustomerclaims(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN

			Truncate table click.f_wmpcustomerclaims
			Restart identity;
			
		insert into click.f_wmpcustomerclaims
		(
			wcc_ou,	wcc_date,	division_code, location_code,
			customer_id, customer_Score,	etlactiveind,	etljobname,
			envsourcecd, datasourcecd, etlcreatedatetime
		)
		
		select
		
			wcc_ou,	wcc_date,	division_code, location_code,
			customer_id, customer_Score,	etlactiveind,	etljobname,
			envsourcecd, datasourcecd, now()
			
			from dwh.f_wmpcustomerclaims;
				END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpcustomerclaims()
    OWNER TO proconnect;