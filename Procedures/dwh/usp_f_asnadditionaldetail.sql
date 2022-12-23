-- PROCEDURE: dwh.usp_f_asnadditionaldetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_asnadditionaldetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_asnadditionaldetail(
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
	p_depsource VARCHAR(100);

    
    p_rawstorageflag integer;

BEGIN

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag,h.depsource
    
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
		
	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN

    SELECT COUNT(*) INTO srccnt
    FROM stg.stg_wms_asn_add_dtl;

    UPDATE dwh.F_ASNAdditionalDetail t
    SET
		asn_hr_key =   oh.asn_hr_key,
        asn_pop_loc_key              = COALESCE(c.loc_key,-1), 
        asn_pop_date_1 = s.wms_asn_pop_date_1,
        asn_pop_date_2 = s.wms_asn_pop_date_2,
        asn_pop_ud_1 = s.wms_asn_pop_ud_1,
        asn_pop_ud_2 = s.wms_asn_pop_ud_2,
        asn_pop_ud_3 = s.wms_asn_pop_ud_3,
        etlactiveind = 1,
        etljobname = p_etljobname,
        envsourcecd = p_envsourcecd ,
        datasourcecd = p_datasourcecd ,
        etlupdatedatetime = NOW()    
    FROM stg.stg_wms_asn_add_dtl s
	INNER JOIN dwh.f_asnheader oh
ON  
	     s.wms_asn_pop_asn_no= oh.asn_no 
	 and s.wms_asn_pop_loc = oh.asn_location
	 and s.wms_asn_pop_ou = oh.asn_ou 

        LEFT JOIN dwh.d_location C      
        ON s.wms_asn_pop_loc  = C.loc_code 
        AND s.wms_asn_pop_ou        = C.loc_ou

    WHERE t.asn_pop_asn_no = s.wms_asn_pop_asn_no
    AND t.asn_pop_loc = s.wms_asn_pop_loc
    AND t.asn_pop_ou = s.wms_asn_pop_ou
    AND t.asn_pop_line_no = s.wms_asn_pop_line_no
	AND 		t.asn_hr_key =   oh.asn_hr_key;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ASNAdditionalDetail 
    (
       asn_hr_key, asn_pop_loc_key,asn_pop_asn_no, asn_pop_loc, asn_pop_ou, asn_pop_line_no, asn_pop_date_1, asn_pop_date_2, asn_pop_ud_1, asn_pop_ud_2, asn_pop_ud_3, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )
    
    SELECT
        oh.asn_hr_key,COALESCE(c.loc_key,-1) ,s.wms_asn_pop_asn_no, s.wms_asn_pop_loc, s.wms_asn_pop_ou, s.wms_asn_pop_line_no, s.wms_asn_pop_date_1, s.wms_asn_pop_date_2, s.wms_asn_pop_ud_1, s.wms_asn_pop_ud_2, s.wms_asn_pop_ud_3, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()

    FROM stg.stg_wms_asn_add_dtl s
	
	INNER JOIN dwh.f_asnheader oh
ON  
	     s.wms_asn_pop_asn_no= oh.asn_no 
	 and s.wms_asn_pop_loc = oh.asn_location
	 and s.wms_asn_pop_ou = oh.asn_ou 
	 
   LEFT JOIN dwh.d_location C      
        ON s.wms_asn_pop_loc  = C.loc_code 
        AND s.wms_asn_pop_ou        = C.loc_ou

    LEFT JOIN dwh.F_ASNAdditionalDetail t
    ON   t.asn_pop_asn_no    = s.wms_asn_pop_asn_no 
    AND  t.asn_pop_loc = s.wms_asn_pop_loc 
    AND  t.asn_pop_ou = s.wms_asn_pop_ou 
    AND  t.asn_pop_line_no = s.wms_asn_pop_line_no 
		AND 		t.asn_hr_key =   oh.asn_hr_key

    WHERE t.asn_pop_asn_no IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_asn_add_dtl
    (   
        wms_asn_pop_asn_no, wms_asn_pop_loc, wms_asn_pop_ou, wms_asn_pop_line_no, wms_asn_pop_date_1, wms_asn_pop_date_2, wms_asn_pop_ud_1, wms_asn_pop_ud_2, wms_asn_pop_ud_3,etlcreateddatetime
    )
    SELECT 
        wms_asn_pop_asn_no, wms_asn_pop_loc, wms_asn_pop_ou, wms_asn_pop_line_no, wms_asn_pop_date_1, wms_asn_pop_date_2, wms_asn_pop_ud_1, wms_asn_pop_ud_2, wms_asn_pop_ud_3,etlcreateddatetime
    FROM stg.stg_wms_asn_add_dtl;
    END IF;
	ELSE    
         p_errorid   := 0;
         select 0 into inscnt;
         select 0 into updcnt;
         select 0 into srccnt;    
         
         IF p_depsource IS NULL
         THEN 
         p_errordesc := 'The Dependent source cannot be NULL.';
         ELSE
         p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
         END IF;
         CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
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
       

END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_asnadditionaldetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
