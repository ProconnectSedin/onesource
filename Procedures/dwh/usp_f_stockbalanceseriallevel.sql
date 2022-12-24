CREATE OR REPLACE PROCEDURE dwh.usp_f_stockbalanceseriallevel(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_stockbal_serial;

    UPDATE dwh.F_StockBalanceSeriallevel t
    SET
        sbs_level_wh_key			  = COALESCE(w.wh_key,-1),
		sbs_level_itm_hdr_key		  = COALESCE(i.itm_hdr_key,-1),
		sbs_level_zone_key			  = COALESCE(z.zone_key,-1),
        sbs_quantity                  = s.sbs_quantity,
        sbs_wh_bat_no                 = s.sbs_wh_bat_no,
        sbs_supp_bat_no               = s.sbs_supp_bat_no,
        sbs_ido_no                    = s.sbs_ido_no,
        sbs_gr_no                     = s.sbs_gr_no,
        sbs_trantype                  = s.sbs_trantype,
        sbs_customer_serial_no        = s.sbs_customer_serial_no,
        sbs_3pl_serial_no             = s.sbs_3pl_serial_no,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_wms_stockbal_serial s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.sbs_item_code			 = i.itm_code
		AND s.sbs_ouinstid 		 	 = i.itm_ou 
	LEFT JOIN dwh.d_zone z 		
		ON  s.sbs_zone 	   	 		 = z.zone_code 
		AND s.sbs_ouinstid 		     = z.zone_ou 
	LEFT JOIN dwh.d_warehouse w 		
		ON  s.sbs_wh_code 	   	     = w.wh_code 
		AND s.sbs_ouinstid 		     = w.wh_ou 
    WHERE t.sbs_wh_code 			 = s.sbs_wh_code
    AND   t.sbs_ouinstid 			 = s.sbs_ouinstid
    AND   t.sbs_item_code 			 = s.sbs_item_code
    AND   t.sbs_sr_no 				 = s.sbs_sr_no
    AND   t.sbs_zone 				 = s.sbs_zone
    AND   t.sbs_bin 				 = s.sbs_bin
    AND   t.sbs_stock_status 	     = s.sbs_stock_status
    AND   t.sbs_lot_no 				 = s.sbs_lot_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_StockBalanceSeriallevel
    (
		sbs_level_wh_key, sbs_level_itm_hdr_key, sbs_level_zone_key,
        sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no, sbs_quantity, sbs_wh_bat_no, sbs_supp_bat_no, sbs_ido_no, sbs_gr_no, sbs_trantype, sbs_customer_serial_no, sbs_3pl_serial_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(w.wh_key,-1), COALESCE(i.itm_hdr_key,-1), COALESCE(z.zone_key,-1),
        s.sbs_wh_code, s.sbs_ouinstid, s.sbs_item_code, s.sbs_sr_no, s.sbs_zone, s.sbs_bin, s.sbs_stock_status, s.sbs_lot_no, s.sbs_quantity, s.sbs_wh_bat_no, s.sbs_supp_bat_no, s.sbs_ido_no, s.sbs_gr_no, s.sbs_trantype, s.sbs_customer_serial_no, s.sbs_3pl_serial_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_stockbal_serial s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.sbs_item_code			 = i.itm_code
		AND s.sbs_ouinstid 		 	 = i.itm_ou 
	LEFT JOIN dwh.d_zone z 		
		ON  s.sbs_zone 	   	 		 = z.zone_code 
		AND s.sbs_ouinstid 		     = z.zone_ou 
	LEFT JOIN dwh.d_warehouse w 		
		ON  s.sbs_wh_code 	   	     = w.wh_code 
		AND s.sbs_ouinstid 		     = w.wh_ou 
    LEFT JOIN dwh.F_StockBalanceSeriallevel t
    ON 		s.sbs_wh_code            = t.sbs_wh_code
    AND     s.sbs_ouinstid 			 = t.sbs_ouinstid
    AND     s.sbs_item_code 		 = t.sbs_item_code
    AND     s.sbs_sr_no 			 = t.sbs_sr_no
    AND     s.sbs_zone 				 = t.sbs_zone
    AND     s.sbs_bin 				 = t.sbs_bin
    AND     s.sbs_stock_status 		 = t.sbs_stock_status
    AND     s.sbs_lot_no 			 = t.sbs_lot_no
    WHERE t.sbs_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_stockbal_serial
    (
        sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no, sbs_quantity, sbs_wh_bat_no, sbs_supp_bat_no, sbs_ido_no, sbs_gr_no, sbs_trantype, sbs_warranty_serial_no, sbs_customer_serial_no, sbs_3pl_serial_no, etlcreateddatetime
    )
    SELECT
        sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no, sbs_quantity, sbs_wh_bat_no, sbs_supp_bat_no, sbs_ido_no, sbs_gr_no, sbs_trantype, sbs_warranty_serial_no, sbs_customer_serial_no, sbs_3pl_serial_no, etlcreateddatetime
    FROM stg.stg_wms_stockbal_serial;
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