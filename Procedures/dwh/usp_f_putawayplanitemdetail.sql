-- PROCEDURE: dwh.usp_f_putawayplanitemdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_putawayplanitemdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_putawayplanitemdetail(
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
    FROM stg.stg_wms_put_plan_item_dtl;

    UPDATE dwh.F_PutawayPlanItemDetail t
    SET
        pway_pln_dtl_key			  = fh.pway_pln_dtl_key,
        pway_pln_itm_dtl_loc_key	  = COALESCE(l.loc_key,-1),
		pway_pln_itm_dtl_itm_hdr_key  = COALESCE(i.itm_hdr_key,-1),
		pway_pln_itm_dtl_zone_key	  = COALESCE(z.zone_key,-1),
        pway_po_no                    = s.wms_pway_po_no,
        pway_po_sr_no                 = s.wms_pway_po_sr_no,
        pway_uid                      = s.wms_pway_uid,
        pway_item                     = s.wms_pway_item,
        pway_zone                     = s.wms_pway_zone,
        pway_allocated_qty            = s.wms_pway_allocated_qty,
        pway_allocated_bin            = s.wms_pway_allocated_bin,
        pway_gr_no                    = s.wms_pway_gr_no,
        pway_gr_lineno                = s.wms_pway_gr_lineno,
        pway_gr_lot_no                = s.wms_pway_gr_lot_no,
        pway_rqs_conformation         = s.wms_pway_rqs_conformation,
        pway_su_type                  = s.wms_pway_su_type,
        pway_su_serial_no             = s.wms_pway_su_serial_no,
        pway_su                       = s.wms_pway_su,
        pway_from_staging_id          = s.wms_pway_from_staging_id,
        pway_supp_batch_no            = s.wms_pway_supp_batch_no,
        pway_thu_serial_no            = s.wms_pway_thu_serial_no,
        pway_allocated_staging        = s.wms_pway_allocated_staging,
        pway_cross_dock               = s.wms_pway_cross_dock,
        pway_stock_status             = s.wms_pway_stock_status,
        pway_staging                  = s.wms_pway_staging,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_wms_put_plan_item_dtl s
    INNER JOIN 	dwh.f_putawayplandetail fh 
			ON  s.wms_pway_loc_code = fh.pway_loc_code 
			AND s.wms_pway_pln_no 	= fh.pway_pln_no 
			AND s.wms_pway_pln_ou 	= fh.pway_pln_ou
	LEFT JOIN dwh.d_itemheader i 
		ON  s.wms_pway_item			 = i.itm_code
		AND s.wms_pway_pln_ou 		 = i.itm_ou 
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pway_loc_code 	 = l.loc_code 
		AND s.wms_pway_pln_ou 		 = l.loc_ou 
	LEFT JOIN dwh.d_zone z 			
		ON  s.wms_pway_zone 		 = z.zone_code
		AND s.wms_pway_loc_code 	 = z.zone_loc_code
		AND s.wms_pway_pln_ou 		 = z.zone_ou 
    WHERE 	t.pway_loc_code 		 = s.wms_pway_loc_code
    AND 	t.pway_pln_no 			 = s.wms_pway_pln_no
    AND 	t.pway_pln_ou 			 = s.wms_pway_pln_ou
    AND 	t.pway_lineno 			 = s.wms_pway_lineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PutawayPlanItemDetail
    (
	    pway_pln_dtl_key,pway_pln_itm_dtl_loc_key, pway_pln_itm_dtl_itm_hdr_key, pway_pln_itm_dtl_zone_key,
        pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno, pway_po_no, pway_po_sr_no, pway_uid, pway_item, pway_zone, pway_allocated_qty, pway_allocated_bin, pway_gr_no, pway_gr_lineno, pway_gr_lot_no, pway_rqs_conformation, pway_su_type, pway_su_serial_no, pway_su, pway_from_staging_id, pway_supp_batch_no, pway_thu_serial_no, pway_allocated_staging, pway_cross_dock, pway_stock_status, pway_staging, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		fh.pway_pln_dtl_key,COALESCE(l.loc_key,-1), COALESCE(i.itm_hdr_key,-1), COALESCE(z.zone_key,-1),
        s.wms_pway_loc_code, s.wms_pway_pln_no, s.wms_pway_pln_ou, s.wms_pway_lineno, s.wms_pway_po_no, s.wms_pway_po_sr_no, s.wms_pway_uid, s.wms_pway_item, s.wms_pway_zone, s.wms_pway_allocated_qty, s.wms_pway_allocated_bin, s.wms_pway_gr_no, s.wms_pway_gr_lineno, s.wms_pway_gr_lot_no, s.wms_pway_rqs_conformation, s.wms_pway_su_type, s.wms_pway_su_serial_no, s.wms_pway_su, s.wms_pway_from_staging_id, s.wms_pway_supp_batch_no, s.wms_pway_thu_serial_no, s.wms_pway_allocated_staging, s.wms_pway_cross_dock, s.wms_pway_stock_status, s.wms_pway_staging, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_put_plan_item_dtl s
    INNER JOIN 	dwh.f_putawayplandetail fh 
			ON  s.wms_pway_loc_code = fh.pway_loc_code 
			AND s.wms_pway_pln_no 	= fh.pway_pln_no 
			AND s.wms_pway_pln_ou 	= fh.pway_pln_ou
	LEFT JOIN dwh.d_itemheader i 
		ON  s.wms_pway_item			 = i.itm_code
		AND s.wms_pway_pln_ou 		 = i.itm_ou 
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pway_loc_code 	 = l.loc_code 
		AND s.wms_pway_pln_ou 		 = l.loc_ou 
	LEFT JOIN dwh.d_zone z 			
		ON  s.wms_pway_zone 		 = z.zone_code
		AND s.wms_pway_pln_ou 		 = z.zone_ou 
		AND s.wms_pway_loc_code 	 = z.zone_loc_code
    LEFT JOIN dwh.F_PutawayPlanItemDetail t
    ON 		s.wms_pway_loc_code 	= t.pway_loc_code
    AND 	s.wms_pway_pln_no 		= t.pway_pln_no
    AND 	s.wms_pway_pln_ou 		= t.pway_pln_ou
    AND 	s.wms_pway_lineno 		= t.pway_lineno
    WHERE 	t.pway_pln_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_put_plan_item_dtl
    (
        wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno, wms_pway_po_no, wms_pway_po_sr_no, wms_pway_uid, wms_pway_item, wms_pway_zone, wms_pway_allocated_qty, wms_pway_allocated_bin, wms_pway_gr_no, wms_pway_gr_lineno, wms_pway_gr_lot_no, wms_pway_rqs_conformation, wms_pway_su_type, wms_pway_su_serial_no, wms_pway_su, wms_pway_from_staging_id, wms_pway_supp_batch_no, wms_pway_thu_serial_no, wms_pway_allocated_staging, wms_pway_cross_dock, wms_pway_target_thu_serial_no, wms_pway_stock_status, wms_pway_staging, wms_pway_su2, wms_pway_su_serial_no2, wms_put_su1_conv_flg, wms_put_su2_conv_flg, etlcreateddatetime
    )
    SELECT
        wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno, wms_pway_po_no, wms_pway_po_sr_no, wms_pway_uid, wms_pway_item, wms_pway_zone, wms_pway_allocated_qty, wms_pway_allocated_bin, wms_pway_gr_no, wms_pway_gr_lineno, wms_pway_gr_lot_no, wms_pway_rqs_conformation, wms_pway_su_type, wms_pway_su_serial_no, wms_pway_su, wms_pway_from_staging_id, wms_pway_supp_batch_no, wms_pway_thu_serial_no, wms_pway_allocated_staging, wms_pway_cross_dock, wms_pway_target_thu_serial_no, wms_pway_stock_status, wms_pway_staging, wms_pway_su2, wms_pway_su_serial_no2, wms_put_su1_conv_flg, wms_put_su2_conv_flg, etlcreateddatetime
    FROM stg.stg_wms_put_plan_item_dtl;
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
ALTER PROCEDURE dwh.usp_f_putawayplanitemdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
