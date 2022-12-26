-- PROCEDURE: dwh.usp_f_brthucontractdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_brthucontractdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_brthucontractdetail(
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

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_tms_brctd_br_thu_wise_contract_tariff_dtls;

	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN
	
    UPDATE dwh.F_BRThuContractDetail t
    SET
		br_key					  				= fh.br_key,
        brctd_thu_line_no                       = COALESCE(s.brctd_thu_line_no,''),
        brctd_contract_id                       = s.brctd_contract_id,
        brctd_cont_type                         = s.brctd_cont_type,
        brctd_cont_service_type                 = s.brctd_cont_service_type,
        brctd_cont_valid_from                   = s.brctd_cont_valid_from,
        brctd_cont_valid_to                     = s.brctd_cont_valid_to,
        brctd_tf_tp_type_code                   = s.brctd_tf_tp_type_code,
        brctd_tf_tp_validity_id                 = s.brctd_tf_tp_validity_id,
        brctd_tf_tp_frm_ship_point              = s.brctd_tf_tp_frm_ship_point,
        brctd_tf_tp_to_ship_point               = s.brctd_tf_tp_to_ship_point,
        brctd_tf_tp_frm_geo_type                = s.brctd_tf_tp_frm_geo_type,
        brctd_tf_tp_frm_geo                     = s.brctd_tf_tp_frm_geo,
        brctd_tf_tp_to_geo_type                 = s.brctd_tf_tp_to_geo_type,
        brctd_tf_tp_to_geo                      = s.brctd_tf_tp_to_geo,
        brctd_tf_tp_dist_check                  = s.brctd_tf_tp_dist_check,
        brctd_tf_tp_wt                          = s.brctd_tf_tp_wt,
        brctd_tf_tp_wt_min                      = s.brctd_tf_tp_wt_min,
        brctd_tf_tp_wt_max                      = s.brctd_tf_tp_wt_max,
        brctd_tf_tp_wt_uom                      = s.brctd_tf_tp_wt_uom,
        brctd_tf_tp_vol                         = s.brctd_tf_tp_vol,
        brctd_tf_tp_trip_time                   = s.brctd_tf_tp_trip_time,
        brctd_tf_tp_vol_conversion              = s.brctd_tf_tp_vol_conversion,
        brctd_tf_tp_service                     = s.brctd_tf_tp_service,
        brctd_tf_tp_sub_service                 = s.brctd_tf_tp_sub_service,
        brctd_tf_tp_thu_type                    = s.brctd_tf_tp_thu_type,
        brctd_tf_tp_min_no_thu                  = s.brctd_tf_tp_min_no_thu,
        brctd_tf_tp_max_no_thu                  = s.brctd_tf_tp_max_no_thu,
        brctd_tf_tp_veh_type                    = s.brctd_tf_tp_veh_type,
        brctd_billable_weight                   = s.brctd_billable_weight,
        brctd_rate_for_billable_weight          = s.brctd_rate_for_billable_weight,
        brctd_stage_of_tariff_derivation        = s.brctd_stage_of_tariff_derivation,
        brctd_staging_ref_document              = s.brctd_staging_ref_document,
        brctd_created_by                        = s.brctd_created_by,
        brctd_created_date                      = s.brctd_created_date,
        brctd_cont_amend_no                     = s.brctd_cont_amend_no,
        brctd_billable_quantity                 = s.brctd_billable_quantity,
        brctd_dd_br_volume                      = s.brctd_dd_br_volume,
        brctd_no_of_pallet                      = s.brctd_no_of_pallet,
        brctd_actual_weight                     = s.brctd_actual_weight,
        brctd_actual_weight_uom                 = s.brctd_actual_weight_uom,
        brctd_actual_volume                     = s.brctd_actual_volume,
        brctd_actual_volume_uom                 = s.brctd_actual_volume_uom,
        brctd_basic_charge                      = s.brctd_basic_charge,
        brctd_cont_min_charge                   = s.brctd_cont_min_charge,
        brctd_chargeable_qty                    = s.brctd_chargeable_qty,
        etlactiveind                            = 1,
        etljobname                              = p_etljobname,
        envsourcecd                             = p_envsourcecd,
        datasourcecd                            = p_datasourcecd,
        etlupdatedatetime                       = NOW()
    FROM stg.stg_tms_brctd_br_thu_wise_contract_tariff_dtls s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.brctd_ou 			= fh.br_ouinstance
            AND S.brctd_br_id       = fh.br_request_Id
    WHERE t.brctd_ou = s.brctd_ou
    AND t.brctd_br_id = s.brctd_br_id
    AND t.brctd_tariff_id = s.brctd_tariff_id
	AND COALESCE(t.brctd_thu_line_no,'') = COALESCE(s.brctd_thu_line_no,'')
	AND t.brctd_staging_ref_document =  s.brctd_staging_ref_document;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_BRThuContractDetail
    (
            br_key,
        brctd_ou, brctd_br_id, brctd_thu_line_no, brctd_contract_id, brctd_cont_type, brctd_cont_service_type, brctd_cont_valid_from, brctd_cont_valid_to, brctd_tariff_id, brctd_tf_tp_type_code, brctd_tf_tp_validity_id, brctd_tf_tp_frm_ship_point, brctd_tf_tp_to_ship_point, brctd_tf_tp_frm_geo_type, brctd_tf_tp_frm_geo, brctd_tf_tp_to_geo_type, brctd_tf_tp_to_geo, brctd_tf_tp_dist_check, brctd_tf_tp_wt, brctd_tf_tp_wt_min, brctd_tf_tp_wt_max, brctd_tf_tp_wt_uom, brctd_tf_tp_vol, brctd_tf_tp_trip_time, brctd_tf_tp_vol_conversion, brctd_tf_tp_service, brctd_tf_tp_sub_service, brctd_tf_tp_thu_type, brctd_tf_tp_min_no_thu, brctd_tf_tp_max_no_thu, brctd_tf_tp_veh_type, brctd_billable_weight, brctd_rate_for_billable_weight, brctd_stage_of_tariff_derivation, brctd_staging_ref_document, brctd_created_by, brctd_created_date, brctd_cont_amend_no, brctd_billable_quantity, brctd_dd_br_volume, brctd_no_of_pallet, brctd_actual_weight, brctd_actual_weight_uom, brctd_actual_volume, brctd_actual_volume_uom, brctd_basic_charge, brctd_cont_min_charge, brctd_chargeable_qty, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.br_key,
        s.brctd_ou, s.brctd_br_id, COALESCE(s.brctd_thu_line_no,''), s.brctd_contract_id, s.brctd_cont_type, s.brctd_cont_service_type, s.brctd_cont_valid_from, s.brctd_cont_valid_to, s.brctd_tariff_id, s.brctd_tf_tp_type_code, s.brctd_tf_tp_validity_id, s.brctd_tf_tp_frm_ship_point, s.brctd_tf_tp_to_ship_point, s.brctd_tf_tp_frm_geo_type, s.brctd_tf_tp_frm_geo, s.brctd_tf_tp_to_geo_type, s.brctd_tf_tp_to_geo, s.brctd_tf_tp_dist_check, s.brctd_tf_tp_wt, s.brctd_tf_tp_wt_min, s.brctd_tf_tp_wt_max, s.brctd_tf_tp_wt_uom, s.brctd_tf_tp_vol, s.brctd_tf_tp_trip_time, s.brctd_tf_tp_vol_conversion, s.brctd_tf_tp_service, s.brctd_tf_tp_sub_service, s.brctd_tf_tp_thu_type, s.brctd_tf_tp_min_no_thu, s.brctd_tf_tp_max_no_thu, s.brctd_tf_tp_veh_type, s.brctd_billable_weight, s.brctd_rate_for_billable_weight, s.brctd_stage_of_tariff_derivation, s.brctd_staging_ref_document, s.brctd_created_by, s.brctd_created_date, s.brctd_cont_amend_no, s.brctd_billable_quantity, s.brctd_dd_br_volume, s.brctd_no_of_pallet, s.brctd_actual_weight, s.brctd_actual_weight_uom, s.brctd_actual_volume, s.brctd_actual_volume_uom, s.brctd_basic_charge, s.brctd_cont_min_charge, s.brctd_chargeable_qty, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_brctd_br_thu_wise_contract_tariff_dtls s
	INNER JOIN 	dwh.f_bookingrequest fh 
			ON  s.brctd_ou 			= fh.br_ouinstance
            AND S.brctd_br_id       = fh.br_request_Id
    LEFT JOIN dwh.F_BRThuContractDetail t
    ON s.brctd_ou = t.brctd_ou
    AND s.brctd_br_id = t.brctd_br_id
    AND s.brctd_tariff_id = t.brctd_tariff_id
	AND COALESCE(t.brctd_thu_line_no,'') = COALESCE(s.brctd_thu_line_no,'')
	AND t.brctd_staging_ref_document =  s.brctd_staging_ref_document
    WHERE t.brctd_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_brctd_br_thu_wise_contract_tariff_dtls
    (
        brctd_ou, brctd_br_id, brctd_thu_line_no, brctd_contract_id, brctd_cont_type, brctd_cont_service_type, brctd_cont_valid_from, brctd_cont_valid_to, brctd_tariff_id, brctd_tf_tp_type_code, brctd_tf_tp_division, brctd_tf_tp_location, brctd_tf_tp_validity_id, brctd_tf_tp_frm_ship_point, brctd_tf_tp_to_ship_point, brctd_tf_tp_frm_geo_type, brctd_tf_tp_frm_geo, brctd_tf_tp_to_geo_type, brctd_tf_tp_to_geo, brctd_tf_tp_dist_check, brctd_tf_tp_dist_min, brctd_tf_tp_dist_max, brctd_tf_tp_dist_uom, brctd_tf_tp_wt, brctd_tf_tp_wt_min, brctd_tf_tp_wt_max, brctd_tf_tp_wt_uom, brctd_tf_tp_vol, brctd_tf_tp_vol_min, brctd_tf_tp_vol_max, brctd_tf_tp_vol_uom, brctd_tf_tp_trip_time, brctd_tf_tp_trip_time_min, brctd_tf_tp_trip_time_max, brctd_tf_tp_trip_time_uom, brctd_tf_tp_vol_conversion, brctd_tf_tp_service, brctd_tf_tp_sub_service, brctd_tf_tp_thu_type, brctd_tf_tp_min_no_thu, brctd_tf_tp_max_no_thu, brctd_tf_tp_class_of_stores, brctd_tf_tp_thu_space_frm, brctd_tf_tp_thu_space_to, brctd_tf_tp_equip_type, brctd_tf_tp_veh_type, brctd_billable_weight, brctd_rate_for_billable_weight, brctd_stage_of_tariff_derivation, brctd_staging_ref_document, brctd_created_by, brctd_created_date, brctd_last_modified_by, brctd_last_modified_date, brctd_timestamp, brctd_cont_amend_no, brctd_billable_quantity, brctd_dd_br_volume, brctd_no_of_pallet, brctd_actual_weight, brctd_actual_weight_uom, brctd_actual_volume, brctd_actual_volume_uom, brctd_basic_charge, brctd_cont_min_charge, brctd_leg_behaviour_id, brctd_chargeable_qty, etlcreateddatetime
    )
    SELECT
        brctd_ou, brctd_br_id, brctd_thu_line_no, brctd_contract_id, brctd_cont_type, brctd_cont_service_type, brctd_cont_valid_from, brctd_cont_valid_to, brctd_tariff_id, brctd_tf_tp_type_code, brctd_tf_tp_division, brctd_tf_tp_location, brctd_tf_tp_validity_id, brctd_tf_tp_frm_ship_point, brctd_tf_tp_to_ship_point, brctd_tf_tp_frm_geo_type, brctd_tf_tp_frm_geo, brctd_tf_tp_to_geo_type, brctd_tf_tp_to_geo, brctd_tf_tp_dist_check, brctd_tf_tp_dist_min, brctd_tf_tp_dist_max, brctd_tf_tp_dist_uom, brctd_tf_tp_wt, brctd_tf_tp_wt_min, brctd_tf_tp_wt_max, brctd_tf_tp_wt_uom, brctd_tf_tp_vol, brctd_tf_tp_vol_min, brctd_tf_tp_vol_max, brctd_tf_tp_vol_uom, brctd_tf_tp_trip_time, brctd_tf_tp_trip_time_min, brctd_tf_tp_trip_time_max, brctd_tf_tp_trip_time_uom, brctd_tf_tp_vol_conversion, brctd_tf_tp_service, brctd_tf_tp_sub_service, brctd_tf_tp_thu_type, brctd_tf_tp_min_no_thu, brctd_tf_tp_max_no_thu, brctd_tf_tp_class_of_stores, brctd_tf_tp_thu_space_frm, brctd_tf_tp_thu_space_to, brctd_tf_tp_equip_type, brctd_tf_tp_veh_type, brctd_billable_weight, brctd_rate_for_billable_weight, brctd_stage_of_tariff_derivation, brctd_staging_ref_document, brctd_created_by, brctd_created_date, brctd_last_modified_by, brctd_last_modified_date, brctd_timestamp, brctd_cont_amend_no, brctd_billable_quantity, brctd_dd_br_volume, brctd_no_of_pallet, brctd_actual_weight, brctd_actual_weight_uom, brctd_actual_volume, brctd_actual_volume_uom, brctd_basic_charge, brctd_cont_min_charge, brctd_leg_behaviour_id, brctd_chargeable_qty, etlcreateddatetime
    FROM stg.stg_tms_brctd_br_thu_wise_contract_tariff_dtls;
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
ALTER PROCEDURE dwh.usp_f_brthucontractdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
