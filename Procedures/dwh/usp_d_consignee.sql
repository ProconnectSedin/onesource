CREATE PROCEDURE dwh.usp_d_consignee(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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

    SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag

    INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag
 
    FROM ods.controldetail d 
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE   d.sourceid      = p_sourceId 
        AND d.dataflowflag  = p_dataflowflag
        AND d.targetobject  = p_targetobject;
        
    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_consignee_hdr;

    UPDATE dwh.d_consignee t
    SET 
        consignee_desc       =       s.wms_consignee_desc,
        consignee_status       =       s.wms_consignee_status,
        consignee_currency       =       s.wms_consignee_currency,
        consignee_address1       =       s.wms_consignee_address1,
        consignee_address2       =       s.wms_consignee_address2,
        consignee_city       =       s.wms_consignee_city,
        consignee_state       =       s.wms_consignee_state,
        consignee_country       =       s.wms_consignee_country,
        consignee_postalcode       =       s.wms_consignee_postalcode,
        consignee_phone1       =       s.wms_consignee_phone1,
        consignee_customer_id       =       s.wms_consignee_customer_id,
        consignee_created_by       =       s.wms_consignee_created_by,
        consignee_created_date       =       s.wms_consignee_created_date,
        consignee_modified_by       =       s.wms_consignee_modified_by,
        consignee_modified_date       =       s.wms_consignee_modified_date,
        consignee_timestamp       =       s.wms_consignee_timestamp,
        consignee_zone       =       s.wms_consignee_zone,
        consignee_timezone       =       s.wms_consignee_timezone,
        etlactiveind           =     1,
        etljobname             =     p_etljobname,
        envsourcecd            =     p_envsourcecd,
        datasourcecd           =     p_datasourcecd,
        etlupdatedatetime      =     NOW()  
    FROM stg.stg_wms_consignee_hdr s
    WHERE t.consignee_id=  s.wms_consignee_id
    AND  t.consignee_ou =s.wms_consignee_ou;
   
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_consignee
    ( consignee_id, consignee_ou, consignee_desc, consignee_status, consignee_currency, consignee_address1, consignee_address2, consignee_city, consignee_state, consignee_country, consignee_postalcode, consignee_phone1, consignee_customer_id, consignee_created_by, consignee_created_date, consignee_modified_by, consignee_modified_date, consignee_timestamp, consignee_zone, consignee_timezone, etlactiveind,
        etljobname,         envsourcecd,    datasourcecd,       etlcreatedatetime
    )
    
    SELECT 
        s.wms_consignee_id, s.wms_consignee_ou, s.wms_consignee_desc, s.wms_consignee_status, s.wms_consignee_currency, s.wms_consignee_address1, s.wms_consignee_address2, s.wms_consignee_city, s.wms_consignee_state, s.wms_consignee_country, s.wms_consignee_postalcode, s.wms_consignee_phone1, s.wms_consignee_customer_id, s.wms_consignee_created_by, s.wms_consignee_created_date, s.wms_consignee_modified_by, s.wms_consignee_modified_date, s.wms_consignee_timestamp, s.wms_consignee_zone, s.wms_consignee_timezone, 
        1,      p_etljobname,       p_envsourcecd,      p_datasourcecd,         now()

    FROM stg.stg_wms_consignee_hdr s
    LEFT JOIN dwh.d_consignee t
    ON s.wms_consignee_id = t.consignee_id  
    AND    s.wms_consignee_ou  = t. consignee_ou     
    WHERE t.consignee_id  IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	IF p_rawstorageflag = 1
	THEN

    INSERT INTO raw.raw_wms_consignee_hdr

    (
        wms_consignee_id, wms_consignee_ou, wms_consignee_desc, wms_consignee_status, wms_consignee_currency,
        wms_consignee_payterm, wms_consignee_reasoncode, wms_consignee_address1, wms_consignee_address2, wms_consignee_address3, 
        wms_consignee_uniqueaddressid, wms_consignee_city, wms_consignee_state, wms_consignee_country, wms_consignee_postalcode,
        wms_consignee_phone1, wms_consignee_phone2, wms_consignee_email, wms_consignee_customer_id, wms_consignee_created_by,
        wms_consignee_created_date, wms_consignee_modified_by, wms_consignee_modified_date, wms_consignee_timestamp, wms_consignee_userdefined1,
        wms_consignee_userdefined2, wms_consignee_userdefined3, wms_consignee_zone, wms_consignee_subzone, 
        wms_consignee_region, wms_consignee_timezone, wms_consignee_latitude, wms_consignee_longitude, wms_consignee_geofencerange,
        wms_consignee_uom, wms_consignee_geofencename, wms_consignee_url, wms_consignee_fax, wms_consignee_shippointid, 
        wms_consignee_time_ordering, wms_consignee_timeslot, etlcreateddatetime
    )
    SELECT
        wms_consignee_id, wms_consignee_ou, wms_consignee_desc, wms_consignee_status, wms_consignee_currency,
        wms_consignee_payterm, wms_consignee_reasoncode, wms_consignee_address1, wms_consignee_address2, wms_consignee_address3, 
        wms_consignee_uniqueaddressid, wms_consignee_city, wms_consignee_state, wms_consignee_country, wms_consignee_postalcode,
        wms_consignee_phone1, wms_consignee_phone2, wms_consignee_email, wms_consignee_customer_id, wms_consignee_created_by,
        wms_consignee_created_date, wms_consignee_modified_by, wms_consignee_modified_date, wms_consignee_timestamp, wms_consignee_userdefined1,
        wms_consignee_userdefined2, wms_consignee_userdefined3, wms_consignee_zone, wms_consignee_subzone, 
        wms_consignee_region, wms_consignee_timezone, wms_consignee_latitude, wms_consignee_longitude, wms_consignee_geofencerange,
        wms_consignee_uom, wms_consignee_geofencename, wms_consignee_url, wms_consignee_fax, wms_consignee_shippointid, 
        wms_consignee_time_ordering, wms_consignee_timeslot, etlcreateddatetime
    FROM stg.stg_wms_consignee_hdr; 
	
	END IF;
	
	EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);
    
        
       select 0 into inscnt;
       select 0 into updcnt;  
  
    
    --SELECT COUNT(*) INTO InsCnt FROM dwh.usp_d_consignee;
END;
$$;