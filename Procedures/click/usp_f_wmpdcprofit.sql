CREATE OR REPLACE PROCEDURE click.usp_f_wmpdcprofit(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN

	TRUNCATE TABLE click.f_wmpdcprofit
	RESTART IDENTITY;
	insert into click.f_wmpdcprofit
	(
		
			dcp_date,		division_code,		Location_code,	Customer_id,		dcp_score,
			etlactiveind, 		etljobname,      envsourcecd, 	datasourcecd,       etlcreatedatetime	
	)
	
	select 
			dcp_date,		division_code,		Location_code,	Customer_id,		dcp_score,
			etlactiveind, 		etljobname,      envsourcecd, 	datasourcecd,       now()
			
			from dwh.f_wmpdcprofit;
	
	
	END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpdcprofit()
    OWNER TO proconnect;