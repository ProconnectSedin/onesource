-- PROCEDURE: dwh.usp_f_pogritemdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_pogritemdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_pogritemdetail(
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
    FROM stg.stg_wms_gr_po_item_dtl;

    UPDATE dwh.F_POGRItemDetail t
    SET
		gr_pln_key =  oh.gr_pln_key,
        gr_po_loc_key    = COALESCE(l.loc_key,-1),
        gr_loc_code                     = s.wms_gr_loc_code,
        gr_pln_no                       = s.wms_gr_pln_no,
        gr_pln_ou                       = s.wms_gr_pln_ou,
        gr_lineno                       = s.wms_gr_lineno,
        gr_po_no                        = s.wms_gr_po_no,
        gr_po_sno                       = s.wms_gr_po_sno,
        gr_item                         = s.wms_gr_item,
        gr_item_desc                    = s.wms_gr_item_desc,
        gr_qty                          = s.wms_gr_qty,
        gr_mas_uom                      = s.wms_gr_mas_uom,
        gr_asn_line_no                  = s.wms_gr_asn_line_no,
        gr_asn_srl_no                   = s.wms_gr_asn_srl_no,
        gr_asn_cust_sl_no               = s.wms_gr_asn_cust_sl_no,
        gr_asn_ref_doc_no1              = s.wms_gr_asn_ref_doc_no1,
        gr_asn_outboundorder_qty        = s.wms_gr_asn_outboundorder_qty,
        gr_asn_remarks                  = s.wms_gr_asn_remarks,
        gr_fully_executed               = s.wms_gr_fully_executed,
        gr_asn_stock_status             = s.wms_gr_asn_stock_status,
        gr_product_status               = s.wms_gr_product_status,
        gr_coo                          = s.wms_gr_coo,
        gr_item_attribute1              = s.wms_gr_item_attribute1,
        gr_item_attribute2              = s.wms_gr_item_attribute2,
        gr_item_attribute3              = s.wms_gr_item_attribute3,
        gr_item_attribute7              = s.wms_gr_item_attribute7,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_wms_gr_po_item_dtl s
    INNER JOIN dwh.f_grplandetail oh
	
     ON  s.wms_gr_loc_code = oh.gr_loc_code   
     and s.wms_gr_pln_no =  oh.gr_pln_no
     and s.wms_gr_pln_ou = oh.gr_pln_ou 

      LEFT JOIN dwh.d_location L        
        ON s.wms_gr_loc_code     = L.loc_code 
        AND s.wms_gr_pln_ou        = L.loc_ou

    WHERE t.gr_loc_code = s.wms_gr_loc_code
    AND t.gr_pln_no = s.wms_gr_pln_no
    AND t.gr_pln_ou = s.wms_gr_pln_ou
    AND t.gr_lineno = s.wms_gr_lineno
    AND t.gr_pln_key =  oh.gr_pln_key;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_POGRItemDetail
    (
       gr_pln_key,gr_po_loc_key ,gr_loc_code, gr_pln_no, gr_pln_ou, gr_lineno, gr_po_no, gr_po_sno, gr_item, gr_item_desc, gr_qty, gr_mas_uom, gr_asn_line_no, gr_asn_srl_no, gr_asn_cust_sl_no, gr_asn_ref_doc_no1, gr_asn_outboundorder_qty, gr_asn_remarks, gr_fully_executed, gr_asn_stock_status, gr_product_status, gr_coo, gr_item_attribute1, gr_item_attribute2, gr_item_attribute3, gr_item_attribute7, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
       oh.gr_pln_key,COALESCE(l.loc_key,-1),s.wms_gr_loc_code, s.wms_gr_pln_no, s.wms_gr_pln_ou, s.wms_gr_lineno, s.wms_gr_po_no, s.wms_gr_po_sno, s.wms_gr_item, s.wms_gr_item_desc, s.wms_gr_qty, s.wms_gr_mas_uom, s.wms_gr_asn_line_no, s.wms_gr_asn_srl_no, s.wms_gr_asn_cust_sl_no, s.wms_gr_asn_ref_doc_no1, s.wms_gr_asn_outboundorder_qty, s.wms_gr_asn_remarks, s.wms_gr_fully_executed, s.wms_gr_asn_stock_status, s.wms_gr_product_status, s.wms_gr_coo, s.wms_gr_item_attribute1, s.wms_gr_item_attribute2, s.wms_gr_item_attribute3, s.wms_gr_item_attribute7, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_gr_po_item_dtl s
	INNER JOIN dwh.f_grplandetail oh
	
     ON  s.wms_gr_loc_code = oh.gr_loc_code   
     and s.wms_gr_pln_no =  oh.gr_pln_no
     and s.wms_gr_pln_ou = oh.gr_pln_ou 

     LEFT JOIN dwh.d_location L        
        ON s.wms_gr_loc_code     = L.loc_code 
        AND s.wms_gr_pln_ou        = L.loc_ou

    LEFT JOIN dwh.F_POGRItemDetail t
	
	
    ON   t.gr_loc_code   = s.wms_gr_loc_code
    AND  t.gr_pln_no  = s.wms_gr_pln_no
    AND  t.gr_pln_ou  = s.wms_gr_pln_ou
    AND  t.gr_lineno  = s.wms_gr_lineno
	    AND t.gr_pln_key =  oh.gr_pln_key

    WHERE t.gr_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_gr_po_item_dtl
    (
        wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou, wms_gr_lineno, wms_gr_po_no, wms_gr_po_sno, wms_gr_item, wms_gr_item_desc, wms_gr_qty, wms_gr_mas_uom, wms_gr_asn_line_no, wms_gr_asn_srl_no, wms_gr_asn_uid, wms_gr_asn_cust_sl_no, wms_gr_asn_ref_doc_no1, wms_gr_asn_consignee, wms_gr_asn_outboundorder_no, wms_gr_asn_outboundorder_qty, wms_gr_asn_outboundorder_lineno, wms_gr_asn_bestbeforedate, wms_gr_asn_remarks, wms_gr_fully_executed, wms_gr_asn_stock_status, wms_gr_inv_type, wms_gr_product_status, wms_gr_coo, wms_gr_item_attribute1, wms_gr_item_attribute2, wms_gr_item_attribute3, wms_gr_item_attribute4, wms_gr_item_attribute5, wms_gr_item_attribute6, wms_gr_item_attribute7, wms_gr_item_attribute8, wms_gr_item_attribute9, wms_gr_item_attribute10, etlcreateddatetime
    )
    SELECT
        wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou, wms_gr_lineno, wms_gr_po_no, wms_gr_po_sno, wms_gr_item, wms_gr_item_desc, wms_gr_qty, wms_gr_mas_uom, wms_gr_asn_line_no, wms_gr_asn_srl_no, wms_gr_asn_uid, wms_gr_asn_cust_sl_no, wms_gr_asn_ref_doc_no1, wms_gr_asn_consignee, wms_gr_asn_outboundorder_no, wms_gr_asn_outboundorder_qty, wms_gr_asn_outboundorder_lineno, wms_gr_asn_bestbeforedate, wms_gr_asn_remarks, wms_gr_fully_executed, wms_gr_asn_stock_status, wms_gr_inv_type, wms_gr_product_status, wms_gr_coo, wms_gr_item_attribute1, wms_gr_item_attribute2, wms_gr_item_attribute3, wms_gr_item_attribute4, wms_gr_item_attribute5, wms_gr_item_attribute6, wms_gr_item_attribute7, wms_gr_item_attribute8, wms_gr_item_attribute9, wms_gr_item_attribute10, etlcreateddatetime
    FROM stg.stg_wms_gr_po_item_dtl;
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
ALTER PROCEDURE dwh.usp_f_pogritemdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
