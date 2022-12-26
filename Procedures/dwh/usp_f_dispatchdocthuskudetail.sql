-- PROCEDURE: dwh.usp_f_dispatchdocthuskudetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_dispatchdocthuskudetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_dispatchdocthuskudetail(
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
    FROM stg.stg_tms_ddtsd_dispatch_document_thu_sku_dtl;

    UPDATE dwh.F_DispatchDocThuSkuDetail t
    SET
		ddtd_key			  		 = fh.ddtd_key,
        ddtsd_serial_no              = s.ddtsd_serial_no,
        ddtsd_child_thu_id           = s.ddtsd_child_thu_id,
        ddtsd_child_serial_no        = s.ddtsd_child_serial_no,
        ddtsd_sku_line_no            = s.ddtsd_sku_line_no,
        ddtsd_sku_id                 = s.ddtsd_sku_id,
        ddtsd_sku_rate               = s.ddtsd_sku_rate,
        ddtsd_sku_quantity           = s.ddtsd_sku_quantity,
        ddtsd_sku_value              = s.ddtsd_sku_value,
        ddtsd_sku_batch_id           = s.ddtsd_sku_batch_id,
        ddtsd_sku_mfg_date           = s.ddtsd_sku_mfg_date,
        ddtsd_sku_expiry_date        = s.ddtsd_sku_expiry_date,
        ddtsd_created_by             = s.ddtsd_created_by,
        ddtsd_created_date           = s.ddtsd_created_date,
        ddtsd_modified_by            = s.ddtsd_modified_by,
        ddtsd_modified_date          = s.ddtsd_modified_date,
        ddtsd_timestamp              = s.ddtsd_timestamp,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_tms_ddtsd_dispatch_document_thu_sku_dtl s
	INNER JOIN 	dwh.f_dispatchdocthudetail fh 
			ON  s.ddtsd_ou 			        = fh.ddtd_ouinstance
            AND S.ddtsd_dispatch_doc_no     = fh.ddtd_dispatch_doc_no
			And s.ddtsd_thu_line_no			= fh.ddtd_thu_line_no
    WHERE 		t.ddtsd_ou 					= s.ddtsd_ou
    AND 		t.ddtsd_dispatch_doc_no 	= s.ddtsd_dispatch_doc_no
    AND 		t.ddtsd_thu_line_no 		= s.ddtsd_thu_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_DispatchDocThuSkuDetail
    (
		ddtd_key,
        ddtsd_ou, ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_serial_no, ddtsd_child_thu_id, ddtsd_child_serial_no, ddtsd_sku_line_no, ddtsd_sku_id, ddtsd_sku_rate, ddtsd_sku_quantity, ddtsd_sku_value, ddtsd_sku_batch_id, ddtsd_sku_mfg_date, ddtsd_sku_expiry_date, ddtsd_created_by, ddtsd_created_date, ddtsd_modified_by, ddtsd_modified_date, ddtsd_timestamp, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
		fh.ddtd_key,
        s.ddtsd_ou, s.ddtsd_dispatch_doc_no, s.ddtsd_thu_line_no, s.ddtsd_serial_no, s.ddtsd_child_thu_id, s.ddtsd_child_serial_no, s.ddtsd_sku_line_no, s.ddtsd_sku_id, s.ddtsd_sku_rate, s.ddtsd_sku_quantity, s.ddtsd_sku_value, s.ddtsd_sku_batch_id, s.ddtsd_sku_mfg_date, s.ddtsd_sku_expiry_date, s.ddtsd_created_by, s.ddtsd_created_date, s.ddtsd_modified_by, s.ddtsd_modified_date, s.ddtsd_timestamp, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_ddtsd_dispatch_document_thu_sku_dtl s
	INNER JOIN 	dwh.f_dispatchdocthudetail fh 
			ON  s.ddtsd_ou 			        = fh.ddtd_ouinstance
            AND S.ddtsd_dispatch_doc_no     = fh.ddtd_dispatch_doc_no
			And s.ddtsd_thu_line_no			= fh.ddtd_thu_line_no
    LEFT JOIN dwh.F_DispatchDocThuSkuDetail t
    ON 			s.ddtsd_ou 					= t.ddtsd_ou
    AND 		s.ddtsd_dispatch_doc_no 	= t.ddtsd_dispatch_doc_no
    AND 		s.ddtsd_thu_line_no 		= t.ddtsd_thu_line_no
    WHERE t.ddtsd_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_ddtsd_dispatch_document_thu_sku_dtl
    (
        ddtsd_ou, ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_serial_no, ddtsd_child_thu_id, ddtsd_child_serial_no, ddtsd_sku_line_no, ddtsd_sku_id, ddtsd_sku_rate, ddtsd_sku_quantity, ddtsd_sku_value, ddtsd_sku_batch_id, ddtsd_sku_mfg_date, ddtsd_sku_expiry_date, ddtsd_created_by, ddtsd_created_date, ddtsd_modified_by, ddtsd_modified_date, ddtsd_timestamp, etlcreateddatetime
    )
    SELECT
        ddtsd_ou, ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_serial_no, ddtsd_child_thu_id, ddtsd_child_serial_no, ddtsd_sku_line_no, ddtsd_sku_id, ddtsd_sku_rate, ddtsd_sku_quantity, ddtsd_sku_value, ddtsd_sku_batch_id, ddtsd_sku_mfg_date, ddtsd_sku_expiry_date, ddtsd_created_by, ddtsd_created_date, ddtsd_modified_by, ddtsd_modified_date, ddtsd_timestamp, etlcreateddatetime
    FROM stg.stg_tms_ddtsd_dispatch_document_thu_sku_dtl;
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
ALTER PROCEDURE dwh.usp_f_dispatchdocthuskudetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
