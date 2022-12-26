CREATE OR REPLACE PROCEDURE dwh.usp_f_brplanningprofiledetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_tms_brppd_planning_profile_dtl;

    UPDATE dwh.f_bRPlanningProfileDetail t
    SET
	    brppd_cust_key                = COALESCE(c.customer_key,-1),  
		brppd_loc_key                 = COALESCE(l.loc_key,-1),
        brppd_direct_entry            = s.brppd_direct_entry,
        brppd_auto_entry              = s.brppd_auto_entry,
        brppd_created_by              = s.brppd_created_by,
        brppd_created_date            = s.brppd_created_date,
        brppd_priority                = s.brppd_priority,
        brppd_param_priority          = s.brppd_param_priority,
        brppd_customer_id             = s.brppd_customer_id,
        brppd_customer_name           = s.brppd_customer_name,
        brppd_execution_plan          = s.brppd_execution_plan,
        brppd_ship_from_id            = s.brppd_ship_from_id,
        brppd_ship_from_desc          = s.brppd_ship_from_desc,
        brppd_ship_from_postal        = s.brppd_ship_from_postal,
        brppd_ship_from_suburb        = s.brppd_ship_from_suburb,
        brppd_ship_to_id              = s.brppd_ship_to_id,
        brppd_ship_to_desc            = s.brppd_ship_to_desc,
        brppd_ship_to_postal          = s.brppd_ship_to_postal,
        brppd_ship_to_suburb          = s.brppd_ship_to_suburb,
        brppd_pickup_date             = s.brppd_pickup_date,
        brppd_pickup_timeslot         = s.brppd_pickup_timeslot,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_tms_brppd_planning_profile_dtl s
	LEFT JOIN dwh.d_location L 		
	ON		s.brppd_ship_from_id= L.loc_code 
    AND		s.brppd_ouinstance	= L.loc_ou
	LEFT JOIN dwh.d_customer c
	ON      s.brppd_customer_id = c.customer_id
	AND     s.brppd_ouinstance	= c.customer_ou
    WHERE	t.brppd_ouinstance	= s.brppd_ouinstance
    AND		t.brppd_profile_id	= s.brppd_profile_id
    AND		t.brppd_br_id		= s.brppd_br_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_bRPlanningProfileDetail
    (
        brppd_cust_key,brppd_loc_key,brppd_ouinstance, brppd_profile_id, brppd_br_id, brppd_direct_entry, brppd_auto_entry, brppd_created_by, brppd_created_date, brppd_priority, brppd_param_priority, 
		brppd_customer_id, brppd_customer_name, brppd_execution_plan, brppd_ship_from_id, brppd_ship_from_desc, brppd_ship_from_postal, 
		brppd_ship_from_suburb, brppd_ship_to_id, brppd_ship_to_desc, brppd_ship_to_postal, brppd_ship_to_suburb, brppd_pickup_date, brppd_pickup_timeslot, 
		etlactiveind, etljobname, envsourcecd, datasourcecd,etlcreatedatetime
    )

    SELECT
        COALESCE(c.customer_key,-1),COALESCE(l.loc_key,-1),s.brppd_ouinstance, s.brppd_profile_id, s.brppd_br_id, s.brppd_direct_entry, s.brppd_auto_entry, s.brppd_created_by, s.brppd_created_date, s.brppd_priority, 
		s.brppd_param_priority, s.brppd_customer_id, s.brppd_customer_name, s.brppd_execution_plan, s.brppd_ship_from_id, s.brppd_ship_from_desc, s.brppd_ship_from_postal, 
		s.brppd_ship_from_suburb, s.brppd_ship_to_id, s.brppd_ship_to_desc, s.brppd_ship_to_postal, s.brppd_ship_to_suburb, s.brppd_pickup_date, s.brppd_pickup_timeslot, 
		1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_brppd_planning_profile_dtl s
	LEFT JOIN dwh.d_location L 		
	ON		s.brppd_ship_from_id= L.loc_code 
    AND		s.brppd_ouinstance	= L.loc_ou
	LEFT JOIN dwh.d_customer c
	ON      s.brppd_customer_id = c.customer_id
	AND     s.brppd_ouinstance	= c.customer_ou
    LEFT JOIN dwh.f_bRPlanningProfileDetail t
    ON		s.brppd_ouinstance	= t.brppd_ouinstance
    AND		s.brppd_profile_id	= t.brppd_profile_id
    AND		s.brppd_br_id		= t.brppd_br_id
    WHERE t.brppd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_brppd_planning_profile_dtl
    (
        brppd_ouinstance, brppd_profile_id, brppd_br_id, brppd_direct_entry, brppd_auto_entry, brppd_created_by, brppd_created_date, brppd_priority, brppd_param_priority, 
		brppd_customer_id, brppd_customer_name, brppd_execution_plan, brppd_ship_from_id, brppd_ship_from_desc, brppd_ship_from_postal, brppd_ship_from_suburb, brppd_ship_to_id, 
		brppd_ship_to_desc, brppd_ship_to_postal, brppd_ship_to_suburb, brppd_pickup_date, brppd_pickup_timeslot, etlcreateddatetime
    )
    SELECT
        brppd_ouinstance, brppd_profile_id, brppd_br_id, brppd_direct_entry, brppd_auto_entry, brppd_created_by, brppd_created_date, brppd_priority, brppd_param_priority, 
		brppd_customer_id, brppd_customer_name, brppd_execution_plan, brppd_ship_from_id, brppd_ship_from_desc, brppd_ship_from_postal, brppd_ship_from_suburb, brppd_ship_to_id, 
		brppd_ship_to_desc, brppd_ship_to_postal, brppd_ship_to_suburb, brppd_pickup_date, brppd_pickup_timeslot, etlcreateddatetime
    FROM stg.stg_tms_brppd_planning_profile_dtl;
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