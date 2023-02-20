-- PROCEDURE: click.usp_f_wmpcyclecount()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmpcyclecount();

CREATE OR REPLACE PROCEDURE click.usp_f_wmpcyclecount(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	p_depsource VARCHAR(100);
	
BEGIN

	TRUNCATE TABLE click.f_wmpcyclecount;
	INSERT INTO click.f_wmpcyclecount
	(ouid,cyclecountdate,divisioncode,locationcode,itemcyclecount,minitemcyclecount)
	SELECT sbl_ouinstid,sbl_wh_loc_code,sbl_ref_doc_date::date as sbl_ref_doc_date,COUNT(distinct sbl_item_code),MIN(1) 
	FROM dwh.f_virtualstockballot
	GROUP BY sbl_ouinstid,sbl_wh_loc_code,sbl_ref_doc_date::date; 

	CREATE TEMP TABLE virtualstockballot
	AS
	SELECT sbl_ouinstid,sbl_wh_loc_code,sbl_ref_doc_date::date,sbl_item_code,SUM(sbl_quantity) as vairance 
	FROM dwh.f_virtualstockballot
	GROUP BY sbl_ouinstid,sbl_wh_loc_code,sbl_ref_doc_date::date,sbl_item_code;

	CREATE TEMP TABLE stockbalsulothistory
	AS
	select sbl_ouinstid,sbl_wh_code,wms_sys_date::date,sbl_item_code,SUM(sbl_quantity) as expvariance
	from dwh.f_stockbalsulothistory
	WHERE wms_sys_date >= (NOW() - INTERVAL '1 MONTHS')::DATE
	GROUP BY sbl_ouinstid,sbl_wh_code,wms_sys_date::date,sbl_item_code;

	--avgvariancepercnt
	
	
	--dccaccuracypercnt
	
END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpcyclecount()
    OWNER TO proconnect;
