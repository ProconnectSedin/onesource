CREATE PROCEDURE dwh.usp_f_internalorderheader(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_internal_order_hdr;

    UPDATE dwh.F_InternalOrderHeader t
    SET
        in_ord_hdr_loc_key				= COALESCE(l.loc_key,-1),
		in_ord_hdr_customer_key			= COALESCE(c.customer_key,-1),
        in_ord_date                     = s.wms_in_ord_date,
        in_ord_ref_doc_typ              = s.wms_in_ord_ref_doc_typ,
        in_ord_customer_id              = s.wms_in_ord_customer_id,
        in_ord_pri_ref_doc_typ          = s.wms_in_ord_pri_ref_doc_typ,
        in_ord_pri_ref_doc_no           = s.wms_in_ord_pri_ref_doc_no,
        in_ord_pri_ref_doc_date         = s.wms_in_ord_pri_ref_doc_date,
        in_ord_status                   = s.wms_in_ord_status,
        in_ord_amendno                  = s.wms_in_ord_amendno,
        in_ord_timestamp                = s.wms_in_ord_timestamp,
        in_ord_userdefined1             = s.wms_in_ord_userdefined1,
        in_ord_userdefined2             = s.wms_in_ord_userdefined2,
        in_ord_userdefined3             = s.wms_in_ord_userdefined3,
        in_createdby                    = s.wms_in_createdby,
        in_created_date                 = s.wms_in_created_date,
        in_modifiedby                   = s.wms_in_modifiedby,
        in_modified_date                = s.wms_in_modified_date,
        in_ord_contract_id              = s.wms_in_ord_contract_id,
        in_ord_contract_amend_no        = s.wms_in_ord_contract_amend_no,
        in_ord_wf_status                = s.wms_in_ord_wf_status,
        in_ord_reasonforreturn          = s.wms_in_ord_reasonforreturn,
        in_ord_stk_acc_level            = s.wms_in_ord_stk_acc_level,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_wms_internal_order_hdr s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_in_ord_location 		= l.loc_code 
		AND s.wms_in_ord_ou 			= l.loc_ou 
	LEFT JOIN dwh.d_customer c 		
		ON  s.wms_in_ord_customer_id 	= c.customer_id 
		AND s.wms_in_ord_ou 			= c.customer_ou 
    WHERE 	t.in_ord_location 			= s.wms_in_ord_location
    AND 	t.in_ord_no 				= s.wms_in_ord_no
    AND 	t.in_ord_ou 				= s.wms_in_ord_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_InternalOrderHeader
    (
		in_ord_hdr_loc_key, in_ord_hdr_customer_key,
        in_ord_location, in_ord_no, in_ord_ou, in_ord_date, in_ord_ref_doc_typ, in_ord_customer_id, in_ord_pri_ref_doc_typ, in_ord_pri_ref_doc_no, in_ord_pri_ref_doc_date, in_ord_status, in_ord_amendno, in_ord_timestamp, in_ord_userdefined1, in_ord_userdefined2, in_ord_userdefined3, in_createdby, in_created_date, in_modifiedby, in_modified_date, in_ord_contract_id, in_ord_contract_amend_no, in_ord_wf_status, in_ord_reasonforreturn, in_ord_stk_acc_level, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1), COALESCE(c.customer_key,-1),
		s.wms_in_ord_location, s.wms_in_ord_no, s.wms_in_ord_ou, s.wms_in_ord_date, s.wms_in_ord_ref_doc_typ, s.wms_in_ord_customer_id, s.wms_in_ord_pri_ref_doc_typ, s.wms_in_ord_pri_ref_doc_no, s.wms_in_ord_pri_ref_doc_date, s.wms_in_ord_status, s.wms_in_ord_amendno, s.wms_in_ord_timestamp, s.wms_in_ord_userdefined1, s.wms_in_ord_userdefined2, s.wms_in_ord_userdefined3, s.wms_in_createdby, s.wms_in_created_date, s.wms_in_modifiedby, s.wms_in_modified_date, s.wms_in_ord_contract_id, s.wms_in_ord_contract_amend_no, s.wms_in_ord_wf_status, s.wms_in_ord_reasonforreturn, s.wms_in_ord_stk_acc_level, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_internal_order_hdr s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_in_ord_location 		= l.loc_code 
		AND s.wms_in_ord_ou 			= l.loc_ou 
	LEFT JOIN dwh.d_customer c 		
		ON  s.wms_in_ord_customer_id 	= c.customer_id 
		AND s.wms_in_ord_ou 			= c.customer_ou 
    LEFT JOIN dwh.F_InternalOrderHeader t
    ON 		s.wms_in_ord_location 		= t.in_ord_location
    AND 	s.wms_in_ord_no 			= t.in_ord_no
    AND 	s.wms_in_ord_ou 			= t.in_ord_ou
    WHERE t.in_ord_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_internal_order_hdr
    (
        wms_in_ord_location, wms_in_ord_no, wms_in_ord_ou, wms_in_ord_date, wms_in_ord_ref_doc_typ, wms_in_ord_customer_id, wms_in_ord_pri_ref_doc_typ, wms_in_ord_pri_ref_doc_no, wms_in_ord_pri_ref_doc_date, wms_in_ord_sec_ref_doc_typ, wms_in_ord_sec_ref_doc_no, wms_in_ord_sec_ref_doc_date, wms_in_ord_status, wms_in_ord_amendno, wms_in_ord_timestamp, wms_in_ord_userdefined1, wms_in_ord_userdefined2, wms_in_ord_userdefined3, wms_in_createdby, wms_in_created_date, wms_in_modifiedby, wms_in_modified_date, wms_in_ord_contract_id, wms_in_ord_contract_amend_no, wms_in_ordprfee_bil_status, wms_in_ord_wf_status, wms_in_ord_reasonforreturn, wms_in_ord_stk_acc_level, wms_in_chporcn_sell_bil_status, etlcreateddatetime
    )
    SELECT
        wms_in_ord_location, wms_in_ord_no, wms_in_ord_ou, wms_in_ord_date, wms_in_ord_ref_doc_typ, wms_in_ord_customer_id, wms_in_ord_pri_ref_doc_typ, wms_in_ord_pri_ref_doc_no, wms_in_ord_pri_ref_doc_date, wms_in_ord_sec_ref_doc_typ, wms_in_ord_sec_ref_doc_no, wms_in_ord_sec_ref_doc_date, wms_in_ord_status, wms_in_ord_amendno, wms_in_ord_timestamp, wms_in_ord_userdefined1, wms_in_ord_userdefined2, wms_in_ord_userdefined3, wms_in_createdby, wms_in_created_date, wms_in_modifiedby, wms_in_modified_date, wms_in_ord_contract_id, wms_in_ord_contract_amend_no, wms_in_ordprfee_bil_status, wms_in_ord_wf_status, wms_in_ord_reasonforreturn, wms_in_ord_stk_acc_level, wms_in_chporcn_sell_bil_status, etlcreateddatetime
    FROM stg.stg_wms_internal_order_hdr;
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