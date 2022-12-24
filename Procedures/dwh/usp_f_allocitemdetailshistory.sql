-- PROCEDURE: dwh.usp_f_allocitemdetailshistory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_allocitemdetailshistory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_allocitemdetailshistory(
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
    FROM stg.stg_wms_alloc_item_detail_hist;
/*
    UPDATE dwh.F_AllocItemDetailsHistory t
    SET
	    allc_dtl_key					= fh.allc_dtl_key,
		allc_itm_hdr_key				= COALESCE(i.itm_hdr_key,-1)
		, allc_wh_key					= COALESCE(w.wh_key,-1)
		, allc_zone_key					= COALESCE(z.zone_key,-1)
		, allc_thu_key					= COALESCE(th.thu_key,-1),
        allc_order_no                 = s.allc_order_no,
        allc_order_line_no            = s.allc_order_line_no,
        allc_order_sch_no             = s.allc_order_sch_no,
        allc_item_code                = s.allc_item_code,
        allc_wh_no                    = s.allc_wh_no,
        allc_zone_no                  = s.allc_zone_no,
        allc_bin_no                   = s.allc_bin_no,
        allc_lot_no                   = s.allc_lot_no,
        allc_batch_no                 = s.allc_batch_no,
        allc_serial_no                = s.allc_serial_no,
        allc_su                       = s.allc_su,
        allc_su_serial_no             = s.allc_su_serial_no,
        allc_su_type                  = s.allc_su_type,
        allc_thu_id                   = s.allc_thu_id,
        allc_tran_qty                 = s.allc_tran_qty,
        allc_allocated_qty            = s.allc_allocated_qty,
        allc_mas_uom                  = s.allc_mas_uom,
        allc_created_date             = s.allc_created_date,
        allc_created_by               = s.allc_created_by,
        allc_thu_serial_no            = s.allc_thu_serial_no,
        allc_inpro_stage              = s.allc_inpro_stage,
        allc_staging_id_crosdk        = s.allc_staging_id_crosdk,
        allc_inpro_stk_line_no        = s.allc_inpro_stk_line_no,
        allc_stock_status             = s.allc_stock_status,
        allc_su_serial_no2            = s.allc_su_serial_no2,
        allc_su2                      = s.allc_su2,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_wms_alloc_item_detail_hist s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.allc_ouinstid				= i.itm_ou
		AND s.allc_doc_ou 				= i.itm_ou 
		AND s.allc_item_code 			= i.itm_code 
	LEFT JOIN dwh.d_warehouse w 		
		ON  s.allc_wh_no 				= w.wh_code 
		AND s.allc_ouinstid				= w.wh_ou 
		AND s.allc_doc_ou 				= w.wh_ou 
	LEFT JOIN dwh.d_zone z 			
		ON  s.allc_zone_no 				= z.zone_code
		AND s.allc_ouinstid				= z.zone_ou
		AND s.allc_doc_ou 				= z.zone_ou 	
		AND s.allc_wh_no				= z.zone_loc_code
	LEFT JOIN dwh.d_thu th 		
		ON  s.allc_thu_id		  		= th.thu_id 
		AND s.allc_ouinstid				= th.thu_ou
		AND s.allc_doc_ou 				= th.thu_ou 
    WHERE t.allc_ouinstid = s.allc_ouinstid
    AND t.allc_doc_no = s.allc_doc_no
    AND t.allc_doc_ou = s.allc_doc_ou
    AND t.allc_doc_line_no = s.allc_doc_line_no
    AND t.allc_alloc_line_no = s.allc_alloc_line_no;

    
*/

     SELECT 0 INTO updcnt ;
/*
    Delete from dwh.F_AllocItemDetailsHistory t
	USING stg.stg_wms_alloc_item_detail_hist s
	where	t.allc_ouinstid     = s.allc_ouinstid
    AND     t.allc_doc_no       = s.allc_doc_no
    AND     t.allc_doc_ou       = s.allc_doc_ou
    AND     t.allc_doc_line_no  = s.allc_doc_line_no
    AND     t.allc_alloc_line_no = s.allc_alloc_line_no;
	--AND COALESCE(wms_asn_modified_date,wms_asn_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/
    INSERT INTO dwh.F_AllocItemDetailsHistory
    (
		allc_itm_hdr_key				, allc_wh_key					, allc_zone_key						, allc_thu_key , 
        allc_ouinstid, allc_doc_no, allc_doc_ou, allc_doc_line_no, allc_alloc_line_no, allc_order_no, allc_order_line_no, allc_order_sch_no, allc_item_code, allc_wh_no, allc_zone_no, allc_bin_no, allc_lot_no, allc_batch_no, allc_serial_no, allc_su, allc_su_serial_no, allc_su_type, allc_thu_id, allc_tran_qty, allc_allocated_qty, allc_mas_uom, allc_created_date, allc_created_by, allc_thu_serial_no, allc_inpro_stage, allc_staging_id_crosdk, allc_inpro_stk_line_no, allc_stock_status, allc_su_serial_no2, allc_su2, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		COALESCE(i.itm_hdr_key,-1)	, COALESCE(w.wh_key,-1)			, COALESCE(z.zone_key,-1)			, COALESCE(th.thu_key,-1), 	
        s.allc_ouinstid, s.allc_doc_no, s.allc_doc_ou, s.allc_doc_line_no, s.allc_alloc_line_no, s.allc_order_no, s.allc_order_line_no, s.allc_order_sch_no, s.allc_item_code, s.allc_wh_no, s.allc_zone_no, s.allc_bin_no, s.allc_lot_no, s.allc_batch_no, s.allc_serial_no, s.allc_su, s.allc_su_serial_no, s.allc_su_type, s.allc_thu_id, s.allc_tran_qty, s.allc_allocated_qty, s.allc_mas_uom, s.allc_created_date, s.allc_created_by, s.allc_thu_serial_no, s.allc_inpro_stage, s.allc_staging_id_crosdk, s.allc_inpro_stk_line_no, s.allc_stock_status, s.allc_su_serial_no2, s.allc_su2, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_alloc_item_detail_hist s
	LEFT JOIN dwh.d_itemheader i 
		ON  s.allc_ouinstid				= i.itm_ou
		AND s.allc_doc_ou 				= i.itm_ou 
		AND s.allc_item_code 			= i.itm_code 
	LEFT JOIN dwh.d_warehouse w 		
		ON  s.allc_wh_no 				= w.wh_code 
		AND s.allc_ouinstid				= w.wh_ou 
		AND s.allc_doc_ou 				= w.wh_ou 
	LEFT JOIN dwh.d_zone z 			
		ON  s.allc_zone_no 				= z.zone_code
		AND s.allc_ouinstid				= z.zone_ou
		AND s.allc_doc_ou 				= z.zone_ou 	
		AND s.allc_wh_no				= z.zone_loc_code
	LEFT JOIN dwh.d_thu th 		
		ON  s.allc_thu_id		  		= th.thu_id 
		AND s.allc_ouinstid				= th.thu_ou
		AND s.allc_doc_ou 				= th.thu_ou 
    LEFT JOIN dwh.F_AllocItemDetailsHistory t
    ON s.allc_ouinstid = t.allc_ouinstid
    AND s.allc_doc_no = t.allc_doc_no
    AND s.allc_doc_ou = t.allc_doc_ou
    AND s.allc_doc_line_no = t.allc_doc_line_no
    AND s.allc_alloc_line_no = t.allc_alloc_line_no
    WHERE t.allc_ouinstid IS NULL;
    
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_alloc_item_detail_hist
    (
        allc_ouinstid, allc_doc_no, allc_doc_ou, allc_doc_line_no, allc_alloc_line_no, allc_order_no, allc_order_line_no, allc_order_sch_no, allc_item_code, allc_wh_no, allc_zone_no, allc_bin_no, allc_lot_no, allc_batch_no, allc_serial_no, allc_su, allc_su_serial_no, allc_su_type, allc_thu_id, allc_tran_qty, allc_allocated_qty, allc_mas_uom, allc_created_date, allc_modified_date, allc_created_by, allc_modified_by, allc_tolerance_qty, allc_thu_serial_no, allc_inpro_stage, allc_staging_id_crosdk, allc_inpro_stk_serial_line_no, allc_inpro_stk_line_no, allc_stock_status, allc_box_thu_id, allc_box_no, allc_su_serial_no2, allc_su2, etlcreateddatetime
    )
    SELECT
        allc_ouinstid, allc_doc_no, allc_doc_ou, allc_doc_line_no, allc_alloc_line_no, allc_order_no, allc_order_line_no, allc_order_sch_no, allc_item_code, allc_wh_no, allc_zone_no, allc_bin_no, allc_lot_no, allc_batch_no, allc_serial_no, allc_su, allc_su_serial_no, allc_su_type, allc_thu_id, allc_tran_qty, allc_allocated_qty, allc_mas_uom, allc_created_date, allc_modified_date, allc_created_by, allc_modified_by, allc_tolerance_qty, allc_thu_serial_no, allc_inpro_stage, allc_staging_id_crosdk, allc_inpro_stk_serial_line_no, allc_inpro_stk_line_no, allc_stock_status, allc_box_thu_id, allc_box_no, allc_su_serial_no2, allc_su2, etlcreateddatetime
    FROM stg.stg_wms_alloc_item_detail_hist;
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
ALTER PROCEDURE dwh.usp_f_allocitemdetailshistory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
