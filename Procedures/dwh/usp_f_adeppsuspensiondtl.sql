-- PROCEDURE: dwh.usp_f_adeppsuspensiondtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_adeppsuspensiondtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_adeppsuspensiondtl(
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
    FROM stg.stg_adepp_suspension_dtl;

    UPDATE dwh.F_adeppsuspensiondtl t
    SET
	    adeppsuspensionhdr_key = coalesce(h.f_adeppsuspensionhdr_key,-1),
        ou_id                  = s.ou_id,
        depr_category          = s.depr_category,
        asset_number           = s.asset_number,
        tag_number             = s.tag_number,
        suspension_no          = s.suspension_no,
        timestamp              = s.timestamp,
        cost_center            = s.cost_center,
        asset_location         = s.asset_location,
        susp_start_date        = s.susp_start_date,
        susp_end_date          = s.susp_end_date,
        status                 = s.status,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_adepp_suspension_dtl s
	inner join dwh.f_adeppsuspensionhdr h
	 ON s.ou_id=h.ou_id
	and s.suspension_no=h.suspension_no
    WHERE t.ou_id = s.ou_id
    AND t.depr_category = s.depr_category
    AND t.asset_number = s.asset_number
    AND t.tag_number = s.tag_number
    AND t.suspension_no = s.suspension_no;

GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_adeppsuspensiondtl
    (
      adeppsuspensionhdr_key,  ou_id, depr_category, asset_number, tag_number, suspension_no, timestamp, cost_center, asset_location, susp_start_date, susp_end_date, status, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
    coalesce(h.f_adeppsuspensionhdr_key,-1),    s.ou_id, s.depr_category, s.asset_number, s.tag_number, s.suspension_no, s.timestamp, s.cost_center, s.asset_location, s.susp_start_date, s.susp_end_date, s.status, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_adepp_suspension_dtl s
	inner join dwh.f_adeppsuspensionhdr h
	 ON s.ou_id=h.ou_id
	and s.suspension_no=h.suspension_no	
    LEFT JOIN dwh.F_adeppsuspensiondtl t
    ON s.ou_id = t.ou_id
    AND s.depr_category = t.depr_category
    AND s.asset_number = t.asset_number
    AND s.tag_number = t.tag_number
    AND s.suspension_no = t.suspension_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adepp_suspension_dtl
    (
        ou_id, depr_category, asset_number, tag_number, suspension_no, timestamp, cost_center, asset_location, susp_start_date, susp_end_date, status, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        ou_id, depr_category, asset_number, tag_number, suspension_no, timestamp, cost_center, asset_location, susp_start_date, susp_end_date, status, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_adepp_suspension_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_adeppsuspensiondtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
