-- PROCEDURE: dwh.usp_f_dispatchdocsignature(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_dispatchdocsignature(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_dispatchdocsignature(
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
    FROM stg.stg_tms_dds_dispatch_document_signature;

    UPDATE dwh.F_DispatchDocSignature t
    SET
		
		ddh_key			  		 	= fh.ddh_key,
        dds_name                    = s.dds_name,
        dds_signature               = s.dds_signature,
        dds_remarks                 = s.dds_remarks,
        dds_feedback                = s.dds_feedback,
        dds_signature_status        = s.dds_signature_status,
        dds_id_type                 = s.dds_id_type,
        dds_id_no                   = s.dds_id_no,
        dds_designation             = s.dds_designation,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_tms_dds_dispatch_document_signature s
	INNER JOIN 	dwh.f_dispatchdocheader fh 
			ON  s.dds_ouinstance 			= fh.ddh_ouinstance
            AND S.dds_dispatch_doc_no       = fh.ddh_dispatch_doc_no
    WHERE 		t.dds_ouinstance 			= s.dds_ouinstance
    AND 		t.dds_Trip_id				= s.dds_Trip_id
    AND 		t.dds_seqno					= s.dds_seqno
    AND 		t.dds_dispatch_doc_no		= s.dds_dispatch_doc_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DispatchDocSignature
    (
		ddh_key,
        dds_ouinstance, dds_Trip_id, dds_seqno, dds_dispatch_doc_no, dds_name, dds_signature, dds_remarks, dds_feedback, dds_signature_status, dds_id_type, dds_id_no, dds_designation, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		fh.ddh_key,
        s.dds_ouinstance, s.dds_Trip_id, s.dds_seqno, s.dds_dispatch_doc_no, s.dds_name, s.dds_signature, s.dds_remarks, s.dds_feedback, s.dds_signature_status, s.dds_id_type, s.dds_id_no, s.dds_designation, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_dds_dispatch_document_signature s
	INNER JOIN 	dwh.f_dispatchdocheader fh 
			ON  s.dds_ouinstance 			= fh.ddh_ouinstance
            AND S.dds_dispatch_doc_no       = fh.ddh_dispatch_doc_no
    LEFT JOIN dwh.F_DispatchDocSignature t
    ON 			s.dds_ouinstance 			= t.dds_ouinstance
    AND 		s.dds_Trip_id 				= t.dds_Trip_id
    AND 		s.dds_seqno 				= t.dds_seqno
    AND 		s.dds_dispatch_doc_no 		= t.dds_dispatch_doc_no
    WHERE t.dds_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    
    update  ods.controldetail 
    set  etllastrundate = (CURRENT_DATE - INTERVAL '7 days')::DATE
    where sourceid = 'tms_dds_dispatch_document_signature'
    and dataflowflag = 'SRCtoStg';
    
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_dds_dispatch_document_signature
    (
        dds_ouinstance, dds_Trip_id, dds_seqno, dds_dispatch_doc_no, dds_name, dds_signature, dds_remarks, dds_feedback, dds_signature_status, dds_id_type, dds_id_no, dds_designation, etlcreateddatetime
    )
    SELECT
        dds_ouinstance, dds_Trip_id, dds_seqno, dds_dispatch_doc_no, dds_name, dds_signature, dds_remarks, dds_feedback, dds_signature_status, dds_id_type, dds_id_no, dds_designation, etlcreateddatetime
    FROM stg.stg_tms_dds_dispatch_document_signature;
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
ALTER PROCEDURE dwh.usp_f_dispatchdocsignature(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
