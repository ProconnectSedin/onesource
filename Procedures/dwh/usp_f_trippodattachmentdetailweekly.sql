-- PROCEDURE: dwh.usp_f_trippodattachmentdetailweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_trippodattachmentdetailweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_trippodattachmentdetailweekly(
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

	IF EXISTS(SELECT 1  FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_tpad_pod_attachment_dtl;

    UPDATE dwh.f_trippodattachmentdetail t
    SET
	    tpad_trip_hdr_key                = fh.plpth_hdr_key,
        tpad_ouinstance                  = s.tpad_ouinstance,
        tpad_Trip_id                     = s.tpad_Trip_id,
        tpad_seqno                       = s.tpad_seqno,
        tpad_doc_no                      = s.tpad_doc_no,
        tpad_document_code               = s.tpad_document_code,
        tpad_attachment_file_name        = s.tpad_attachment_file_name,
        tpad_attachment                  = s.tpad_attachment,
        tpad_remarks                     = s.tpad_remarks,
        tpad_created_by                  = s.tpad_created_by,
        tpad_created_date                = s.tpad_created_date,
        tpad_last_updated_by             = s.tpad_last_updated_by,
        tpad_last_updated_date           = s.tpad_last_updated_date,
        tpad_timestamp                   = s.tpad_timestamp,
        tpad_addln_doc_no                = s.tpad_addln_doc_no,
        tpad_doc_type                    = s.tpad_doc_type,
        tpad_hdn_file_name               = s.tpad_hdn_file_name,
        tpad_parent_guid                 = s.tpad_parent_guid,
        tpad_dispatch_doc_no             = s.tpad_dispatch_doc_no,
        etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
    FROM stg.stg_tms_tpad_pod_attachment_dtl s
	inner join dwh.f_tripplanningheader fh
	ON		tpad_ouinstance  			=	fh.plpth_ouinstance
	AND		tpad_Trip_id			    =	fh.plpth_trip_plan_id
    WHERE t.tpad_line_no = s.tpad_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_trippodattachmentdetail
    (
        tpad_trip_hdr_key,tpad_ouinstance, tpad_Trip_id, tpad_seqno, tpad_line_no, tpad_doc_no, tpad_document_code, tpad_attachment_file_name, 
		tpad_attachment, tpad_remarks, tpad_created_by, tpad_created_date, tpad_last_updated_by, tpad_last_updated_date, tpad_timestamp, 
		tpad_addln_doc_no, tpad_doc_type, tpad_hdn_file_name, tpad_parent_guid, tpad_dispatch_doc_no, etlactiveind, etljobname, 
		envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.plpth_hdr_key,s.tpad_ouinstance, s.tpad_Trip_id, s.tpad_seqno, s.tpad_line_no, s.tpad_doc_no, s.tpad_document_code, s.tpad_attachment_file_name, 
		s.tpad_attachment, s.tpad_remarks, s.tpad_created_by, s.tpad_created_date, s.tpad_last_updated_by, s.tpad_last_updated_date, s.tpad_timestamp, 
		s.tpad_addln_doc_no, s.tpad_doc_type, s.tpad_hdn_file_name, s.tpad_parent_guid, s.tpad_dispatch_doc_no, 1, p_etljobname, 
		p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_tpad_pod_attachment_dtl s
	inner join dwh.f_tripplanningheader fh
	ON		tpad_ouinstance  			=	fh.plpth_ouinstance
	AND		tpad_Trip_id			    =	fh.plpth_trip_plan_id
    LEFT JOIN dwh.f_trippodattachmentdetail t
    ON		s.tpad_line_no				=	t.tpad_line_no
    WHERE t.tpad_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	
	UPDATE dwh.f_trippodattachmentdetail t1
	set  etlactiveind        =  0,
         etlupdatedatetime   = Now()::TIMESTAMP
	from dwh.f_trippodattachmentdetail t
	left join stg.stg_tms_tpad_pod_attachment_dtl s
	ON    s.tpad_line_no		    =	t.tpad_line_no
	Where t.tpad_dtl_key			= t1.tpad_dtl_key
	AND   COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
	AND   s.tpad_line_no IS NULL;
	
	
	
	
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tpad_pod_attachment_dtl
    (
        tpad_ouinstance, tpad_Trip_id, tpad_seqno, tpad_line_no, tpad_doc_no, tpad_document_code, tpad_attachment_file_name, 
		tpad_attachment, tpad_remarks, tpad_created_by, tpad_created_date, tpad_last_updated_by, tpad_last_updated_date, tpad_timestamp, 
		tpad_addln_doc_no, tpad_doc_type, tpad_hdn_file_name, tpad_parent_guid, tpad_dispatch_doc_no, etlcreateddatetime
    )
    SELECT
        tpad_ouinstance, tpad_Trip_id, tpad_seqno, tpad_line_no, tpad_doc_no, tpad_document_code, tpad_attachment_file_name, 
		tpad_attachment, tpad_remarks, tpad_created_by, tpad_created_date, tpad_last_updated_by, tpad_last_updated_date, tpad_timestamp, 
		tpad_addln_doc_no, tpad_doc_type, tpad_hdn_file_name, tpad_parent_guid, tpad_dispatch_doc_no, etlcreateddatetime
    FROM stg.stg_tms_tpad_pod_attachment_dtl;
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
ALTER PROCEDURE dwh.usp_f_trippodattachmentdetailweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
