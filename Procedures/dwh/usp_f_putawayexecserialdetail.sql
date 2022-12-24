-- PROCEDURE: dwh.usp_f_putawayexecserialdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_putawayexecserialdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_putawayexecserialdetail(
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
    FROM stg.stg_wms_put_exec_serial_dtl;

    UPDATE dwh.F_PutawayExecserialDetail t
    SET
        pway_exe_dtl_key			    =fh.pway_exe_dtl_key,
        pway_exec_serial_dtl_loc_key   = COALESCE(l.loc_key,-1),
		pway_exec_serial_dtl_zone_key  = COALESCE(z.zone_key,-1),
        pway_itm_lineno                = s.wms_pway_itm_lineno,
        pway_zone                      = s.wms_pway_zone,
        pway_bin                       = s.wms_pway_bin,
        pway_serialno                  = s.wms_pway_serialno,
        pway_lotno                     = s.wms_pway_lotno,
        pway_cust_sno                  = s.wms_pway_cust_sno,
        pway_3pl_sno                   = s.wms_pway_3pl_sno,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_wms_put_exec_serial_dtl s
    INNER JOIN 	dwh.f_putawayexecdetail fh 
			ON  s.wms_pway_loc_code = fh.pway_loc_code 
			AND s.wms_pway_exec_no 	= fh.pway_exec_no 
			AND s.wms_pway_exec_ou 	= fh.pway_exec_ou
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pway_loc_code 	   = l.loc_code 
		AND s.wms_pway_exec_ou 		   = l.loc_ou 
	LEFT JOIN dwh.d_zone z 		
		ON  s.wms_pway_zone 	   	   = z.zone_code 
		AND s.wms_pway_exec_ou 		   = z.zone_ou 
		AND s.wms_pway_loc_code		   = z.zone_loc_code
    WHERE 	t.pway_loc_code 		   = s.wms_pway_loc_code
    AND 	t.pway_exec_no             = s.wms_pway_exec_no
    AND 	t.pway_exec_ou             = s.wms_pway_exec_ou
    AND 	t.pway_lineno              = s.wms_pway_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PutawayExecserialDetail
    (
		pway_exe_dtl_key,pway_exec_serial_dtl_loc_key, pway_exec_serial_dtl_zone_key,
        pway_loc_code, pway_exec_no, pway_exec_ou, pway_lineno, pway_itm_lineno, pway_zone, pway_bin, pway_serialno, pway_lotno, pway_cust_sno, pway_3pl_sno, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		fh.pway_exe_dtl_key,COALESCE(l.loc_key,-1), COALESCE(z.zone_key,-1),
        s.wms_pway_loc_code, s.wms_pway_exec_no, s.wms_pway_exec_ou, s.wms_pway_lineno, 
        s.wms_pway_itm_lineno, s.wms_pway_zone, s.wms_pway_bin, s.wms_pway_serialno, 
        s.wms_pway_lotno, s.wms_pway_cust_sno, s.wms_pway_3pl_sno
        , 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_put_exec_serial_dtl s
    INNER JOIN 	dwh.f_putawayexecdetail fh 
			ON  s.wms_pway_loc_code = fh.pway_loc_code 
			AND s.wms_pway_exec_no 	= fh.pway_exec_no 
			AND s.wms_pway_exec_ou 	= fh.pway_exec_ou
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pway_loc_code 	   = l.loc_code 
		AND s.wms_pway_exec_ou 		   = l.loc_ou 
	LEFT JOIN dwh.d_zone z 		
		ON  s.wms_pway_zone 	   	   = z.zone_code 
		AND s.wms_pway_exec_ou 		   = z.zone_ou 
		AND s.wms_pway_loc_code		   = z.zone_loc_code
    LEFT JOIN dwh.F_PutawayExecserialDetail t
    ON 		s.wms_pway_loc_code 	   = t.pway_loc_code
    AND 	s.wms_pway_exec_no 		   = t.pway_exec_no
    AND 	s.wms_pway_exec_ou 		   = t.pway_exec_ou
    AND 	s.wms_pway_lineno 		   = t.pway_lineno
    WHERE t.pway_exec_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_put_exec_serial_dtl
    (
        wms_pway_loc_code, wms_pway_exec_no, wms_pway_exec_ou, wms_pway_lineno, wms_pway_itm_lineno, wms_pway_zone, wms_pway_bin, wms_pway_serialno, wms_pway_lotno, wms_pway_staging, wms_pway_cust_sno, wms_pway_3pl_sno, wms_pway_warranty_sno, etlcreateddatetime
    )
    SELECT
        wms_pway_loc_code, wms_pway_exec_no, wms_pway_exec_ou, wms_pway_lineno, wms_pway_itm_lineno, wms_pway_zone, wms_pway_bin, wms_pway_serialno, wms_pway_lotno, wms_pway_staging, wms_pway_cust_sno, wms_pway_3pl_sno, wms_pway_warranty_sno, etlcreateddatetime
    FROM stg.stg_wms_put_exec_serial_dtl;
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
ALTER PROCEDURE dwh.usp_f_putawayexecserialdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
