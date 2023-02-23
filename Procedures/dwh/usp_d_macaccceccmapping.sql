-- PROCEDURE: dwh.usp_d_macaccceccmapping(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_macaccceccmapping(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_macaccceccmapping(
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
    FROM stg.stg_mac_acc_ce_cc_mapping;

    --UPDATE dwh.d_macaccceccmapping t
    --SET
    --    ou_id                 = s.ou_id,
    --    company_code          = s.company_code,
    --    account_no            = s.account_no,
    --    element_no            = s.element_no,
    --    center_no             = s.center_no,
    --    effective_date        = s.effective_date,
    --    expiry_date           = s.expiry_date,
    --    user_id               = s.user_id,
    --    mod_datetime          = s.mod_datetime,
    --    timestamp             = s.timestamp,
    --    bu_id                 = s.bu_id,
    --    etlactiveind          = 1,
    --    etljobname            = p_etljobname,
    --    envsourcecd           = p_envsourcecd,
    --    datasourcecd          = p_datasourcecd,
    --    etlupdatedatetime     = NOW()
    --FROM stg.stg_mac_acc_ce_cc_mapping s
    --WHERE t.ou_id = s.ou_id
    --AND t.company_code = s.company_code
    --AND t.account_no = s.account_no
    --AND t.element_no = s.element_no
    --AND t.center_no = s.center_no
    --AND t.effective_date = s.effective_date
    --AND t.expiry_date = s.expiry_date;
	
    --GET DIAGNOSTICS updcnt = ROW_COUNT;

	TRUNCATE TABLE dwh.d_macaccceccmapping
	RESTART IDENTITY;

    INSERT INTO dwh.d_macaccceccmapping
    (
        ou_id, 				company_code, 		account_no, 		element_no, 		center_no, 
		effective_date, 	expiry_date, 		user_id, 			mod_datetime, 		timestamp, 
		bu_id, 				etlactiveind, 		etljobname, 		envsourcecd, 		datasourcecd, 
		etlcreatedatetime
    )

    SELECT
        s.ou_id, 			s.company_code, 	s.account_no, 		s.element_no, 		s.center_no, 
		s.effective_date, 	s.expiry_date, 		s.user_id, 			s.mod_datetime, 	s.timestamp, 
		s.bu_id, 			1, 					p_etljobname, 		p_envsourcecd, 		p_datasourcecd, 
		NOW()
    FROM stg.stg_mac_acc_ce_cc_mapping s;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	select 0 into updcnt;
	
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_mac_acc_ce_cc_mapping
    (
        ou_id, 				company_code, 			account_no, 	element_no, 	center_no, 
		effective_date, 	expiry_date, 			user_id, 		mod_datetime, 	timestamp, 
		bu_id, 				etlcreateddatetime
    )
    SELECT
        ou_id, 				company_code, 			account_no, 	element_no, 	center_no, 
		effective_date, 	expiry_date, 			user_id, 		mod_datetime, 	timestamp, 
		bu_id, 				etlcreateddatetime
    FROM stg.stg_mac_acc_ce_cc_mapping;
    
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
ALTER PROCEDURE dwh.usp_d_macaccceccmapping(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
