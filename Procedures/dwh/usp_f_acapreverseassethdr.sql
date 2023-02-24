-- PROCEDURE: dwh.usp_f_acapreverseassethdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_acapreverseassethdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_acapreverseassethdr(
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
    FROM stg.stg_acap_reverse_asset_hdr;

    UPDATE dwh.f_acapreverseassethdr t
    SET
        timestamp              = s.timestamp,
        tran_date              = s.tran_date,
        fb_id                  = s.fb_id,
        status                 = s.status,
        num_type               = s.num_type,
        asset_number           = s.asset_number,
        asset_desc             = s.asset_desc,
        asset_class            = s.asset_class,
        cost_center            = s.cost_center,
        asset_group            = s.asset_group,
        remarks                = s.remarks,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_acap_reverse_asset_hdr s
    WHERE 	t.ou_id 		   = s.ou_id
    AND 	t.document_number  = s.document_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_acapreverseassethdr
    (
        ou_id,          document_number,    timestamp,      tran_date,  fb_id, 
		status,         num_type,           asset_number,   asset_desc, asset_class, 
		cost_center,    asset_group,        remarks,        createdby,  createddate, 
		modifiedby,     modifieddate,       etlactiveind,   etljobname, envsourcecd, 
		datasourcecd,   etlcreatedatetime
    )

    SELECT
        s.ou_id,        s.document_number,  s.timestamp,    s.tran_date,    s.fb_id, 
		s.status,       s.num_type,         s.asset_number, s.asset_desc,   s.asset_class, 
		s.cost_center,  s.asset_group,      s.remarks,      s.createdby,    s.createddate, 
		s.modifiedby,   s.modifieddate,     1,              p_etljobname,   p_envsourcecd, 
		p_datasourcecd, NOW()
    FROM stg.stg_acap_reverse_asset_hdr s
    LEFT JOIN dwh.f_acapreverseassethdr t
    ON  s.ou_id 		  = t.ou_id
    AND s.document_number = t.document_number
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_acap_reverse_asset_hdr
    (
        ou_id,          document_number,    timestamp,          tran_date,      fb_id, 
        status,         num_type,           asset_number,       asset_desc,     asset_class, 
        cost_center,    asset_group,        remarks,            createdby,      createddate, 
        modifiedby,     modifieddate,       etlcreateddatetime
    )
    SELECT
        ou_id,          document_number,    timestamp,          tran_date,      fb_id, 
        status,         num_type,           asset_number,       asset_desc,     asset_class, 
        cost_center,    asset_group,        remarks,            createdby,      createddate, 
        modifiedby,     modifieddate,       etlcreateddatetime
    FROM stg.stg_acap_reverse_asset_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_acapreverseassethdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
