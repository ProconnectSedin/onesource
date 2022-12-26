-- PROCEDURE: ods.usp_db_table_size()

-- DROP PROCEDURE IF EXISTS ods.usp_db_table_size();

CREATE OR REPLACE PROCEDURE ods.usp_db_table_size(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE
    Snapshot_time timestamp;
    
BEGIN

SELECT Now()::timestamp into Snapshot_time;

INSERT INTO ods.db_size(snapshot_date,db_name,db_size)
SELECT Snapshot_time,datname,pg_size_pretty( pg_database_size(datname) )
FROM pg_database
where datname = 'onesource';

INSERT INTO ods.Table_size(Snapshot_date,DB_Name,Table_Schema,Table_Name,Row_Count,Table_Size)
select
  Snapshot_time,
  table_catalog,
  table_schema,
  table_name,
  count_rows_of_table(table_schema, table_name),
  pg_size_pretty(pg_total_relation_size(table_schema||'.'||table_name))
from
  information_schema.tables
where  table_schema  in ('dwh', 'click')
and table_type = 'BASE TABLE'
order by  3 desc,  4 asc;

END;
$BODY$;
ALTER PROCEDURE ods.usp_db_table_size()
    OWNER TO proconnect;
