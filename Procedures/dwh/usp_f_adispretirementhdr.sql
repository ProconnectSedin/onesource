-- PROCEDURE: dwh.usp_f_adispretirementhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_adispretirementhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_adispretirementhdr(
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
    FROM stg.stg_adisp_retirement_hdr;

    UPDATE dwh.f_adispretirementhdr t
    SET
        timestamp                = s.timestamp,
        retirement_date          = s.retirement_date,
        fb_id                    = s.fb_id,
        num_type                 = s.num_type,
        pay_category             = s.pay_category,
        proposal_number          = s.proposal_number,
        gen_auth_invoice         = s.gen_auth_invoice,
        retirement_status        = s.retirement_status,
        createdby                = s.createdby,
        createddate              = s.createddate,
        modifiedby               = s.modifiedby,
        modifieddate             = s.modifieddate,
        num_type_cdi             = s.num_type_cdi,
        workflow_status          = s.workflow_status,
        workflow_error           = s.workflow_error,
        wf_guid                  = s.wf_guid,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_adisp_retirement_hdr s
    WHERE t.ou_id 				 = s.ou_id
    AND   t.retirement_number 	 = s.retirement_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_adispretirementhdr
    (
        ou_id, 				retirement_number, 	timestamp, 			retirement_date, 	fb_id, 
		num_type, 			pay_category, 		proposal_number, 	gen_auth_invoice, 	retirement_status, 
		createdby, 			createddate, 		modifiedby, 		modifieddate, 		num_type_cdi, 
		workflow_status, 	workflow_error, 	wf_guid, 			etlactiveind, 		etljobname, 
		envsourcecd, 		datasourcecd, 		etlcreatedatetime
    )

    SELECT
        s.ou_id, 			s.retirement_number, 	s.timestamp, 		s.retirement_date, 		s.fb_id, 
		s.num_type, 		s.pay_category, 		s.proposal_number, 	s.gen_auth_invoice, 	s.retirement_status, 
		s.createdby, 		s.createddate, 			s.modifiedby, 		s.modifieddate, 		s.num_type_cdi, 
		s.workflow_status, 	s.workflow_error, 		s.wf_guid, 			1, 						p_etljobname, 
		p_envsourcecd, 		p_datasourcecd, 		NOW()
    FROM stg.stg_adisp_retirement_hdr s
    LEFT JOIN dwh.f_adispretirementhdr t
    ON  s.ou_id 			= t.ou_id
    AND s.retirement_number = t.retirement_number
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adisp_retirement_hdr
    (
        ou_id, 				retirement_number, 	timestamp, 			retirement_date, 		fb_id, 
		num_type, 			pay_category, 		proposal_number, 	gen_auth_invoice, 		retirement_status, 
		createdby, 			createddate, 		modifiedby, 		modifieddate, 			num_type_cdi, 
		workflow_status, 	workflow_error, 	wf_guid, 			etlcreateddatetime
    )
    SELECT
		ou_id, 				retirement_number, 	timestamp, 			retirement_date, 		fb_id, 
		num_type, 			pay_category, 		proposal_number, 	gen_auth_invoice, 		retirement_status, 
		createdby, 			createddate, 		modifiedby, 		modifieddate, 			num_type_cdi, 
		workflow_status, 	workflow_error, 	wf_guid, 			etlcreateddatetime
    FROM stg.stg_adisp_retirement_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_adispretirementhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
