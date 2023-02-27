-- PROCEDURE: dwh.usp_f_adisptransferhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_adisptransferhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_adisptransferhdr(
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
    FROM stg.stg_adisp_transfer_hdr;

    UPDATE dwh.f_adisptransferhdr t
    SET
        timestamp                 = s.timestamp,
        transfer_date             = s.transfer_date,
        transfer_status           = s.transfer_status,
        num_type                  = s.num_type,
        source_fb_id              = s.source_fb_id,
        destination_fb_id         = s.destination_fb_id,
        confirmation_date         = s.confirmation_date,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        transfer_in_no            = s.transfer_in_no,
        tcal_status_in            = s.tcal_status_in,
        tcal_status               = s.tcal_status,
        tran_type                 = s.tran_type,
        transfer_in_status        = s.transfer_in_status,
        transfer_in_numtyp        = s.transfer_in_numtyp,
        workflow_status           = s.workflow_status,
        workflow_error            = s.workflow_error,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_adisp_transfer_hdr s
    WHERE t.ou_id 				  = s.ou_id
    AND   t.transfer_number 	  = s.transfer_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_adisptransferhdr
    (
        ou_id, 				transfer_number, 	timestamp, 				transfer_date, 			transfer_status, 
		num_type, 			source_fb_id, 		destination_fb_id, 		confirmation_date, 		createdby, 
		createddate, 		modifiedby, 		modifieddate, 			transfer_in_no, 		tcal_status_in, 
		tcal_status, 		tran_type, 			transfer_in_status, 	transfer_in_numtyp, 	workflow_status, 
		workflow_error, 	etlactiveind, 		etljobname, 			envsourcecd, 			datasourcecd, 
		etlcreatedatetime
    )

    SELECT
        s.ou_id, 			s.transfer_number, 		s.timestamp, 			s.transfer_date, 		s.transfer_status, 
		s.num_type, 		s.source_fb_id, 		s.destination_fb_id, 	s.confirmation_date, 	s.createdby, 
		s.createddate, 		s.modifiedby, 			s.modifieddate, 		s.transfer_in_no, 		s.tcal_status_in, 
		s.tcal_status, 		s.tran_type, 			s.transfer_in_status, 	s.transfer_in_numtyp, 	s.workflow_status, 
		s.workflow_error, 	1, 						p_etljobname, 			p_envsourcecd, 			p_datasourcecd, 
		NOW()
    FROM stg.stg_adisp_transfer_hdr s
    LEFT JOIN dwh.f_adisptransferhdr t
    ON s.ou_id = t.ou_id
    AND s.transfer_number = t.transfer_number
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adisp_transfer_hdr
    (
        ou_id, 				transfer_number, 		timestamp, 				transfer_date, 			transfer_status, 
		num_type, 			source_fb_id, 			destination_fb_id, 		confirmation_date, 		createdby, 
		createddate, 		modifiedby, 			modifieddate, 			transfer_in_no, 		tcal_status_in, 
		tcal_status, 		tran_type, 				transfer_in_status, 	transfer_in_numtyp, 	workflow_status, 
		workflow_error, 	etlcreateddatetime
    )
    SELECT
        ou_id, 				transfer_number, 		timestamp, 				transfer_date, 			transfer_status, 
		num_type, 			source_fb_id, 			destination_fb_id, 		confirmation_date, 		createdby, 
		createddate, 		modifiedby, 			modifieddate, 			transfer_in_no, 		tcal_status_in, 
		tcal_status, 		tran_type, 				transfer_in_status, 	transfer_in_numtyp, 	workflow_status, 
		workflow_error, 	etlcreateddatetime
    FROM stg.stg_adisp_transfer_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_adisptransferhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
