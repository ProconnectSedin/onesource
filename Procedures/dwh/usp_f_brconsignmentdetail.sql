-- PROCEDURE: dwh.usp_f_brconsignmentdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_brconsignmentdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_brconsignmentdetail(
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
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag, h.depsource
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag, p_depsource
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
    FROM stg.stg_tms_brcd_consgt_details;

    UPDATE dwh.F_BRConsignmentDetail t
    SET
		br_key							  = fh.br_key,
		brcd_thu_key			  		  = COALESCE(th.thu_key,-1),
		brcd_curr_key			  		  = COALESCE(c.curr_key,-1),
        cd_thu_id                         = s.cd_thu_id,
        cd_thu_qty                        = s.cd_thu_qty,
        cd_thu_qty_uom                    = s.cd_thu_qty_uom,
        cd_declared_value_of_goods        = s.cd_declared_value_of_goods,
        cd_insurance_value                = s.cd_insurance_value,
        cd_currency                       = s.cd_currency,
        cd_class_of_stores                = s.cd_class_of_stores,
        cd_volume                         = s.cd_volume,
        cd_volume_uom                     = s.cd_volume_uom,
        cd_gross_weight                   = s.cd_gross_weight,
        cd_weight_uom                     = s.cd_weight_uom,
        cd_creation_date                  = s.cd_creation_date,
        cd_created_by                     = s.cd_created_by,
        cd_last_modified_date             = s.cd_last_modified_date,
        cd_last_modified_by               = s.cd_last_modified_by,
        cd_unique_id                      = s.cd_unique_id,
        cd_no_of_pallet_space             = s.cd_no_of_pallet_space,
        cd_transfer_to                    = s.cd_transfer_to,
        cd_commoditycode                  = s.cd_commoditycode,
        cd_commodityuom                   = s.cd_commodityuom,
        cd_net_weight                     = s.cd_net_weight,
        cd_shipper_invoice_value          = s.cd_shipper_invoice_value,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_tms_brcd_consgt_details s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.cd_ouinstance 			= fh.br_ouinstance
            AND S.cd_br_id                 	= fh.br_request_Id
	LEFT JOIN dwh.d_thu th 			
			ON 	s.cd_thu_id 			    = th.thu_id
			AND s.cd_ouinstance        	    = th.thu_ou
	LEFT JOIN dwh.d_currency c 			
			ON 	s.cd_currency 			    = c.iso_curr_code
    WHERE 		t.cd_ouinstance 			= s.cd_ouinstance
    AND 		t.cd_br_id 					= s.cd_br_id
    AND 		t.cd_line_no 				= s.cd_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_BRConsignmentDetail
    (
        br_key,brcd_thu_key,brcd_curr_key,
        cd_ouinstance, cd_br_id, cd_line_no, cd_thu_id, cd_thu_qty, cd_thu_qty_uom, cd_declared_value_of_goods, cd_insurance_value, cd_currency, cd_class_of_stores, cd_volume, cd_volume_uom, cd_gross_weight, cd_weight_uom, cd_creation_date, cd_created_by, cd_last_modified_date, cd_last_modified_by, cd_unique_id, cd_no_of_pallet_space, cd_transfer_to, cd_commoditycode, cd_commodityuom, cd_net_weight, cd_shipper_invoice_value, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.br_key,COALESCE(th.thu_key,-1),COALESCE(c.curr_key,-1),
        s.cd_ouinstance, s.cd_br_id, s.cd_line_no, s.cd_thu_id, s.cd_thu_qty, s.cd_thu_qty_uom, s.cd_declared_value_of_goods, s.cd_insurance_value, s.cd_currency, s.cd_class_of_stores, s.cd_volume, s.cd_volume_uom, s.cd_gross_weight, s.cd_weight_uom, s.cd_creation_date, s.cd_created_by, s.cd_last_modified_date, s.cd_last_modified_by, s.cd_unique_id, s.cd_no_of_pallet_space, s.cd_transfer_to, s.cd_commoditycode, s.cd_commodityuom, s.cd_net_weight, s.cd_shipper_invoice_value, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_brcd_consgt_details s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.cd_ouinstance 			= fh.br_ouinstance
            AND S.cd_br_id                 	= fh.br_request_Id
	LEFT JOIN dwh.d_thu th 			
			ON 	s.cd_thu_id 			    = th.thu_id
			AND s.cd_ouinstance        	    = th.thu_ou
	LEFT JOIN dwh.d_currency c 			
			ON 	s.cd_currency 			    = c.iso_curr_code
    LEFT JOIN dwh.F_BRConsignmentDetail t
    ON 			s.cd_ouinstance 			= t.cd_ouinstance
    AND 		s.cd_br_id 					= t.cd_br_id
    AND 		s.cd_line_no 				= t.cd_line_no
    WHERE 		t.cd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_brcd_consgt_details
    (
        cd_ouinstance, cd_br_id, cd_line_no, cd_thu_id, cd_thu_qty, cd_thu_qty_uom, cd_declared_value_of_goods, cd_insurance_value, cd_currency, cd_class_of_stores, cd_volume, cd_volume_uom, cd_gross_weight, cd_weight_uom, cd_creation_date, cd_created_by, cd_last_modified_date, cd_last_modified_by, cd_unique_id, cd_br_billing_status, cd_no_of_pallet_space, cd_added_for_equ_vehicle, cd_transfer_type, cd_transfer_to, cd_transfer_Account, cd_vendor_thu_id, cd_trans_doc_no, cd_vendor_ac_no, cd_commoditycode, cd_commodityqty, cd_commodityuom, cd_com_parent_line_id, cd_net_weight, cd_timestamp, cd_amount_collected, cd_shipper_invoice_no, cd_shipper_invoice_value, cd_shipper_invoice_date, etlcreateddatetime
    )
    SELECT
        cd_ouinstance, cd_br_id, cd_line_no, cd_thu_id, cd_thu_qty, cd_thu_qty_uom, cd_declared_value_of_goods, cd_insurance_value, cd_currency, cd_class_of_stores, cd_volume, cd_volume_uom, cd_gross_weight, cd_weight_uom, cd_creation_date, cd_created_by, cd_last_modified_date, cd_last_modified_by, cd_unique_id, cd_br_billing_status, cd_no_of_pallet_space, cd_added_for_equ_vehicle, cd_transfer_type, cd_transfer_to, cd_transfer_Account, cd_vendor_thu_id, cd_trans_doc_no, cd_vendor_ac_no, cd_commoditycode, cd_commodityqty, cd_commodityuom, cd_com_parent_line_id, cd_net_weight, cd_timestamp, cd_amount_collected, cd_shipper_invoice_no, cd_shipper_invoice_value, cd_shipper_invoice_date, etlcreateddatetime
    FROM stg.stg_tms_brcd_consgt_details;
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
ALTER PROCEDURE dwh.usp_f_brconsignmentdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
