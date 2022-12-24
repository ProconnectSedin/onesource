CREATE OR REPLACE PROCEDURE dwh.usp_f_stockbinhistorydetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_stock_bin_history_dtl;

    UPDATE dwh.f_stockBinHistoryDetail t
    SET
        bin_dtl_key                    = COALESCE(fh.bin_dtl_key,-1),
	    stock_loc_key                  = COALESCE(l.loc_key,-1),
		stock_thu_key                  = COALESCE(h.thu_key,-1),
		stock_item_key                 = COALESCE(it.itm_hdr_key,-1),
		stock_cust_key                 = COALESCE(c.customer_key,-1),
        stock_bin_type                 = s.wms_stock_bin_type,
        stock_customer                 = s.wms_stock_customer,
        stock_opening_bal              = s.wms_stock_opening_bal,
        stock_in_qty                   = s.wms_stock_in_qty,
        stock_out_qty                  = s.wms_stock_out_qty,
        stock_bin_qty                  = s.wms_stock_bin_qty,
        stock_su_opening_bal           = s.wms_stock_su_opening_bal,
        stock_su_count_qty_in          = s.wms_stock_su_count_qty_in,
        stock_su_count_qty_out         = s.wms_stock_su_count_qty_out,
        stock_su_count_qty_bal         = s.wms_stock_su_count_qty_bal,
        stock_thu_opening_bal          = s.wms_stock_thu_opening_bal,
        stock_thu_count_qty_in         = s.wms_stock_thu_count_qty_in,
        stock_thu_count_qty_out        = s.wms_stock_thu_count_qty_out,
        stock_thu_count_qty_bal        = s.wms_stock_thu_count_qty_bal,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_wms_stock_bin_history_dtl s
    LEFT JOIN dwh.f_bindetails fh 	
        on  fh.bin_ou       = s.wms_stock_ou
        and fh.bin_code     = s.wms_stock_bin
        and fh.bin_loc_code = s.wms_stock_location
        and fh.bin_zone     = s.wms_stock_zone
        and fh.bin_type     = s.wms_stock_bin_type
	LEFT JOIN dwh.d_location L 		
		ON s.wms_stock_location	 			= L.loc_code 
        AND s.wms_stock_ou	        		= L.loc_ou
	LEFT JOIN dwh.d_itemheader it 			
		ON s.wms_stock_item					= it.itm_code
        AND s.wms_stock_ou	        		= it.itm_ou
	LEFT JOIN dwh.d_customer c
	    ON s.wms_stock_customer				= c.customer_id
		AND s.wms_stock_ou	        		= c.customer_ou 
	LEFT JOIN dwh.d_thu h
		ON  s.wms_stock_thu_id				= h.thu_id
		AND s.wms_stock_ou					= h.thu_ou

    WHERE t.stock_ou						= s.wms_stock_ou
	AND t.stock_bin							= s.wms_stock_bin
	AND t.stock_location					= s.wms_stock_location
	AND t.stock_zone						= s.wms_stock_zone
	AND t.stock_bin_type					= s.wms_stock_bin_type
    AND t.stock_date						= s.wms_stock_date    
    AND t.stock_item						= s.wms_stock_item
    AND t.stock_thu_id						= s.wms_stock_thu_id
    AND t.stock_su							= s.wms_stock_su;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_stockBinHistoryDetail
    (
	    bin_dtl_key,stock_loc_key,stock_thu_key,stock_item_key,stock_cust_key,
        stock_ou, stock_date, stock_location, stock_zone, stock_bin, stock_bin_type, stock_customer, stock_item, stock_opening_bal, stock_in_qty, stock_out_qty, stock_bin_qty, stock_thu_id, stock_su_opening_bal, stock_su_count_qty_in, stock_su_count_qty_out, stock_su_count_qty_bal, stock_su, stock_thu_opening_bal, stock_thu_count_qty_in, stock_thu_count_qty_out, stock_thu_count_qty_bal, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
	    COALESCE(fh.bin_dtl_key,-1),COALESCE(l.loc_key,-1),COALESCE(h.thu_key,-1),COALESCE(it.itm_hdr_key,-1),COALESCE(c.customer_key,-1),
        s.wms_stock_ou, s.wms_stock_date, s.wms_stock_location, s.wms_stock_zone, s.wms_stock_bin, s.wms_stock_bin_type, s.wms_stock_customer, TRIM(s.wms_stock_item), s.wms_stock_opening_bal, s.wms_stock_in_qty, s.wms_stock_out_qty, s.wms_stock_bin_qty, s.wms_stock_thu_id, s.wms_stock_su_opening_bal, s.wms_stock_su_count_qty_in, s.wms_stock_su_count_qty_out, s.wms_stock_su_count_qty_bal, s.wms_stock_su, s.wms_stock_thu_opening_bal, s.wms_stock_thu_count_qty_in, s.wms_stock_thu_count_qty_out, s.wms_stock_thu_count_qty_bal, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_stock_bin_history_dtl s
    LEFT JOIN dwh.f_bindetails fh 	
        on  fh.bin_ou       = s.wms_stock_ou
        and fh.bin_code     = s.wms_stock_bin
        and fh.bin_loc_code = s.wms_stock_location
        and fh.bin_zone     = s.wms_stock_zone
        and fh.bin_type     = s.wms_stock_bin_type
	LEFT JOIN dwh.d_location L 		
		ON s.wms_stock_location	 			= L.loc_code 
        AND s.wms_stock_ou	        		= L.loc_ou
	LEFT JOIN dwh.d_itemheader it 			
		ON s.wms_stock_item					= it.itm_code
        AND s.wms_stock_ou	        		= it.itm_ou
	LEFT JOIN dwh.d_customer c
	    ON s.wms_stock_customer				= c.customer_id
		AND s.wms_stock_ou	        		= c.customer_ou 
	LEFT JOIN dwh.d_thu h
		ON  s.wms_stock_thu_id				= h.thu_id
		AND s.wms_stock_ou					= h.thu_ou
    LEFT JOIN dwh.f_stockBinHistoryDetail t
		ON t.stock_ou						= s.wms_stock_ou
		AND t.stock_bin							= s.wms_stock_bin
		AND t.stock_location					= s.wms_stock_location
		AND t.stock_zone						= s.wms_stock_zone
		AND t.stock_bin_type					= s.wms_stock_bin_type
    	AND t.stock_date						= s.wms_stock_date    
    	AND t.stock_item						= s.wms_stock_item
    	AND t.stock_thu_id						= s.wms_stock_thu_id
    	AND t.stock_su							= s.wms_stock_su
	WHERE t.stock_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_stock_bin_history_dtl
    (
        wms_stock_ou, wms_stock_date, wms_stock_location, wms_stock_zone, wms_stock_bin, wms_stock_bin_type, wms_stock_customer, wms_stock_item, wms_stock_opening_bal, wms_stock_in_qty, wms_stock_out_qty, wms_stock_bin_qty, wms_stock_thu_id, wms_stock_su_opening_bal, wms_stock_su_count_qty_in, wms_stock_su_count_qty_out, wms_stock_su_count_qty_bal, wms_stock_su, wms_stock_thu_opening_bal, wms_stock_thu_count_qty_in, wms_stock_thu_count_qty_out, wms_stock_thu_count_qty_bal, etlcreateddatetime
    )
    SELECT
        wms_stock_ou, wms_stock_date, wms_stock_location, wms_stock_zone, wms_stock_bin, wms_stock_bin_type, wms_stock_customer, wms_stock_item, wms_stock_opening_bal, wms_stock_in_qty, wms_stock_out_qty, wms_stock_bin_qty, wms_stock_thu_id, wms_stock_su_opening_bal, wms_stock_su_count_qty_in, wms_stock_su_count_qty_out, wms_stock_su_count_qty_bal, wms_stock_su, wms_stock_thu_opening_bal, wms_stock_thu_count_qty_in, wms_stock_thu_count_qty_out, wms_stock_thu_count_qty_bal, etlcreateddatetime
    FROM stg.stg_wms_stock_bin_history_dtl;
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