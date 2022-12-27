-- FUNCTION: ods.usp_target_count(bigint)

DROP FUNCTION IF EXISTS ods.usp_target_count(bigint);

CREATE OR REPLACE FUNCTION ods.usp_target_count(
	v_rowid bigint)
    RETURNS TABLE(v_sourcetable text, v_dwhtable text, v_dimension character varying, v_period numeric, v_sourcedatacount bigint) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

declare v_max int;
 v_id integer =1;
 v_Data text;
 v_DB text;
 v_SchemaName text;
 v_TableName text;
 v_dwhtable text;
 v_Column_List text;
 v_FromClause text;
 v_WhereClause text;
 v_GroupByClause text;
 v_JoinTableName text;
 v_JoinCondition text;
	
 begin
   select     		   DB,
                       SchemaName,
					   sourcetable,
                       TableName,
                       Column_List,
                       TableName,    
                       WhereClause_ColumnName,
                       GroupBy_ColumnName,
                       Join_TableName,
                       Join_ColumnName into v_DB, v_SchemaName, v_TableName, v_dwhtable,v_Column_List, v_FromClause, v_WhereClause, v_GroupByClause, v_JoinTableName, v_JoinCondition
            FROM    ods.DataValidation_ScriptGenerator
            WHERE    Row_id = v_rowid;
		
			IF v_WhereClause IS NULL AND v_GroupByClause IS NULL
			 THEN
			  	v_Data='select '''|| v_TableName || ''','''||v_dwhtable||''','|| v_Column_List ||'from ' || v_SchemaName|| '.'|| v_dwhtable;
			 END IF; 

				IF v_WhereClause IS NOT NULL AND v_GroupByClause IS NULL 
			  THEN
                v_Data='select '''|| v_TableName || ''','''||v_dwhtable||''','|| v_Column_List ||'from ' || v_SchemaName|| '.' || v_dwhtable || ' where ' || v_WhereClause;
              END IF;   
		
			IF  v_WhereClause IS NOT NULL AND v_GroupByClause IS NOT NULL AND v_JoinTableName IS NOT NULL
             THEN
            	v_Data:='select '''|| v_TableName || ''','''||v_dwhtable||''','|| v_Column_List ||'from ' || v_SchemaName|| '.' || v_dwhtable || ' d join ' || v_SchemaName|| '.' ||  v_JoinTableName || ' h ' || v_JoinCondition || ' where ' || v_WhereClause ||' group by '|| v_GroupByClause;
			END IF;
			
            IF  v_WhereClause IS NOT NULL AND v_GroupByClause IS NOT NULL AND v_JoinTableName IS NULL                
				THEN
           		v_Data:='select '''|| v_TableName || ''','''||v_dwhtable||''','|| v_Column_List ||'from ' || v_SchemaName|| '.' || v_dwhtable || ' where ' || v_WhereClause ||' group by '|| v_GroupByClause;
            END IF;  
			
			

	  RETURN QUERY EXECUTE v_Data;
          
END;
$BODY$;

ALTER FUNCTION ods.usp_target_count(bigint)
    OWNER TO proconnect;
