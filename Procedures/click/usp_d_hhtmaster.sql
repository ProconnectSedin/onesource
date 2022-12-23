-- PROCEDURE: click.usp_d_hhtmaster()

-- DROP PROCEDURE IF EXISTS click.usp_d_hhtmaster();

CREATE OR REPLACE PROCEDURE click.usp_d_hhtmaster(
	)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
    p_errorid integer;
    p_errordesc character varying;

BEGIN
   

    TRUNCATE ONLY click.d_hhtmaster restart identity ;

    INSERT INTO click.d_hhtmaster
    (
       hht_loc_key, id,   locationcode,    locationdesc,    brand, Count,    oldcount040220,   oldcount300920,
            oldcount030321,         etlactiveind,                   etljobname, 
        envsourcecd,                datasourcecd,                   etlcreatedatetime
    )

    SELECT
        s.hht_loc_key,  s.id,   s.locationcode,    s.locationdesc,    s.brand, s.Count,    s.oldcount040220,   s.oldcount300920,s.oldcount030321,               
        '1',                s.etljobname,       s.envsourcecd,  s.datasourcecd, NOW()::Timestamp
    FROM dwh.d_hht_master s;

 
        
    EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
END;
$BODY$;
ALTER PROCEDURE click.usp_d_hhtmaster()
    OWNER TO proconnect;
