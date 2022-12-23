-- PROCEDURE: ods.usp_table_reindex()

-- DROP PROCEDURE IF EXISTS ods.usp_table_reindex();

CREATE OR REPLACE PROCEDURE ods.usp_table_reindex(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	
declare v_max int;
 v_min int;
 v_tableschema character varying;
 v_tablename character varying;
begin
 select max(rowid),min(rowid) into v_max,v_min from ods.table_size 
	where snapshot_date :: date = current_date::Date
	and row_count > 10000;
	
	--select 2,2 into v_max,v_min;
while v_min <= v_max
   loop            
   		 select  table_name,table_schema into v_tablename,v_tableschema from ods.table_size 
		 where rowid = v_min;
	-- raise notice 'Value: %',  'REINDEX TABLE ' || v_tableschema || '.' ||v_tablename;
    	
		EXECUTE 'REINDEX TABLE ' || v_tableschema || '.' ||v_tablename;
 		v_min:=v_min+1;
   end loop;
		   
END;
$BODY$;
ALTER PROCEDURE ods.usp_table_reindex()
    OWNER TO proconnect;
