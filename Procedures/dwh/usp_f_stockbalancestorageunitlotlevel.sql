CREATE PROCEDURE dwh.usp_f_stockbalancestorageunitlotlevel(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_stockbal_su_lot;

    UPDATE dwh.F_StockBalanceStorageunitLotLevel t
    SET
        sbl_lot_level_wh_key	 = COALESCE(w.wh_key,-1),
		sbl_lot_level_itm_hdr_key= COALESCE(i.itm_hdr_key,-1),
		sbl_lot_level_zone_key	 = COALESCE(z.zone_key,-1),
		sbl_lot_level_thu_key	 = COALESCE(th.thu_key,-1),
        sbl_su_type              = s.sbl_su_type,
        sbl_thu_id               = s.sbl_thu_id,
        sbl_quantity             = s.sbl_quantity,
        sbl_wh_bat_no            = s.sbl_wh_bat_no,
        sbl_supp_bat_no          = s.sbl_supp_bat_no,
        sbl_ido_no               = s.sbl_ido_no,
        sbl_gr_no                = s.sbl_gr_no,
        sbl_trantype             = s.sbl_trantype,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_wms_stockbal_su_lot s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.sbl_item_code			 = i.itm_code
		AND s.sbl_ouinstid 		 	 = i.itm_ou 
	LEFT JOIN dwh.d_zone z 		
		ON  s.sbl_zone 	   	 		 = z.zone_code 
		AND s.sbl_ouinstid 		     = z.zone_ou 
	LEFT JOIN dwh.d_warehouse w 		
		ON  s.sbl_wh_code 	   	     = w.wh_code 
		AND s.sbl_ouinstid 		     = w.wh_ou 
	LEFT JOIN dwh.d_thu th 		
		ON  s.sbl_thu_id 	   	     = th.thu_code 
		AND s.sbl_ouinstid 		     = th.thu_ou 
    WHERE 	t.sbl_wh_code 			 = s.sbl_wh_code
    AND 	t.sbl_ouinstid 			 = s.sbl_ouinstid
    AND 	t.sbl_item_code 		 = s.sbl_item_code
    AND 	t.sbl_lot_no 	 		 = s.sbl_lot_no
    AND 	t.sbl_zone 				 = s.sbl_zone
    AND 	t.sbl_bin 				 = s.sbl_bin
    AND 	t.sbl_su 				 = s.sbl_su
    AND 	t.sbl_stock_status 		 = s.sbl_stock_status
    AND 	t.sbl_su_serial_no 		 = s.sbl_su_serial_no
    AND 	t.sbl_thu_serial_no 	 = s.sbl_thu_serial_no
    AND 	t.sbl_su_serial_no2 	 = s.sbl_su_serial_no2;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_StockBalanceStorageunitLotLevel
    (
		sbl_lot_level_wh_key, sbl_lot_level_itm_hdr_key, sbl_lot_level_zone_key, sbl_lot_level_thu_key,
        sbl_wh_code, sbl_ouinstid, sbl_item_code, sbl_lot_no, sbl_zone, sbl_bin, sbl_su, sbl_su_type, sbl_thu_id, sbl_stock_status, sbl_quantity, sbl_su_serial_no, sbl_wh_bat_no, sbl_supp_bat_no, sbl_ido_no, sbl_gr_no, sbl_trantype, sbl_thu_serial_no, sbl_su_serial_no2, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(w.wh_key,-1), COALESCE(i.itm_hdr_key,-1),  COALESCE(z.zone_key,-1), COALESCE(th.thu_key,-1),
        s.sbl_wh_code, s.sbl_ouinstid, s.sbl_item_code, s.sbl_lot_no, s.sbl_zone, s.sbl_bin, s.sbl_su, s.sbl_su_type, s.sbl_thu_id, s.sbl_stock_status, s.sbl_quantity, s.sbl_su_serial_no, s.sbl_wh_bat_no, s.sbl_supp_bat_no, s.sbl_ido_no, s.sbl_gr_no, s.sbl_trantype, s.sbl_thu_serial_no, s.sbl_su_serial_no2, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_stockbal_su_lot s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.sbl_item_code			 = i.itm_code
		AND s.sbl_ouinstid 		 	 = i.itm_ou 
	LEFT JOIN dwh.d_zone z 		
		ON  s.sbl_zone 	   	 		 = z.zone_code 
		AND s.sbl_ouinstid 		     = z.zone_ou 
	LEFT JOIN dwh.d_warehouse w 		
		ON  s.sbl_wh_code 	   	     = w.wh_code 
		AND s.sbl_ouinstid 		     = w.wh_ou 
	LEFT JOIN dwh.d_thu th 		
		ON  s.sbl_thu_id 	   	     = th.thu_code 
		AND s.sbl_ouinstid 		     = th.thu_ou 
    LEFT JOIN dwh.F_StockBalanceStorageunitLotLevel t
    ON 		s.sbl_wh_code 			 = t.sbl_wh_code
    AND 	s.sbl_ouinstid 			 = t.sbl_ouinstid
    AND 	s.sbl_item_code 		 = t.sbl_item_code
    AND 	s.sbl_lot_no 			 = t.sbl_lot_no
    AND 	s.sbl_zone 				 = t.sbl_zone
    AND 	s.sbl_bin 				 = t.sbl_bin
    AND 	s.sbl_su 				 = t.sbl_su
    AND 	s.sbl_stock_status       = t.sbl_stock_status
    AND 	s.sbl_su_serial_no       = t.sbl_su_serial_no
    AND 	s.sbl_thu_serial_no      = t.sbl_thu_serial_no
    AND 	s.sbl_su_serial_no2      = t.sbl_su_serial_no2
    WHERE t.sbl_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_stockbal_su_lot
    (
        sbl_wh_code, sbl_ouinstid, sbl_item_code, sbl_lot_no, sbl_zone, sbl_bin, sbl_su, sbl_su_type, sbl_thu_id, sbl_stock_status, sbl_quantity, sbl_su_serial_no, sbl_wh_bat_no, sbl_supp_bat_no, sbl_ido_no, sbl_gr_no, sbl_trantype, sbl_thu_serial_no, sbl_su2, sbl_su_serial_no2, etlcreateddatetime
    )
    SELECT
        sbl_wh_code, sbl_ouinstid, sbl_item_code, sbl_lot_no, sbl_zone, sbl_bin, sbl_su, sbl_su_type, sbl_thu_id, sbl_stock_status, sbl_quantity, sbl_su_serial_no, sbl_wh_bat_no, sbl_supp_bat_no, sbl_ido_no, sbl_gr_no, sbl_trantype, sbl_thu_serial_no, sbl_su2, sbl_su_serial_no2, etlcreateddatetime
    FROM stg.stg_wms_stockbal_su_lot;
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