CREATE PROCEDURE dwh.usp_d_hht_master(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_pcsit_hht_master;

    -- UPDATE dwh.d_hht_master t
    -- SET
    --     hht_loc_key                         =COALESCE(l.loc_key,-1),            
    --     id                                   =s.id,
    --     locationcode                     =s.locationcode,
    --     locationdesc                         =s.locationdesc,
    --     brand                               =s.brand,
    --     Count                               =s.Count,
    --     oldcount040220                      =s.oldcount040220,
    --     oldcount300920                      =s.oldcount300920,
    --     oldcount030321                      =s.oldcount030321,
    --     etlactiveind                        = 1,
    --     etljobname                          = p_etljobname,
    --     envsourcecd                         = p_envsourcecd,
    --     datasourcecd                        = p_datasourcecd,
    --     etlupdatedatetime                   = NOW()
    -- FROM stg.stg_pcsit_hht_master s
    -- LEFT JOIN dwh.d_location l       
    --  ON  s.locationcode          = l.loc_code ;

    TRUNCATE ONLY dwh.d_hht_master restart identity ;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_hht_master
    (
            hht_loc_key, id,   locationcode,    locationdesc,    brand, Count,    oldcount040220,   oldcount300920,
            oldcount030321,         etlactiveind,                   etljobname, 
        envsourcecd,                datasourcecd,                   etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1), s.id,   s.locationcode,    s.locationdesc,    s.brand, s.Count,    s.oldcount040220,   s.oldcount300920,s.oldcount030321,               
        1,              p_etljobname,       p_envsourcecd,  p_datasourcecd, NOW()
    FROM stg.stg_pcsit_hht_master s
    LEFT JOIN dwh.d_location l      
        ON  s.locationcode          = l.loc_code; 
        
--     WHERE    IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_pcsit_hht_master
    (
             id,   locationcode,    locationdesc,    brand,Count,    oldcount040220,   oldcount300920,
            oldcount030321,         etlcreateddatetime
    )
    SELECT
            id,   locationcode,    locationdesc,    brand,Count,    oldcount040220,   oldcount300920,
            oldcount030321,     etlcreateddatetime
    FROM stg.stg_pcsit_hht_master;
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