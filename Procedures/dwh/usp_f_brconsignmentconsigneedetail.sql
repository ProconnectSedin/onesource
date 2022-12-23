-- PROCEDURE: dwh.usp_f_brconsignmentconsigneedetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_brconsignmentconsigneedetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_brconsignmentconsigneedetail(
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
    FROM stg.stg_tms_brccd_consgt_consignee_details;

    UPDATE dwh.F_BRConsignmentConsigneeDetail t
    SET 
		br_key								= fh.br_key,
		brccd_consignee_hdr_key				= COALESCE(c.consignee_hdr_key,-1),
        ccd_consignee_id                    = s.ccd_consignee_id,
        ccd_consignee_name                  = s.ccd_consignee_name,
        ccd_consignee_contact_person        = s.ccd_consignee_contact_person,
        ccd_consignee_address_line1         = s.ccd_consignee_address_line1,
        ccd_consignee_address_line2         = s.ccd_consignee_address_line2,
        ccd_consignee_address_line3         = s.ccd_consignee_address_line3,
        ccd_consignee_postal_code           = s.ccd_consignee_postal_code,
        ccd_consignee_subzone               = s.ccd_consignee_subzone,
        ccd_consignee_city                  = s.ccd_consignee_city,
        ccd_consignee_zone                  = s.ccd_consignee_zone,
        ccd_consignee_state                 = s.ccd_consignee_state,
        ccd_consignee_region                = s.ccd_consignee_region,
        ccd_consignee_country               = s.ccd_consignee_country,
        ccd_created_by                      = s.ccd_created_by,
        ccd_created_Date                    = s.ccd_created_Date,
        ccd_last_modified_date              = s.ccd_last_modified_date,
        ccd_last_modified_by                = s.ccd_last_modified_by,
        etlactiveind                        = 1,
        etljobname                          = p_etljobname,
        envsourcecd                         = p_envsourcecd,
        datasourcecd                        = p_datasourcecd,
        etlupdatedatetime                   = NOW()
    FROM stg.stg_tms_brccd_consgt_consignee_details s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.ccd_ouinstance 			= fh.br_ouinstance
            AND S.ccd_br_id                 = fh.br_request_Id
	LEFT JOIN dwh.d_consignee c 			
			ON 	s.ccd_consignee_id 			= c.consignee_id
			AND s.ccd_ouinstance        	= c.consignee_ou
    WHERE 		t.ccd_ouinstance 			= s.ccd_ouinstance
    AND 		t.ccd_br_id 				= s.ccd_br_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_BRConsignmentConsigneeDetail
    (
        br_key,                         brccd_consignee_hdr_key,
        ccd_ouinstance, 				ccd_br_id, 						ccd_consignee_id, 				ccd_consignee_name, 		ccd_consignee_contact_person, 
		ccd_consignee_address_line1, 	ccd_consignee_address_line2, 	ccd_consignee_address_line3, 	ccd_consignee_postal_code, 	ccd_consignee_subzone, 
		ccd_consignee_city, 			ccd_consignee_zone, 			ccd_consignee_state, 			ccd_consignee_region, 		ccd_consignee_country, 
		ccd_created_by, 				ccd_created_Date, 				ccd_last_modified_date, 		ccd_last_modified_by, 		etlactiveind, 
		etljobname, 					envsourcecd, 					datasourcecd, 					etlcreatedatetime
    )

    SELECT
        fh.br_key,                      COALESCE(c.consignee_hdr_key,-1),
        s.ccd_ouinstance, 				s.ccd_br_id, 					s.ccd_consignee_id, 			s.ccd_consignee_name, 			s.ccd_consignee_contact_person, 
		s.ccd_consignee_address_line1, 	s.ccd_consignee_address_line2, 	s.ccd_consignee_address_line3, 	s.ccd_consignee_postal_code, 	s.ccd_consignee_subzone, 
		s.ccd_consignee_city, 			s.ccd_consignee_zone, 			s.ccd_consignee_state, 			s.ccd_consignee_region, 		s.ccd_consignee_country, 
		s.ccd_created_by, 				s.ccd_created_Date, 			s.ccd_last_modified_date, 		s.ccd_last_modified_by, 		1,
		p_etljobname,					p_envsourcecd, 					p_datasourcecd, NOW()
    FROM stg.stg_tms_brccd_consgt_consignee_details s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.ccd_ouinstance 			= fh.br_ouinstance
            AND S.ccd_br_id                 = fh.br_request_Id
	LEFT JOIN 	dwh.d_consignee c 			
			ON 	s.ccd_consignee_id 			= c.consignee_id
			AND s.ccd_ouinstance        	= c.consignee_ou
    LEFT JOIN 	dwh.F_BRConsignmentConsigneeDetail t
    ON 			s.ccd_ouinstance 			= t.ccd_ouinstance
    AND 		s.ccd_br_id 				= t.ccd_br_id
    WHERE 		t.ccd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_brccd_consgt_consignee_details
    (
        ccd_ouinstance, 				ccd_br_id, 						ccd_consignee_id, 				ccd_consignee_name, 			ccd_consignee_contact_person, 
		ccd_consignee_address_line1, 	ccd_consignee_address_line2, 	ccd_consignee_address_line3, 	ccd_consignee_postal_code, 		ccd_consignee_subzone, 
		ccd_consignee_city, 			ccd_consignee_zone, 			ccd_consignee_state, 			ccd_consignee_region, 			ccd_consignee_country, 
		ccd_np_sameas_consignee, 		ccd_notify_party_id, 			ccd_np_name, 					ccd_np_contact_person, 			ccd_np_address_line1, 
		ccd_np_address_line2, 			ccd_np_address_line3, 			ccd_np_postal_code, 			ccd_np_subzone, 				ccd_np_city, 
		ccd_np_zone, 					ccd_np_state, 					ccd_np_region, 					ccd_np_country, 				ccd_np_primary_phone, 
		ccd_np_secondary_phone, 		ccd_np_email_id, 				ccd_created_by, 				ccd_created_Date, 				ccd_last_modified_date, 
		ccd_last_modified_by, 			ccd_consignee_type_of_entry, 	ccd_timestamp, 					etlcreateddatetime
    )
    SELECT
		ccd_ouinstance, 				ccd_br_id, 						ccd_consignee_id, 				ccd_consignee_name, 			ccd_consignee_contact_person, 
		ccd_consignee_address_line1, 	ccd_consignee_address_line2, 	ccd_consignee_address_line3, 	ccd_consignee_postal_code, 		ccd_consignee_subzone, 
		ccd_consignee_city, 			ccd_consignee_zone, 			ccd_consignee_state, 			ccd_consignee_region, 			ccd_consignee_country, 
		ccd_np_sameas_consignee, 		ccd_notify_party_id, 			ccd_np_name, 					ccd_np_contact_person, 			ccd_np_address_line1, 
		ccd_np_address_line2, 			ccd_np_address_line3, 			ccd_np_postal_code, 			ccd_np_subzone, 				ccd_np_city, 
		ccd_np_zone, 					ccd_np_state, 					ccd_np_region, 					ccd_np_country, 				ccd_np_primary_phone, 
		ccd_np_secondary_phone, 		ccd_np_email_id, 				ccd_created_by, 				ccd_created_Date, 				ccd_last_modified_date, 
		ccd_last_modified_by, 			ccd_consignee_type_of_entry, 	ccd_timestamp, 					etlcreateddatetime
    FROM stg.stg_tms_brccd_consgt_consignee_details;
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
ALTER PROCEDURE dwh.usp_f_brconsignmentconsigneedetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
