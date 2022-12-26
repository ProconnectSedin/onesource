-- PROCEDURE: dwh.usp_f_stockuiditemtrackingdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_stockuiditemtrackingdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_stockuiditemtrackingdetail(
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
        ON d.sourceid 				= h.sourceid
    WHERE d.sourceid 				= p_sourceId
        AND d.dataflowflag 			= p_dataflowflag
        AND d.targetobject 			= p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_stock_uid_item_tracking_dtl;

    UPDATE dwh.f_stockuiditemtrackingdetail t
    SET
        stk_itm_dtl_loc_key             = COALESCE(l.loc_key,-1),
		stk_itm_dtl_itm_hdr_key			= COALESCE(i.itm_hdr_key,-1),
        stk_itm_dtl_customer_key        = COALESCE(c.customer_key,-1),
        stk_itm_dtl_date_key            = COALESCE(d.datekey,-1),
        stk_itm_dtl_thu_key             = COALESCE(th.thu_key,-1),	
        stk_su                   		= s.wms_stk_su,
        stk_thu_id               		= s.wms_stk_thu_id,
        stk_thu_serial_no        		= s.wms_stk_thu_serial_no,
        stk_opn_bal              		= s.wms_stk_opn_bal,
        stk_received             		= s.wms_stk_received,
        stk_issued               		= s.wms_stk_issued,
        stk_cls_bal              		= s.wms_stk_cls_bal,
        stk_write_off_qty        		= s.wms_stk_write_off_qty,
        etlactiveind             		= 1,
        etljobname               		= p_etljobname,
        envsourcecd              		= p_envsourcecd,
        datasourcecd             		= p_datasourcecd,
        etlupdatedatetime        		= NOW()
    FROM stg.stg_wms_stock_uid_item_tracking_dtl s
	LEFT JOIN dwh.d_location l
		ON  s.wms_stk_location			= l.loc_code
		AND s.wms_stk_ou				= l.loc_ou
	LEFT JOIN dwh.d_itemheader i	
		ON  s.wms_stk_item				= i.itm_code
		AND s.wms_stk_ou				= i.itm_ou	
	LEFT JOIN dwh.d_customer c	
		ON  s.wms_stk_customer			= c.customer_id
		AND s.wms_stk_ou				= c.customer_ou	
	LEFT JOIN dwh.d_date d	
		ON  s.wms_stk_date::DATE		= d.dateactual
	LEFT JOIN dwh.d_thu th	
		ON  s.wms_stk_thu_id			= th.thu_id
		AND s.wms_stk_ou				= th.thu_ou		
    WHERE   t.stk_ou 					= s.wms_stk_ou
		AND t.stk_location 				= s.wms_stk_location
		AND t.stk_item 					= s.wms_stk_item
		AND t.stk_customer 				= s.wms_stk_customer
		AND t.stk_date 					= s.wms_stk_date
		AND t.stk_uid_serial_no 		= s.wms_stk_uid_serial_no
		AND t.stk_lot_no 				= s.wms_stk_lot_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_stockuiditemtrackingdetail
    (
        stk_itm_dtl_loc_key		, stk_itm_dtl_itm_hdr_key		, stk_itm_dtl_customer_key		, stk_itm_dtl_date_key, 
		stk_itm_dtl_thu_key		, stk_ou						, stk_location					, stk_item, 
		stk_customer			, stk_date						, stk_uid_serial_no				, stk_lot_no, 
		stk_su					, stk_thu_id					, stk_thu_serial_no				, stk_opn_bal, 
		stk_received			, stk_issued					, stk_cls_bal					, stk_write_off_qty, 
		etlactiveind			, etljobname					, envsourcecd					, datasourcecd				, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1)	, COALESCE(i.itm_hdr_key,-1)	, COALESCE(c.customer_key,-1)	, COALESCE(d.datekey,-1), 
		COALESCE(th.thu_key,-1)	, s.wms_stk_ou					, s.wms_stk_location			, s.wms_stk_item, 
		s.wms_stk_customer		, s.wms_stk_date				, s.wms_stk_uid_serial_no		, s.wms_stk_lot_no, 
		s.wms_stk_su			, s.wms_stk_thu_id				, s.wms_stk_thu_serial_no		, s.wms_stk_opn_bal, 
		s.wms_stk_received		, s.wms_stk_issued				, s.wms_stk_cls_bal				, s.wms_stk_write_off_qty, 
		1						, p_etljobname					, p_envsourcecd					, p_datasourcecd			, NOW()
    FROM stg.stg_wms_stock_uid_item_tracking_dtl s
	LEFT JOIN dwh.d_location l
		ON  s.wms_stk_location			= l.loc_code
		AND s.wms_stk_ou				= l.loc_ou
	LEFT JOIN dwh.d_itemheader i	
		ON  s.wms_stk_item				= i.itm_code
		AND s.wms_stk_ou				= i.itm_ou	
	LEFT JOIN dwh.d_customer c	
		ON  s.wms_stk_customer			= c.customer_id
		AND s.wms_stk_ou				= c.customer_ou	
	LEFT JOIN dwh.d_date d	
		ON  s.wms_stk_date::DATE		= d.dateactual
	LEFT JOIN dwh.d_thu th	
		ON  s.wms_stk_thu_id			= th.thu_id
		AND s.wms_stk_ou				= th.thu_ou		
    LEFT JOIN dwh.f_stockuiditemtrackingdetail t
		ON  s.wms_stk_ou 				= t.stk_ou
		AND s.wms_stk_location 			= t.stk_location
		AND s.wms_stk_item 				= t.stk_item
		AND s.wms_stk_customer 			= t.stk_customer
		AND s.wms_stk_date 				= t.stk_date
		AND s.wms_stk_uid_serial_no 	= t.stk_uid_serial_no
		AND s.wms_stk_lot_no 			= t.stk_lot_no
    WHERE   t.stk_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_stock_uid_item_tracking_dtl
    (
        wms_stk_ou		, wms_stk_location		, wms_stk_item			, wms_stk_customer, 
		wms_stk_date	, wms_stk_uid_serial_no	, wms_stk_lot_no		, wms_stk_su, 
		wms_stk_thu_id	, wms_stk_thu_serial_no	, wms_stk_opn_bal		, wms_stk_received, 
		wms_stk_issued	, wms_stk_cls_bal		, wms_stk_write_off_qty	, wms_UID2SerialNo, 
		wms_SU2			, etlcreateddatetime
    )
    SELECT
        wms_stk_ou		, wms_stk_location		, wms_stk_item			, wms_stk_customer, 
		wms_stk_date	, wms_stk_uid_serial_no	, wms_stk_lot_no		, wms_stk_su, 
		wms_stk_thu_id	, wms_stk_thu_serial_no	, wms_stk_opn_bal		, wms_stk_received, 
		wms_stk_issued	, wms_stk_cls_bal		, wms_stk_write_off_qty	, wms_UID2SerialNo, 
		wms_SU2			, etlcreateddatetime
	FROM stg.stg_wms_stock_uid_item_tracking_dtl;
    END IF;

    EXCEPTION WHEN others THEN
    GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_stockuiditemtrackingdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
