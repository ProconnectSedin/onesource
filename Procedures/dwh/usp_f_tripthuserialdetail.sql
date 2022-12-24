-- PROCEDURE: dwh.usp_f_tripthuserialdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tripthuserialdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tripthuserialdetail(
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

    IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN
        SELECT COUNT(1) INTO srccnt
        FROM stg.stg_tms_plttsd_trip_thu_serial_details;

        UPDATE dwh.F_TripTHUSerialDetail t
        SET
        plttd_trip_thu_key    =     oh.plttd_trip_thu_key ,   
        plttsd_serial                = s.plttsd_serial,
        plttsd_serial_qty            = s.plttsd_serial_qty,
        plttsd_created_by            = s.plttsd_created_by,
        plttsd_created_date          = s.plttsd_created_date,
        plttsd_modified_by           = s.plttsd_modified_by,
        plttsd_modified_date         = s.plttsd_modified_date,
        
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
        FROM stg.stg_tms_plttsd_trip_thu_serial_details s

      	INNER JOIN dwh.f_tripthudetail oh 
	  	ON   	s.plttsd_ouinstance 	=  oh.plttd_ouinstance
      	AND  	s.plttsd_trip_plan_id 	=  oh.plttd_trip_plan_id 
       	AND 	s.plttsd_plan_line_id 	=  oh.plttd_trip_plan_line_no      
    	AND  	s.plttsd_thu_line_id 	=  oh.plttd_thu_line_no 
		AND 	s.plttsd_dispatch		=  oh.plttd_dispatch_doc_no

        WHERE t.plttsd_ouinstance 		= s.plttsd_ouinstance
    	AND t.plttsd_trip_plan_id 		= s.plttsd_trip_plan_id
    	AND t.plttsd_plan_line_id 		= s.plttsd_plan_line_id
    	AND t.plttsd_thu_line_id 		= s.plttsd_thu_line_id
    	AND t.plttsd_serial_line_id 	= s.plttsd_serial_line_id
    	AND t.plttsd_dispatch 			= s.plttsd_dispatch;
     

     GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_TripTHUSerialDetail
        (
             plttd_trip_thu_key, plttsd_ouinstance, plttsd_trip_plan_id, plttsd_plan_line_id, plttsd_thu_line_id, plttsd_serial_line_id, plttsd_serial, plttsd_serial_qty, plttsd_created_by, plttsd_created_date, plttsd_modified_by, plttsd_modified_date, plttsd_dispatch, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
            oh.plttd_trip_thu_key ,s.plttsd_ouinstance, s.plttsd_trip_plan_id, s.plttsd_plan_line_id, s.plttsd_thu_line_id, s.plttsd_serial_line_id, s.plttsd_serial, s.plttsd_serial_qty, s.plttsd_created_by, s.plttsd_created_date, s.plttsd_modified_by, s.plttsd_modified_date, s.plttsd_dispatch, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_tms_plttsd_trip_thu_serial_details s

        INNER JOIN dwh.f_tripthudetail oh 
		ON  s.plttsd_ouinstance 	=   oh.plttd_ouinstance
       	AND s.plttsd_trip_plan_id 	=   oh.plttd_trip_plan_id 
       	AND s.plttsd_plan_line_id 	=   oh.plttd_trip_plan_line_no      
    	AND s.plttsd_thu_line_id 	=  	oh.plttd_thu_line_no 
		AND s.plttsd_dispatch		=	oh.plttd_dispatch_doc_no

        LEFT JOIN dwh.F_TripTHUSerialDetail t
        ON s.plttsd_ouinstance 		= t.plttsd_ouinstance
    	AND s.plttsd_trip_plan_id 	= t.plttsd_trip_plan_id
    	AND s.plttsd_plan_line_id 	= t.plttsd_plan_line_id
    	AND s.plttsd_thu_line_id 	= t.plttsd_thu_line_id
    	AND s.plttsd_serial_line_id = t.plttsd_serial_line_id
    	AND s.plttsd_dispatch 		= t.plttsd_dispatch
        WHERE t.plttsd_ouinstance IS NULL;

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_tms_plttsd_trip_thu_serial_details
        (
            plttsd_ouinstance, plttsd_trip_plan_id, plttsd_plan_line_id, plttsd_thu_line_id, plttsd_serial_line_id, plttsd_serial, plttsd_serial_qty, plttsd_serial_wei, plttsd_serial_vol, plttsd_created_by, plttsd_created_date, plttsd_modified_by, plttsd_modified_date, plttsd_time_stamp, plttsd_dispatch, etlcreateddatetime
        )
        SELECT
            plttsd_ouinstance, plttsd_trip_plan_id, plttsd_plan_line_id, plttsd_thu_line_id, plttsd_serial_line_id, plttsd_serial, plttsd_serial_qty, plttsd_serial_wei, plttsd_serial_vol, plttsd_created_by, plttsd_created_date, plttsd_modified_by, plttsd_modified_date, plttsd_time_stamp, plttsd_dispatch, etlcreateddatetime
        FROM stg.stg_tms_plttsd_trip_thu_serial_details;
    END IF;

   ELSE    
         p_errorid   := 0;
         select 0 into inscnt;
            select 0 into updcnt;
         select 0 into srccnt;    
         
         IF p_depsource IS NULL
         THEN 
         p_errordesc := 'The Dependent source cannot be NULL.';
         ELSE
         p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
         END IF;
         CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
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
ALTER PROCEDURE dwh.usp_f_tripthuserialdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
