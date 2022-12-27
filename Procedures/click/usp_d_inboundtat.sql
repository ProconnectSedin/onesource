-- PROCEDURE: click.usp_d_inboundtat()

-- DROP PROCEDURE IF EXISTS click.usp_d_inboundtat();

CREATE OR REPLACE PROCEDURE click.usp_d_inboundtat(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN
    UPDATE click.d_inboundtat t
    SET
        d_inboundtat_key = s.d_inboundtat_key,
		Location_key = s.Location_key,
        id = s.id,
        ou = s.ou,
        locationcode = s.locationcode,
        ordertype = s.ordertype,
        servicetype = s.servicetype,
        cutofftime = s.cutofftime,
        processtat = s.processtat,
        grtat = s.grtat,
        putawaytat = s.putawaytat,
        openingtime = s.openingtime,
        closingtime = s.closingtime,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlcreatedatetime = s.etlcreatedatetime,
        etlupdatedatetime = NOW()
    FROM dwh.d_inboundtat s
    WHERE t.id = s.id
    AND t.ou = s.ou
    AND t.locationcode = s.locationcode
    AND t.ordertype = s.ordertype
    AND t.servicetype = s.servicetype;

    INSERT INTO click.d_inboundtat(d_inboundtat_key, Location_key ,id, ou, locationcode, ordertype, servicetype, cutofftime, processtat, grtat, putawaytat, openingtime, closingtime, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.d_inboundtat_key,s.Location_key ,s.id, s.ou, s.locationcode, s.ordertype, s.servicetype, s.cutofftime, s.processtat, s.grtat, s.putawaytat, s.openingtime, s.closingtime, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd,  NOW()
    FROM dwh.d_inboundtat s
    LEFT JOIN click.d_inboundtat t
    ON t.id = s.id
    AND t.ou = s.ou
    AND t.locationcode = s.locationcode
    AND t.ordertype = s.ordertype
    AND t.servicetype = s.servicetype
    WHERE t.id IS NULL;
END;
$BODY$;
ALTER PROCEDURE click.usp_d_inboundtat()
    OWNER TO proconnect;
