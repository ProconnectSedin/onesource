-- PROCEDURE: click.usp_datavalidation_scriptgenerator()

-- DROP PROCEDURE IF EXISTS click.usp_datavalidation_scriptgenerator();

CREATE OR REPLACE PROCEDURE click.usp_datavalidation_scriptgenerator(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	
declare v_max int;
 v_id integer =1;

begin
truncate only ods.dwh_Data_Count restart identity;
select max(Row_id)  into v_max   from ods.DataValidation_ScriptGenerator;
 
--select  381 into v_max;

while v_id <= v_max
   loop            
    	Insert into ods.dwh_Data_Count(sourcetable,dwhtablename,dimension,Period,datacount)
		select *  from ods.usp_target_count(v_id);
 		v_id:=v_id+1;
   end loop;
	 	   
		   
		   
END;
$BODY$;
ALTER PROCEDURE click.usp_datavalidation_scriptgenerator()
    OWNER TO proconnect;
