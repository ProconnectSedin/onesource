CREATE OR REPLACE PROCEDURE dwh.usp_f_pcsputawayplanlist(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

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
    FROM stg.stg_pcs_putaway_planlist;

    UPDATE dwh.F_PCSPutawayplanlist t
    SET
        plan_no                  	= s.wms_plan_no,
		putaway_emp_code        	= s.wms_putaway_emp_code,
		putaway_euip_code       	= s.wms_putaway_euip_code,
		putaway_loc_code        	= s.wms_putaway_loc_code,
		emp_user                 	= s.wms_emp_user,
        created_date             	= s.wms_created_date,
        seq_no                   	= s.wms_seq_no,
        etlactiveind             	= 1,
        etljobname               	= p_etljobname,
        envsourcecd              	= p_envsourcecd,
        datasourcecd             	= p_datasourcecd,
        etlupdatedatetime        	= NOW()
    FROM stg.stg_pcs_putaway_planlist s
    WHERE   plan_no                 = s.wms_plan_no
		AND	putaway_emp_code        = s.wms_putaway_emp_code
		AND putaway_euip_code       = s.wms_putaway_euip_code
		AND putaway_loc_code        = s.wms_putaway_loc_code
		AND emp_user                = s.wms_emp_user
        AND created_date            = s.wms_created_date
        AND seq_no                  = s.wms_seq_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PCSPutawayplanlist
    (
        putaway_emp_code, emp_user, plan_no, putaway_euip_code, putaway_loc_code, created_date, seq_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.wms_putaway_emp_code, s.wms_emp_user, s.wms_plan_no, s.wms_putaway_euip_code, s.wms_putaway_loc_code, s.wms_created_date, s.wms_seq_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_pcs_putaway_planlist s
    LEFT JOIN dwh.F_PCSPutawayplanlist t
		ON  t.plan_no                = s.wms_plan_no
		AND	t.putaway_emp_code       = s.wms_putaway_emp_code
		AND t.putaway_euip_code      = s.wms_putaway_euip_code
		AND t.putaway_loc_code       = s.wms_putaway_loc_code
		AND t.emp_user               = s.wms_emp_user
        AND t.created_date           = s.wms_created_date
        AND t.seq_no                 = s.wms_seq_no	
    WHERE  t.putaway_emp_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_pcs_putaway_planlist
    (
        wms_putaway_emp_code, wms_emp_user, wms_plan_no, wms_putaway_euip_code, wms_putaway_loc_code, wms_created_date, wms_seq_no, etlcreateddatetime
    )
    SELECT
        wms_putaway_emp_code, wms_emp_user, wms_plan_no, wms_putaway_euip_code, wms_putaway_loc_code, wms_created_date, wms_seq_no, etlcreateddatetime
    FROM stg.stg_pcs_putaway_planlist;
    
    END IF;
    
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;