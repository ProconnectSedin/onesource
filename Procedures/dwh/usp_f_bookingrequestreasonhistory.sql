-- PROCEDURE: dwh.usp_f_bookingrequestreasonhistory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_bookingrequestreasonhistory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_bookingrequestreasonhistory(
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
DECLARE
  v_min INTEGER;
 v_max INTEGER;
 v_amendno_f INTEGER;
 v_createddate character varying(100);
 v_br_ouinstance INTEGER;
 v_br_request_id character varying(72);
 v_amend_no_stg INTEGER;
BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

	IF EXISTS(SELECT 1  FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_br_booking_request_reason_hist;

	call dwh.usp_booking_his_amendno_update();
	
    UPDATE dwh.f_bookingRequestReasonHistory t
    SET
	    br_hdr_key           = fh.br_key,
        br_status            = s.br_status,
        reason_code          = s.reason_code,
        reason_desc          = s.reason_desc,
        created_date         = s.created_date,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM	stg.stg_tms_br_booking_request_reason_hist s
	INNER JOIN dwh.f_bookingrequest fh
	ON      s.br_request_Id     = fh.br_request_id
	AND     s.br_ouinstance     = fh.br_ouinstance
    WHERE	t.br_ouinstance		= s.br_ouinstance
    AND		t.br_request_Id		= s.br_request_Id
    AND		t.amend_no			= s.amend_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_bookingRequestReasonHistory
    (
        br_hdr_key,br_ouinstance, br_request_Id, amend_no, br_status, reason_code, reason_desc, created_date, etlactiveind, etljobname, 
		envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.br_key,s.br_ouinstance, s.br_request_Id, s.amend_no, s.br_status, s.reason_code, s.reason_desc, s.created_date, 1, p_etljobname, 
		p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_br_booking_request_reason_hist s
	INNER JOIN dwh.f_bookingrequest fh
	ON      s.br_request_Id     = fh.br_request_id
	AND     s.br_ouinstance     = fh.br_ouinstance
    LEFT JOIN dwh.f_bookingRequestReasonHistory t
    ON s.br_ouinstance = t.br_ouinstance
    AND s.br_request_Id = t.br_request_Id
    AND s.amend_no = t.amend_no
    WHERE t.br_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_br_booking_request_reason_hist
    (
        br_ouinstance, br_request_Id, amend_no, br_status, reason_code, reason_desc, created_date, etlcreateddatetime
    )
    SELECT
        br_ouinstance, br_request_Id, amend_no, br_status, reason_code, reason_desc, created_date, etlcreateddatetime
    FROM stg.stg_tms_br_booking_request_reason_hist;
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
ALTER PROCEDURE dwh.usp_f_bookingrequestreasonhistory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
