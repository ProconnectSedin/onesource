-- PROCEDURE: click.usp_d_outboundtat()

-- DROP PROCEDURE IF EXISTS click.usp_d_outboundtat();

CREATE OR REPLACE PROCEDURE click.usp_d_outboundtat(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN
    
    TRUNCATE ONLY click.d_outboundtat restart identity ;

    INSERT INTO click.d_outboundtat( 
       obd_tat_key,loc_key, id, ou, locationcode, orderType, ServiceType, ProcessTAT, pickTAT, PackTAT, DispTAT, DelTAT, picktat1, packtat1, disptat1, deltat1, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      s.obd_tat_key,s.loc_key, s.id, s.ou, s.locationcode, s.orderType, s.ServiceType, s.ProcessTAT, s.pickTAT, s.PackTAT, s.DispTAT, s.DelTAT, s.picktat1, s.packtat1, s.disptat1, s.deltat1, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, s.etlcreatedatetime
    FROM dwh.d_outboundtat s;
    
END;
$BODY$;
ALTER PROCEDURE click.usp_d_outboundtat()
    OWNER TO proconnect;
