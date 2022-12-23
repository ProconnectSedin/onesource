-- PROCEDURE: click.usp_d_thuitemmap()

-- DROP PROCEDURE IF EXISTS click.usp_d_thuitemmap();

CREATE OR REPLACE PROCEDURE click.usp_d_thuitemmap(
	)
LANGUAGE 'plpgsql'
AS $BODY$

Declare p_etllastrundate date;

BEGIN

	SELECT max(COALESCE(etlupdatedatetime,etlcreatedatetime)):: DATE as p_etllastrundate
	INTO p_etllastrundate
	FROM click.d_thuitemmap;	
	
	
    UPDATE click.d_thuitemmap t
    SET
        thu_itm_key = s.thu_itm_key,
        thu_loc_code = s.thu_loc_code,
        thu_ou = s.thu_ou,
        thu_serial_no = s.thu_serial_no,
        thu_id = s.thu_id,
        thu_item = s.thu_item,
        thu_lot_no = s.thu_lot_no,
        thu_itm_serial_no = s.thu_itm_serial_no,
        thu_qty = s.thu_qty,
        thu_created_by = s.thu_created_by,
        thu_created_date = s.thu_created_date,
        thu_ser_no = s.thu_ser_no,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = s.etlupdatedatetime
    FROM dwh.d_thuitemmap s
    WHERE t.thu_loc_code = s.thu_loc_code
    AND t.thu_ou = s.thu_ou
    AND t.thu_serial_no = s.thu_serial_no
    AND t.thu_id = s.thu_id
    AND t.thu_item = s.thu_item
    AND t.thu_lot_no = s.thu_lot_no
    AND t.thu_itm_serial_no = s.thu_itm_serial_no
	AND COALESCE(s.etlupdatedatetime,s.etlcreatedatetime)::DATE > p_etllastrundate;
	

    INSERT INTO click.d_thuitemmap(thu_itm_key, thu_loc_code, thu_ou, thu_serial_no, thu_id, thu_item, thu_lot_no, thu_itm_serial_no, thu_qty, thu_created_by, thu_created_date, thu_ser_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.thu_itm_key, s.thu_loc_code, s.thu_ou, s.thu_serial_no, s.thu_id, s.thu_item, s.thu_lot_no, s.thu_itm_serial_no, s.thu_qty, s.thu_created_by, s.thu_created_date, s.thu_ser_no, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, s.etlcreatedatetime
    FROM dwh.d_thuitemmap s
    LEFT JOIN click.d_thuitemmap t
    ON t.thu_loc_code = s.thu_loc_code
    AND t.thu_ou = s.thu_ou
    AND t.thu_serial_no = s.thu_serial_no
    AND t.thu_id = s.thu_id
    AND t.thu_item = s.thu_item
    AND t.thu_lot_no = s.thu_lot_no
    AND t.thu_itm_serial_no = s.thu_itm_serial_no
    WHERE t.thu_loc_code IS NULL
	AND COALESCE(s.etlupdatedatetime,s.etlcreatedatetime)::DATE > p_etllastrundate;
END;
$BODY$;
ALTER PROCEDURE click.usp_d_thuitemmap()
    OWNER TO proconnect;
