-- PROCEDURE: dwh.usp_f_dispatchdocthuchilddetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_dispatchdocthuchilddetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_dispatchdocthuchilddetail(
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
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
    FROM stg.stg_tms_ddtcd_dispatch_document_thu_child_dtl;

    UPDATE dwh.F_DispatchDocTHUChildDetail t
    SET
		ddtd_key							  = fh.ddtd_key,	
        ddtcd_thu_child_id                    = s.ddtcd_thu_child_id,
        ddtcd_thu_child_serial_no             = s.ddtcd_thu_child_serial_no,
        ddtcd_thu_child_qty                   = s.ddtcd_thu_child_qty,
        ddtcd_created_by                      = s.ddtcd_created_by,
        ddtcd_created_date                    = s.ddtcd_created_date,
        ddtcd_last_modified_by                = s.ddtcd_last_modified_by,
        ddtcd_lst_modified_date               = s.ddtcd_lst_modified_date,
        ddtcd_timestamp                       = s.ddtcd_timestamp,
        ddtcd_main_thu_child_serial_no        = s.ddtcd_main_thu_child_serial_no,
        etlactiveind                          = 1,
        etljobname                            = p_etljobname,
        envsourcecd                           = p_envsourcecd,
        datasourcecd                          = p_datasourcecd,
        etlupdatedatetime                     = NOW()
    FROM stg.stg_tms_ddtcd_dispatch_document_thu_child_dtl s
	INNER JOIN 	dwh.f_dispatchdocthudetail fh 
			ON  s.ddtcd_ouinstance 			= fh.ddtd_ouinstance
            AND s.ddtcd_dispatch_doc_no     = fh.ddtd_dispatch_doc_no
			And s.ddtcd_thu_line_no			= fh.ddtd_thu_line_no
    WHERE 		t.ddtcd_ouinstance 			= s.ddtcd_ouinstance
    AND 		t.ddtcd_dispatch_doc_no 	= s.ddtcd_dispatch_doc_no
    AND 		t.ddtcd_thu_line_no 		= s.ddtcd_thu_line_no
    AND 		t.ddtcd_thu_child_line_no 	= s.ddtcd_thu_child_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DispatchDocTHUChildDetail
    (
		ddtd_key,
        ddtcd_ouinstance, ddtcd_dispatch_doc_no, ddtcd_thu_line_no, ddtcd_thu_child_line_no, ddtcd_thu_child_id, ddtcd_thu_child_serial_no, ddtcd_thu_child_qty, ddtcd_created_by, ddtcd_created_date, ddtcd_last_modified_by, ddtcd_lst_modified_date, ddtcd_timestamp, ddtcd_main_thu_child_serial_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		fh.ddtd_key,
        s.ddtcd_ouinstance, s.ddtcd_dispatch_doc_no, s.ddtcd_thu_line_no, s.ddtcd_thu_child_line_no, s.ddtcd_thu_child_id, s.ddtcd_thu_child_serial_no, s.ddtcd_thu_child_qty, s.ddtcd_created_by, s.ddtcd_created_date, s.ddtcd_last_modified_by, s.ddtcd_lst_modified_date, s.ddtcd_timestamp, s.ddtcd_main_thu_child_serial_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_ddtcd_dispatch_document_thu_child_dtl s
	INNER JOIN 	dwh.f_dispatchdocthudetail fh 
			ON  s.ddtcd_ouinstance 			= fh.ddtd_ouinstance
            AND S.ddtcd_dispatch_doc_no     = fh.ddtd_dispatch_doc_no
			And s.ddtcd_thu_line_no			= fh.ddtd_thu_line_no
    LEFT JOIN dwh.F_DispatchDocTHUChildDetail t
    ON 			s.ddtcd_ouinstance 			= t.ddtcd_ouinstance
    AND 		s.ddtcd_dispatch_doc_no 	= t.ddtcd_dispatch_doc_no
    AND 		s.ddtcd_thu_line_no 		= t.ddtcd_thu_line_no
    AND 		s.ddtcd_thu_child_line_no 	= t.ddtcd_thu_child_line_no
    WHERE t.ddtcd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_ddtcd_dispatch_document_thu_child_dtl
    (
        ddtcd_ouinstance, ddtcd_dispatch_doc_no, ddtcd_thu_line_no, ddtcd_thu_child_line_no, ddtcd_thu_child_id, ddtcd_thu_child_serial_no, ddtcd_thu_child_qty, ddtcd_created_by, ddtcd_created_date, ddtcd_last_modified_by, ddtcd_lst_modified_date, ddtcd_timestamp, ddtcd_main_thu_child_serial_no, etlcreateddatetime
    )
    SELECT
        ddtcd_ouinstance, ddtcd_dispatch_doc_no, ddtcd_thu_line_no, ddtcd_thu_child_line_no, ddtcd_thu_child_id, ddtcd_thu_child_serial_no, ddtcd_thu_child_qty, ddtcd_created_by, ddtcd_created_date, ddtcd_last_modified_by, ddtcd_lst_modified_date, ddtcd_timestamp, ddtcd_main_thu_child_serial_no, etlcreateddatetime
    FROM stg.stg_tms_ddtcd_dispatch_document_thu_child_dtl;
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
ALTER PROCEDURE dwh.usp_f_dispatchdocthuchilddetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
