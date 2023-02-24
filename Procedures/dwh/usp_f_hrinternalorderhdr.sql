-- PROCEDURE: dwh.usp_f_hrinternalorderhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_hrinternalorderhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_hrinternalorderhdr(
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
    FROM stg.stg_wms_hr_internal_order_hdr;

    UPDATE dwh.F_hrinternalorderhdr t
    SET
		loc_key						   = l.loc_key,
		vendor_key					   = v.vendor_key,
        in_ord_location                = s.wms_in_ord_location,
        in_ord_no                      = s.wms_in_ord_no,
        in_ord_ou                      = s.wms_in_ord_ou,
        in_ord_contract_id             = s.wms_in_ord_contract_id,
        in_ord_date                    = s.wms_in_ord_date,
        in_ord_typ                     = s.wms_in_ord_typ,
        in_ord_status                  = s.wms_in_ord_status,
        in_ord_customer_id             = s.wms_in_ord_customer_id,
        in_ord_vendor_id               = s.wms_in_ord_vendor_id,
        in_ord_pri_ref_doc_typ         = s.wms_in_ord_pri_ref_doc_typ,
        in_ord_pri_ref_doc_no          = s.wms_in_ord_pri_ref_doc_no,
        in_ord_pri_ref_doc_date        = s.wms_in_ord_pri_ref_doc_date,
        in_ord_amendno                 = s.wms_in_ord_amendno,
        in_ord_timestamp               = s.wms_in_ord_timestamp,
        in_createdby                   = s.wms_in_createdby,
        in_created_date                = s.wms_in_created_date,
        in_modifiedby                  = s.wms_in_modifiedby,
        in_modified_date               = s.wms_in_modified_date,
        in_ord_desc                    = s.wms_in_ord_desc,
        in_ord_division                = s.wms_in_ord_division,
        in_ord_cont_srv_type           = s.wms_in_ord_cont_srv_type,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_wms_hr_internal_order_hdr s
	LEFT JOIN dwh.d_location l
	ON l.loc_code		= s.wms_in_ord_location
	AND l.loc_ou 		= s.wms_in_ord_ou
	LEFT JOIN dWh.d_vendor v
	ON v.vendor_id	= s.wms_in_ord_vendor_id
	AND v.vendor_ou	= s.wms_in_ord_ou
    WHERE t.in_ord_ou = s.wms_in_ord_ou
    AND t.in_ord_no = s.wms_in_ord_no
    AND t.in_ord_location = s.wms_in_ord_location;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_hrinternalorderhdr
    (
		loc_key					, vendor_key			,        
		in_ord_location			, in_ord_no				, in_ord_ou			, in_ord_contract_id, in_ord_date, 
		in_ord_typ				, in_ord_status			, in_ord_customer_id, in_ord_vendor_id	, in_ord_pri_ref_doc_typ, 
		in_ord_pri_ref_doc_no	, in_ord_pri_ref_doc_date, in_ord_amendno	, in_ord_timestamp	, in_createdby, 
		in_created_date			, in_modifiedby			, in_modified_date	, in_ord_desc		, in_ord_division, 
		in_ord_cont_srv_type	, 
		etlactiveind			, etljobname			, envsourcecd		, datasourcecd		, etlcreatedatetime
    )

    SELECT
		l.loc_key					, v.vendor_key,
        s.wms_in_ord_location		, s.wms_in_ord_no				, s.wms_in_ord_ou			, s.wms_in_ord_contract_id	, s.wms_in_ord_date, 
		s.wms_in_ord_typ			, s.wms_in_ord_status			, s.wms_in_ord_customer_id	, s.wms_in_ord_vendor_id	, s.wms_in_ord_pri_ref_doc_typ,
		s.wms_in_ord_pri_ref_doc_no	, s.wms_in_ord_pri_ref_doc_date	, s.wms_in_ord_amendno		, s.wms_in_ord_timestamp	, s.wms_in_createdby,
		s.wms_in_created_date		, s.wms_in_modifiedby			, s.wms_in_modified_date	, s.wms_in_ord_desc			, s.wms_in_ord_division,
		s.wms_in_ord_cont_srv_type	,
					1				, p_etljobname					, p_envsourcecd				, p_datasourcecd			, NOW()
    FROM stg.stg_wms_hr_internal_order_hdr s
	LEFT JOIN dwh.d_location l
	ON l.loc_code		= s.wms_in_ord_location
	AND l.loc_ou 		= s.wms_in_ord_ou
	LEFT JOIN dWh.d_vendor v
	ON v.vendor_id	= s.wms_in_ord_vendor_id
	AND v.vendor_ou	= s.wms_in_ord_ou
    LEFT JOIN dwh.F_hrinternalorderhdr t
    ON t.in_ord_ou = s.wms_in_ord_ou
    AND t.in_ord_no = s.wms_in_ord_no
    AND t.in_ord_location = s.wms_in_ord_location
    WHERE t.in_ord_location IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_hr_internal_order_hdr
    (
        wms_in_ord_location, wms_in_ord_no, wms_in_ord_ou, wms_in_ord_contract_id, wms_in_ord_date, wms_in_ord_typ, wms_in_ord_status, wms_in_ord_customer_id, wms_in_ord_vendor_id, wms_in_ord_pri_ref_doc_typ, wms_in_ord_pri_ref_doc_no, wms_in_ord_pri_ref_doc_date, wms_in_ord_sec_ref_doc_typ, wms_in_ord_sec_ref_doc_no, wms_in_ord_sec_ref_doc_date, wms_in_ord_amendno, wms_in_ord_timestamp, wms_in_ord_userdefined1, wms_in_ord_userdefined2, wms_in_ord_userdefined3, wms_in_createdby, wms_in_created_date, wms_in_modifiedby, wms_in_modified_date, wms_in_ord_desc, wms_in_ord_division, wms_in_ord_workflow_sts, wms_in_ord_rerurn_for_reason, wms_in_ord_cont_srv_type, etlcreateddatetime
    )
    SELECT
        wms_in_ord_location, wms_in_ord_no, wms_in_ord_ou, wms_in_ord_contract_id, wms_in_ord_date, wms_in_ord_typ, wms_in_ord_status, wms_in_ord_customer_id, wms_in_ord_vendor_id, wms_in_ord_pri_ref_doc_typ, wms_in_ord_pri_ref_doc_no, wms_in_ord_pri_ref_doc_date, wms_in_ord_sec_ref_doc_typ, wms_in_ord_sec_ref_doc_no, wms_in_ord_sec_ref_doc_date, wms_in_ord_amendno, wms_in_ord_timestamp, wms_in_ord_userdefined1, wms_in_ord_userdefined2, wms_in_ord_userdefined3, wms_in_createdby, wms_in_created_date, wms_in_modifiedby, wms_in_modified_date, wms_in_ord_desc, wms_in_ord_division, wms_in_ord_workflow_sts, wms_in_ord_rerurn_for_reason, wms_in_ord_cont_srv_type, etlcreateddatetime
    FROM stg.stg_wms_hr_internal_order_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_hrinternalorderhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
