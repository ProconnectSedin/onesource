CREATE OR REPLACE PROCEDURE dwh.usp_d_wmsoutboundtat(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_dim_outbound_Tat;

    TRUNCATE only dwh.D_WMSOutboundTAT  RESTART identity;
	
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_WMSOutboundTAT
    (
       wms_loc_key, id, ou, locationcode, orderType, ServiceType, ProcessTAT, pickTAT, PackTAT, DispTAT, DelTAT, picktat1, packtat1, disptat1, deltat1, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       COALESCE(l.loc_key,-1), s.id, s.ou, s.locationcode, s.orderType, s.ServiceType, s.ProcessTAT, s.pickTAT, s.PackTAT, s.DispTAT, s.DelTAT, s.picktat1, s.packtat1, s.disptat1, s.deltat1, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_dim_outbound_Tat s
	
	 LEFT JOIN dwh.d_location L      
        ON s.locationcode   = L.loc_code 
        AND s.ou        = L.loc_ou;
    

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_dim_outbound_Tat
    (
        id, ou, locationcode, orderType, ServiceType, ProcessTAT, pickTAT, PackTAT, DispTAT, DelTAT, picktat1, packtat1, disptat1, deltat1, etlcreateddatetime
    )
    SELECT
        id, ou, locationcode, orderType, ServiceType, ProcessTAT, pickTAT, PackTAT, DispTAT, DelTAT, picktat1, packtat1, disptat1, deltat1, etlcreateddatetime
    FROM stg.stg_dim_outbound_Tat;
    
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