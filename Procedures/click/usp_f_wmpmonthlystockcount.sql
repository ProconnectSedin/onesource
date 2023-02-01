CREATE OR REPLACE PROCEDURE click.usp_f_wmpmonthlystockcount(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN
	TRUNCATE TABLE click.f_wmpmonthlystockcount
		RESTART IDENTITY;
		
			insert into click.f_wmpmonthlystockcount
		(
			msc_ou , 		msc_date , 		division_code , Location_code ,
			Customer_id ,   msc_zone , 		bin ,			item_code,
			Expected_qty ,  available_qty , etlactiveind ,	etljobname ,
			envsourcecd ,	datasourcecd ,	etlcreatedatetime 
		)
		
		select 
			msc_ou , 		msc_date , 		division_code , Location_code ,
			Customer_id ,   msc_zone , 		bin ,			item_code,
			Expected_qty ,  available_qty , etlactiveind ,	etljobname ,
			envsourcecd ,	datasourcecd ,	etlcreatedatetime
			
		from dwh.f_wmpmonthlystockcount;
		
			END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpmonthlystockcount()
    OWNER TO proconnect;
