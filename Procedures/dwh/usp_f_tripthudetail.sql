CREATE PROCEDURE dwh.usp_f_tripthudetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    p_depsource VARCHAR(100);

    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag, h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag, p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

   
        SELECT COUNT(1) INTO srccnt
        FROM stg.stg_tms_plttd_trip_thu_details;

        UPDATE dwh.F_TripTHUDetail t
        SET
        plttd_thu_key      			   = COALESCE(th.thu_key,-1),
        plttd_ouinstance               = s.plttd_ouinstance,
        plttd_thu_qty                  = s.plttd_thu_qty,
        plttd_thu_weight               = s.plttd_thu_weight,
        plttd_thu_vol                  = s.plttd_thu_vol,
        plttd_created_by               = s.plttd_created_by,
        plttd_created_date             = s.plttd_created_date,
        plttd_modified_by              = s.plttd_modified_by,
        plttd_modified_date            = s.plttd_modified_date,
        plttd_thu_id                   = s.plttd_thu_id,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
        FROM stg.stg_tms_plttd_trip_thu_details s

        LEFT JOIN dwh.d_thu th         
        ON  s.plttd_thu_id        = th.thu_id 
        AND s.plttd_ouinstance       = th.thu_ou       

    WHERE t.plttd_ouinstance = s.plttd_ouinstance
    AND t.plttd_trip_plan_id = s.plttd_trip_plan_id
    AND t.plttd_trip_plan_line_no = s.plttd_trip_plan_line_no
    AND t.plttd_thu_line_no = s.plttd_thu_line_no
    AND t.plttd_dispatch_doc_no = s.plttd_dispatch_doc_no;
	
    GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_TripTHUDetail
        (
           plttd_thu_key , plttd_ouinstance, plttd_trip_plan_id, plttd_trip_plan_line_no, plttd_thu_line_no, plttd_thu_qty, plttd_thu_weight, plttd_thu_vol, plttd_created_by, plttd_created_date, plttd_modified_by, plttd_modified_date, plttd_dispatch_doc_no, plttd_thu_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
           COALESCE(th.thu_key,-1),s.plttd_ouinstance, s.plttd_trip_plan_id, s.plttd_trip_plan_line_no, s.plttd_thu_line_no, s.plttd_thu_qty, s.plttd_thu_weight, s.plttd_thu_vol, s.plttd_created_by, s.plttd_created_date, s.plttd_modified_by, s.plttd_modified_date, s.plttd_dispatch_doc_no, s.plttd_thu_id, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_tms_plttd_trip_thu_details s

        LEFT JOIN dwh.d_thu th         
        ON  s.plttd_thu_id        	 = th.thu_id 
        AND s.plttd_ouinstance       = th.thu_ou

        LEFT JOIN dwh.F_TripTHUDetail t
        ON s.plttd_ouinstance 		= t.plttd_ouinstance
    	AND s.plttd_trip_plan_id 	= t.plttd_trip_plan_id
    	AND s.plttd_trip_plan_line_no = t.plttd_trip_plan_line_no
    	AND s.plttd_thu_line_no 		= t.plttd_thu_line_no
    	AND s.plttd_dispatch_doc_no = t.plttd_dispatch_doc_no
    	WHERE t.plttd_ouinstance IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_tms_plttd_trip_thu_details
        (
            plttd_ouinstance, plttd_trip_plan_id, plttd_trip_plan_line_no, plttd_thu_line_no, plttd_thu_qty, plttd_thu_weight, plttd_thu_vol, plttd_created_by, plttd_created_date, plttd_modified_by, plttd_modified_date, plttd_timestamp, plttd_dispatch_doc_no, plttd_thu_id, etlcreateddatetime
        )
        SELECT
            plttd_ouinstance, plttd_trip_plan_id, plttd_trip_plan_line_no, plttd_thu_line_no, plttd_thu_qty, plttd_thu_weight, plttd_thu_vol, plttd_created_by, plttd_created_date, plttd_modified_by, plttd_modified_date, plttd_timestamp, plttd_dispatch_doc_no, plttd_thu_id, etlcreateddatetime
        FROM stg.stg_tms_plttd_trip_thu_details;
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