CREATE VIEW ods.show_db_sizes AS
 SELECT pg_database.datname,
    pg_size_pretty(pg_database_size(pg_database.datname)) AS pg_size_pretty
   FROM pg_database
  ORDER BY (pg_database_size(pg_database.datname)) DESC;
  