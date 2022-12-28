-- PROCEDURE: dwh.usp_f_wavedetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_wavedetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_wavedetail(
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_wave_dtl;

    UPDATE dwh.f_waveDetail t
    SET
	    wave_hdr_key                   = fh.wave_hdr_key,
		wave_loc_key				   = COALESCE(l.loc_key,-1),
		wave_item_key				   = COALESCE(it.itm_hdr_key,-1),
		wave_cust_key				   = COALESCE(c.customer_key,-1),
        wave_so_no                     = s.wms_wave_so_no,
        wave_so_sr_no                  = s.wms_wave_so_sr_no,
        wave_so_sch_no                 = s.wms_wave_so_sch_no,
        wave_item_code                 = s.wms_wave_item_code,
        wave_qty                       = s.wms_wave_qty,
        wave_line_status               = s.wms_wave_line_status,
        wave_outbound_no               = s.wms_wave_outbound_no,
        wave_customer_code             = s.wms_wave_customer_code,
        wave_customer_item_code        = s.wms_wave_customer_item_code,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_wms_wave_dtl s
	INNER JOIN 	dwh.f_waveheader fh 
		ON  s.wms_wave_ou 				= fh.wave_ou 
		AND s.wms_wave_loc_code			= fh.wave_loc_code 
		AND s.wms_wave_no				= fh.wave_no
	LEFT JOIN dwh.d_location L 		
		ON s.wms_wave_loc_code	 			= L.loc_code 
        AND s.wms_wave_ou	        		= L.loc_ou
	LEFT JOIN dwh.d_itemheader it 			
		ON s.wms_wave_item_code 			= it.itm_code
        AND s.wms_wave_ou	        		= it.itm_ou
	LEFT JOIN dwh.d_customer c
	    ON s.wms_wave_customer_code         = c.customer_id
		AND s.wms_wave_ou	        		= c.customer_ou
    WHERE t.wave_ou                     = s.wms_wave_ou
	 AND  t.wave_loc_code               = s.wms_wave_loc_code
	 AND  t.wave_no                     = s.wms_wave_no
	 AND  t.wave_lineno					= s.wms_wave_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_waveDetail
    (
        wave_hdr_key,wave_loc_key,wave_item_key,wave_cust_key,wave_loc_code,wave_no,wave_ou,
		wave_lineno, wave_so_no, wave_so_sr_no, wave_so_sch_no, wave_item_code, wave_qty, wave_line_status, wave_outbound_no, wave_customer_code, wave_customer_item_code, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
	    fh.wave_hdr_key,COALESCE(l.loc_key,-1),COALESCE(it.itm_hdr_key,-1),COALESCE(c.customer_key,-1),s.wms_wave_loc_code,s.wms_wave_no,s.wms_wave_ou,
        s.wms_wave_lineno, s.wms_wave_so_no, s.wms_wave_so_sr_no, s.wms_wave_so_sch_no, s.wms_wave_item_code, s.wms_wave_qty, s.wms_wave_line_status, s.wms_wave_outbound_no, s.wms_wave_customer_code, s.wms_wave_customer_item_code, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_wave_dtl s
	INNER JOIN 	dwh.f_waveheader fh 
		ON  s.wms_wave_ou 					= fh.wave_ou 
		AND s.wms_wave_loc_code 			= fh.wave_loc_code 
		AND s.wms_wave_no 					= fh.wave_no
	LEFT JOIN dwh.d_location L 		
		ON s.wms_wave_loc_code	 			= L.loc_code 
        AND s.wms_wave_ou	        		= L.loc_ou
	LEFT JOIN dwh.d_itemheader it 			
		ON s.wms_wave_item_code 			= it.itm_code
        AND s.wms_wave_ou	        		= it.itm_ou
	LEFT JOIN dwh.d_customer c
	    ON s.wms_wave_customer_code         = c.customer_id
		AND s.wms_wave_ou	        		= c.customer_ou
    LEFT JOIN dwh.f_waveDetail t
    ON    s.wms_wave_lineno             = t.wave_lineno
	 AND  s.wms_wave_ou                 = t.wave_ou 
	 AND  s.wms_wave_loc_code           = t.wave_loc_code
	 AND  s.wms_wave_no                 = t.wave_no
    WHERE t.wave_no IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_wave_dtl
    (
	    wms_wave_loc_code,wms_wave_no,wms_wave_ou,
        wms_wave_lineno, wms_wave_so_no, wms_wave_so_sr_no, wms_wave_so_sch_no, wms_wave_item_code, wms_wave_qty, wms_wave_line_status, wms_wave_outbound_no, wms_wave_customer_code, wms_wave_customer_item_code, wms_wave_tripplan_id, etlcreateddatetime
    )
    SELECT
	    wms_wave_loc_code,wms_wave_no,wms_wave_ou,
        wms_wave_lineno, wms_wave_so_no, wms_wave_so_sr_no, wms_wave_so_sch_no, wms_wave_item_code, wms_wave_qty, wms_wave_line_status, wms_wave_outbound_no, wms_wave_customer_code, wms_wave_customer_item_code, wms_wave_tripplan_id, etlcreateddatetime
    FROM stg.stg_wms_wave_dtl;
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
	
	EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;	
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_wavedetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
