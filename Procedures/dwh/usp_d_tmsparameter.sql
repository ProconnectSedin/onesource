CREATE PROCEDURE dwh.usp_d_tmsparameter(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_component_met;

    UPDATE dwh.D_TMSParameter t
    SET
        tms_optionvalue          = s.tms_optionvalue,
        tms_sequenceno           = s.tms_sequenceno,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_tms_component_met s
    WHERE	t.tms_componentname	= s.tms_componentname
    AND		t.tms_paramcategory	= s.tms_paramcategory
    AND		t.tms_paramtype		= s.tms_paramtype
    AND		t.tms_paramcode		= s.tms_paramcode
    AND		t.tms_paramdesc		= s.tms_paramdesc
    AND		t.tms_langid		= s.tms_langid;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_TMSParameter
    (
        tms_componentname	, tms_paramcategory		, tms_paramtype		, tms_paramcode		, tms_paramdesc	, 
		tms_langid			, tms_optionvalue		, tms_sequenceno	, 
		etlactiveind		, etljobname			, envsourcecd		, datasourcecd		, etlcreatedatetime
    )

    SELECT
        s.tms_componentname	, s.tms_paramcategory	, s.tms_paramtype	, s.tms_paramcode	, s.tms_paramdesc,
		s.tms_langid		, s.tms_optionvalue		, s.tms_sequenceno	, 
				1			, p_etljobname			, p_envsourcecd		, p_datasourcecd	, NOW()
    FROM stg.stg_tms_component_met s
    LEFT JOIN dwh.D_TMSParameter t
    ON	s.tms_componentname	= t.tms_componentname
    AND	s.tms_paramcategory	= t.tms_paramcategory
    AND	s.tms_paramtype		= t.tms_paramtype
    AND	s.tms_paramcode		= t.tms_paramcode
    AND	s.tms_paramdesc		= t.tms_paramdesc
    AND	s.tms_langid		= t.tms_langid
    WHERE t.tms_componentname IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN


    INSERT INTO raw.raw_tms_component_met
    (
        tms_componentname	, tms_paramcategory	, tms_paramtype	, tms_paramcode		, tms_paramdesc	, 
		tms_langid			, tms_optionvalue	, tms_sequenceno, etlcreateddatetime
    )
    SELECT
        tms_componentname	, tms_paramcategory	, tms_paramtype	, tms_paramcode		, tms_paramdesc	, 
		tms_langid			, tms_optionvalue	, tms_sequenceno, etlcreateddatetime
    FROM stg.stg_tms_component_met;
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