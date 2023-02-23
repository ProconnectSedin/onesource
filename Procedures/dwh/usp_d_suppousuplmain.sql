-- PROCEDURE: dwh.usp_d_suppousuplmain(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_suppousuplmain(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_suppousuplmain(
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
    FROM stg.stg_supp_ou_suplmain;

    UPDATE dwh.d_suppousuplmain t
    SET
        supp_ou_loid                   = s.supp_ou_loid,
        supp_ou_ouinstid               = s.supp_ou_ouinstid,
        supp_ou_supcode                = s.supp_ou_supcode,
        supp_ou_supstatus              = s.supp_ou_supstatus,
        supp_ou_paymentpriority        = s.supp_ou_paymentpriority,
        supp_ou_approved               = s.supp_ou_approved,
        supp_ou_approveddate           = s.supp_ou_approveddate,
        supp_ou_reasoncode             = s.supp_ou_reasoncode,
        supp_ou_createdby              = s.supp_ou_createdby,
        supp_ou_createdate             = s.supp_ou_createdate,
        supp_ou_modifiedby             = s.supp_ou_modifiedby,
        supp_ou_modifieddate           = s.supp_ou_modifieddate,
        supp_ou_bucode                 = s.supp_ou_bucode,
        supp_ou_companycode            = s.supp_ou_companycode,
        supp_pan_number                = s.supp_pan_number,
        supp_wf_status                 = s.supp_wf_status,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_supp_ou_suplmain s
    WHERE t.supp_ou_loid = s.supp_ou_loid
    AND t.supp_ou_ouinstid = s.supp_ou_ouinstid
    AND t.supp_ou_supcode = s.supp_ou_supcode;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_suppousuplmain
    (
        supp_ou_loid, supp_ou_ouinstid, supp_ou_supcode, supp_ou_supstatus, supp_ou_paymentpriority, supp_ou_approved, supp_ou_approveddate, supp_ou_reasoncode, supp_ou_createdby, supp_ou_createdate, supp_ou_modifiedby, supp_ou_modifieddate, supp_ou_bucode, supp_ou_companycode, supp_pan_number, supp_wf_status, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.supp_ou_loid, s.supp_ou_ouinstid, s.supp_ou_supcode, s.supp_ou_supstatus, s.supp_ou_paymentpriority, s.supp_ou_approved, s.supp_ou_approveddate, s.supp_ou_reasoncode, s.supp_ou_createdby, s.supp_ou_createdate, s.supp_ou_modifiedby, s.supp_ou_modifieddate, s.supp_ou_bucode, s.supp_ou_companycode, s.supp_pan_number, s.supp_wf_status, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_supp_ou_suplmain s
    LEFT JOIN dwh.D_suppousuplmain t
    ON s.supp_ou_loid = t.supp_ou_loid
    AND s.supp_ou_ouinstid = t.supp_ou_ouinstid
    AND s.supp_ou_supcode = t.supp_ou_supcode
    WHERE t.supp_ou_loid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_supp_ou_suplmain
    (
        supp_ou_loid, supp_ou_ouinstid, supp_ou_supcode, supp_ou_supstatus, supp_ou_paymentpriority, supp_ou_approved, supp_ou_approveddate, supp_ou_reasoncode, supp_ou_createdby, supp_ou_createdate, supp_ou_modifiedby, supp_ou_modifieddate, supp_ou_bucode, supp_ou_companycode, supp_ou_licenseno, supp_ou_gen_from, supp_pan_number, supp_wf_status, etlcreateddatetime
    )
    SELECT
        supp_ou_loid, supp_ou_ouinstid, supp_ou_supcode, supp_ou_supstatus, supp_ou_paymentpriority, supp_ou_approved, supp_ou_approveddate, supp_ou_reasoncode, supp_ou_createdby, supp_ou_createdate, supp_ou_modifiedby, supp_ou_modifieddate, supp_ou_bucode, supp_ou_companycode, supp_ou_licenseno, supp_ou_gen_from, supp_pan_number, supp_wf_status, etlcreateddatetime
    FROM stg.stg_supp_ou_suplmain;
    
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
ALTER PROCEDURE dwh.usp_d_suppousuplmain(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
