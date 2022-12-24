CREATE OR REPLACE PROCEDURE dwh.usp_d_georegion(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_geo_region_hdr;

    UPDATE dwh.d_geoRegion t
    SET 
        geo_reg_desc     = s.wms_geo_reg_desc,
        geo_reg_stat     = s.wms_geo_reg_stat,
        geo_reg_rsn     = s.wms_geo_reg_rsn,
        geo_reg_created_by     = s.wms_geo_reg_created_by,
        geo_reg_created_date     = s.wms_geo_reg_created_date,
        geo_reg_modified_by     = s.wms_geo_reg_modified_by,
        geo_reg_modified_date     = s.wms_geo_reg_modified_date,
        geo_reg_timestamp     = s.wms_geo_reg_timestamp,
        geo_reg_userdefined1     = s.wms_geo_reg_userdefined1,
        geo_reg_userdefined2     = s.wms_geo_reg_userdefined2,
        geo_reg_userdefined3     = s.wms_geo_reg_userdefined3,
        etlactiveind           =     1,
        etljobname             =     p_etljobname,
        envsourcecd            =     p_envsourcecd,
        datasourcecd           =     p_datasourcecd,
        etlupdatedatetime      =     NOW()  
    FROM stg.stg_wms_geo_region_hdr s
    WHERE t.geo_reg     = s.wms_geo_reg
    AND   t.geo_reg_ou  = s.wms_geo_reg_ou;
   
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_geoRegion
    (geo_reg, geo_reg_ou, geo_reg_desc, geo_reg_stat, geo_reg_rsn, geo_reg_created_by, geo_reg_created_date, geo_reg_modified_by, geo_reg_modified_date, geo_reg_timestamp, geo_reg_userdefined1, geo_reg_userdefined2, geo_reg_userdefined3, etlactiveind,
        etljobname,         envsourcecd,    datasourcecd,       etlcreatedatetime
    )
    
    SELECT 
       s.wms_geo_reg, s.wms_geo_reg_ou, s.wms_geo_reg_desc, s.wms_geo_reg_stat, s.wms_geo_reg_rsn, s.wms_geo_reg_created_by, s.wms_geo_reg_created_date, s.wms_geo_reg_modified_by, s.wms_geo_reg_modified_date, s.wms_geo_reg_timestamp, s.wms_geo_reg_userdefined1, s.wms_geo_reg_userdefined2, s.wms_geo_reg_userdefined3,
        1,      p_etljobname,       p_envsourcecd,      p_datasourcecd,         now()
    FROM stg.stg_wms_geo_region_hdr s
    LEFT JOIN dwh.d_geoRegion t
    ON  s.wms_geo_reg =t.geo_reg     
    AND s.wms_geo_reg_ou =t.geo_reg_ou
    WHERE t.geo_reg  IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

    INSERT INTO raw.raw_wms_geo_region_hdr

    (
    wms_geo_reg, wms_geo_reg_ou, wms_geo_reg_desc, wms_geo_reg_stat, wms_geo_reg_rsn, wms_geo_reg_created_by,
    wms_geo_reg_created_date, wms_geo_reg_modified_by, wms_geo_reg_modified_date, wms_geo_reg_timestamp, 
    wms_geo_reg_userdefined1, wms_geo_reg_userdefined2, wms_geo_reg_userdefined3, etlcreateddatetime
    )
    SELECT
    wms_geo_reg, wms_geo_reg_ou, wms_geo_reg_desc, wms_geo_reg_stat, wms_geo_reg_rsn, wms_geo_reg_created_by,
    wms_geo_reg_created_date, wms_geo_reg_modified_by, wms_geo_reg_modified_date, wms_geo_reg_timestamp, 
    wms_geo_reg_userdefined1, wms_geo_reg_userdefined2, wms_geo_reg_userdefined3, etlcreateddatetime
    FROM stg.stg_wms_geo_region_hdr; 
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
    
    --SELECT COUNT(*) INTO InsCnt FROM dwh.usp_d_geoRegion;
END;
$$;