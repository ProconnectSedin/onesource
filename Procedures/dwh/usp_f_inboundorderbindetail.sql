-- PROCEDURE: dwh.usp_f_inboundorderbindetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_inboundorderbindetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_inboundorderbindetail(
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
    FROM stg.stg_wms_int_ord_bin_dtl;

    UPDATE dwh.F_InboundOrderBinDetail t
    SET
	    in_ord_hdr_key   = oh.in_ord_hdr_key,
        inb_loc_key             =   COALESCE(l.loc_key,-1),
        in_ord_item              = s.wms_in_ord_item,
        in_ord_bin_qty           = s.wms_in_ord_bin_qty,
        in_ord_source_bin        = s.wms_in_ord_source_bin,
        in_ord_target_bin        = s.wms_in_ord_target_bin,
        etlactiveind             = 1,
        etljobname               = p_etljobname,
        envsourcecd              = p_envsourcecd,
        datasourcecd             = p_datasourcecd,
        etlupdatedatetime        = NOW()
    FROM stg.stg_wms_int_ord_bin_dtl s
	INNER JOIN dwh.f_internalorderheader oh
    ON  s.wms_in_ord_location = oh.in_ord_location  
    and s.wms_in_ord_no =oh.in_ord_no
    and s.wms_in_ord_ou = oh.in_ord_ou
	
LEFT JOIN dwh.d_location L      
        ON s.wms_in_ord_location   = L.loc_code 
        AND s.wms_in_ord_ou        = L.loc_ou

    WHERE t.in_ord_location = s.wms_in_ord_location
    AND t.in_ord_no = s.wms_in_ord_no
    AND t.in_ord_lineno = s.wms_in_ord_lineno
    AND t.in_ord_ou = s.wms_in_ord_ou
	AND t.in_ord_hdr_key   = oh.in_ord_hdr_key;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_InboundOrderBinDetail
    (
        in_ord_hdr_key ,inb_loc_key ,in_ord_location, in_ord_no, in_ord_lineno, in_ord_ou, in_ord_item, in_ord_bin_qty, in_ord_source_bin, in_ord_target_bin, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        oh.in_ord_hdr_key, COALESCE(l.loc_key,-1),s.wms_in_ord_location, s.wms_in_ord_no, s.wms_in_ord_lineno, s.wms_in_ord_ou, s.wms_in_ord_item, s.wms_in_ord_bin_qty, s.wms_in_ord_source_bin, s.wms_in_ord_target_bin, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_int_ord_bin_dtl s
	INNER JOIN dwh.f_internalorderheader oh
    ON  s.wms_in_ord_location = oh.in_ord_location  
    and s.wms_in_ord_no =oh.in_ord_no
    and s.wms_in_ord_ou = oh.in_ord_ou

    LEFT JOIN dwh.d_location L      
        ON s.wms_in_ord_location   = L.loc_code 
        AND s.wms_in_ord_ou        = L.loc_ou

    LEFT JOIN dwh.F_InboundOrderBinDetail t
    ON s.wms_in_ord_location = t.in_ord_location
    AND s.wms_in_ord_no = t.in_ord_no
    AND s.wms_in_ord_lineno = t.in_ord_lineno
    AND s.wms_in_ord_ou = t.in_ord_ou
	AND  t.in_ord_hdr_key   = oh.in_ord_hdr_key

    WHERE t.in_ord_location IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_int_ord_bin_dtl
    (
        wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou, wms_in_ord_item, wms_in_ord_bin_qty, wms_in_ord_source_bin, wms_in_ord_target_bin, wms_in_ord_customer_item_code, etlcreateddatetime
    )
    SELECT
        wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou, wms_in_ord_item, wms_in_ord_bin_qty, wms_in_ord_source_bin, wms_in_ord_target_bin, wms_in_ord_customer_item_code, etlcreateddatetime
    FROM stg.stg_wms_int_ord_bin_dtl;
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
ALTER PROCEDURE dwh.usp_f_inboundorderbindetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
