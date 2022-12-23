CREATE PROCEDURE dwh.usp_f_deliverydelayreason(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_pcsit_rdil_uncontrollable_tbl;

    UPDATE dwh.F_DeliveryDelayReason t
    SET
        wms_loc_key            = COALESCE(l.loc_key,-1),
        InvoiceNo              = s.InvoiceNo,
        InvoiceDate            = s.InvoiceDate,
        InvoiceHoldType        = s.InvoiceHoldType,
        Remarks                = s.Remarks,
        CreatedBy              = s.CreatedBy,
        CreatedDate            = s.CreatedDate,
        GUID                   = s.GUID,
        TranOU                 = s.TranOU,
        Type                   = s.Type,
        Activity               = s.Activity,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_pcsit_rdil_uncontrollable_tbl s
    LEFT JOIN dwh.d_location L      
        ON s.LocationCode   = L.loc_code 
        AND s.tranou        = L.loc_ou

    WHERE COALESCE(t.tranou,0) = COALESCE(s.tranou,0)
    AND COALESCE(t.type,'') = COALESCE(s.type,'')
    AND COALESCE(t.activity,'') = COALESCE(s.activity,'')
    AND COALESCE(t.LocationCode,'') = COALESCE(s.LocationCode,'')
    AND COALESCE(t.InvoiceNo,'') = COALESCE(s.InvoiceNo,'')
    AND COALESCE(t.InvoiceDate,'1900-01-01') = COALESCE(s.InvoiceDate,'1900-01-01')
    AND COALESCE(t.invoiceholdtype,'') = COALESCE(s.invoiceholdtype,'')
    and COALESCE(t.guid,'') = COALESCE(s.guid,'')
    and COALESCE(t.remarks,'') = COALESCE(s.remarks,'');

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DeliveryDelayReason
    (
       wms_loc_key, LocationCode    , InvoiceNo     , InvoiceDate, 
        InvoiceHoldType , Remarks       , CreatedBy , 
        CreatedDate     , GUID          , TranOU    , 
        Type            , Activity      , 
        etlactiveind    , etljobname    , envsourcecd, 
        datasourcecd    , etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1),s.LocationCode      , s.InvoiceNo   , s.InvoiceDate , 
        s.InvoiceHoldType   , s.Remarks     , s.CreatedBy   , 
        s.CreatedDate       , s.GUID        , s.TranOU      , 
        s.Type              , s.Activity    , 
                1           , p_etljobname  , p_envsourcecd , 
        p_datasourcecd      , NOW()
    FROM stg.stg_pcsit_rdil_uncontrollable_tbl s
        LEFT JOIN dwh.d_location L      
        ON s.LocationCode   = L.loc_code 
        AND s.tranou        = L.loc_ou

    LEFT JOIN dwh.F_DeliveryDelayReason t
    ON  COALESCE(t.tranou,0) = COALESCE(s.tranou,0)
    AND COALESCE(t.type,'') = COALESCE(s.type,'')
    AND COALESCE(t.activity,'') = COALESCE(s.activity,'')
    AND COALESCE(t.LocationCode,'') = COALESCE(s.LocationCode,'')
    AND COALESCE(t.InvoiceNo,'') = COALESCE(s.InvoiceNo,'')
    AND COALESCE(t.InvoiceDate,'1900-01-01') = COALESCE(s.InvoiceDate,'1900-01-01')
    AND COALESCE(t.invoiceholdtype,'') = COALESCE(s.invoiceholdtype,'')
    and COALESCE(t.guid,'') = COALESCE(s.guid,'')
    and COALESCE(t.remarks,'') = COALESCE(s.remarks,'')
    WHERE t.LocationCode IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    INSERT INTO raw.raw_pcsit_rdil_uncontrollable_tbl
    (
        LocationCode    , InvoiceNo , InvoiceDate, 
        InvoiceHoldType , Remarks   , CreatedBy, 
        CreatedDate     , GUID      , TranOU, 
        Type            , Activity  , etlcreateddatetime
    )
    SELECT
        LocationCode    , InvoiceNo , InvoiceDate, 
        InvoiceHoldType , Remarks   , CreatedBy, 
        CreatedDate     , GUID      , TranOU, 
        Type            , Activity  , etlcreateddatetime
    FROM stg.stg_pcsit_rdil_uncontrollable_tbl;

    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, 
                                p_batchid,p_taskname, 'sp_ExceptionHandling', 
                                p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
       
END;
$$;