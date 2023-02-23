-- PROCEDURE: dwh.usp_d_suppsgssuplgroupmap(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_suppsgssuplgroupmap(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_suppsgssuplgroupmap(
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
    FROM stg.stg_supp_sgs_suplgroupmap;

    UPDATE dwh.d_suppsgssuplgroupmap t
    SET
        supp_sgs_loid                = s.supp_sgs_loid,
        supp_sgs_supgrpcode          = s.supp_sgs_supgrpcode,
        supp_sgs_supcode             = s.supp_sgs_supcode,
        supp_sgs_createdby           = s.supp_sgs_createdby,
        supp_sgs_createddate         = s.supp_sgs_createddate,
        supp_sgs_modifiedby          = s.supp_sgs_modifiedby,
        supp_sgs_modifieddate        = s.supp_sgs_modifieddate,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_supp_sgs_suplgroupmap s
    WHERE t.supp_sgs_loid = s.supp_sgs_loid
    AND t.supp_sgs_supgrpcode = s.supp_sgs_supgrpcode
    AND t.supp_sgs_supcode = s.supp_sgs_supcode;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_suppsgssuplgroupmap
    (
        supp_sgs_loid, supp_sgs_supgrpcode, supp_sgs_supcode, supp_sgs_createdby, supp_sgs_createddate, supp_sgs_modifiedby, supp_sgs_modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.supp_sgs_loid, s.supp_sgs_supgrpcode, s.supp_sgs_supcode, s.supp_sgs_createdby, s.supp_sgs_createddate, s.supp_sgs_modifiedby, s.supp_sgs_modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_supp_sgs_suplgroupmap s
    LEFT JOIN dwh.d_suppsgssuplgroupmap t
    ON s.supp_sgs_loid = t.supp_sgs_loid
    AND s.supp_sgs_supgrpcode = t.supp_sgs_supgrpcode
    AND s.supp_sgs_supcode = t.supp_sgs_supcode
    WHERE t.supp_sgs_loid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_supp_sgs_suplgroupmap
    (
        supp_sgs_loid, supp_sgs_supgrpcode, supp_sgs_supcode, supp_sgs_createdby, supp_sgs_createddate, supp_sgs_modifiedby, supp_sgs_modifieddate, etlcreateddatetime
    )
    SELECT
        supp_sgs_loid, supp_sgs_supgrpcode, supp_sgs_supcode, supp_sgs_createdby, supp_sgs_createddate, supp_sgs_modifiedby, supp_sgs_modifieddate, etlcreateddatetime
    FROM stg.stg_supp_sgs_suplgroupmap;
    
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
ALTER PROCEDURE dwh.usp_d_suppsgssuplgroupmap(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
