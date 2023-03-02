-- PROCEDURE: dwh.usp_f_virtualstockballot(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_virtualstockballot(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_virtualstockballot(
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag
 
	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag
 
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_virtual_stockbal_lot;

	update dwh.f_virtualstockballot d
	set
		itm_hdr_key				= i.itm_hdr_key,
		loc_key					= l.loc_key,
		ref_doc_date_key		= ky.datekey,
		sbl_wh_loc_code			= s.sbl_wh_code,
		sbl_ouinstid			= s.sbl_ouinstid,
		sbl_line_no				= s.sbl_line_no,
		sbl_item_code			= s.sbl_item_code,
		sbl_lot_no				= s.sbl_lot_no,
		sbl_zone				= s.sbl_zone,
		sbl_bin					= s.sbl_bin,
		sbl_stock_status		= s.sbl_stock_status,
		sbl_from_zone			= s.sbl_from_zone,
		sbl_from_bin			= s.sbl_from_bin,
		sbl_ref_doc_no			= s.sbl_ref_doc_no,
		sbl_ref_doc_type		= s.sbl_ref_doc_type,
		sbl_ref_doc_date		= s.sbl_ref_doc_date,
		sbl_ref_doc_line_no		= s.sbl_ref_doc_line_no,
		sbl_disposal_doc_type	= s.sbl_disposal_doc_type,
		sbl_disposal_doc_no		= s.sbl_disposal_doc_no,
		sbl_disposal_doc_date	= s.sbl_disposal_doc_date,
		sbl_disposal_status		= s.sbl_disposal_status,
		sbl_quantity			= s.sbl_quantity,
		sbl_wh_bat_no			= s.sbl_wh_bat_no,
		sbl_supp_bat_no			= s.sbl_supp_bat_no,
		sbl_ido_no				= s.sbl_ido_no,
		sbl_gr_no				= s.sbl_gr_no,
		sbl_created_date		= s.sbl_created_date,
		sbl_created_by			= s.sbl_created_by,
		sbl_modified_date		= s.sbl_modified_date,
		sbl_modified_by			= s.sbl_modified_by,
		sbl_to_zone				= s.sbl_to_zone,
		sbl_to_bin				= s.sbl_to_bin,
		sbl_reason_code			= s.sbl_reason_code,
		etlactiveind			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()
	from stg.stg_wms_virtual_stockbal_lot s
	left join dwh.d_location l
	on s.sbl_wh_code = l.loc_code
	and s.sbl_ouinstid = l.loc_ou
	left join dwh.d_itemheader i
	on s.sbl_item_code = i.itm_code
	and s.sbl_ouinstid = i.itm_ou
	left join dwh.d_date ky
	on s.sbl_ref_doc_date::date = ky.dateactual
	where d.sbl_wh_loc_code = s.sbl_wh_code
	and d.sbl_ouinstid = s.sbl_ouinstid
	and d.sbl_line_no = s.sbl_line_no;
	
	GET DIAGNOSTICS updcnt = ROW_COUNT;
	
	insert into dwh.f_virtualstockballot 
	(
	itm_hdr_key			, loc_key				, ref_doc_date_key		, sbl_wh_loc_code, 
	sbl_ouinstid		, sbl_line_no			, sbl_item_code			, sbl_lot_no,
	sbl_zone			, sbl_bin				, sbl_stock_status		, sbl_from_zone, 
	sbl_from_bin		, sbl_ref_doc_no		, sbl_ref_doc_type		, sbl_ref_doc_date, 
	sbl_ref_doc_line_no	, sbl_disposal_doc_type	, sbl_disposal_doc_no	, sbl_disposal_doc_date, 
	sbl_disposal_status	, sbl_quantity			, sbl_wh_bat_no			, sbl_supp_bat_no, 
	sbl_ido_no			, sbl_gr_no				, sbl_created_date		, sbl_created_by, 
	sbl_modified_date	, sbl_modified_by		, sbl_to_zone			, sbl_to_bin, 
	sbl_reason_code		, 
	etlactiveind		, etljobname			, envsourcecd			, datasourcecd, 
	etlcreatedatetime
	)
	
	select
	i.itm_hdr_key			, l.loc_key					, ky.datekey				, s.sbl_wh_code,
	s.sbl_ouinstid			, s.sbl_line_no				, s.sbl_item_code			, s.sbl_lot_no,
	s.sbl_zone				, s.sbl_bin					, s.sbl_stock_status		, s.sbl_from_zone, 
	s.sbl_from_bin			, s.sbl_ref_doc_no			, s.sbl_ref_doc_type		, s.sbl_ref_doc_date, 
	s.sbl_ref_doc_line_no	, s.sbl_disposal_doc_type	, s.sbl_disposal_doc_no		, s.sbl_disposal_doc_date, 
	s.sbl_disposal_status	, s.sbl_quantity			, s.sbl_wh_bat_no			, s.sbl_supp_bat_no, 
	s.sbl_ido_no			, s.sbl_gr_no				, s.sbl_created_date		, s.sbl_created_by, 
	s.sbl_modified_date		, s.sbl_modified_by			, s.sbl_to_zone				, s.sbl_to_bin, 
	s.sbl_reason_code		,
			1				, p_etljobname			, p_envsourcecd 		, p_datasourcecd ,
			NOW()	
	FROM stg.stg_wms_virtual_stockbal_lot s
	LEFT JOIN dwh.d_location l
	ON s.sbl_wh_code = l.loc_code
	AND s.sbl_ouinstid = l.loc_ou
	LEFT JOIN dwh.d_itemheader i
	ON s.sbl_item_code = i.itm_code
	AND s.sbl_ouinstid = i.itm_ou
	LEFT JOIN dwh.d_date ky
	ON s.sbl_ref_doc_date::date = ky.dateactual
	LEFT JOIN dwh.f_virtualstockballot d
	ON d.sbl_wh_loc_code = s.sbl_wh_code
	AND d.sbl_ouinstid = s.sbl_ouinstid
	AND d.sbl_line_no = s.sbl_line_no
	WHERE d.sbl_wh_loc_code is null;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	INSERT INTO raw.raw_wms_virtual_stockbal_lot
	(
		sbl_wh_code, 
		sbl_ouinstid		, sbl_line_no			, sbl_item_code			, sbl_lot_no,
		sbl_zone			, sbl_bin				, sbl_stock_status		, sbl_from_zone, 
		sbl_from_bin		, sbl_ref_doc_no		, sbl_ref_doc_type		, sbl_ref_doc_date, 
		sbl_ref_doc_line_no	, sbl_disposal_doc_type	, sbl_disposal_doc_no	, sbl_disposal_doc_date, 
		sbl_disposal_status	, sbl_quantity			, sbl_wh_bat_no			, sbl_supp_bat_no, 
		sbl_ido_no			, sbl_gr_no				, sbl_created_date		, sbl_created_by, 
		sbl_modified_date	, sbl_modified_by		, sbl_to_zone			, sbl_to_bin, 
		sbl_reason_code		, etlcreateddatetime
	)
	select 
		sbl_wh_code, 
		sbl_ouinstid		, sbl_line_no			, sbl_item_code			, sbl_lot_no,
		sbl_zone			, sbl_bin				, sbl_stock_status		, sbl_from_zone, 
		sbl_from_bin		, sbl_ref_doc_no		, sbl_ref_doc_type		, sbl_ref_doc_date, 
		sbl_ref_doc_line_no	, sbl_disposal_doc_type	, sbl_disposal_doc_no	, sbl_disposal_doc_date, 
		sbl_disposal_status	, sbl_quantity			, sbl_wh_bat_no			, sbl_supp_bat_no, 
		sbl_ido_no			, sbl_gr_no				, sbl_created_date		, sbl_created_by, 
		sbl_modified_date	, sbl_modified_by		, sbl_to_zone			, sbl_to_bin, 
		sbl_reason_code		, etlcreatedatetime
	from stg.stg_wms_virtual_stockbal_lot;

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
ALTER PROCEDURE dwh.usp_f_virtualstockballot(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
