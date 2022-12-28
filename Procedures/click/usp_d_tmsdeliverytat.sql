-- PROCEDURE: click.usp_d_tmsdeliverytat()

-- DROP PROCEDURE IF EXISTS click.usp_d_tmsdeliverytat();

CREATE OR REPLACE PROCEDURE click.usp_d_tmsdeliverytat(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN
    
    TRUNCATE ONLY click.d_tmsdeliverytat restart identity ;

    INSERT INTO click.d_tmsdeliverytat(tms_dly_tat_key, agent_code, shipfrom_place, shipfrom_pincode, shipto_place, shipto_pincode, ship_mode, tat, tat_uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.tms_dly_tat_key, s.agent_code, s.shipfrom_place, s.shipfrom_pincode, s.shipto_place, s.shipto_pincode, s.ship_mode, s.tat, s.tat_uom, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_tmsdeliverytat s;
    
END;
$BODY$;
ALTER PROCEDURE click.usp_d_tmsdeliverytat()
    OWNER TO proconnect;
