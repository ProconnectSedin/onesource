CREATE OR REPLACE PROCEDURE click.usp_f_wmpsecuritygadgets(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN

			Truncate table click.f_wmpsecuritygadgets
			Restart identity;
			
	insert into click.f_wmpsecuritygadgets
		(
			wsg_ou,	wsg_date,	division_code,	location_code,
			customer_id, Score, etlactiveind,	etljobname,
			envsourcecd, datasourcecd, etlcreatedatetime
		)
		
		select
			wsg_ou,	wsg_date,	division_code,	location_code,
			customer_id, Score, etlactiveind,	etljobname,
			envsourcecd, datasourcecd, etlcreatedatetime
			from dwh.f_wmpsecuritygadgets;
				END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpsecuritygadgets()
    OWNER TO proconnect;