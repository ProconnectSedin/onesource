-- PROCEDURE: dwh.usp_d_suppaddraddress(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_suppaddraddress(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_suppaddraddress(
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
    FROM stg.stg_supp_addr_address;

    UPDATE dwh.D_suppaddraddress t
    SET
        supp_addr_loid                  = s.supp_addr_loid,
        supp_addr_supcode               = s.supp_addr_supcode,
        supp_addr_addid                 = s.supp_addr_addid,
        supp_addr_contperson            = s.supp_addr_contperson,
        supp_addr_contperson_shd        = s.supp_addr_contperson_shd,
        supp_addr_address1              = s.supp_addr_address1,
        supp_addr_address2              = s.supp_addr_address2,
        supp_addr_address3              = s.supp_addr_address3,
        supp_addr_city                  = s.supp_addr_city,
        supp_addr_state                 = s.supp_addr_state,
        supp_addr_country               = s.supp_addr_country,
        supp_addr_zip                   = s.supp_addr_zip,
        supp_addr_fax                   = s.supp_addr_fax,
        supp_addr_phone                 = s.supp_addr_phone,
        supp_addr_email                 = s.supp_addr_email,
        supp_addr_createdby             = s.supp_addr_createdby,
        supp_addr_createdate            = s.supp_addr_createdate,
        supp_addr_modifiedby            = s.supp_addr_modifiedby,
        supp_addr_modifieddate          = s.supp_addr_modifieddate,
        supp_addr_mobileno              = s.supp_addr_mobileno,
        supp_addr_countrycode           = s.supp_addr_countrycode,
        supp_addr_statedesc             = s.supp_addr_statedesc,
        supp_addr_hobranchcode          = s.supp_addr_hobranchcode,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_supp_addr_address s
    WHERE t.supp_addr_loid = s.supp_addr_loid
    AND t.supp_addr_supcode = s.supp_addr_supcode
    AND t.supp_addr_addid = s.supp_addr_addid;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_suppaddraddress
    (
        supp_addr_loid, supp_addr_supcode, supp_addr_addid, supp_addr_contperson, supp_addr_contperson_shd, supp_addr_address1, supp_addr_address2, supp_addr_address3, supp_addr_city, supp_addr_state, supp_addr_country, supp_addr_zip, supp_addr_fax, supp_addr_phone, supp_addr_email, supp_addr_createdby, supp_addr_createdate, supp_addr_modifiedby, supp_addr_modifieddate, supp_addr_mobileno, supp_addr_countrycode, supp_addr_statedesc, supp_addr_hobranchcode, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.supp_addr_loid, s.supp_addr_supcode, s.supp_addr_addid, s.supp_addr_contperson, s.supp_addr_contperson_shd, s.supp_addr_address1, s.supp_addr_address2, s.supp_addr_address3, s.supp_addr_city, s.supp_addr_state, s.supp_addr_country, s.supp_addr_zip, s.supp_addr_fax, s.supp_addr_phone, s.supp_addr_email, s.supp_addr_createdby, s.supp_addr_createdate, s.supp_addr_modifiedby, s.supp_addr_modifieddate, s.supp_addr_mobileno, s.supp_addr_countrycode, s.supp_addr_statedesc, s.supp_addr_hobranchcode, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_supp_addr_address s
    LEFT JOIN dwh.D_suppaddraddress t
    ON s.supp_addr_loid = t.supp_addr_loid
    AND s.supp_addr_supcode = t.supp_addr_supcode
    AND s.supp_addr_addid = t.supp_addr_addid
    WHERE t.supp_addr_loid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_supp_addr_address
    (
        supp_addr_loid, supp_addr_supcode, supp_addr_addid, supp_addr_contperson, supp_addr_contperson_shd, supp_addr_address1, supp_addr_address2, supp_addr_address3, supp_addr_city, supp_addr_state, supp_addr_country, supp_addr_zip, supp_addr_fax, supp_addr_phone, supp_addr_email, supp_addr_createdby, supp_addr_createdate, supp_addr_modifiedby, supp_addr_modifieddate, supp_addr_mobileno, supp_addr_countrycode, supp_addr_statedesc, supp_addr_hobranchcode, supp_latitude, supp_longitude, etlcreateddatetime
    )
    SELECT
        supp_addr_loid, supp_addr_supcode, supp_addr_addid, supp_addr_contperson, supp_addr_contperson_shd, supp_addr_address1, supp_addr_address2, supp_addr_address3, supp_addr_city, supp_addr_state, supp_addr_country, supp_addr_zip, supp_addr_fax, supp_addr_phone, supp_addr_email, supp_addr_createdby, supp_addr_createdate, supp_addr_modifiedby, supp_addr_modifieddate, supp_addr_mobileno, supp_addr_countrycode, supp_addr_statedesc, supp_addr_hobranchcode, supp_latitude, supp_longitude, etlcreateddatetime
    FROM stg.stg_supp_addr_address;
    
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
ALTER PROCEDURE dwh.usp_d_suppaddraddress(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
