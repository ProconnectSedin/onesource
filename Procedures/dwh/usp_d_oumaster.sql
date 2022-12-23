CREATE PROCEDURE dwh.usp_d_oumaster(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename,h.rawstorageflag

    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname,p_rawstorageflag

    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
    ON d.sourceid	= h.sourceid
    WHERE d.sourceid	= p_sourceId
    AND d.dataflowflag	= p_dataflowflag
    AND d.targetobject	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_emod_ou_mst;

    UPDATE dwh.D_OuMaster t
    SET
        otimestamp             = s.timestamp,
        default_flag          = s.default_flag,
        map_status            = s.map_status,
        effective_from        = s.effective_from,
        createdby             = s.createdby,
        createddate           = s.createddate,
        modifiedby            = s.modifiedby,
        modifieddate          = s.modifieddate,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_emod_ou_mst s
    WHERE t.ou_id = s.ou_id
    AND t.bu_id = s.bu_id
    AND t.company_code = s.company_code
    AND t.address_id = s.address_id
    AND t.serial_no = s.serial_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_OuMaster
    (
        ou_id			, bu_id			, company_code	,
		address_id		, serial_no		, otimestamp		, 
		default_flag	, map_status	, effective_from, 
		createdby		, createddate	, modifiedby	, 
		modifieddate	, 
		etlactiveind	, etljobname	, envsourcecd	, 
		datasourcecd	, etlcreatedatetime
    )

    SELECT
        s.ou_id			, s.bu_id		, s.company_code	, 
		s.address_id	, s.serial_no	, s.timestamp		, 
		s.default_flag	, s.map_status	, s.effective_from	, 
		s.createdby		, s.createddate	, s.modifiedby		, 
		s.modifieddate	, 
				1		, p_etljobname	, p_envsourcecd		, 
		p_datasourcecd	, NOW()
    FROM stg.stg_emod_ou_mst s
    LEFT JOIN dwh.D_OuMaster t
    ON s.ou_id = t.ou_id
    AND s.bu_id = t.bu_id
    AND s.company_code = t.company_code
    AND s.address_id = t.address_id
    AND s.serial_no = t.serial_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN


    INSERT INTO raw.raw_emod_ou_mst
    (
        ou_id			, bu_id			, company_code	, 
		address_id		, serial_no		, timestamp		, 
		default_flag	, map_status	, effective_from, 
		effective_to	, createdby		, createddate	, 
		modifiedby		, modifieddate	, latitude		, 
		longitude		, etlcreateddatetime
    )
    SELECT
        ou_id			, bu_id			, company_code	, 
		address_id		, serial_no		, timestamp		, 
		default_flag	, map_status	, effective_from, 
		effective_to	, createdby		, createddate	, 
		modifiedby		, modifieddate	, latitude		, 
		longitude		, etlcreateddatetime
	FROM stg.stg_emod_ou_mst;
	END IF;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;	
END;
$$;