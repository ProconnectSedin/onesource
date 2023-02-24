-- PROCEDURE: dwh.usp_f_adeppreversehdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_adeppreversehdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_adeppreversehdr(
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
    FROM stg.stg_adepp_reverse_hdr;

    UPDATE dwh.f_adeppreversehdr t
    SET
        timestamp              = s.timestamp,
        revr_option            = s.revr_option,
        depr_total             = s.depr_total,
        susp_total             = s.susp_total,
        reversal_date          = s.reversal_date,
        fb_id                  = s.fb_id,
        num_type               = s.num_type,
        rev_status             = s.rev_status,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_adepp_reverse_hdr s
    WHERE t.ou_id 			   = s.ou_id
    AND   t.rev_doc_no 		   = s.rev_doc_no
    AND   t.depr_proc_runno    = s.depr_proc_runno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_adeppreversehdr
    (
        ou_id, 			rev_doc_no, 	timestamp, 		revr_option, 	depr_proc_runno, 
		depr_total, 	susp_total, 	reversal_date, 	fb_id, 			num_type, 
		rev_status, 	createdby, 		createddate, 	modifiedby, 	modifieddate, 
		etlactiveind, 	etljobname, 	envsourcecd, 	datasourcecd, 	etlcreatedatetime
    )

    SELECT
        s.ou_id, 			s.rev_doc_no, 	s.timestamp, 		s.revr_option, 		s.depr_proc_runno, 
		s.depr_total, 		s.susp_total, 	s.reversal_date, 	s.fb_id, 			s.num_type, 
		s.rev_status, 		s.createdby, 	s.createddate, 		s.modifiedby, 		s.modifieddate, 
		1, 					p_etljobname, 	p_envsourcecd, 		p_datasourcecd, 	NOW()
    FROM stg.stg_adepp_reverse_hdr s
    LEFT JOIN dwh.f_adeppreversehdr t
    ON  s.ou_id 			= t.ou_id
    AND s.rev_doc_no 		= t.rev_doc_no
    AND s.depr_proc_runno   = t.depr_proc_runno
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adepp_reverse_hdr
    (
        ou_id, 		rev_doc_no, timestamp, 		revr_option, 	depr_proc_runno, 
		depr_total, susp_total, reversal_date, 	fb_id, 			num_type, 
		rev_status, createdby, 	createddate,	 modifiedby, 	modifieddate, 
		etlcreateddatetime
    )
    SELECT
        ou_id, 		rev_doc_no, timestamp, 		revr_option, 	depr_proc_runno, 
		depr_total, susp_total, reversal_date, 	fb_id, 			num_type, 
		rev_status, createdby, 	createddate,	 modifiedby, 	modifieddate, 
		etlcreateddatetime
    FROM stg.stg_adepp_reverse_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_adeppreversehdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
