-- PROCEDURE: dwh.usp_f_execthuserialdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_execthuserialdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_execthuserialdetail(
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
        FROM stg.stg_tms_pletsd_exec_thu_serial_details;

        UPDATE dwh.F_ExecThuSerialDetail t
        SET

        plepd_trip_exe_pln_dtl_key            = oh.plepd_trip_exe_pln_dtl_key,
        pletsd_serial                         = s.pletsd_serial,
        pletsd_serial_available_qty           = s.pletsd_serial_available_qty,
        pletsd_serial_draft_qty               = s.pletsd_serial_draft_qty,
        pletsd_serial_confirmed_qty           = s.pletsd_serial_confirmed_qty,
        pletsd_serail_available_weight        = s.pletsd_serail_available_weight,
        pletsd_serial_draft_weight            = s.pletsd_serial_draft_weight,
        pletsd_serial_confirmed_weight        = s.pletsd_serial_confirmed_weight,
        pletsd_serial_available_volume        = s.pletsd_serial_available_volume,
        pletsd_serial_draft_volume            = s.pletsd_serial_draft_volume,
        pletsd_serial_confirmed_volume        = s.pletsd_serial_confirmed_volume,
        pletsd_created_by                     = s.pletsd_created_by,
        pletsd_created_date                   = s.pletsd_created_date,
        pletsd_modified_by                    = s.pletsd_modified_by,
        pletsd_modified_date                  = s.pletsd_modified_date,
        pletsd_timestamp                      = s.pletsd_timestamp,
        pletsd_serial_initiated_qty           = s.pletsd_serial_initiated_qty,
        pletsd_serial_executed_qty            = s.pletsd_serial_executed_qty,
        pletsd_serial_initiated_weight        = s.pletsd_serial_initiated_weight,
        pletsd_serial_executed_weight         = s.pletsd_serial_executed_weight,
        pletsd_serial_initiated_volume        = s.pletsd_serial_initiated_volume,
        pletsd_serial_executed_volume         = s.pletsd_serial_executed_volume,
        pletsd_serial_dropped_off             = s.pletsd_serial_dropped_off,
        pletsd_serial_dispatch                = s.pletsd_serial_dispatch,
        pletsd_updated_by                     = s.pletsd_updated_by,
        pletsd_picked_shortclosure            = s.pletsd_picked_shortclosure,
            etlactiveind                          = 1,
        etljobname                            = p_etljobname,
        envsourcecd                           = p_envsourcecd,
        datasourcecd                          = p_datasourcecd,
        etlupdatedatetime                     = NOW()
        FROM stg.stg_tms_pletsd_exec_thu_serial_details s

INNER JOIN dwh.f_tripexecutionplandetail oh
ON    s.pletsd_execution_plan_id =    oh.plepd_execution_plan_id
 AND  s.pletsd_line_no =   oh.plepd_line_no
 AND  s.pletsd_ouinstance =   oh.plepd_ouinstance

        WHERE t.pletsd_ouinstance = s.pletsd_ouinstance
    AND t.pletsd_execution_plan_id = s.pletsd_execution_plan_id
    AND t.pletsd_line_no = s.pletsd_line_no
    AND t.pletsd_thu_line_no = s.pletsd_thu_line_no
    AND t.pletsd_serial_line_no  = s.pletsd_serial_line_no;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_ExecThuSerialDetail
        (
          plepd_trip_exe_pln_dtl_key,  pletsd_ouinstance, pletsd_execution_plan_id, pletsd_line_no, pletsd_thu_line_no, pletsd_serial_line_no, pletsd_serial, pletsd_serial_available_qty, pletsd_serial_draft_qty, pletsd_serial_confirmed_qty, pletsd_serail_available_weight, pletsd_serial_draft_weight, pletsd_serial_confirmed_weight, pletsd_serial_available_volume, pletsd_serial_draft_volume, pletsd_serial_confirmed_volume, pletsd_created_by, pletsd_created_date, pletsd_modified_by, pletsd_modified_date, pletsd_timestamp, pletsd_serial_initiated_qty, pletsd_serial_executed_qty, pletsd_serial_initiated_weight, pletsd_serial_executed_weight, pletsd_serial_initiated_volume, pletsd_serial_executed_volume, pletsd_serial_dropped_off, pletsd_serial_dispatch, pletsd_updated_by, pletsd_picked_shortclosure, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
           oh.plepd_trip_exe_pln_dtl_key, s.pletsd_ouinstance, s.pletsd_execution_plan_id, s.pletsd_line_no, s.pletsd_thu_line_no, s.pletsd_serial_line_no, s.pletsd_serial, s.pletsd_serial_available_qty, s.pletsd_serial_draft_qty, s.pletsd_serial_confirmed_qty, s.pletsd_serail_available_weight, s.pletsd_serial_draft_weight, s.pletsd_serial_confirmed_weight, s.pletsd_serial_available_volume, s.pletsd_serial_draft_volume, s.pletsd_serial_confirmed_volume, s.pletsd_created_by, s.pletsd_created_date, s.pletsd_modified_by, s.pletsd_modified_date, s.pletsd_timestamp, s.pletsd_serial_initiated_qty, s.pletsd_serial_executed_qty, s.pletsd_serial_initiated_weight, s.pletsd_serial_executed_weight, s.pletsd_serial_initiated_volume, s.pletsd_serial_executed_volume, s.pletsd_serial_dropped_off, s.pletsd_serial_dispatch, s.pletsd_updated_by, s.pletsd_picked_shortclosure, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_tms_pletsd_exec_thu_serial_details s

        INNER JOIN dwh.f_tripexecutionplandetail oh
       ON    s.pletsd_execution_plan_id =    oh.plepd_execution_plan_id
       AND  s.pletsd_line_no =   oh.plepd_line_no
       AND  s.pletsd_ouinstance =   oh.plepd_ouinstance

        LEFT JOIN dwh.F_ExecThuSerialDetail t
        ON s.pletsd_ouinstance = t.pletsd_ouinstance
    AND t.pletsd_execution_plan_id = s.pletsd_execution_plan_id
    AND t.pletsd_line_no = s.pletsd_line_no
    AND t.pletsd_thu_line_no = s.pletsd_thu_line_no
    AND t.pletsd_serial_line_no  = s.pletsd_serial_line_no

        WHERE t.pletsd_ouinstance IS NULL;
		

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_tms_pletsd_exec_thu_serial_details
        (
            pletsd_ouinstance, pletsd_execution_plan_id, pletsd_line_no, pletsd_thu_line_no, pletsd_serial_line_no, pletsd_serial, pletsd_serial_available_qty, pletsd_serial_draft_qty, pletsd_serial_confirmed_qty, pletsd_serail_available_weight, pletsd_serial_draft_weight, pletsd_serial_confirmed_weight, pletsd_serial_available_volume, pletsd_serial_draft_volume, pletsd_serial_confirmed_volume, pletsd_created_by, pletsd_created_date, pletsd_modified_by, pletsd_modified_date, pletsd_timestamp, pletsd_serial_initiated_qty, pletsd_serial_executed_qty, pletsd_serial_initiated_weight, pletsd_serial_executed_weight, pletsd_serial_initiated_volume, pletsd_serial_executed_volume, pletsd_serial_dropped_off, pletsd_serial_dispatch, pletsd_updated_by, pletsd_picked_shortclosure, etlcreateddatetime
        )
        SELECT
            pletsd_ouinstance, pletsd_execution_plan_id, pletsd_line_no, pletsd_thu_line_no, pletsd_serial_line_no, pletsd_serial, pletsd_serial_available_qty, pletsd_serial_draft_qty, pletsd_serial_confirmed_qty, pletsd_serail_available_weight, pletsd_serial_draft_weight, pletsd_serial_confirmed_weight, pletsd_serial_available_volume, pletsd_serial_draft_volume, pletsd_serial_confirmed_volume, pletsd_created_by, pletsd_created_date, pletsd_modified_by, pletsd_modified_date, pletsd_timestamp, pletsd_serial_initiated_qty, pletsd_serial_executed_qty, pletsd_serial_initiated_weight, pletsd_serial_executed_weight, pletsd_serial_initiated_volume, pletsd_serial_executed_volume, pletsd_serial_dropped_off, pletsd_serial_dispatch, pletsd_updated_by, pletsd_picked_shortclosure, etlcreateddatetime
        FROM stg.stg_tms_pletsd_exec_thu_serial_details;
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
ALTER PROCEDURE dwh.usp_f_execthuserialdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
