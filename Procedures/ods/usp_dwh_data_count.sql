-- PROCEDURE: ods.usp_dwh_data_count()

-- DROP PROCEDURE IF EXISTS ods.usp_dwh_data_count();

CREATE OR REPLACE PROCEDURE ods.usp_dwh_data_count(
	)
LANGUAGE 'plpgsql'
AS $BODY$
	
declare v_max int;
	p_errordesc character varying;
	p_errorid integer;
	v_id integer =1;
	v_TableName text;
 v_dwhtable text;

begin
truncate only ods.dwh_Data_Count restart identity;
select max(Row_id)  into v_max   from ods.DataValidation_ScriptGenerator;
 
--select  2 into v_max;

while v_id <= v_max
   loop      
   Begin
   	select  		   sourcetable,
                       TableName
             into v_TableName, v_dwhtable
            FROM    ods.DataValidation_ScriptGenerator
            WHERE    Row_id = v_id;
    	Insert into ods.dwh_Data_Count(sourcetable,dwhtablename,dimension,period,datacount)
		select * from ods.usp_target_count(v_id);
		EXCEPTION  
       WHEN others THEN       
      get stacked diagnostics
	  p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    insert into ods.datavalidation_error (spname,type,sourcetable,targetTableName,errorline,errorid,errordesc,errordate) values ('usp_dwh_data_count','datacount',
                               v_TableName,
								v_dwhtable,
								'sp_ExceptionHandling - LineNo : '||v_id,
                                p_errorid,p_errordesc,now());
										 
  END;  
        
 		v_id:=v_id+1;
   end loop;
	 	   
		update ods.dwh_data_count set period ='NA' where period = '9999';
   
		   
END;
$BODY$;
ALTER PROCEDURE ods.usp_dwh_data_count()
    OWNER TO proconnect;
