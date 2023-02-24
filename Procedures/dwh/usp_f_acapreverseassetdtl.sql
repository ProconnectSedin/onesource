-- PROCEDURE: dwh.usp_f_acapreverseassetdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_acapreverseassetdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_acapreverseassetdtl(
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

	IF EXISTS(SELECT 1  FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_acap_reverse_asset_dtl;

    UPDATE dwh.f_acapreverseassetdtl t
    SET
		acap_reverse_asset_hdr_key = COALESCE(a.acap_reverse_asset_hdr_key,-1),
        timestamp              = s.timestamp,
        tag_desc               = s.tag_desc,
        depr_category          = s.depr_category,
        business_use           = s.business_use,
        inservice_date         = s.inservice_date,
        asset_location         = s.asset_location,
        cost_center            = s.cost_center,
        tag_cost               = s.tag_cost,
        tag_status             = s.tag_status,
        inv_cycle              = s.inv_cycle,
        salvage_value          = s.salvage_value,
        manufacturer           = s.manufacturer,
        bar_code               = s.bar_code,
        serial_no              = s.serial_no,
        warranty_no            = s.warranty_no,
        model                  = s.model,
        custodian              = s.custodian,
        book_value             = s.book_value,
        createdby              = s.createdby,
        createddate            = s.createddate,
        modifiedby             = s.modifiedby,
        modifieddate           = s.modifieddate,
        etlactiveind           = 1,
        etljobname             = p_etljobname,
        envsourcecd            = p_envsourcecd,
        datasourcecd           = p_datasourcecd,
        etlupdatedatetime      = NOW()
    FROM stg.stg_acap_reverse_asset_dtl s
	LEFT JOIN dwh.f_acapreverseassethdr a
	ON    s.ou_id			   = a.ou_id
	AND   s.document_number    = a.document_number
    WHERE t.ou_id 			   = s.ou_id
    AND   t.document_number    = s.document_number
    AND   t.tag_number 		   = s.tag_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_acapreverseassetdtl
    (
		acap_reverse_asset_hdr_key,
        ou_id, 			document_number, 	tag_number, 	timestamp, 		tag_desc, 
		depr_category, 	business_use, 		inservice_date, asset_location, cost_center, 
		tag_cost, 		tag_status, 		inv_cycle, 		salvage_value, 	manufacturer, 
		bar_code, 		serial_no, 			warranty_no, 	model, 			custodian, 
		book_value, 	createdby, 			createddate, 	modifiedby, 	modifieddate, 
		etlactiveind, 	etljobname, 		envsourcecd, 	datasourcecd, 	etlcreatedatetime
    )

    SELECT
		COALESCE(a.acap_reverse_asset_hdr_key,-1),
        s.ou_id, 			s.document_number, 	s.tag_number, 		s.timestamp, 		s.tag_desc, 
		s.depr_category, 	s.business_use, 	s.inservice_date, 	s.asset_location, 	s.cost_center, 
		s.tag_cost, 		s.tag_status, 		s.inv_cycle, 		s.salvage_value, 	s.manufacturer, 
		s.bar_code, 		s.serial_no, 		s.warranty_no, 		s.model, 			s.custodian, 
		s.book_value, 		s.createdby, 		s.createddate, 		s.modifiedby, 		s.modifieddate, 
		1, 					p_etljobname, 		p_envsourcecd, 		p_datasourcecd, 	NOW()
    FROM stg.stg_acap_reverse_asset_dtl s
	LEFT JOIN dwh.f_acapreverseassethdr a
	ON    s.ou_id			   = a.ou_id
	AND   s.document_number    = a.document_number
    LEFT JOIN dwh.f_acapreverseassetdtl t
    ON 	  s.ou_id 			   = t.ou_id
    AND   s.document_number    = t.document_number
    AND   s.tag_number 		   = t.tag_number
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_acap_reverse_asset_dtl
    (
        ou_id, 			document_number, 	tag_number, 	timestamp, 		tag_desc, 
		depr_category, 	business_use, 		inservice_date, asset_location, cost_center, 
		tag_cost, 		tag_status, 		inv_cycle, 		salvage_value, 	manufacturer, 
		bar_code, 		serial_no, 			warranty_no, 	model, 			custodian, 
		book_value, 	createdby, 			createddate, 	modifiedby, 	modifieddate, 
		etlcreateddatetime
    )
    SELECT
        ou_id, 			document_number, 	tag_number, 	timestamp, 		tag_desc, 
		depr_category, 	business_use, 		inservice_date, asset_location, cost_center, 
		tag_cost, 		tag_status, 		inv_cycle, 		salvage_value, 	manufacturer, 
		bar_code, 		serial_no, 			warranty_no, 	model, 			custodian, 
		book_value, 	createdby, 			createddate, 	modifiedby, 	modifieddate, 
		etlcreateddatetime
    FROM stg.stg_acap_reverse_asset_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_acapreverseassetdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
