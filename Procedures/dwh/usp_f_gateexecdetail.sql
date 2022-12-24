CREATE OR REPLACE PROCEDURE dwh.usp_f_gateexecdetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
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
    FROM stg.stg_wms_gate_exec_dtl;

    UPDATE dwh.f_gateexecdetail t
    SET
		gate_exec_dtl_loc_key	  = COALESCE(l.loc_key,-1),
		gate_exec_dtl_veh_key	  = COALESCE(v.veh_key,-1),
		gate_exec_dtl_eqp_key	  = COALESCE(eq.eqp_key,-1),
		gate_exec_dtl_emp_hdr_key = COALESCE(e.emp_hdr_key,-1),
        gate_pln_no               = s.wms_gate_pln_no,
        gate_pln_ou               = s.wms_gate_pln_ou,
        gate_exec_date            = s.wms_gate_exec_date,
        gate_exec_status          = s.wms_gate_exec_status,
        gate_exec_gateno          = s.wms_gate_exec_gateno,
        gate_purpose              = s.wms_gate_purpose,
        gate_flag                 = s.wms_gate_flag,
        gate_actual_date          = s.wms_gate_actual_date,
        gate_ser_provider         = s.wms_gate_ser_provider,
        gate_person               = s.wms_gate_person,
        gate_veh_type             = s.wms_gate_veh_type,
        gate_vehicle_no           = s.wms_gate_vehicle_no,
        gate_equip_type           = s.wms_gate_equip_type,
        gate_equip_no             = s.wms_gate_equip_no,
        gate_ref_doc_typ1         = s.wms_gate_ref_doc_typ1,
        gate_ref_doc_no1          = s.wms_gate_ref_doc_no1,
        gate_ref_doc_typ2         = s.wms_gate_ref_doc_typ2,
        gate_ref_doc_no2          = s.wms_gate_ref_doc_no2,
        gate_ref_doc_typ3         = s.wms_gate_ref_doc_typ3,
        gate_ref_doc_no3          = s.wms_gate_ref_doc_no3,
        gate_instructions         = s.wms_gate_instructions,
        gate_employee             = s.wms_gate_employee,
        gate_created_by           = s.wms_gate_created_by,
        gate_created_date         = s.wms_gate_created_date,
        gate_timestamp            = s.wms_gate_timestamp,
        gate_userdefined1         = s.wms_gate_userdefined1,
        gate_gatein_no            = s.wms_gate_gatein_no,
        gate_customer_name        = s.wms_gate_customer_name,
        gate_vendor_name          = s.wms_gate_vendor_name,
        gate_from                 = s.wms_gate_from,
        gate_to                   = s.wms_gate_to,
        gate_noofunits            = s.wms_gate_noofunits,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_wms_gate_exec_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_gate_loc_code 	= l.loc_code 
		AND s.wms_gate_exec_ou 		= l.loc_ou 
	LEFT JOIN dwh.d_vehicle v 			
		ON  s.wms_gate_vehicle_no 	= v.veh_id
		AND s.wms_gate_exec_ou 		= v.veh_ou 
	LEFT JOIN dwh.d_equipment eq 		
		ON  s.wms_gate_equip_no		= eq.eqp_equipment_id 
		AND s.wms_gate_exec_ou 		= eq.eqp_ou  	
	LEFT JOIN dwh.d_employeeheader e 		
		ON  s.wms_gate_employee		= e.emp_employee_code 
		AND s.wms_gate_exec_ou 		= e.emp_ou 
    WHERE 	t.gate_loc_code 	 = s.wms_gate_loc_code
    AND 	t.gate_exec_no 		 = s.wms_gate_exec_no
    AND 	t.gate_exec_ou 		 = s.wms_gate_exec_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_gateexecdetail
    (
        gate_exec_dtl_loc_key,	gate_exec_dtl_veh_key,	gate_exec_dtl_eqp_key,	gate_exec_dtl_emp_hdr_key,
		gate_loc_code, 			gate_pln_no, 			gate_pln_ou, 			gate_exec_no, 				gate_exec_ou, 
		gate_exec_date, 		gate_exec_status, 		gate_exec_gateno, 		gate_purpose, 				gate_flag, 
		gate_actual_date, 		gate_ser_provider, 		gate_person, 			gate_veh_type, 				gate_vehicle_no, 
		gate_equip_type, 		gate_equip_no, 			gate_ref_doc_typ1, 		gate_ref_doc_no1, 			gate_ref_doc_typ2, 
		gate_ref_doc_no2, 		gate_ref_doc_typ3, 		gate_ref_doc_no3, 		gate_instructions, 			gate_employee, 
		gate_created_by, 		gate_created_date, 		gate_timestamp, 		gate_userdefined1, 			gate_gatein_no, 
		gate_customer_name, 	gate_vendor_name, 		gate_from, 				gate_to, 					gate_noofunits, 
		etlactiveind, 			etljobname, 			envsourcecd, 			datasourcecd, 				etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1),		COALESCE(v.veh_key,-1),		COALESCE(eq.eqp_key,-1),	COALESCE(e.emp_hdr_key,-1),
		s.wms_gate_loc_code, 		s.wms_gate_pln_no, 			s.wms_gate_pln_ou, 			s.wms_gate_exec_no, 		s.wms_gate_exec_ou, 
		s.wms_gate_exec_date, 		s.wms_gate_exec_status, 	s.wms_gate_exec_gateno, 	s.wms_gate_purpose, 		s.wms_gate_flag, 
		s.wms_gate_actual_date, 	s.wms_gate_ser_provider, 	s.wms_gate_person, 			s.wms_gate_veh_type, 		s.wms_gate_vehicle_no, 
		s.wms_gate_equip_type, 		s.wms_gate_equip_no, 		s.wms_gate_ref_doc_typ1, 	s.wms_gate_ref_doc_no1, 	s.wms_gate_ref_doc_typ2, 
		s.wms_gate_ref_doc_no2, 	s.wms_gate_ref_doc_typ3, 	s.wms_gate_ref_doc_no3, 	s.wms_gate_instructions, 	s.wms_gate_employee, 
		s.wms_gate_created_by, 		s.wms_gate_created_date, 	s.wms_gate_timestamp, 		s.wms_gate_userdefined1, 	s.wms_gate_gatein_no, 
		s.wms_gate_customer_name, 	s.wms_gate_vendor_name, 	s.wms_gate_from, 			s.wms_gate_to, 				s.wms_gate_noofunits, 
		1,	 						p_etljobname, 				p_envsourcecd, 				p_datasourcecd, 			NOW()
    FROM stg.stg_wms_gate_exec_dtl s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_gate_loc_code 	= l.loc_code 
		AND s.wms_gate_exec_ou 		= l.loc_ou 
	LEFT JOIN dwh.d_vehicle v 			
		ON  s.wms_gate_vehicle_no 	= v.veh_id
		AND s.wms_gate_exec_ou 		= v.veh_ou 
	LEFT JOIN dwh.d_equipment eq 		
		ON  s.wms_gate_equip_no		= eq.eqp_equipment_id 
		AND s.wms_gate_exec_ou 		= eq.eqp_ou  	
	LEFT JOIN dwh.d_employeeheader e 		
		ON  s.wms_gate_employee		= e.emp_employee_code 
		AND s.wms_gate_exec_ou 		= e.emp_ou 
    LEFT JOIN dwh.f_gateexecdetail t
		ON 	s.wms_gate_loc_code 	= t.gate_loc_code
		AND s.wms_gate_exec_no 		= t.gate_exec_no
		AND s.wms_gate_exec_ou 		= t.gate_exec_ou
    WHERE t.gate_exec_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_gate_exec_dtl
    (
        wms_gate_loc_code, 		wms_gate_pln_no, 		wms_gate_pln_ou, 		wms_gate_exec_no, 				wms_gate_exec_ou, 
		wms_gate_exec_date, 	wms_gate_exec_status, 	wms_gate_exec_gateno, 	wms_gate_purpose, 				wms_gate_flag, 
		wms_gate_actual_date, 	wms_gate_ser_provider, 	wms_gate_person, 		wms_gate_veh_type, 				wms_gate_vehicle_no, 
		wms_gate_equip_type, 	wms_gate_equip_no, 		wms_gate_ref_doc_typ1, 	wms_gate_ref_doc_no1, 			wms_gate_ref_doc_typ2, 
		wms_gate_ref_doc_no2, 	wms_gate_ref_doc_typ3, 	wms_gate_ref_doc_no3, 	wms_gate_instructions, 			wms_gate_employee, 
		wms_gate_created_by, 	wms_gate_created_date, 	wms_gate_modified_by, 	wms_gate_modified_date, 		wms_gate_timestamp, 
		wms_gate_userdefined1, 	wms_gate_userdefined2, 	wms_gate_userdefined3, 	wms_gate_contwait_bil_status, 	wms_gate_bil_value, 
		wms_gate_gatein_no, 	wms_gate_customer_name, wms_gate_vendor_name, 	wms_gate_from, 					wms_gate_to, 
		wms_gate_noofunits, 	etlcreateddatetime
    )
    SELECT
        wms_gate_loc_code, 		wms_gate_pln_no, 		wms_gate_pln_ou, 		wms_gate_exec_no, 				wms_gate_exec_ou, 
		wms_gate_exec_date, 	wms_gate_exec_status, 	wms_gate_exec_gateno, 	wms_gate_purpose, 				wms_gate_flag, 
		wms_gate_actual_date, 	wms_gate_ser_provider, 	wms_gate_person, 		wms_gate_veh_type, 				wms_gate_vehicle_no, 
		wms_gate_equip_type, 	wms_gate_equip_no, 		wms_gate_ref_doc_typ1, 	wms_gate_ref_doc_no1, 			wms_gate_ref_doc_typ2, 
		wms_gate_ref_doc_no2, 	wms_gate_ref_doc_typ3, 	wms_gate_ref_doc_no3, 	wms_gate_instructions, 			wms_gate_employee, 
		wms_gate_created_by, 	wms_gate_created_date, 	wms_gate_modified_by, 	wms_gate_modified_date, 		wms_gate_timestamp, 
		wms_gate_userdefined1, 	wms_gate_userdefined2, 	wms_gate_userdefined3, 	wms_gate_contwait_bil_status, 	wms_gate_bil_value, 
		wms_gate_gatein_no, 	wms_gate_customer_name, wms_gate_vendor_name, 	wms_gate_from, 					wms_gate_to, 
		wms_gate_noofunits, 	etlcreateddatetime
    FROM stg.stg_wms_gate_exec_dtl;
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
$$;