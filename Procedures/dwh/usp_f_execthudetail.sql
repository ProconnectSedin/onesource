-- PROCEDURE: dwh.usp_f_execthudetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_execthudetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_execthudetail(
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
        FROM stg.stg_tms_pletd_exec_thu_details;

        UPDATE dwh.F_ExecThuDetail t
        SET
        plepd_trip_exe_pln_dtl_key       	=  oh.plepd_trip_exe_pln_dtl_key,
        pletd_thu_available_qty             = s.pletd_thu_available_qty,
        pletd_thu_draft_qty                 = s.pletd_thu_draft_qty,
        pletd_thu_confirmed_qty             = s.pletd_thu_confirmed_qty,
        pletd_thu_available_weight          = s.pletd_thu_available_weight,
        pletd_thu_draft_weight              = s.pletd_thu_draft_weight,
        pletd_thu_confirmed_weight          = s.pletd_thu_confirmed_weight,
        pletd_thu_available_volume          = s.pletd_thu_available_volume,
        pletd_thu_draft_volume              = s.pletd_thu_draft_volume,
        pletd_thu_confirmed_volume          = s.pletd_thu_confirmed_volume,
        pletd_created_by                    = s.pletd_created_by,
        pletd_created_date                  = s.pletd_created_date,
        pletd_modified_by                   = s.pletd_modified_by,
        pletd_modified_date                 = s.pletd_modified_date,
        pletd_updated_by                    = s.pletd_updated_by,
        pletd_timestamp                     = s.pletd_timestamp,
        pletd_initiated_qty                 = s.pletd_initiated_qty,
        pletd_executed_qty                  = s.pletd_executed_qty,
        pletd_dispatch_docno                = s.pletd_dispatch_docno,
        pletd_thu_id                        = s.pletd_thu_id,
        pletd_weight                        = s.pletd_weight,
        pletd_weight_uom                    = s.pletd_weight_uom,
        pletd_volume                        = s.pletd_volume,
        pletd_volume_uom                    = s.pletd_volume_uom,
        pletd_pallet                        = s.pletd_pallet,
        pletd_thu_qty                       = s.pletd_thu_qty,
        pletd_pickup_shotclosure_qty        = s.pletd_pickup_shotclosure_qty,
        etlactiveind                        = 1,
        etljobname                          = p_etljobname,
        envsourcecd                         = p_envsourcecd,
        datasourcecd                        = p_datasourcecd,
        etlupdatedatetime                   = NOW()
        FROM stg.stg_tms_pletd_exec_thu_details s

        INNER JOIN dwh.f_tripexecutionplandetail oh
        ON    s.pletd_ouinstance  			= oh.plepd_ouinstance
        AND   s.pletd_execution_plan_id  	= oh.plepd_execution_plan_id
        AND   s.pletd_line_no  				= oh.plepd_line_no
        WHERE t.pletd_ouinstance = s.pletd_ouinstance
    	AND t.pletd_execution_plan_id = s.pletd_execution_plan_id
    	AND t.pletd_line_no = s.pletd_line_no
		AND t.pletd_dispatch_docno =  s.pletd_dispatch_docno
    	AND t.pletd_thu_line_no = s.pletd_thu_line_no;

        GET DIAGNOSTICS updcnt = ROW_COUNT;

        INSERT INTO dwh.F_ExecThuDetail
        (
           plepd_trip_exe_pln_dtl_key, pletd_ouinstance, pletd_execution_plan_id, pletd_line_no, pletd_thu_line_no, pletd_thu_available_qty, pletd_thu_draft_qty, pletd_thu_confirmed_qty, pletd_thu_available_weight, pletd_thu_draft_weight, pletd_thu_confirmed_weight, pletd_thu_available_volume, pletd_thu_draft_volume, pletd_thu_confirmed_volume, pletd_created_by, pletd_created_date, pletd_modified_by, pletd_modified_date, pletd_updated_by, pletd_timestamp, pletd_initiated_qty, pletd_executed_qty, pletd_dispatch_docno, pletd_thu_id, pletd_weight, pletd_weight_uom, pletd_volume, pletd_volume_uom, pletd_pallet, pletd_thu_qty, pletd_pickup_shotclosure_qty, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
        )

        SELECT
            oh.plepd_trip_exe_pln_dtl_key,s.pletd_ouinstance, s.pletd_execution_plan_id, s.pletd_line_no, s.pletd_thu_line_no, s.pletd_thu_available_qty, s.pletd_thu_draft_qty, s.pletd_thu_confirmed_qty, s.pletd_thu_available_weight, s.pletd_thu_draft_weight, s.pletd_thu_confirmed_weight, s.pletd_thu_available_volume, s.pletd_thu_draft_volume, s.pletd_thu_confirmed_volume, s.pletd_created_by, s.pletd_created_date, s.pletd_modified_by, s.pletd_modified_date, s.pletd_updated_by, s.pletd_timestamp, s.pletd_initiated_qty, s.pletd_executed_qty, s.pletd_dispatch_docno, s.pletd_thu_id, s.pletd_weight, s.pletd_weight_uom, s.pletd_volume, s.pletd_volume_uom, s.pletd_pallet, s.pletd_thu_qty, s.pletd_pickup_shotclosure_qty, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
        FROM stg.stg_tms_pletd_exec_thu_details s

    INNER JOIN dwh.f_tripexecutionplandetail oh
        ON  s.pletd_ouinstance  			= oh.plepd_ouinstance
        AND   s.pletd_execution_plan_id  	= oh.plepd_execution_plan_id
        AND   s.pletd_line_no  				= oh.plepd_line_no

    LEFT JOIN dwh.F_ExecThuDetail t
        ON s.pletd_ouinstance = t.pletd_ouinstance
        AND s.pletd_execution_plan_id = t.pletd_execution_plan_id
        AND s.pletd_line_no = t.pletd_line_no
		AND s.pletd_dispatch_docno =  t.pletd_dispatch_docno
        AND s.pletd_thu_line_no = t.pletd_thu_line_no
        WHERE t.pletd_ouinstance IS NULL;
		
		

        GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

        INSERT INTO raw.raw_tms_pletd_exec_thu_details
        (
            pletd_ouinstance, pletd_execution_plan_id, pletd_line_no, pletd_thu_line_no, pletd_thu_available_qty, pletd_thu_draft_qty, pletd_thu_confirmed_qty, pletd_thu_available_weight, pletd_thu_draft_weight, pletd_thu_confirmed_weight, pletd_thu_available_volume, pletd_thu_draft_volume, pletd_thu_confirmed_volume, pletd_created_by, pletd_created_date, pletd_modified_by, pletd_modified_date, pletd_updated_by, pletd_timestamp, pletd_initiated_qty, pletd_executed_qty, pletd_dispatch_docno, pletd_thu_id, pletd_weight, pletd_weight_uom, pletd_volume, pletd_volume_uom, pletd_pallet, pletd_thu_qty, pletd_pickup_shotclosure_qty, etlcreateddatetime
        )
        SELECT
            pletd_ouinstance, pletd_execution_plan_id, pletd_line_no, pletd_thu_line_no, pletd_thu_available_qty, pletd_thu_draft_qty, pletd_thu_confirmed_qty, pletd_thu_available_weight, pletd_thu_draft_weight, pletd_thu_confirmed_weight, pletd_thu_available_volume, pletd_thu_draft_volume, pletd_thu_confirmed_volume, pletd_created_by, pletd_created_date, pletd_modified_by, pletd_modified_date, pletd_updated_by, pletd_timestamp, pletd_initiated_qty, pletd_executed_qty, pletd_dispatch_docno, pletd_thu_id, pletd_weight, pletd_weight_uom, pletd_volume, pletd_volume_uom, pletd_pallet, pletd_thu_qty, pletd_pickup_shotclosure_qty, etlcreateddatetime
        FROM stg.stg_tms_pletd_exec_thu_details;
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
ALTER PROCEDURE dwh.usp_f_execthudetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
