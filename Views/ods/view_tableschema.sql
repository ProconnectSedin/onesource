CREATE VIEW ods.view_tableschema AS
 SELECT t.table_name,
    t.table_catalog,
    c.table_schema,
    c.column_name,
    c.is_nullable,
    c.data_type,
    c.character_maximum_length,
    c.is_identity,
    con.constraint_name
   FROM ((information_schema.tables t
     JOIN information_schema.columns c ON ((((t.table_name)::name = (c.table_name)::name) AND ((t.table_schema)::name = (c.table_schema)::name))))
     LEFT JOIN information_schema.constraint_column_usage con ON ((((c.table_name)::name = (con.table_name)::name) AND ((c.table_schema)::name = (con.table_schema)::name) AND ((c.column_name)::name = (con.column_name)::name))));
