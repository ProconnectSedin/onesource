-- PROCEDURE: ods.usp_dwh_data_count()

-- DROP PROCEDURE IF EXISTS ods.usp_dwh_data_count();

CREATE OR REPLACE PROCEDURE ods.usp_dwh_data_count(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	
declare v_max int;
 v_id integer =1;

begin
truncate only ods.dwh_Data_Count restart identity;
select max(Row_id)  into v_max   from ods.DataValidation_ScriptGenerator;
 
--select  100 into v_max;

while v_id <= v_max
   loop            
    	Insert into ods.dwh_Data_Count(sourcetable,dwhtablename,dimension,period,datacount)
		select * from ods.usp_target_count(v_id);
 		v_id:=v_id+1;
   end loop;
	 	   
update ods.dwh_data_count set period ='NA' where period = '9999';
   
		   
END;
$BODY$;
ALTER PROCEDURE ods.usp_dwh_data_count()
    OWNER TO proconnect;
