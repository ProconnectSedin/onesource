-- PROCEDURE: dwh.usp_d_custaddrdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_custaddrdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_custaddrdtl(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE
    p_etljobname VARCHAR(100);
    p_envsourcecd VARCHAR(50);
    p_datasourcecd VARCHAR(50);
    p_batchid integer;
    p_taskname VARCHAR(100);
    p_packagename  VARCHAR(100);
    p_errorid integer;
    p_errordesc character varying;
    p_errorline integer;
    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_cust_addr_dtl;

    UPDATE dwh.d_custaddrdtl t
    SET
        addr_lo                   = s.addr_lo,
        addr_cust_code            = s.addr_cust_code,
        addr_lineno               = s.addr_lineno,
        addr_created_ou           = s.addr_created_ou,
        addr_address_id           = s.addr_address_id,
        addr_addrline1            = s.addr_addrline1,
        addr_addrline2            = s.addr_addrline2,
        addr_addrline3            = s.addr_addrline3,
        addr_city                 = s.addr_city,
        addr_state                = s.addr_state,
        addr_country              = s.addr_country,
        addr_zip                  = s.addr_zip,
        addr_phone1               = s.addr_phone1,
        addr_phone2               = s.addr_phone2,
        addr_email                = s.addr_email,
        addr_fax                  = s.addr_fax,
        addr_inco_term            = s.addr_inco_term,
        addr_del_area_code        = s.addr_del_area_code,
        addr_created_by           = s.addr_created_by,
        addr_created_date         = s.addr_created_date,
        addr_modified_by          = s.addr_modified_by,
        addr_modified_date        = s.addr_modified_date,
        addr_hobranchcode         = s.addr_hobranchcode,
        addr_Status               = s.addr_Status,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_cust_addr_dtl s
    WHERE t.addr_lo = s.addr_lo
    AND t.addr_cust_code = s.addr_cust_code
    AND t.addr_lineno = s.addr_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_custaddrdtl
    (
        addr_lo			, addr_cust_code	, addr_lineno		, addr_created_ou	, addr_address_id,
		addr_addrline1	, addr_addrline2	, addr_addrline3	, addr_city			, addr_state,
		addr_country	, addr_zip			, addr_phone1		, addr_phone2		, addr_email,
		addr_fax		, addr_inco_term	, addr_del_area_code, addr_created_by	, addr_created_date,
		addr_modified_by, addr_modified_date, addr_hobranchcode	, addr_Status		,
		etlactiveind	, etljobname		, envsourcecd		, datasourcecd		, etlcreatedatetime
    )

    SELECT
        s.addr_lo			, s.addr_cust_code		, s.addr_lineno			, s.addr_created_ou	, s.addr_address_id,
		s.addr_addrline1	, s.addr_addrline2		, s.addr_addrline3		, s.addr_city		, s.addr_state,
		s.addr_country		, s.addr_zip			, s.addr_phone1			, s.addr_phone2		, s.addr_email,
		s.addr_fax			, s.addr_inco_term		, s.addr_del_area_code	, s.addr_created_by	, s.addr_created_date,
		s.addr_modified_by	, s.addr_modified_date	, s.addr_hobranchcode	, s.addr_Status		,
				1			, p_etljobname			, p_envsourcecd			, p_datasourcecd	, NOW()
    FROM stg.stg_cust_addr_dtl s
    LEFT JOIN dwh.D_custaddrdtl t
    ON s.addr_lo = t.addr_lo
    AND s.addr_cust_code = t.addr_cust_code
    AND s.addr_lineno = t.addr_lineno
    WHERE t.addr_lo IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_cust_addr_dtl
    (
        addr_lo, addr_cust_code, addr_lineno, addr_created_ou, addr_address_id, addr_addrline1, addr_addrline2, addr_addrline3, addr_city, addr_state, addr_country, addr_zip, addr_phone1, addr_phone2, addr_email, addr_fax, addr_inco_term, addr_inco_place_air, addr_inco_place_road, addr_inco_place_rail, addr_inco_place_ship, addr_del_area_code, addr_created_by, addr_created_date, addr_modified_by, addr_modified_date, addr_addnl1, addr_addnl2, addr_addnl3, addr_hobranchcode, addr_latitude, addr_longitude, addr_cust_name, addr_Status, addr_reasoncode, addr_name, etlcreateddatetime
    )
    SELECT
        addr_lo, addr_cust_code, addr_lineno, addr_created_ou, addr_address_id, addr_addrline1, addr_addrline2, addr_addrline3, addr_city, addr_state, addr_country, addr_zip, addr_phone1, addr_phone2, addr_email, addr_fax, addr_inco_term, addr_inco_place_air, addr_inco_place_road, addr_inco_place_rail, addr_inco_place_ship, addr_del_area_code, addr_created_by, addr_created_date, addr_modified_by, addr_modified_date, addr_addnl1, addr_addnl2, addr_addnl3, addr_hobranchcode, addr_latitude, addr_longitude, addr_cust_name, addr_Status, addr_reasoncode, addr_name, etlcreateddatetime
    FROM stg.stg_cust_addr_dtl;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_d_custaddrdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
