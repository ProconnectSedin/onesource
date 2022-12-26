CREATE OR REPLACE PROCEDURE dwh.usp_f_planningheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_plph_planning_hdr;

    UPDATE dwh.F_PlanningHeader t
    SET
        plph_loc_key                   =   COALESCE(l.loc_key,-1),
        plph_status                     = s.plph_status,
        plph_description                = s.plph_description,
        plph_planning_profile_no        = s.plph_planning_profile_no,
        plph_plan_location_no           = s.plph_plan_location_no,
        plph_created_by                 = s.plph_created_by,
        plph_created_date               = s.plph_created_date,
        plph_last_modified_by           = s.plph_last_modified_by,
        plph_last_modified_date         = s.plph_last_modified_date,
        plph_plan_mode                  = s.plph_plan_mode,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_tms_plph_planning_hdr s

    LEFT JOIN dwh.d_location L      
        ON s.plph_plan_location_no   = L.loc_code 
        and s.plph_ouinstance = L.loc_ou
      

    WHERE t.plph_ouinstance = s.plph_ouinstance
    AND t.plph_plan_run_no = s.plph_plan_run_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PlanningHeader
    (
       plph_loc_key, plph_ouinstance, plph_plan_run_no, plph_status, plph_description, plph_planning_profile_no, plph_plan_location_no, plph_created_by, plph_created_date, plph_last_modified_by, plph_last_modified_date, plph_plan_mode, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(l.loc_key,-1), s.plph_ouinstance, s.plph_plan_run_no, s.plph_status, s.plph_description, s.plph_planning_profile_no, s.plph_plan_location_no, s.plph_created_by, s.plph_created_date, s.plph_last_modified_by, s.plph_last_modified_date, s.plph_plan_mode, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_plph_planning_hdr s

      LEFT JOIN dwh.d_location L      
        ON s.plph_plan_location_no   = L.loc_code 
        and s.plph_ouinstance = L.loc_ou
      

    LEFT JOIN dwh.F_PlanningHeader t
    ON s.plph_ouinstance = t.plph_ouinstance
    AND s.plph_plan_run_no = t.plph_plan_run_no
    WHERE t.plph_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_plph_planning_hdr
    (
        plph_ouinstance, plph_plan_run_no, plph_status, plph_description, plph_planning_profile_no, plph_plan_location_no, plph_from_location, plph_to_location, plph_created_by, plph_created_date, plph_last_modified_by, plph_last_modified_date, plph_timestamp, plph_plan_mode, etlcreateddatetime
    )
    SELECT
        plph_ouinstance, plph_plan_run_no, plph_status, plph_description, plph_planning_profile_no, plph_plan_location_no, plph_from_location, plph_to_location, plph_created_by, plph_created_date, plph_last_modified_by, plph_last_modified_date, plph_timestamp, plph_plan_mode, etlcreateddatetime
    FROM stg.stg_tms_plph_planning_hdr;
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