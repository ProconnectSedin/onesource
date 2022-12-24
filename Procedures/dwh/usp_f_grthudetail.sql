-- PROCEDURE: dwh.usp_f_grthudetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grthudetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grthudetail(
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
    WHERE   d.sourceid      = p_sourceId 
        AND d.dataflowflag  = p_dataflowflag
        AND d.targetobject  = p_targetobject;
		
    IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
    THEN
    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_gr_thu_dtl;

    UPDATE dwh.F_GRTHUDetail t
    SET
	    gr_pln_key   = oh.gr_pln_key,
        gr_loc_key    = COALESCE(l.loc_key,-1),
        gr_po_no = s.wms_gr_po_no,
        gr_thu_id = s.wms_gr_thu_id,
        gr_thu_desc = s.wms_gr_thu_desc,
        gr_thu_class = s.wms_gr_thu_class,
        gr_thu_qty = s.wms_gr_thu_qty,
        gr_pal_status = s.wms_gr_pal_status,
        etlactiveind = 1,
        etljobname = p_etljobname,
        envsourcecd = p_envsourcecd ,
        datasourcecd = p_datasourcecd ,
        etlupdatedatetime = NOW()    
    FROM stg.stg_wms_gr_thu_dtl s
	
	INNER JOIN dwh.f_grplandetail oh
     ON  s.wms_gr_loc_code = oh.gr_loc_code 
     and s.wms_gr_pln_no =oh.gr_pln_no
     and s.wms_gr_pln_ou = oh.gr_pln_ou
	 
   LEFT JOIN dwh.d_location L        
        ON s.wms_gr_loc_code     = L.loc_code 
        AND s.wms_gr_pln_ou        = L.loc_ou

    WHERE t.gr_loc_code = s.wms_gr_loc_code
    AND t.gr_pln_no = s.wms_gr_pln_no
    AND t.gr_pln_ou = s.wms_gr_pln_ou
    AND t.gr_lineno = s.wms_gr_lineno
		AND    t.gr_pln_key   = oh.gr_pln_key;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_GRTHUDetail 
    (
      gr_pln_key, gr_loc_key, gr_loc_code, gr_pln_no, gr_pln_ou, gr_lineno, gr_po_no, gr_thu_id, gr_thu_desc, gr_thu_class, gr_thu_qty, gr_pal_status, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )
    
    SELECT
       oh.gr_pln_key, COALESCE(l.loc_key,-1), s.wms_gr_loc_code, s.wms_gr_pln_no, s.wms_gr_pln_ou, s.wms_gr_lineno, s.wms_gr_po_no, s.wms_gr_thu_id, s.wms_gr_thu_desc, s.wms_gr_thu_class, s.wms_gr_thu_qty, s.wms_gr_pal_status, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_gr_thu_dtl s

		INNER JOIN dwh.f_grplandetail oh
     ON  s.wms_gr_loc_code = oh.gr_loc_code 
     and s.wms_gr_pln_no =oh.gr_pln_no
     and s.wms_gr_pln_ou = oh.gr_pln_ou
	 
  LEFT JOIN dwh.d_location L        
        ON s.wms_gr_loc_code     = L.loc_code 
        AND s.wms_gr_pln_ou        = L.loc_ou

    LEFT JOIN dwh.F_GRTHUDetail t
    ON s.wms_gr_loc_code = t.gr_loc_code
    AND s.wms_gr_pln_no = t.gr_pln_no
    AND s.wms_gr_pln_ou = t.gr_pln_ou
    AND s.wms_gr_lineno = t.gr_lineno
     AND t.gr_pln_key   = oh.gr_pln_key

    WHERE t.gr_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_gr_thu_dtl
    (   
        wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou, wms_gr_lineno, wms_gr_po_no, wms_gr_thu_id, wms_gr_thu_desc, wms_gr_thu_class, wms_gr_thu_sno, wms_gr_thu_qty, wms_gr_thu_owner, wms_gr_thu_tod, wms_gr_pal_status,etlcreateddatetime
    )
    SELECT 
        wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou, wms_gr_lineno, wms_gr_po_no, wms_gr_thu_id, wms_gr_thu_desc, wms_gr_thu_class, wms_gr_thu_sno, wms_gr_thu_qty, wms_gr_thu_owner, wms_gr_thu_tod, wms_gr_pal_status,etlcreateddatetime
    FROM stg.stg_wms_gr_thu_dtl;  
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
ALTER PROCEDURE dwh.usp_f_grthudetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
