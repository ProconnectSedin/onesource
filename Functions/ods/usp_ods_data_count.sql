CREATE FUNCTION ods.usp_ods_data_count() RETURNS void
    LANGUAGE plpgsql
    AS $$

    declare v_Data text;
    v_TableName text;
    v_Column_List text;
    v_FromClause text;
    v_WhereClause text;
    v_GroupByClause text;
begin
    select TableName from DataValidation_ScriptGenerator;
    select Column_List from DataValidation_ScriptGenerator;
    select TableName from DataValidation_ScriptGenerator;
    select WhereClause_ColumnName from DataValidation_ScriptGenerator;
    select GroupBy_ColumnName from DataValidation_ScriptGenerator;

    v_Data:='select '' '|| v_TableName || ''',' || v_Column_List ||
    'from ' || v_TableName || ' where ' || v_WhereClause ||
    'group by '|| v_GroupByClause;
    Select v_Data;
END;
$$;