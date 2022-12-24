-- PROCEDURE: dwh.usp_f_grplandetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grplandetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grplandetail(
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

    SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d 
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE   d.sourceid      = p_sourceId 
        AND d.dataflowflag  = p_dataflowflag
        AND d.targetobject  = p_targetobject;

    SELECT COUNT(*) INTO srccnt
    FROM stg.stg_wms_gr_plan_dtl;

    UPDATE dwh.F_GRPlanDetail t
    SET

        gr_loc_key        = COALESCE(l.loc_key,-1),
        gr_date_key       = COALESCE(d.datekey,-1),
		gr_emp_key		= COALESCE(e.emp_hdr_key,-1),
        gr_pln_date = s.wms_gr_pln_date,
        gr_pln_status = s.wms_gr_pln_status,
        gr_po_no = s.wms_gr_po_no,
        gr_po_date = s.wms_gr_po_date,
        gr_asn_no = s.wms_gr_asn_no,
        gr_asn_date = s.wms_gr_asn_date,
        gr_employee = s.wms_gr_employee,
        gr_remarks = s.wms_gr_remarks,
        gr_timestamp = s.wms_gr_timestamp,
        gr_source_stage = s.wms_gr_source_stage,
        gr_source_docno = s.wms_gr_source_docno,
        gr_created_by = s.wms_gr_created_by,
        gr_created_date = s.wms_gr_created_date,
        gr_modified_by = s.wms_gr_modified_by,
        gr_modified_date = s.wms_gr_modified_date,
        gr_staging_id = s.wms_gr_staging_id,
        gr_build_uid = s.wms_gr_build_uid,
        gr_notype = s.wms_gr_notype,
        gr_ref_type = s.wms_gr_ref_type,
        gr_pln_product_status = s.wms_gr_pln_product_status,
        gr_pln_coo = s.wms_gr_pln_coo,
        gr_pln_item_attribute1 = s.wms_gr_pln_item_attribute1,
        gr_pln_item_attribute2 = s.wms_gr_pln_item_attribute2,
        gr_pln_item_attribute3 = s.wms_gr_pln_item_attribute3,
        etlactiveind = 1,
        etljobname = p_etljobname,
        envsourcecd = p_envsourcecd ,
        datasourcecd = p_datasourcecd ,
        etlupdatedatetime = NOW()    
    FROM stg.stg_wms_gr_plan_dtl s

    LEFT JOIN dwh.d_location L      
        ON s.wms_gr_loc_code   = L.loc_code 
        AND s.wms_gr_pln_ou        = L.loc_ou
    LEFT JOIN dwh.d_date D          
        ON s.wms_gr_asn_date::date = D.dateactual
	LEFT JOIN dwh.d_employeeheader e 		
		ON  s.wms_gr_employee  	= e.emp_employee_code 
        AND s.wms_gr_pln_ou        	= e.emp_ou	

    WHERE t.gr_loc_code = s.wms_gr_loc_code
    AND t.gr_pln_no = s.wms_gr_pln_no
    AND t.gr_pln_ou = s.wms_gr_pln_ou;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_GRPlanDetail 
    (
        gr_loc_key,
        gr_date_key,gr_emp_key,gr_loc_code, gr_pln_no, gr_pln_ou, gr_pln_date, gr_pln_status, gr_po_no, gr_po_date, gr_asn_no, gr_asn_date, gr_employee, gr_remarks, gr_timestamp, gr_source_stage, gr_source_docno, gr_created_by, gr_created_date, gr_modified_by, gr_modified_date, gr_staging_id, gr_build_uid, gr_notype, gr_ref_type, gr_pln_product_status, gr_pln_coo, gr_pln_item_attribute1, gr_pln_item_attribute2, gr_pln_item_attribute3, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )
    
    SELECT
        COALESCE(l.loc_key,-1),
        COALESCE(d.datekey,-1), COALESCE(e.emp_hdr_key,-1),s.wms_gr_loc_code, s.wms_gr_pln_no, s.wms_gr_pln_ou, s.wms_gr_pln_date, s.wms_gr_pln_status, s.wms_gr_po_no, s.wms_gr_po_date, s.wms_gr_asn_no, s.wms_gr_asn_date, s.wms_gr_employee, s.wms_gr_remarks, s.wms_gr_timestamp, s.wms_gr_source_stage, s.wms_gr_source_docno, s.wms_gr_created_by, s.wms_gr_created_date, s.wms_gr_modified_by, s.wms_gr_modified_date, s.wms_gr_staging_id, s.wms_gr_build_uid, s.wms_gr_notype, s.wms_gr_ref_type, s.wms_gr_pln_product_status, s.wms_gr_pln_coo, s.wms_gr_pln_item_attribute1, s.wms_gr_pln_item_attribute2, s.wms_gr_pln_item_attribute3, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_gr_plan_dtl s

    LEFT JOIN dwh.d_location L      
        ON s.wms_gr_loc_code   = L.loc_code 
        AND s.wms_gr_pln_ou        = L.loc_ou
    LEFT JOIN dwh.d_date D          
        ON s.wms_gr_asn_date::date = D.dateactual
		
	LEFT JOIN dwh.d_employeeheader e 		
		ON  s.wms_gr_employee  	= e.emp_employee_code 
        AND s.wms_gr_pln_ou        	= e.emp_ou

    LEFT JOIN dwh.F_GRPlanDetail t
    ON   t.gr_loc_code  = s.wms_gr_loc_code 
    AND  t.gr_pln_no = s.wms_gr_pln_no 
    AND  t.gr_pln_ou = s.wms_gr_pln_ou 
    WHERE t.gr_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN
    
    INSERT INTO raw.raw_wms_gr_plan_dtl
    (   
        wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou, wms_gr_pln_date, wms_gr_pln_status, wms_gr_po_no, wms_gr_po_date, wms_gr_asn_no, wms_gr_asn_date, wms_gr_employee, wms_gr_remarks, wms_gr_timestamp, wms_gr_source_stage, wms_gr_source_docno, wms_gr_created_by, wms_gr_created_date, wms_gr_modified_by, wms_gr_modified_date, wms_gr_userdefined1, wms_gr_userdefined2, wms_gr_userdefined3, wms_gr_staging_id, wms_gr_build_uid, wms_gr_notype, wms_gr_notype_prefix, wms_gr_ref_type, wms_gr_employeename, wms_gr_refdocno, wms_gr_remark, wms_gr_customerserialno, wms_gr_pln_inv_type, wms_gr_pln_product_status, wms_gr_pln_coo, wms_gr_pln_item_attribute1, wms_gr_pln_item_attribute2, wms_gr_pln_item_attribute3, wms_gr_pln_item_attribute4, wms_gr_pln_item_attribute5, wms_gr_pln_item_attribute10, wms_gr_pln_item_attribute6, wms_gr_stag_id, wms_gr_pln_item_attribute7, wms_gr_pln_item_attribute8, wms_gr_pln_item_attribute9,etlcreateddatetime
    )
    SELECT 
        wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou, wms_gr_pln_date, wms_gr_pln_status, wms_gr_po_no, wms_gr_po_date, wms_gr_asn_no, wms_gr_asn_date, wms_gr_employee, wms_gr_remarks, wms_gr_timestamp, wms_gr_source_stage, wms_gr_source_docno, wms_gr_created_by, wms_gr_created_date, wms_gr_modified_by, wms_gr_modified_date, wms_gr_userdefined1, wms_gr_userdefined2, wms_gr_userdefined3, wms_gr_staging_id, wms_gr_build_uid, wms_gr_notype, wms_gr_notype_prefix, wms_gr_ref_type, wms_gr_employeename, wms_gr_refdocno, wms_gr_remark, wms_gr_customerserialno, wms_gr_pln_inv_type, wms_gr_pln_product_status, wms_gr_pln_coo, wms_gr_pln_item_attribute1, wms_gr_pln_item_attribute2, wms_gr_pln_item_attribute3, wms_gr_pln_item_attribute4, wms_gr_pln_item_attribute5, wms_gr_pln_item_attribute10, wms_gr_pln_item_attribute6, wms_gr_stag_id, wms_gr_pln_item_attribute7, wms_gr_pln_item_attribute8, wms_gr_pln_item_attribute9,etlcreateddatetime
    FROM stg.stg_wms_gr_plan_dtl;  
    END IF;

     EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);
    
        
       select 0 into inscnt;
       select 0 into updcnt;  
         
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_grplandetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
