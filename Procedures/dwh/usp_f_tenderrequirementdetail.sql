-- PROCEDURE: dwh.usp_f_tenderrequirementdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tenderrequirementdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tenderrequirementdetail(
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
    FROM stg.stg_tms_trd_tender_req_dtls;

    UPDATE dwh.F_TenderRequirementDetail t
    SET

    	trd_hdr_key               		   = fh.trh_hdr_key,
        trd_ouinstance                    = s.trd_ouinstance,
        trd_tender_req_no                 = s.trd_tender_req_no,
        trd_tender_req_line_no            = s.trd_tender_req_line_no,
        trd_ref_doc_type                  = s.trd_ref_doc_type,
        trd_from_geo                      = s.trd_from_geo,
        trd_from_geo_type                 = s.trd_from_geo_type,
        trd_to_geo                        = s.trd_to_geo,
        trd_to_geo_type                   = s.trd_to_geo_type,
        trd_req_for_vehicle               = s.trd_req_for_vehicle,
        trd_req_for_equipment             = s.trd_req_for_equipment,
        trd_req_for_driver                = s.trd_req_for_driver,
        trd_req_for_handler               = s.trd_req_for_handler,
        trd_req_for_services              = s.trd_req_for_services,
        trd_req_for_schedule              = s.trd_req_for_schedule,
        trd_req_created_by                = s.trd_req_created_by,
        trd_req_created_date              = s.trd_req_created_date,
        trd_req_last_modified_by          = s.trd_req_last_modified_by,
        trd_req_last_modified_date        = s.trd_req_last_modified_date,
        trd_timestamp                     = s.trd_timestamp,
        trd_trip_plan_id                  = s.trd_trip_plan_id,
        geo_city_desc                     = s.wms_geo_city_desc,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_tms_trd_tender_req_dtls s
    INNER JOIN  dwh.f_tenderrequirementheader fh 
		ON  s.trd_ouinstance		= fh.trh_ouinstance 
		AND s.trd_tender_req_no		= fh.trh_tender_req_no 
    WHERE t.trd_ouinstance			= s.trd_ouinstance
		AND t.trd_tender_req_no		= s.trd_tender_req_no
		AND t.trd_tender_req_line_no = s.trd_tender_req_line_no
		AND t.trd_ref_doc_no		= s.trd_ref_doc_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_TenderRequirementDetail
    ( 
        trd_hdr_key, trd_ouinstance, trd_tender_req_no, trd_tender_req_line_no, trd_ref_doc_type, trd_ref_doc_no, trd_from_geo, trd_from_geo_type, trd_to_geo, trd_to_geo_type, trd_req_for_vehicle, trd_req_for_equipment, trd_req_for_driver, trd_req_for_handler, trd_req_for_services, trd_req_for_schedule, trd_req_created_by, trd_req_created_date, trd_req_last_modified_by, trd_req_last_modified_date, trd_timestamp, trd_trip_plan_id, geo_city_desc, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.trh_hdr_key, s.trd_ouinstance, s.trd_tender_req_no, s.trd_tender_req_line_no, s.trd_ref_doc_type, s.trd_ref_doc_no, s.trd_from_geo, s.trd_from_geo_type, s.trd_to_geo, s.trd_to_geo_type, s.trd_req_for_vehicle, s.trd_req_for_equipment, s.trd_req_for_driver, s.trd_req_for_handler, s.trd_req_for_services, s.trd_req_for_schedule, s.trd_req_created_by, s.trd_req_created_date, s.trd_req_last_modified_by, s.trd_req_last_modified_date, s.trd_timestamp, s.trd_trip_plan_id, s.wms_geo_city_desc, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_trd_tender_req_dtls s

    INNER JOIN  dwh.f_tenderrequirementheader fh 
		ON  s.trd_ouinstance		= fh.trh_ouinstance 
		AND s.trd_tender_req_no		= fh.trh_tender_req_no
    LEFT JOIN dwh.F_TenderRequirementDetail t
		ON s.trd_ouinstance			= t.trd_ouinstance
		AND s.trd_tender_req_no		= t.trd_tender_req_no
		AND s.trd_tender_req_line_no = t.trd_tender_req_line_no
		AND s.trd_ref_doc_no		= t.trd_ref_doc_no
    WHERE t.trd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_trd_tender_req_dtls
    (
        trd_ouinstance, trd_tender_req_no, trd_tender_req_line_no, trd_ref_doc_type, trd_ref_doc_no, trd_from_geo, trd_from_geo_type, trd_to_geo, trd_to_geo_type, trd_req_for_vehicle, trd_req_for_equipment, trd_req_for_driver, trd_req_for_handler, trd_req_for_services, trd_req_for_schedule, trd_req_created_by, trd_req_created_date, trd_req_last_modified_by, trd_req_last_modified_date, trd_timestamp, trd_trip_plan_id, wms_geo_city_desc, etlcreateddatetime
    )
    SELECT
        trd_ouinstance, trd_tender_req_no, trd_tender_req_line_no, trd_ref_doc_type, trd_ref_doc_no, trd_from_geo, trd_from_geo_type, trd_to_geo, trd_to_geo_type, trd_req_for_vehicle, trd_req_for_equipment, trd_req_for_driver, trd_req_for_handler, trd_req_for_services, trd_req_for_schedule, trd_req_created_by, trd_req_created_date, trd_req_last_modified_by, trd_req_last_modified_date, trd_timestamp, trd_trip_plan_id, wms_geo_city_desc, etlcreateddatetime
    FROM stg.stg_tms_trd_tender_req_dtls;
    
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
ALTER PROCEDURE dwh.usp_f_tenderrequirementdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
