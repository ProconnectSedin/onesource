-- PROCEDURE: dwh.usp_f_dispatchdocthuserialdetailweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_dispatchdocthuserialdetailweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_dispatchdocthuserialdetailweekly(
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
    FROM stg.stg_tms_ddtcd_dispatch_document_thu_serial_dtl;

    UPDATE dwh.F_DispatchDocThuSerialDetail t
    SET
		ddtd_key			  			  = fh.ddtd_key,
		ddtsd_ouinstance                = s.ddtsd_ouinstance,
        ddtsd_dispatch_doc_no             = s.ddtsd_dispatch_doc_no,
        ddtsd_thu_line_no                 = s.ddtsd_thu_line_no,
        ddtsd_thu_serial_line_no          = s.ddtsd_thu_serial_line_no,
        ddtsd_thu_serial_no               = s.ddtsd_thu_serial_no,
        ddtsd_thu_seal_no                 = s.ddtsd_thu_seal_no,
        ddtsd_UN_code                     = s.ddtsd_UN_code,
        ddtsd_class_code                  = s.ddtsd_class_code,
        ddtsd_hs_code                     = s.ddtsd_hs_code,
        ddtsd_hazmat_code                 = s.ddtsd_hazmat_code,
        ddtsd_HAC_code                    = s.ddtsd_HAC_code,
        ddtsd_length                      = s.ddtsd_length,
        ddtsd_breadth                     = s.ddtsd_breadth,
        ddtsd_height                      = s.ddtsd_height,
        ddtsd_lbh_uom                     = s.ddtsd_lbh_uom,
        ddtsd_gross_weight                = s.ddtsd_gross_weight,
        ddtsd_gross_weight_uom            = s.ddtsd_gross_weight_uom,
        ddtsd_created_by                  = s.ddtsd_created_by,
        ddtsd_created_date                = s.ddtsd_created_date,
        ddtsd_last_modified_by            = s.ddtsd_last_modified_by,
        ddtsd_lst_modified_date           = s.ddtsd_lst_modified_date,
        ddtsd_timestamp                   = s.ddtsd_timestamp,
        ddtsd_AltQty                      = s.ddtsd_AltQty,
        ddtsd_AltQty_Uom                  = s.ddtsd_AltQty_Uom,
        ddtsd_Customs_SealNo              = s.ddtsd_Customs_SealNo,
        ddtsd_Container_Type_Specs        = s.ddtsd_Container_Type_Specs,
        ddtsd_Container_Size_Specs        = s.ddtsd_Container_Size_Specs,
        ddtsd_customer_serial_no          = s.ddtsd_customer_serial_no,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_tms_ddtcd_dispatch_document_thu_serial_dtl s
	INNER JOIN 	dwh.f_dispatchdocthudetail fh 
			ON  s.ddtsd_ouinstance 			= fh.ddtd_ouinstance
            AND S.ddtsd_dispatch_doc_no      = fh.ddtd_dispatch_doc_no
			And s.ddtsd_thu_line_no			= fh.ddtd_thu_line_no
    WHERE 		t.ddtsd_ouinstance			= s.ddtsd_ouinstance
	AND 		t.ddtsd_dispatch_doc_no 	= s.ddtsd_dispatch_doc_no
    AND 		t.ddtsd_thu_line_no 		= s.ddtsd_thu_line_no
    AND 		t.ddtsd_thu_serial_line_no 	= s.ddtsd_thu_serial_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DispatchDocThuSerialDetail
    (
        ddtd_key,
        ddtsd_ouinstance,ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_thu_serial_line_no, ddtsd_thu_serial_no, ddtsd_thu_seal_no, ddtsd_UN_code, ddtsd_class_code, ddtsd_hs_code, ddtsd_hazmat_code, ddtsd_HAC_code, ddtsd_length, ddtsd_breadth, ddtsd_height, ddtsd_lbh_uom, ddtsd_gross_weight, ddtsd_gross_weight_uom, ddtsd_created_by, ddtsd_created_date, ddtsd_last_modified_by, ddtsd_lst_modified_date, ddtsd_timestamp, ddtsd_AltQty, ddtsd_AltQty_Uom, ddtsd_Customs_SealNo, ddtsd_Container_Type_Specs, ddtsd_Container_Size_Specs, ddtsd_customer_serial_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.ddtd_key,
        s.ddtsd_ouinstance,s.ddtsd_dispatch_doc_no, s.ddtsd_thu_line_no, s.ddtsd_thu_serial_line_no, s.ddtsd_thu_serial_no, s.ddtsd_thu_seal_no, s.ddtsd_UN_code, s.ddtsd_class_code, s.ddtsd_hs_code, s.ddtsd_hazmat_code, s.ddtsd_HAC_code, s.ddtsd_length, s.ddtsd_breadth, s.ddtsd_height, s.ddtsd_lbh_uom, s.ddtsd_gross_weight, s.ddtsd_gross_weight_uom, s.ddtsd_created_by, s.ddtsd_created_date, s.ddtsd_last_modified_by, s.ddtsd_lst_modified_date, s.ddtsd_timestamp, s.ddtsd_AltQty, s.ddtsd_AltQty_Uom, s.ddtsd_Customs_SealNo, s.ddtsd_Container_Type_Specs, s.ddtsd_Container_Size_Specs, s.ddtsd_customer_serial_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_ddtcd_dispatch_document_thu_serial_dtl s
	INNER JOIN 	dwh.f_dispatchdocthudetail fh 
			ON  s.ddtsd_ouinstance 			= fh.ddtd_ouinstance
            AND S.ddtsd_dispatch_doc_no      = fh.ddtd_dispatch_doc_no
			And s.ddtsd_thu_line_no			= fh.ddtd_thu_line_no
    LEFT JOIN dwh.F_DispatchDocThuSerialDetail t
    ON  s.ddtsd_ouinstance			= t.ddtsd_ouinstance
	AND s.ddtsd_dispatch_doc_no = t.ddtsd_dispatch_doc_no
    AND s.ddtsd_thu_line_no = t.ddtsd_thu_line_no
    AND s.ddtsd_thu_serial_line_no = t.ddtsd_thu_serial_line_no
    WHERE t.ddtsd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	UPDATE dwh.F_DispatchDocThuSerialDetail t1
	 SET etlactiveind =  0,
     etlupdatedatetime = Now()::timestamp
     FROM dwh.F_DispatchDocThuSerialDetail t
	left join  stg.stg_tms_ddtcd_dispatch_document_thu_serial_dtl s
	 ON  s.ddtsd_ouinstance			= t.ddtsd_ouinstance
	AND s.ddtsd_dispatch_doc_no = t.ddtsd_dispatch_doc_no
    AND s.ddtsd_thu_line_no = t.ddtsd_thu_line_no
    AND s.ddtsd_thu_serial_line_no = t.ddtsd_thu_serial_line_no
	where t.ddtsd_key= t1.ddtsd_key
	AND   COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
	and 	s.ddtsd_ouinstance IS NULL;
	
	
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_ddtcd_dispatch_document_thu_serial_dtl
    (
        ddtsd_ouinstance,ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_thu_serial_line_no, ddtsd_thu_serial_no, ddtsd_thu_seal_no, ddtsd_UN_code, ddtsd_class_code, ddtsd_hs_code, ddtsd_hazmat_code, ddtsd_HAC_code, ddtsd_length, ddtsd_breadth, ddtsd_height, ddtsd_lbh_uom, ddtsd_gross_weight, ddtsd_gross_weight_uom, ddtsd_created_by, ddtsd_created_date, ddtsd_last_modified_by, ddtsd_lst_modified_date, ddtsd_timestamp, ddtsd_AltQty, ddtsd_AltQty_Uom, ddtsd_Customs_SealNo, ddtsd_Container_Type_Specs, ddtsd_Container_Size_Specs, ddtsd_customer_serial_no, etlcreateddatetime
    )
    SELECT
        ddtsd_ouinstance,ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_thu_serial_line_no, ddtsd_thu_serial_no, ddtsd_thu_seal_no, ddtsd_UN_code, ddtsd_class_code, ddtsd_hs_code, ddtsd_hazmat_code, ddtsd_HAC_code, ddtsd_length, ddtsd_breadth, ddtsd_height, ddtsd_lbh_uom, ddtsd_gross_weight, ddtsd_gross_weight_uom, ddtsd_created_by, ddtsd_created_date, ddtsd_last_modified_by, ddtsd_lst_modified_date, ddtsd_timestamp, ddtsd_AltQty, ddtsd_AltQty_Uom, ddtsd_Customs_SealNo, ddtsd_Container_Type_Specs, ddtsd_Container_Size_Specs, ddtsd_customer_serial_no, etlcreateddatetime
    FROM stg.stg_tms_ddtcd_dispatch_document_thu_serial_dtl;
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
ALTER PROCEDURE dwh.usp_f_dispatchdocthuserialdetailweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
