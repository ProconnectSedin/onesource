-- PROCEDURE: click.usp_f_wmpinventoryaccuracy()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmpinventoryaccuracy();

CREATE OR REPLACE PROCEDURE click.usp_f_wmpinventoryaccuracy(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	p_depsource VARCHAR(100);
	
BEGIN

--select * from click.f_wmpinventoryaccuracy;

-- UPDATE click.f_wmpinventoryaccuracy t
-- SET ou_id					=s.ou_id,
-- 	stockcountdate			=s.stockcountdate,
-- 	divisioncode			=s.divisioncode,
-- 	locationcode			=s.locationcode,
-- 	customerid				=s.customerid,
-- 	itemcode				=s.itemcode,
-- 	totalexpected			=SUM(s.expectedqty),
-- 	totalavailable			=SUM(availableqty)
-- from click.f_wmpmonthlystockcount s
-- where ou_id					=s.ou_id
-- and	  stockcountdate		=s.stockcountdate,
-- and	  divisioncode			=s.divisioncode,
-- and	  locationcode			=s.locationcode,
-- and	  customerid			=s.customerid;

	TRUNCATE TABLE click.f_wmpinventoryaccuracy;
	INSERT INTO click.f_wmpinventoryaccuracy
	(ouid,stockcountdate,divisioncode,locationcode,customerid,itemcode,totalexpected,totalavailable)
	SELECT ouid,stockcountdate,divisioncode,locationcode,customerid,itemcode,SUM(expectedqty),SUM(availableqty)
	FROM click.f_wmpmonthlystockcount
	GROUP BY ouid,stockcountdate,divisioncode,locationcode,customerid,itemcode;
	
	UPDATE click.f_wmpinventoryaccuracy
	SET variance = abs(totalexpected - totalavailable),
		variancepercnt = abs((cast(totalexpected as numeric(21,2)) - cast(totalavailable as numeric(21,2)))/cast(totalexpected as numeric(21,2)))*100,
		inventoryaccuracy = (100-abs(((cast(totalexpected as numeric(21,2)) - cast(totalavailable as numeric(21,2)))/cast(totalexpected as numeric(21,2)))*100));
	
END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpinventoryaccuracy()
    OWNER TO proconnect;
