-- PROCEDURE: dwh.usp_f_brconsignmentskudetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_brconsignmentskudetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_brconsignmentskudetail(
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
    FROM stg.stg_tms_brcsd_consgt_sku_details;

    UPDATE dwh.F_BRConsignmentSKUDetail t
    SET
	    br_key					  = fh.br_key,
        brcsd_serial_no           = s.brcsd_serial_no,
        brcsd_sku_id              = s.brcsd_sku_id,
        brcsd_sku_rate            = s.brcsd_sku_rate,
        brcsd_sku_quantity        = s.brcsd_sku_quantity,
        brcsd_sku_value           = s.brcsd_sku_value,
        brcsd_created_by          = s.brcsd_created_by,
        brcsd_created_date        = s.brcsd_created_date,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_tms_brcsd_consgt_sku_details s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.brcsd_ou 			= fh.br_ouinstance
            AND S.brcsd_br_id       = fh.br_request_Id
    WHERE t.brcsd_ou = s.brcsd_ou
    AND t.brcsd_br_id = s.brcsd_br_id
    AND t.brcsd_thu_line_no = s.brcsd_thu_line_no
    AND t.brcsd_sku_line_no = s.brcsd_sku_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_BRConsignmentSKUDetail
    (
        br_key,
        brcsd_ou, brcsd_br_id, brcsd_thu_line_no, brcsd_serial_no, brcsd_sku_line_no, brcsd_sku_id, brcsd_sku_rate, brcsd_sku_quantity, brcsd_sku_value, brcsd_created_by, brcsd_created_date, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.br_key,
        s.brcsd_ou, s.brcsd_br_id, s.brcsd_thu_line_no, s.brcsd_serial_no, s.brcsd_sku_line_no, s.brcsd_sku_id, s.brcsd_sku_rate, s.brcsd_sku_quantity, s.brcsd_sku_value, s.brcsd_created_by, s.brcsd_created_date, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_brcsd_consgt_sku_details s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.brcsd_ou 			= fh.br_ouinstance
            AND S.brcsd_br_id       = fh.br_request_Id
    LEFT JOIN dwh.F_BRConsignmentSKUDetail t
    ON s.brcsd_ou = t.brcsd_ou
    AND s.brcsd_br_id = t.brcsd_br_id
    AND s.brcsd_thu_line_no = t.brcsd_thu_line_no
    AND s.brcsd_sku_line_no = t.brcsd_sku_line_no
    WHERE t.brcsd_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_brcsd_consgt_sku_details
    (
        brcsd_ou, brcsd_br_id, brcsd_thu_line_no, brcsd_serial_no, brcsd_child_thu_id, brcsd_child_serial_no, brcsd_sku_line_no, brcsd_sku_id, brcsd_sku_rate, brcsd_sku_quantity, brcsd_sku_value, brcsd_sku_batch_id, brcsd_sku_mfg_date, brcsd_sku_expiry_date, brcsd_created_by, brcsd_created_date, brcsd_modified_by, brcsd_modified_date, brcsd_timestamp, brcsd_igst_amount, brcsd_cgst_amount, brcsd_sgst_amount, brcsd_utgst_amount, brcsd_cess_amount, etlcreateddatetime
    )
    SELECT
        brcsd_ou, brcsd_br_id, brcsd_thu_line_no, brcsd_serial_no, brcsd_child_thu_id, brcsd_child_serial_no, brcsd_sku_line_no, brcsd_sku_id, brcsd_sku_rate, brcsd_sku_quantity, brcsd_sku_value, brcsd_sku_batch_id, brcsd_sku_mfg_date, brcsd_sku_expiry_date, brcsd_created_by, brcsd_created_date, brcsd_modified_by, brcsd_modified_date, brcsd_timestamp, brcsd_igst_amount, brcsd_cgst_amount, brcsd_sgst_amount, brcsd_utgst_amount, brcsd_cess_amount, etlcreateddatetime
    FROM stg.stg_tms_brcsd_consgt_sku_details;
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
ALTER PROCEDURE dwh.usp_f_brconsignmentskudetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
