-- PROCEDURE: dwh.usp_f_stockconversionheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_stockconversionheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_stockconversionheader(
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
        ON d.sourceid 			= h.sourceid
    WHERE d.sourceid 			= p_sourceId
        AND d.dataflowflag 		= p_dataflowflag
        AND d.targetobject 		= p_targetobject;

    SELECT COUNT(1) INTO srccnt FROM stg.stg_wms_stock_conversion_hdr;

    UPDATE dwh.F_StockConversionHeader t
    SET
        stk_con_loc_key 						= COALESCE(l.loc_key,-1),
        stk_con_date_key 						= COALESCE(d.datekey,-1),
        stk_con_proposal_date          			= s.wms_stk_con_proposal_date,
        stk_con_proposal_status        			= s.wms_stk_con_proposal_status,
        stk_con_proposal_type          			= s.wms_stk_con_proposal_type,
        stk_con_ref_doc_no             			= s.wms_stk_con_ref_doc_no,
        stk_con_approver               			= s.wms_stk_con_approver,
        stk_con_remarks                			= s.wms_stk_con_remarks,
        stk_con_created_by             			= s.wms_stk_con_created_by,
        stk_con_created_date           			= s.wms_stk_con_created_date,
        stk_con_modified_by            			= s.wms_stk_con_modified_by,
        stk_con_modified_date          			= s.wms_stk_con_modified_date,
        stk_con_timestamp              			= s.wms_stk_con_timestamp,
        etlactiveind                   			= 1,
        etljobname                     			= p_etljobname,
        envsourcecd                    			= p_envsourcecd,
        datasourcecd                   			= p_datasourcecd,
        etlupdatedatetime              			= NOW()
    FROM stg.stg_wms_stock_conversion_hdr s
	LEFT JOIN dwh.d_location l
		ON  s.wms_stk_con_loc_code 				= l.loc_code
		AND s.wms_stk_con_proposal_ou			= l.loc_ou
	LEFT JOIN dwh.d_date d	
		ON  s.wms_stk_con_proposal_date::date 	= d.dateactual
    WHERE   t.stk_con_loc_code 					= s.wms_stk_con_loc_code
		AND t.stk_con_proposal_no 				= s.wms_stk_con_proposal_no
		AND t.stk_con_proposal_ou 				= s.wms_stk_con_proposal_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_StockConversionHeader
    (
        stk_con_loc_key				, stk_con_date_key				, stk_con_loc_code				, stk_con_proposal_no, 
		stk_con_proposal_ou			, stk_con_proposal_date			, stk_con_proposal_status		, stk_con_proposal_type, 
		stk_con_ref_doc_no			, stk_con_approver				, stk_con_remarks				, stk_con_created_by, 
		stk_con_created_date		, stk_con_modified_by			, stk_con_modified_date			, stk_con_timestamp, 
		etlactiveind				, etljobname					, envsourcecd					, datasourcecd					, etlcreatedatetime
    )

    SELECT
        COALESCE(l.loc_key,-1)		, COALESCE(d.datekey,-1)		, s.wms_stk_con_loc_code		, s.wms_stk_con_proposal_no, 
		s.wms_stk_con_proposal_ou	, s.wms_stk_con_proposal_date	, s.wms_stk_con_proposal_status	, s.wms_stk_con_proposal_type, 
		s.wms_stk_con_ref_doc_no	, s.wms_stk_con_approver		, s.wms_stk_con_remarks			, s.wms_stk_con_created_by, 
		s.wms_stk_con_created_date	, s.wms_stk_con_modified_by		, s.wms_stk_con_modified_date	, s.wms_stk_con_timestamp, 
		1							, p_etljobname					, p_envsourcecd					, p_datasourcecd				, NOW()
    FROM stg.stg_wms_stock_conversion_hdr s
	LEFT JOIN dwh.d_location l
		ON  s.wms_stk_con_loc_code 				= l.loc_code
		AND s.wms_stk_con_proposal_ou			= l.loc_ou
	LEFT JOIN dwh.d_date d	
		ON  s.wms_stk_con_proposal_date::date 	= d.dateactual	
    LEFT JOIN dwh.F_StockConversionHeader t
		ON  s.wms_stk_con_loc_code 				= t.stk_con_loc_code
		AND s.wms_stk_con_proposal_no 			= t.stk_con_proposal_no
		AND s.wms_stk_con_proposal_ou 			= t.stk_con_proposal_ou
    WHERE   t.stk_con_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_stock_conversion_hdr
    (
        wms_stk_con_loc_code			, wms_stk_con_proposal_no			, wms_stk_con_proposal_ou	, wms_stk_con_proposal_date, 
		wms_stk_con_proposal_status		, wms_stk_con_proposal_type			, wms_stk_con_ref_doc_no	, wms_stk_con_approver, 
		wms_stk_con_remarks				, wms_stk_con_created_by			, wms_stk_con_created_date	, wms_stk_con_modified_by, 
		wms_stk_con_modified_date		, wms_stk_con_timestamp				, wms_stk_con_userdefined1	, wms_stk_con_userdefined2, 
		wms_stk_con_userdefined3		, wms_stk_recasfee_last_bil_date	, etlcreateddatetime
    )
    SELECT
        wms_stk_con_loc_code			, wms_stk_con_proposal_no			, wms_stk_con_proposal_ou	, wms_stk_con_proposal_date, 
		wms_stk_con_proposal_status		, wms_stk_con_proposal_type			, wms_stk_con_ref_doc_no	, wms_stk_con_approver, 
		wms_stk_con_remarks				, wms_stk_con_created_by			, wms_stk_con_created_date	, wms_stk_con_modified_by, 
		wms_stk_con_modified_date		, wms_stk_con_timestamp				, wms_stk_con_userdefined1	, wms_stk_con_userdefined2, 
		wms_stk_con_userdefined3		, wms_stk_recasfee_last_bil_date	, etlcreateddatetime
	FROM stg.stg_wms_stock_conversion_hdr;
    END IF;

    EXCEPTION
        WHEN others THEN
        GET stacked DIAGNOSTICS p_errorid   = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
    SELECT 0 INTO inscnt;
    SELECT 0 INTO updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_stockconversionheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
