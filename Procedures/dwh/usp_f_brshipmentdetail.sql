-- PROCEDURE: dwh.usp_f_brshipmentdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_brshipmentdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_brshipmentdetail(
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
    FROM stg.stg_tms_brsd_shipment_details;

    UPDATE dwh.f_bRShipmentDetail t
    SET
	    brsd_br_key                                 =	fh.br_key,
        brsd_from_ship_point_id                     =	s.brsd_from_ship_point_id,
        brsd_from_ship_point_name                   =	s.brsd_from_ship_point_name,
        brsd_from_contact_person                    =	s.brsd_from_contact_person,
        brsd_from_address_line1                     =	s.brsd_from_address_line1,
        brsd_from_address_line2                     =	s.brsd_from_address_line2,
        brsd_from_address_line3                     =	s.brsd_from_address_line3,
        brsd_from_postal_code                       =	s.brsd_from_postal_code,
        brsd_from_subzone                           =	s.brsd_from_subzone,
        brsd_from_city                              =	s.brsd_from_city,
        brsd_from_zone                              =	s.brsd_from_zone,
        brsd_from_state                             =	s.brsd_from_state,
        brsd_from_region                            =	s.brsd_from_region,
        brsd_from_country                           =	s.brsd_from_country,
        brsd_from_primary_phone                     =	s.brsd_from_primary_phone,
        brsd_from_secondary_phone                   =	s.brsd_from_secondary_phone,
        brsd_from_pick_date                         =	s.brsd_from_pick_date,
        brsd_from_picktime_slot_from                =	s.brsd_from_picktime_slot_from,
        brsd_from_picktime_slot_to                  =	s.brsd_from_picktime_slot_to,
        brsd_from_creation_date                     =	s.brsd_from_creation_date,
        brsd_from_created_by                        =	s.brsd_from_created_by,
        brsd_from_last_modified_date                =	s.brsd_from_last_modified_date,
        brsd_from_last_modified_by                  =	s.brsd_from_last_modified_by,
        brsd_to_ship_point_id                       =	s.brsd_to_ship_point_id,
        brsd_to_ship_point_name                     =	s.brsd_to_ship_point_name,
        brsd_to_contact_person                      =	s.brsd_to_contact_person,
        brsd_to_address_line1                       =	s.brsd_to_address_line1,
        brsd_to_address_line2                       =	s.brsd_to_address_line2,
        brsd_to_address_line3                       =	s.brsd_to_address_line3,
        brsd_to_postal_code                         =	s.brsd_to_postal_code,
        brsd_to_subzone                             =	s.brsd_to_subzone,
        brsd_to_city                                =	s.brsd_to_city,
        brsd_to_zone                                =	s.brsd_to_zone,
        brsd_to_state                               =	s.brsd_to_state,
        brsd_to_region                              =	s.brsd_to_region,
        brsd_to_country                             =	s.brsd_to_country,
        brsd_to_primary_phone                       =	s.brsd_to_primary_phone,
        brsd_to_secondary_phone                     =	s.brsd_to_secondary_phone,
        brsd_to_creation_date                       =	s.brsd_to_creation_date,
        brsd_to_created_by                          =	s.brsd_to_created_by,
        brsd_to_last_modified_date                  =	s.brsd_to_last_modified_date,
        brsd_to_last_modified_by                    =	s.brsd_to_last_modified_by,
        brsd_unique_id                              =	s.brsd_unique_id,
        brsd_to_delivery_date                       =	s.brsd_to_delivery_date,
        brsd_to_deliverytime_slot_from              =	s.brsd_to_deliverytime_slot_from,
        brsd_to_deliverytime_slot_to                =	s.brsd_to_deliverytime_slot_to,
        brsd_to_consignee_same_as_ship_to           =	s.brsd_to_consignee_same_as_ship_to,
        brsd_from_suburb                            =	s.brsd_from_suburb,
        brsd_to_suburb                              =	s.brsd_to_suburb,
        brsd_alternate_to_ship_point_id             =	s.brsd_alternate_to_ship_point_id,
        brsd_alternate_to_ship_point_name           =	s.brsd_alternate_to_ship_point_name,
        brsd_alternate_to_contact_person            =	s.brsd_alternate_to_contact_person,
        brsd_alternate_to_address_line1             =	s.brsd_alternate_to_address_line1,
        brsd_alternate_to_address_line2             =	s.brsd_alternate_to_address_line2,
        brsd_alternate_to_postal_code               =	s.brsd_alternate_to_postal_code,
        brsd_alternate_to_city                      =	s.brsd_alternate_to_city,
        brsd_alternate_to_state                     =	s.brsd_alternate_to_state,
        brsd_alternate_to_country                   =	s.brsd_alternate_to_country,
        brsd_alternate_to_last_modified_date        =	s.brsd_alternate_to_last_modified_date,
        brsd_alternate_to_last_modified_by          =	s.brsd_alternate_to_last_modified_by,
        brsd_alternate_to_suburb                    =	s.brsd_alternate_to_suburb,
        brsd_alternate_to_remarks                   =	s.brsd_alternate_to_remarks,
        brsd_from_email_id                          =	s.brsd_from_email_id,
        brsd_to_email_id                            =	s.brsd_to_email_id,
        etlactiveind                                =	1,
        etljobname                                  =	p_etljobname,
        envsourcecd                                 =	p_envsourcecd,
        datasourcecd                                =	p_datasourcecd,
        etlupdatedatetime                           =	NOW()
    FROM stg.stg_tms_brsd_shipment_details s
	INNER JOIN dwh.f_bookingrequest fh
	ON		s.brsd_ouinstance						=	fh.br_ouinstance
	AND		s.brsd_br_id							=	fh.br_request_id
    WHERE	t.brsd_ouinstance						=	s.brsd_ouinstance
    AND		t.brsd_br_id							=	s.brsd_br_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_bRShipmentDetail
    (
        brsd_br_key,brsd_ouinstance, brsd_br_id, brsd_from_ship_point_id, brsd_from_ship_point_name, brsd_from_contact_person, brsd_from_address_line1, 
		brsd_from_address_line2, brsd_from_address_line3, brsd_from_postal_code, brsd_from_subzone, brsd_from_city, brsd_from_zone, brsd_from_state, 
		brsd_from_region, brsd_from_country, brsd_from_primary_phone, brsd_from_secondary_phone, brsd_from_pick_date, brsd_from_picktime_slot_from, 
		brsd_from_picktime_slot_to, brsd_from_creation_date, brsd_from_created_by, brsd_from_last_modified_date, brsd_from_last_modified_by, 
		brsd_to_ship_point_id, brsd_to_ship_point_name, brsd_to_contact_person, brsd_to_address_line1, brsd_to_address_line2, brsd_to_address_line3, 
		brsd_to_postal_code, brsd_to_subzone, brsd_to_city, brsd_to_zone, brsd_to_state, brsd_to_region, brsd_to_country, brsd_to_primary_phone, 
		brsd_to_secondary_phone, brsd_to_creation_date, brsd_to_created_by, brsd_to_last_modified_date, brsd_to_last_modified_by, brsd_unique_id, 
		brsd_to_delivery_date, brsd_to_deliverytime_slot_from, brsd_to_deliverytime_slot_to, brsd_to_consignee_same_as_ship_to, brsd_from_suburb, 
		brsd_to_suburb, brsd_alternate_to_ship_point_id, brsd_alternate_to_ship_point_name, brsd_alternate_to_contact_person, brsd_alternate_to_address_line1, 
		brsd_alternate_to_address_line2, brsd_alternate_to_postal_code, brsd_alternate_to_city, brsd_alternate_to_state, brsd_alternate_to_country, 
		brsd_alternate_to_last_modified_date, brsd_alternate_to_last_modified_by, brsd_alternate_to_suburb, brsd_alternate_to_remarks, brsd_from_email_id, 
		brsd_to_email_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.br_key,s.brsd_ouinstance, s.brsd_br_id, s.brsd_from_ship_point_id, s.brsd_from_ship_point_name, s.brsd_from_contact_person, s.brsd_from_address_line1, 
		s.brsd_from_address_line2, s.brsd_from_address_line3, s.brsd_from_postal_code, s.brsd_from_subzone, s.brsd_from_city, s.brsd_from_zone, s.brsd_from_state, 
		s.brsd_from_region, s.brsd_from_country, s.brsd_from_primary_phone, s.brsd_from_secondary_phone, s.brsd_from_pick_date, s.brsd_from_picktime_slot_from, 
		s.brsd_from_picktime_slot_to, s.brsd_from_creation_date, s.brsd_from_created_by, s.brsd_from_last_modified_date, s.brsd_from_last_modified_by, 
		s.brsd_to_ship_point_id, s.brsd_to_ship_point_name, s.brsd_to_contact_person, s.brsd_to_address_line1, s.brsd_to_address_line2, s.brsd_to_address_line3, 
		s.brsd_to_postal_code, s.brsd_to_subzone, s.brsd_to_city, s.brsd_to_zone, s.brsd_to_state, s.brsd_to_region, s.brsd_to_country, s.brsd_to_primary_phone, 
		s.brsd_to_secondary_phone, s.brsd_to_creation_date, s.brsd_to_created_by, s.brsd_to_last_modified_date, s.brsd_to_last_modified_by, s.brsd_unique_id, 
		s.brsd_to_delivery_date, s.brsd_to_deliverytime_slot_from, s.brsd_to_deliverytime_slot_to, s.brsd_to_consignee_same_as_ship_to, s.brsd_from_suburb, 
		s.brsd_to_suburb, s.brsd_alternate_to_ship_point_id, s.brsd_alternate_to_ship_point_name, s.brsd_alternate_to_contact_person, s.brsd_alternate_to_address_line1, 
		s.brsd_alternate_to_address_line2, s.brsd_alternate_to_postal_code, s.brsd_alternate_to_city, s.brsd_alternate_to_state, s.brsd_alternate_to_country, 
		s.brsd_alternate_to_last_modified_date, s.brsd_alternate_to_last_modified_by, s.brsd_alternate_to_suburb, s.brsd_alternate_to_remarks, s.brsd_from_email_id, 
		s.brsd_to_email_id, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_brsd_shipment_details s
	INNER JOIN dwh.f_bookingrequest fh
	ON		s.brsd_ouinstance						=	fh.br_ouinstance
	AND		s.brsd_br_id							=	fh.br_request_id
    LEFT JOIN dwh.f_bRShipmentDetail t
    ON		s.brsd_ouinstance						=	t.brsd_ouinstance
    AND		s.brsd_br_id							=	t.brsd_br_id
	AND     fh.br_key                               =   t.brsd_br_key
    WHERE t.brsd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_brsd_shipment_details
    (
        brsd_ouinstance, brsd_br_id, brsd_from_ship_point_id, brsd_from_ship_point_name, brsd_from_contact_person, brsd_from_address_line1, 
		brsd_from_address_line2, brsd_from_address_line3, brsd_from_postal_code, brsd_from_subzone, brsd_from_city, brsd_from_zone, brsd_from_state, brsd_from_region, 
		brsd_from_country, brsd_from_primary_phone, brsd_from_secondary_phone, brsd_from_pick_date, brsd_from_picktime_slot_from, brsd_from_picktime_slot_to, 
		brsd_from_creation_date, brsd_from_created_by, brsd_from_last_modified_date, brsd_from_last_modified_by, brsd_to_ship_point_id, brsd_to_ship_point_name, 
		brsd_to_contact_person, brsd_to_address_line1, brsd_to_address_line2, brsd_to_address_line3, brsd_to_postal_code, brsd_to_subzone, brsd_to_city, brsd_to_zone, 
		brsd_to_state, brsd_to_region, brsd_to_country, brsd_to_primary_phone, brsd_to_secondary_phone, brsd_to_creation_date, brsd_to_created_by, brsd_to_last_modified_date, 
		brsd_to_last_modified_by, brsd_unique_id, brsd_to_delivery_date, brsd_to_deliverytime_slot_from, brsd_to_deliverytime_slot_to, brsd_to_consignee_same_as_ship_to, 
		brsd_from_suburb, brsd_to_suburb, brsd_alternate_to_ship_point_id, brsd_alternate_to_ship_point_name, brsd_alternate_to_contact_person, brsd_alternate_to_address_line1, 
		brsd_alternate_to_address_line2, brsd_alternate_to_address_line3, brsd_alternate_to_postal_code, brsd_alternate_to_subzone, brsd_alternate_to_city, brsd_alternate_to_zone, 
		brsd_alternate_to_state, brsd_alternate_to_region, brsd_alternate_to_country, brsd_alternate_to_primary_phone, brsd_alternate_to_secondary_phone, 
		brsd_alternate_to_creation_date, brsd_alternate_to_created_by, brsd_alternate_to_last_modified_date, brsd_alternate_to_last_modified_by, 
		brsd_alternate_to_consignee_same_as_ship_to, brsd_alternate_to_suburb, brsd_alternate_to_remarks, brsd_from_email_id, brsd_from_remarks, brsd_to_email_id, 
		brsd_to_remarks, brsd_timestamp, brsd_alternate_Contact_remarks, brsd_alternate_email_id, etlcreateddatetime
    )
    SELECT
        brsd_ouinstance, brsd_br_id, brsd_from_ship_point_id, brsd_from_ship_point_name, brsd_from_contact_person, brsd_from_address_line1, 
		brsd_from_address_line2, brsd_from_address_line3, brsd_from_postal_code, brsd_from_subzone, brsd_from_city, brsd_from_zone, brsd_from_state, brsd_from_region, 
		brsd_from_country, brsd_from_primary_phone, brsd_from_secondary_phone, brsd_from_pick_date, brsd_from_picktime_slot_from, brsd_from_picktime_slot_to, 
		brsd_from_creation_date, brsd_from_created_by, brsd_from_last_modified_date, brsd_from_last_modified_by, brsd_to_ship_point_id, brsd_to_ship_point_name, 
		brsd_to_contact_person, brsd_to_address_line1, brsd_to_address_line2, brsd_to_address_line3, brsd_to_postal_code, brsd_to_subzone, brsd_to_city, brsd_to_zone, 
		brsd_to_state, brsd_to_region, brsd_to_country, brsd_to_primary_phone, brsd_to_secondary_phone, brsd_to_creation_date, brsd_to_created_by, brsd_to_last_modified_date, 
		brsd_to_last_modified_by, brsd_unique_id, brsd_to_delivery_date, brsd_to_deliverytime_slot_from, brsd_to_deliverytime_slot_to, brsd_to_consignee_same_as_ship_to, 
		brsd_from_suburb, brsd_to_suburb, brsd_alternate_to_ship_point_id, brsd_alternate_to_ship_point_name, brsd_alternate_to_contact_person, brsd_alternate_to_address_line1, 
		brsd_alternate_to_address_line2, brsd_alternate_to_address_line3, brsd_alternate_to_postal_code, brsd_alternate_to_subzone, brsd_alternate_to_city, brsd_alternate_to_zone, 
		brsd_alternate_to_state, brsd_alternate_to_region, brsd_alternate_to_country, brsd_alternate_to_primary_phone, brsd_alternate_to_secondary_phone, 
		brsd_alternate_to_creation_date, brsd_alternate_to_created_by, brsd_alternate_to_last_modified_date, brsd_alternate_to_last_modified_by, 
		brsd_alternate_to_consignee_same_as_ship_to, brsd_alternate_to_suburb, brsd_alternate_to_remarks, brsd_from_email_id, brsd_from_remarks, brsd_to_email_id, 
		brsd_to_remarks, brsd_timestamp, brsd_alternate_Contact_remarks, brsd_alternate_email_id, etlcreateddatetime
    FROM stg.stg_tms_brsd_shipment_details;
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
ALTER PROCEDURE dwh.usp_f_brshipmentdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
