-- PROCEDURE: dwh.usp_f_dispatchdocthudetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_dispatchdocthudetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_dispatchdocthudetail(
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
    FROM stg.stg_tms_ddtd_dispatch_document_thu_dtl;

    UPDATE dwh.F_DispatchDocThuDetail t
    SET
		ddh_key			  			  	= fh.ddh_key,
        ddh_thu_key	  					= COALESCE(th.thu_key,-1),
        ddtd_ouinstance                = s.ddtd_ouinstance,
        ddtd_dispatch_doc_no           = s.ddtd_dispatch_doc_no,
        ddtd_thu_line_no               = s.ddtd_thu_line_no,
        ddtd_thu_id                    = s.ddtd_thu_id,
        ddtd_thu_qty                   = s.ddtd_thu_qty,
        ddtd_class_stores              = s.ddtd_class_stores,
        ddtd_thu_desc                  = s.ddtd_thu_desc,
        ddtd_thu_vol                   = s.ddtd_thu_vol,
        ddtd_thu_vol_uom               = s.ddtd_thu_vol_uom,
        ddtd_thu_weight                = s.ddtd_thu_weight,
        ddtd_thu_weight_uom            = s.ddtd_thu_weight_uom,
        ddtd_created_by                = s.ddtd_created_by,
        ddtd_created_date              = s.ddtd_created_date,
        ddtd_last_modified_by          = s.ddtd_last_modified_by,
        ddtd_lst_modified_date         = s.ddtd_lst_modified_date,
        ddtd_timestamp                 = s.ddtd_timestamp,
        ddtd_transfer_type             = s.ddtd_transfer_type,
        ddtd_remarks                   = s.ddtd_remarks,
        ddtd_vendor_thu_id             = s.ddtd_vendor_thu_id,
        ddtd_transfer_doc_no           = s.ddtd_transfer_doc_no,
        ddtd_vendor_ac_no              = s.ddtd_vendor_ac_no,
        ddtd_damaged_qty               = s.ddtd_damaged_qty,
        ddtd_billing_status            = s.ddtd_billing_status,
        ddtd_no_of_pallet_space        = s.ddtd_no_of_pallet_space,
        ddtd_height                    = s.ddtd_height,
        ddtd_Commodityid               = s.ddtd_Commodityid,
        ddtd_Commodity_QTY             = s.ddtd_Commodity_QTY,
        ddtd_Qty_UOM                   = s.ddtd_Qty_UOM,
        ddtd_thu_qty_uom               = s.ddtd_thu_qty_uom,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_tms_ddtd_dispatch_document_thu_dtl s
	INNER JOIN 	dwh.f_dispatchdocheader fh 
			ON  s.ddtd_ouinstance 			= fh.ddh_ouinstance
            AND s.ddtd_dispatch_doc_no      = fh.ddh_dispatch_doc_no
	LEFT JOIN dwh.d_thu th 			
-- 			ON 	s.ddtd_thu_id 			    = th.thu_id
-- 			AND s.ddtd_ouinstance        	= th.thu_ou
		    ON 	s.ddtd_ouinstance        	= th.thu_ou
			AND s.ddtd_thu_id 			    = th.thu_id
    WHERE 		t.ddtd_ouinstance 			= s.ddtd_ouinstance
    AND 		t.ddtd_dispatch_doc_no 		= s.ddtd_dispatch_doc_no
    AND 		t.ddtd_thu_line_no 			= s.ddtd_thu_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DispatchDocThuDetail
    (
		ddh_key, ddh_thu_key,
        ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no, ddtd_thu_id, ddtd_thu_qty, ddtd_class_stores, ddtd_thu_desc, ddtd_thu_vol, ddtd_thu_vol_uom, ddtd_thu_weight, ddtd_thu_weight_uom, ddtd_created_by, ddtd_created_date, ddtd_last_modified_by, ddtd_lst_modified_date, ddtd_timestamp, ddtd_transfer_type, ddtd_remarks, ddtd_vendor_thu_id, ddtd_transfer_doc_no, ddtd_vendor_ac_no, ddtd_damaged_qty, ddtd_billing_status, ddtd_no_of_pallet_space, ddtd_height, ddtd_Commodityid, ddtd_Commodity_QTY, ddtd_Qty_UOM, ddtd_thu_qty_uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		fh.ddh_key, COALESCE(th.thu_key,-1),
        s.ddtd_ouinstance, s.ddtd_dispatch_doc_no, s.ddtd_thu_line_no, s.ddtd_thu_id, s.ddtd_thu_qty, s.ddtd_class_stores, s.ddtd_thu_desc, s.ddtd_thu_vol, s.ddtd_thu_vol_uom, s.ddtd_thu_weight, s.ddtd_thu_weight_uom, s.ddtd_created_by, s.ddtd_created_date, s.ddtd_last_modified_by, s.ddtd_lst_modified_date, s.ddtd_timestamp, s.ddtd_transfer_type, s.ddtd_remarks, s.ddtd_vendor_thu_id, s.ddtd_transfer_doc_no, s.ddtd_vendor_ac_no, s.ddtd_damaged_qty, s.ddtd_billing_status, s.ddtd_no_of_pallet_space, s.ddtd_height, s.ddtd_Commodityid, s.ddtd_Commodity_QTY, s.ddtd_Qty_UOM, s.ddtd_thu_qty_uom, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_ddtd_dispatch_document_thu_dtl s
	INNER JOIN 	dwh.f_dispatchdocheader fh 
			ON  s.ddtd_ouinstance 			= fh.ddh_ouinstance
            AND s.ddtd_dispatch_doc_no      = fh.ddh_dispatch_doc_no
	LEFT JOIN dwh.d_thu th 			
-- 			ON 	s.ddtd_thu_id 			    = th.thu_id
-- 			AND s.ddtd_ouinstance        	= th.thu_ou
			ON 	s.ddtd_ouinstance        	= th.thu_ou
			AND s.ddtd_thu_id 			    = th.thu_id
    LEFT JOIN dwh.F_DispatchDocThuDetail t
    ON 			s.ddtd_ouinstance 			= t.ddtd_ouinstance
    AND 		s.ddtd_dispatch_doc_no 		= t.ddtd_dispatch_doc_no
    AND 		s.ddtd_thu_line_no 			= t.ddtd_thu_line_no
    WHERE t.ddtd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_ddtd_dispatch_document_thu_dtl
    (
        ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no, ddtd_thu_id, ddtd_thu_qty, ddtd_class_stores, ddtd_thu_desc, ddtd_thu_vol, ddtd_thu_vol_uom, ddtd_thu_weight, ddtd_thu_weight_uom, ddtd_created_by, ddtd_created_date, ddtd_last_modified_by, ddtd_lst_modified_date, ddtd_timestamp, ddtd_transfer_type, ddtd_remarks, ddtd_vendor_thu_id, ddtd_transfer_doc_no, ddtd_vendor_ac_no, ddtd_damaged_qty, ddtd_billing_status, ddtd_no_of_pallet_space, ddtd_height, ddtd_Commodityid, ddtd_Commodity_QTY, ddtd_Qty_UOM, ddtd_thu_qty_uom, etlcreateddatetime
    )
    SELECT
        ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no, ddtd_thu_id, ddtd_thu_qty, ddtd_class_stores, ddtd_thu_desc, ddtd_thu_vol, ddtd_thu_vol_uom, ddtd_thu_weight, ddtd_thu_weight_uom, ddtd_created_by, ddtd_created_date, ddtd_last_modified_by, ddtd_lst_modified_date, ddtd_timestamp, ddtd_transfer_type, ddtd_remarks, ddtd_vendor_thu_id, ddtd_transfer_doc_no, ddtd_vendor_ac_no, ddtd_damaged_qty, ddtd_billing_status, ddtd_no_of_pallet_space, ddtd_height, ddtd_Commodityid, ddtd_Commodity_QTY, ddtd_Qty_UOM, ddtd_thu_qty_uom, etlcreateddatetime
    FROM stg.stg_tms_ddtd_dispatch_document_thu_dtl;
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
ALTER PROCEDURE dwh.usp_f_dispatchdocthudetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
