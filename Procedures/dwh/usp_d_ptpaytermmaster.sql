-- PROCEDURE: dwh.usp_d_ptpaytermmaster(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_ptpaytermmaster(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_ptpaytermmaster(
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
    FROM stg.stg_pt_payterm_master;

    UPDATE dwh.d_ptpaytermmaster t
    SET
        pt_description            = s.pt_description,
        pt_effectivedate          = s.pt_effectivedate,
        pt_expirydate             = s.pt_expirydate,
        pt_status                 = s.pt_status,
        pt_propdiscount           = s.pt_propdiscount,
        pt_anchordateinfo         = s.pt_anchordateinfo,
        pt_created_by             = s.pt_created_by,
        pt_created_date           = s.pt_created_date,
        pt_modified_by            = s.pt_modified_by,
        pt_modified_date          = s.pt_modified_date,
        pt_timestamp_value        = s.pt_timestamp_value,
        pt_lo_id                  = s.pt_lo_id,
        pt_created_langid         = s.pt_created_langid,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_pt_payterm_master s
    WHERE t.pt_ouinstance 		  = s.pt_ouinstance
    AND   t.pt_paytermcode 		  = s.pt_paytermcode
    AND   t.pt_version_no 		  = s.pt_version_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_ptpaytermmaster
    (
        pt_ouinstance, 		pt_paytermcode, 	pt_version_no, 		pt_description, 	pt_effectivedate, 
		pt_expirydate, 		pt_status, 			pt_propdiscount, 	pt_anchordateinfo, 	pt_created_by, 
		pt_created_date, 	pt_modified_by, 	pt_modified_date, 	pt_timestamp_value, pt_lo_id, 
		pt_created_langid, 	etlactiveind, 		etljobname, 		envsourcecd, 		datasourcecd, 
		etlcreatedatetime
    )

    SELECT
        s.pt_ouinstance, 		s.pt_paytermcode, 	s.pt_version_no, 	s.pt_description, 		s.pt_effectivedate, 
		s.pt_expirydate, 		s.pt_status, 		s.pt_propdiscount, 	s.pt_anchordateinfo, 	s.pt_created_by, 
		s.pt_created_date, 		s.pt_modified_by, 	s.pt_modified_date, s.pt_timestamp_value, 	s.pt_lo_id, 
		s.pt_created_langid, 	1, 					p_etljobname, 		p_envsourcecd, 			p_datasourcecd, 
		NOW()
    FROM stg.stg_pt_payterm_master s
    LEFT JOIN dwh.d_ptpaytermmaster t
    ON  s.pt_ouinstance  = t.pt_ouinstance
    AND s.pt_paytermcode = t.pt_paytermcode
    AND s.pt_version_no  = t.pt_version_no
    WHERE t.pt_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_pt_payterm_master
    (
        pt_ouinstance, 	pt_paytermcode, 	pt_version_no, 		pt_description, 	pt_effectivedate, 
		pt_expirydate, 	pt_status, 			pt_propdiscount, 	pt_anchordateinfo, 	pt_remarks, 
		pt_created_by, 	pt_created_date, 	pt_modified_by, 	pt_modified_date, 	pt_timestamp_value, 
		pt_lo_id, 		pt_created_langid, 	etlcreateddatetime
    )
    SELECT
        pt_ouinstance, 	pt_paytermcode, 	pt_version_no, 		pt_description, 	pt_effectivedate, 
		pt_expirydate, 	pt_status, 			pt_propdiscount, 	pt_anchordateinfo, 	pt_remarks, 
		pt_created_by, 	pt_created_date, 	pt_modified_by, 	pt_modified_date, 	pt_timestamp_value, 
		pt_lo_id, 		pt_created_langid, 	etlcreateddatetime
    FROM stg.stg_pt_payterm_master;
    
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
ALTER PROCEDURE dwh.usp_d_ptpaytermmaster(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
