-- PROCEDURE: dwh.usp_f_brconsignmentthuserialdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_brconsignmentthuserialdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_brconsignmentthuserialdetail(
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
		
	

	IF EXISTS(SELECT 1  FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_brctd_consgt_thu_serial_details;

    UPDATE dwh.f_bRConsignmentTHUSerialDetail t
    SET
	    ctsd_br_key						= fh.br_key,
        ctsd_serial_no					= s.ctsd_serial_no,
        ctsd_hazmat_code				= s.ctsd_hazmat_code,
        ctsd_length						= s.ctsd_length,
        ctsd_breadth					= s.ctsd_breadth,
        ctsd_height						= s.ctsd_height,
        ctsd_lbh_uom					= s.ctsd_lbh_uom,
        ctsd_gross_weight				= s.ctsd_gross_weight,
        ctsd_gross_weight_uom			= s.ctsd_gross_weight_uom,
        ctsd_created_date				= s.ctsd_created_date,
        ctsd_created_by					= s.ctsd_created_by,
        ctsd_last_modified_by			= s.ctsd_last_modified_by,
        ctsd_last_modified_Date			= s.ctsd_last_modified_Date,
        ctsd_AltQty						= s.ctsd_AltQty,
        ctsd_AltQty_Uom					= s.ctsd_AltQty_Uom,
        etlactiveind					= 1,
        etljobname						= p_etljobname,
        envsourcecd						= p_envsourcecd,
        datasourcecd					= p_datasourcecd,
        etlupdatedatetime				= NOW()
    FROM stg.stg_tms_brctd_consgt_thu_serial_details s
	INNER JOIN dwh.f_bookingrequest fh
	ON   s.ctsd_ouinstance				=	fh.br_ouinstance
	AND  s.ctsd_br_id					=	fh.br_request_id
    WHERE t.ctsd_ouinstance				=	s.ctsd_ouinstance
    AND t.ctsd_br_id					=	s.ctsd_br_id
    AND t.ctsd_thu_line_no				=	s.ctsd_thu_line_no
    AND t.ctsd_thu_serial_line_no		=	s.ctsd_thu_serial_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_bRConsignmentTHUSerialDetail
    (
        ctsd_br_key,ctsd_ouinstance, ctsd_br_id, ctsd_thu_line_no, ctsd_thu_serial_line_no, ctsd_serial_no, ctsd_hazmat_code, ctsd_length, 
		ctsd_breadth, ctsd_height, ctsd_lbh_uom, ctsd_gross_weight, ctsd_gross_weight_uom, ctsd_created_date, ctsd_created_by, ctsd_last_modified_by, 
		ctsd_last_modified_Date, ctsd_AltQty, ctsd_AltQty_Uom, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.br_key,s.ctsd_ouinstance, s.ctsd_br_id, s.ctsd_thu_line_no, s.ctsd_thu_serial_line_no, s.ctsd_serial_no, s.ctsd_hazmat_code, s.ctsd_length, 
		s.ctsd_breadth, s.ctsd_height, s.ctsd_lbh_uom, s.ctsd_gross_weight, s.ctsd_gross_weight_uom, s.ctsd_created_date, s.ctsd_created_by, s.ctsd_last_modified_by, 
		s.ctsd_last_modified_Date, s.ctsd_AltQty, s.ctsd_AltQty_Uom, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_brctd_consgt_thu_serial_details s
	INNER JOIN dwh.f_bookingrequest fh
	ON   s.ctsd_ouinstance			=	fh.br_ouinstance
	AND  s.ctsd_br_id				=	fh.br_request_id
    LEFT JOIN dwh.f_bRConsignmentTHUSerialDetail t
    ON s.ctsd_ouinstance			=	t.ctsd_ouinstance
    AND s.ctsd_br_id				=	t.ctsd_br_id
    AND s.ctsd_thu_line_no			=	t.ctsd_thu_line_no
    AND s.ctsd_thu_serial_line_no	=	t.ctsd_thu_serial_line_no
	WHERE t.ctsd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_brctd_consgt_thu_serial_details
    (
        ctsd_ouinstance, ctsd_br_id, ctsd_thu_line_no, ctsd_thu_serial_line_no, ctsd_serial_no, ctsd_seat_no, ctsd_UN_code, ctsd_class_code, 
		ctsd_hs_code, ctsd_hazmat_code, ctsd_HAC_code, ctsd_length, ctsd_breadth, ctsd_height, ctsd_lbh_uom, ctsd_gross_weight, ctsd_gross_weight_uom, 
		ctsd_created_date, ctsd_created_by, ctsd_last_modified_by, ctsd_last_modified_Date, ctsd_AltQty, ctsd_AltQty_Uom, ctsd_customer_serial_no, 
		ctsd_timestamp, etlcreateddatetime
    )
    SELECT
        ctsd_ouinstance, ctsd_br_id, ctsd_thu_line_no, ctsd_thu_serial_line_no, ctsd_serial_no, ctsd_seat_no, ctsd_UN_code, ctsd_class_code, 
		ctsd_hs_code, ctsd_hazmat_code, ctsd_HAC_code, ctsd_length, ctsd_breadth, ctsd_height, ctsd_lbh_uom, ctsd_gross_weight, ctsd_gross_weight_uom, 
		ctsd_created_date, ctsd_created_by, ctsd_last_modified_by, ctsd_last_modified_Date, ctsd_AltQty, ctsd_AltQty_Uom, ctsd_customer_serial_no, 
		ctsd_timestamp, etlcreateddatetime
    FROM stg.stg_tms_brctd_consgt_thu_serial_details;
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
ALTER PROCEDURE dwh.usp_f_brconsignmentthuserialdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
