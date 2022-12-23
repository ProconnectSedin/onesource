CREATE PROCEDURE dwh.usp_f_stockuidtrackingdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_stock_uid_tracking_dtl;

    UPDATE dwh.f_stockuidtrackingdetail t
    SET
        stk_trc_dtl_loc_key				= COALESCE(l.loc_key,-1),
		stk_trc_dtl_zone_key			= COALESCE(z.zone_key,-1),
		stk_trc_dtl_bin_type_key		= COALESCE(b.bin_typ_key,-1),
		stk_trc_dtl_customer_key		= COALESCE(c.customer_key,-1),
		stk_trc_dtl_thu_key				= COALESCE(th.thu_key,-1),
		stk_ou                    		= s.wms_stk_ou,
        stk_to_date               		= s.wms_stk_to_date,
        stk_from_tran_type        		= s.wms_stk_from_tran_type,
        stk_to_tran_type          		= s.wms_stk_to_tran_type,
        stk_from_tran_no          		= s.wms_stk_from_tran_no,
        stk_to_tran_no            		= s.wms_stk_to_tran_no,
        etlactiveind              		= 1,
        etljobname                		= p_etljobname,
        envsourcecd               		= p_envsourcecd,
        datasourcecd              		= p_datasourcecd,
        etlupdatedatetime         		= NOW()
    FROM stg.stg_wms_stock_uid_tracking_dtl s
	LEFT JOIN dwh.d_location l
		ON  s.wms_stk_location			= l.loc_code
		AND s.wms_stk_ou				= l.loc_ou	
	LEFT JOIN dwh.d_zone z		
		ON  s.wms_stk_zone				= z.zone_code
		AND s.wms_stk_location          = z.zone_loc_code
		AND s.wms_stk_ou				= z.zone_ou
	LEFT JOIN dwh.d_bintypes b		
		ON  s.wms_stk_bin_type			= b.bin_typ_code
		AND s.wms_stk_location			= b.bin_typ_loc_code
		AND s.wms_stk_ou				= b.bin_typ_ou
	LEFT JOIN dwh.d_customer c		
		ON  s.wms_stk_customer			= c.customer_id
		AND s.wms_stk_ou				= c.customer_ou			
	LEFT JOIN dwh.d_thu th		
		ON  s.wms_stk_thu_id			= th.thu_id
		AND s.wms_stk_ou				= th.thu_ou		
    WHERE   t.stk_location 				= s.wms_stk_location
		AND t.stk_zone 					= s.wms_stk_zone
		AND t.stk_bin 					= s.wms_stk_bin
		AND t.stk_bin_type 				= s.wms_stk_bin_type
		AND t.stk_staging_id 			= s.wms_stk_staging_id
		AND t.stk_stage 				= s.wms_stk_stage
		AND t.stk_customer 				= s.wms_stk_customer
		AND t.stk_uid_serial_no 		= s.wms_stk_uid_serial_no
		AND t.stk_thu_id 				= s.wms_stk_thu_id
		AND t.stk_su 					= s.wms_stk_su
		AND t.stk_from_date 			= s.wms_stk_from_date;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_stockuidtrackingdetail
    (
        stk_trc_dtl_loc_key	, stk_trc_dtl_zone_key	, stk_trc_dtl_bin_type_key	, stk_trc_dtl_customer_key, 
		stk_trc_dtl_thu_key	, stk_ou				, stk_location				, stk_zone, 
		stk_bin				, stk_bin_type			, stk_staging_id			, stk_stage, 
		stk_customer		, stk_uid_serial_no		, stk_thu_id				, stk_su, 
		stk_from_date		, stk_to_date			, stk_from_tran_type		, stk_to_tran_type, 
		stk_from_tran_no	, stk_to_tran_no		, etlactiveind				, etljobname, 
		envsourcecd			, datasourcecd			, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1)	, COALESCE(z.zone_key,-1)	, COALESCE(b.bin_typ_key,-1)	, COALESCE(c.customer_key,-1),
		COALESCE(th.thu_key,-1)	, s.wms_stk_ou				, s.wms_stk_location			, s.wms_stk_zone, 
		s.wms_stk_bin			, s.wms_stk_bin_type		, s.wms_stk_staging_id			, s.wms_stk_stage, 
		s.wms_stk_customer		, s.wms_stk_uid_serial_no	, s.wms_stk_thu_id				, s.wms_stk_su, 
		s.wms_stk_from_date		, s.wms_stk_to_date			, s.wms_stk_from_tran_type		, s.wms_stk_to_tran_type, 
		s.wms_stk_from_tran_no	, s.wms_stk_to_tran_no		, 1								, p_etljobname, 
		p_envsourcecd			, p_datasourcecd			, NOW()
    FROM stg.stg_wms_stock_uid_tracking_dtl s
	LEFT JOIN dwh.d_location l
		ON  s.wms_stk_location			= l.loc_code
		AND s.wms_stk_ou				= l.loc_ou	
	LEFT JOIN dwh.d_zone z		
		ON  s.wms_stk_zone				= z.zone_code
		AND s.wms_stk_location          = z.zone_loc_code
		AND s.wms_stk_ou				= z.zone_ou
	LEFT JOIN dwh.d_bintypes b		
		ON  s.wms_stk_bin_type			= b.bin_typ_code
		AND s.wms_stk_location			= b.bin_typ_loc_code
		AND s.wms_stk_ou				= b.bin_typ_ou
	LEFT JOIN dwh.d_customer c		
		ON  s.wms_stk_customer			= c.customer_id
		AND s.wms_stk_ou				= c.customer_ou			
	LEFT JOIN dwh.d_thu th		
		ON  s.wms_stk_thu_id			= th.thu_id
		AND s.wms_stk_ou				= th.thu_ou		
    LEFT JOIN dwh.f_stockuidtrackingdetail t
		ON  s.wms_stk_location 			= t.stk_location
		AND s.wms_stk_zone 				= t.stk_zone
		AND s.wms_stk_bin 				= t.stk_bin
		AND s.wms_stk_bin_type 			= t.stk_bin_type
		AND s.wms_stk_staging_id 		= t.stk_staging_id
		AND s.wms_stk_stage 			= t.stk_stage
		AND s.wms_stk_customer 			= t.stk_customer
		AND s.wms_stk_uid_serial_no 	= t.stk_uid_serial_no
		AND s.wms_stk_thu_id 			= t.stk_thu_id
		AND s.wms_stk_su 				= t.stk_su
		AND s.wms_stk_from_date 		= t.stk_from_date
    WHERE   t.stk_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_stock_uid_tracking_dtl
    (
        wms_stk_ou				, wms_stk_location			, wms_stk_zone			, wms_stk_bin, 
		wms_stk_bin_type		, wms_stk_staging_id		, wms_stk_stage			, wms_stk_customer, 
		wms_stk_uid_serial_no	, wms_stk_thu_id			, wms_stk_su			, wms_stk_from_date, 
		wms_stk_to_date			, wms_stk_from_tran_type	, wms_stk_to_tran_type	, wms_stk_from_tran_no, 
		wms_stk_to_tran_no		, etlcreateddatetime
    )
    SELECT
        wms_stk_ou				, wms_stk_location			, wms_stk_zone			, wms_stk_bin, 
		wms_stk_bin_type		, wms_stk_staging_id		, wms_stk_stage			, wms_stk_customer, 
		wms_stk_uid_serial_no	, wms_stk_thu_id			, wms_stk_su			, wms_stk_from_date, 
		wms_stk_to_date			, wms_stk_from_tran_type	, wms_stk_to_tran_type	, wms_stk_from_tran_no, 
		wms_stk_to_tran_no		, etlcreateddatetime
	FROM stg.stg_wms_stock_uid_tracking_dtl;
    END IF;

    EXCEPTION WHEN others THEN
    GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;
END;
$$;