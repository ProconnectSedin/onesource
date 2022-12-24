-- PROCEDURE: dwh.usp_f_inbounditemamenddetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_inbounditemamenddetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_inbounditemamenddetail(
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
    FROM stg.stg_wms_inbound_item_detail_h;

    UPDATE dwh.F_InboundItemAmendDetail t
    SET 
        inb_amh_key              = oh.inb_amh_key,
        inb_loc_key              = COALESCE(l.loc_key,-1),
        inb_itm_key              = COALESCE(c.itm_hdr_key,-1),
        inb_item_code            = s.wms_inb_item_code,
        inb_order_qty            = s.wms_inb_order_qty,
        inb_alt_uom              = s.wms_inb_alt_uom,
        inb_sch_type             = s.wms_inb_sch_type,
        inb_receipt_date         = s.wms_inb_receipt_date,
        inb_item_inst            = s.wms_inb_item_inst,
        inb_supp_code            = s.wms_inb_supp_code,
        inb_balqty               = s.wms_inb_balqty,
        inb_linestatus           = s.wms_inb_linestatus,
        inb_recdqty              = s.wms_inb_recdqty,
        inb_accpdqty             = s.wms_inb_accpdqty,
        inb_itm_grrejdqty        = s.wms_inb_itm_grrejdqty,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_wms_inbound_item_detail_h s	
	INNER JOIN dwh.f_inboundamendheader oh
    ON  s.wms_inb_loc_code = oh.inb_loc_code 
	and s.wms_inb_orderno =oh.inb_orderno 
	and s.wms_inb_ou = oh.inb_ou 
	and s.wms_inb_amendno =oh.inb_amendno

LEFT JOIN dwh.d_itemheader C        
        ON s.wms_inb_item_code       = C.itm_code 
        AND s.wms_inb_ou      = C.itm_ou

LEFT JOIN dwh.d_location L      
        ON s.wms_inb_loc_code   = L.loc_code 
        AND s.wms_inb_ou        = L.loc_ou

    WHERE t.inb_loc_code = s.wms_inb_loc_code
    AND t.inb_orderno = s.wms_inb_orderno
    AND t.inb_lineno = s.wms_inb_lineno
    AND t.inb_ou = s.wms_inb_ou
    AND t.inb_amendno = s.wms_inb_amendno     
	AND t.inb_amh_key  = oh.inb_amh_key;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_InboundItemAmendDetail
    (
       inb_amh_key, inb_itm_key ,
        inb_loc_key ,inb_loc_code, inb_orderno, inb_lineno, inb_ou, inb_amendno, inb_item_code, inb_order_qty, inb_alt_uom, inb_sch_type, inb_receipt_date, inb_item_inst, inb_supp_code, inb_balqty, inb_linestatus, inb_recdqty, inb_accpdqty, inb_itm_grrejdqty, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        

         oh.inb_amh_key,COALESCE(c.itm_hdr_key,-1),COALESCE(l.loc_key,-1),
        s.wms_inb_loc_code, s.wms_inb_orderno, s.wms_inb_lineno, s.wms_inb_ou, s.wms_inb_amendno, s.wms_inb_item_code, s.wms_inb_order_qty, s.wms_inb_alt_uom, s.wms_inb_sch_type, s.wms_inb_receipt_date, s.wms_inb_item_inst, s.wms_inb_supp_code, s.wms_inb_balqty, s.wms_inb_linestatus, s.wms_inb_recdqty, s.wms_inb_accpdqty, s.wms_inb_itm_grrejdqty, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_inbound_item_detail_h s
	
	INNER JOIN dwh.f_inboundamendheader oh
   ON   s.wms_inb_loc_code = oh.inb_loc_code 
	and s.wms_inb_orderno =oh.inb_orderno 
	and s.wms_inb_ou = oh.inb_ou 
	and s.wms_inb_amendno =oh.inb_amendno

    
    LEFT JOIN dwh.d_itemheader C        
        ON s.wms_inb_item_code       = C.itm_code 
        AND s.wms_inb_ou      = C.itm_ou

    LEFT JOIN dwh.d_location L      
        ON s.wms_inb_loc_code   = L.loc_code 
        AND s.wms_inb_ou        = L.loc_ou

    LEFT JOIN dwh.F_InboundItemAmendDetail t
    ON s.wms_inb_loc_code = t.inb_loc_code
    AND s.wms_inb_orderno = t.inb_orderno
    AND s.wms_inb_lineno = t.inb_lineno
    AND s.wms_inb_ou = t.inb_ou
    AND s.wms_inb_amendno = t.inb_amendno
		AND t.inb_amh_key  = oh.inb_amh_key

    WHERE t.inb_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_inbound_item_detail_h
    (
        wms_inb_loc_code, wms_inb_orderno, wms_inb_lineno, wms_inb_ou, wms_inb_amendno, wms_inb_item_code, wms_inb_order_qty, wms_inb_alt_uom, wms_inb_sch_type, wms_inb_receipt_date, wms_inb_item_inst, wms_inb_supp_code, wms_inb_addressid, wms_inb_balqty, wms_inb_linestatus, wms_inb_recdqty, wms_inb_accpdqty, wms_inb_returnedqty, wms_inb_itm_grrejdqty, wms_inb_itm_grmovdqty, wms_inb_operation_status, wms_inb_cust_item_code, wms_inb_master_uom_qty, etlcreateddatetime
    )
    SELECT
        wms_inb_loc_code, wms_inb_orderno, wms_inb_lineno, wms_inb_ou, wms_inb_amendno, wms_inb_item_code, wms_inb_order_qty, wms_inb_alt_uom, wms_inb_sch_type, wms_inb_receipt_date, wms_inb_item_inst, wms_inb_supp_code, wms_inb_addressid, wms_inb_balqty, wms_inb_linestatus, wms_inb_recdqty, wms_inb_accpdqty, wms_inb_returnedqty, wms_inb_itm_grrejdqty, wms_inb_itm_grmovdqty, wms_inb_operation_status, wms_inb_cust_item_code, wms_inb_master_uom_qty, etlcreateddatetime
    FROM stg.stg_wms_inbound_item_detail_h;
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
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_inbounditemamenddetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
