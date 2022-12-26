-- PROCEDURE: dwh.usp_f_packplanheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_packplanheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_packplanheader(
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
    FROM stg.stg_wms_pack_plan_hdr;

    UPDATE dwh.F_PackPlanHeader t
    SET
		pack_pln_hdr_loc_key	  = COALESCE(l.loc_key,-1),
		pack_pln_hdr_date_key	  = COALESCE(d.datekey,-1),
		pack_pln_hdr_emp_hdr_key  = COALESCE(e.emp_hdr_key,-1),
        pack_pln_date             = s.wms_pack_pln_date,
        pack_pln_status           = s.wms_pack_pln_status,
        pack_employee             = s.wms_pack_employee,
        pack_packing_bay          = s.wms_pack_packing_bay,
        pack_source_stage         = s.wms_pack_source_stage,
        pack_source_docno         = s.wms_pack_source_docno,
        pack_created_by           = s.wms_pack_created_by,
        pack_created_date         = s.wms_pack_created_date,
        pack_modified_by          = s.wms_pack_modified_by,
        pack_modified_date        = s.wms_pack_modified_date,
        pack_timestamp            = s.wms_pack_timestamp,
        pack_userdefined1         = s.wms_pack_userdefined1,
        pack_userdefined2         = s.wms_pack_userdefined2,
        pack_userdefined3         = s.wms_pack_userdefined3,
        pack_pln_urgent           = s.wms_pack_pln_urgent,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_wms_pack_plan_hdr s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pack_loc_code 	 = l.loc_code 
        AND s.wms_pack_pln_ou        = l.loc_ou
	LEFT JOIN dwh.d_date d 			
		ON  s.wms_pack_pln_date::date= d.dateactual
	LEFT JOIN dwh.d_employeeheader e 		
		ON 	s.wms_pack_employee      = e.emp_employee_code 
        AND s.wms_pack_pln_ou        = e.emp_ou
    WHERE 	t.pack_loc_code 		 = s.wms_pack_loc_code
    AND 	t.pack_pln_no            = s.wms_pack_pln_no
    AND 	t.pack_pln_ou            = s.wms_pack_pln_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PackPlanHeader
    (
		pack_pln_hdr_loc_key,		pack_pln_hdr_date_key,			pack_pln_hdr_emp_hdr_key,
        pack_loc_code, 				pack_pln_no, 					pack_pln_ou, 					pack_pln_date, 			pack_pln_status, 
		pack_employee, 				pack_packing_bay, 				pack_source_stage, 				pack_source_docno, 		pack_created_by, 
		pack_created_date, 			pack_modified_by, 				pack_modified_date, 			pack_timestamp, 		pack_userdefined1, 
		pack_userdefined2, 			pack_userdefined3, 				pack_pln_urgent, 				etlactiveind, 			etljobname, 
		envsourcecd, 				datasourcecd, 					etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1),		COALESCE(d.datekey,-1),		 	COALESCE(e.emp_hdr_key,-1),
        s.wms_pack_loc_code, 		s.wms_pack_pln_no, 				s.wms_pack_pln_ou, 				s.wms_pack_pln_date, 			s.wms_pack_pln_status, 
		s.wms_pack_employee, 		s.wms_pack_packing_bay, 		s.wms_pack_source_stage, 		s.wms_pack_source_docno, 		s.wms_pack_created_by, 
		s.wms_pack_created_date, 	s.wms_pack_modified_by, 		s.wms_pack_modified_date, 		s.wms_pack_timestamp, 			s.wms_pack_userdefined1, 
		s.wms_pack_userdefined2, 	s.wms_pack_userdefined3, 		s.wms_pack_pln_urgent, 			1, 								p_etljobname, 
		p_envsourcecd, 				p_datasourcecd, 				NOW()
    FROM stg.stg_wms_pack_plan_hdr s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_pack_loc_code 	 = l.loc_code 
        AND s.wms_pack_pln_ou        = l.loc_ou
	LEFT JOIN dwh.d_date d 			
		ON  s.wms_pack_pln_date::date= d.dateactual
	LEFT JOIN dwh.d_employeeheader e 		
		ON 	s.wms_pack_employee      = e.emp_employee_code 
        AND s.wms_pack_pln_ou        = e.emp_ou
    LEFT JOIN dwh.F_PackPlanHeader t
    ON 		s.wms_pack_loc_code 	 = t.pack_loc_code
    AND 	s.wms_pack_pln_no 		 = t.pack_pln_no
    AND 	s.wms_pack_pln_ou 		 = t.pack_pln_ou
    WHERE 	t.pack_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pack_plan_hdr
    (
        wms_pack_loc_code, 		wms_pack_pln_no, 		wms_pack_pln_ou, 			wms_pack_pln_date, 			wms_pack_pln_status, 
		wms_pack_packed_as, 	wms_pack_employee, 		wms_pack_packing_bay, 		wms_pack_source_stage, 		wms_pack_source_docno, 
		wms_pack_created_by, 	wms_pack_created_date, 	wms_pack_modified_by, 		wms_pack_modified_date, 	wms_pack_timestamp, 
		wms_pack_userdefined1, 	wms_pack_userdefined2, 	wms_pack_userdefined3, 		wms_pack_pln_urgent, 		etlcreateddatetime
    )
    SELECT
        wms_pack_loc_code, 		wms_pack_pln_no, 		wms_pack_pln_ou, 			wms_pack_pln_date, 			wms_pack_pln_status, 
		wms_pack_packed_as, 	wms_pack_employee, 		wms_pack_packing_bay, 		wms_pack_source_stage, 		wms_pack_source_docno, 
		wms_pack_created_by, 	wms_pack_created_date, 	wms_pack_modified_by, 		wms_pack_modified_date, 	wms_pack_timestamp, 
		wms_pack_userdefined1, 	wms_pack_userdefined2, 	wms_pack_userdefined3, 		wms_pack_pln_urgent, 		etlcreateddatetime
    FROM stg.stg_wms_pack_plan_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_packplanheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
