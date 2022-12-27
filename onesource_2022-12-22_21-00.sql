CREATE SERVER fdw_serv FOREIGN DATA WRAPPER postgres_fdw OPTIONS (
    dbname 'onesource_stage',
    host '20.219.105.177',
    port '5432'
);
ALTER SERVER fdw_serv OWNER TO proconnect;
SET default_tablespace = '';
SET default_table_access_method = heap;

CREATE TRIGGER controldetailtrigger AFTER INSERT OR DELETE OR UPDATE ON ods.controldetail FOR EACH ROW EXECUTE FUNCTION ods.controldetailaudit();
CREATE TRIGGER controlheadertrigger AFTER INSERT OR DELETE OR UPDATE ON ods.controlheader FOR EACH ROW EXECUTE FUNCTION ods.controlheaderaudit();
CREATE TRIGGER trig_copy AFTER INSERT OR UPDATE ON public.table1 FOR EACH ROW EXECUTE FUNCTION public.function_copy();
