-- PROCEDURE: dwh.usp_f_adeppsuspensionhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_adeppsuspensionhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_adeppsuspensionhdr(
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
    FROM stg.stg_adepp_suspension_hdr;

    UPDATE dwh.F_adeppsuspensionhdr t
    SET
        ou_id                  = s.ou_id,
        suspension_no          = s.suspension_no,
        timestamp              = s.timestamp,
        suspension_desc        = s.suspension_desc,
        depr_book              = s.depr_book,
        susp_start_date        = s.susp_start_date,
        susp_end_date          = s.susp_end_date,
        fb_id                  = s.fb_id,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_adepp_suspension_hdr s
    WHERE t.ou_id = s.ou_id
    AND t.suspension_no = s.suspension_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_adeppsuspensionhdr
    (
        ou_id, suspension_no, timestamp, suspension_desc, depr_book, susp_start_date, susp_end_date, fb_id, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.suspension_no, s.timestamp, s.suspension_desc, s.depr_book, s.susp_start_date, s.susp_end_date, s.fb_id, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_adepp_suspension_hdr s
    LEFT JOIN dwh.F_adeppsuspensionhdr t
    ON s.ou_id = t.ou_id
    AND s.suspension_no = t.suspension_no
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_adepp_suspension_hdr
    (
        ou_id, suspension_no, timestamp, suspension_desc, depr_book, susp_start_date, susp_end_date, fb_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        ou_id, suspension_no, timestamp, suspension_desc, depr_book, susp_start_date, susp_end_date, fb_id, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_adepp_suspension_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_adeppsuspensionhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
