-- PROCEDURE: dwh.usp_f_adispisassettagdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_adispisassettagdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_adispisassettagdtl(
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
    FROM stg.Stg_adisp_is_asset_tag_dtl;

    UPDATE dwh.f_adispisassettagdtl t
    SET
        timestamp            = s.timestamp,
        cap_number           = s.cap_number,
        tag_status           = s.tag_status,
        transfer_date        = s.transfer_date,
        createdby            = s.createdby,
        createddate          = s.createddate,
        etlactiveind         = 1,
        etljobname           = p_etljobname,
        envsourcecd          = p_envsourcecd,
        datasourcecd         = p_datasourcecd,
        etlupdatedatetime    = NOW()
    FROM stg.Stg_adisp_is_asset_tag_dtl s
    WHERE t.guid 			 = s.guid
    AND   t.ou_id 			 = s.ou_id
    AND   t.asset_number 	 = s.asset_number
    AND   t.tag_number 		 = s.tag_number
    AND   t.fb_id 			 = s.fb_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_adispisassettagdtl
    (
        guid, 				ou_id, 			asset_number, 	tag_number, fb_id, 
		timestamp, 			cap_number, 	tag_status, 	transfer_date, createdby, 
		createddate, 		etlactiveind, 	etljobname, 	envsourcecd, datasourcecd, 
		etlcreatedatetime
    )

    SELECT
        s.guid, 		s.ou_id, 		s.asset_number, 	s.tag_number, 		s.fb_id, 
		s.timestamp, 	s.cap_number, 	s.tag_status,		s.transfer_date, 	s.createdby, 
		s.createddate, 	1, 				p_etljobname, 		p_envsourcecd, 		p_datasourcecd, 
		NOW()
    FROM stg.Stg_adisp_is_asset_tag_dtl s
    LEFT JOIN dwh.f_adispisassettagdtl t
    ON  s.guid 			= t.guid
    AND s.ou_id 		= t.ou_id
    AND s.asset_number 	= t.asset_number
    AND s.tag_number 	= t.tag_number
    AND s.fb_id 		= t.fb_id
    WHERE t.guid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adisp_is_asset_tag_dtl
    (
        guid, 				ou_id, 				asset_number, 		tag_number, 		fb_id, 
		timestamp, 			cap_number, 		proposal_number, 	tag_status, 		dest_fbid, 
		transfer_date, 		asset_location, 	cost_center, 		createdby, 			createddate, 
		modifiedby, 		modifieddate, 		etlcreateddatetime
    )
    SELECT
        guid, 				ou_id, 				asset_number, 		tag_number, 		fb_id, 
		timestamp, 			cap_number, 		proposal_number, 	tag_status, 		dest_fbid, 
		transfer_date, 		asset_location, 	cost_center, 		createdby, 			createddate, 
		modifiedby, 		modifieddate, 		etlcreateddatetime
    FROM stg.Stg_adisp_is_asset_tag_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_adispisassettagdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
