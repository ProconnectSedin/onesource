-- PROCEDURE: dwh.usp_f_tripvendortariffrevcostdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tripvendortariffrevcostdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tripvendortariffrevcostdetail(
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
    FROM stg.stg_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl;

    UPDATE dwh.f_tripvendortariffrevcostdetail t
    SET
	    tvtrcd_hdr_key                    = fh.tvtrch_key,
        tvtrcd_leg_id                     = s.tvtrcd_leg_id,
        tvtrcd_buy_sell_type              = s.tvtrcd_buy_sell_type,
        tvtrcd_stage_of_derivation        = s.tvtrcd_stage_of_derivation,
        tvtrcd_date_of_stage              = s.tvtrcd_date_of_stage,
        tvtrcd_contract_id                = s.tvtrcd_contract_id,
        tvtrcd_tariff_id                  = s.tvtrcd_tariff_id,
        tvtrcd_tariff_type                = s.tvtrcd_tariff_type,
        tvtrcd_rate                       = s.tvtrcd_rate,
        tvtrcd_remarks                    = s.tvtrcd_remarks,
        tvtrcd_trip_rev_cost_sk           = s.tvtrcd_trip_rev_cost_sk,
        tvtrcd_trip_plan_hdr_sk           = s.tvtrcd_trip_plan_hdr_sk,
        tvtrcd_created_by                 = s.tvtrcd_created_by,
        tvtrcd_created_date               = s.tvtrcd_created_date,
        tvtrcd_modified_by                = s.tvtrcd_modified_by,
        tvtrcd_modified_date              = s.tvtrcd_modified_date,
        tvtrcd_time_stamp                 = s.tvtrcd_time_stamp,
        tvtrcd_resource_type              = s.tvtrcd_resource_type,
        tvtrcd_weight                     = s.tvtrcd_weight,
        tvtrcd_weight_uom                 = s.tvtrcd_weight_uom,
        tvtrcd_pallet                     = s.tvtrcd_pallet,
        tvtrcd_chk_flag                   = s.tvtrcd_chk_flag,
        tvtrcd_vendor_flag                = s.tvtrcd_vendor_flag,
        tvtrcd_tariff_remarks             = s.tvtrcd_tariff_remarks,
        tvtrcd_resource_id                = s.tvtrcd_resource_id,
        tvtrcd_amendment_no               = s.tvtrcd_amendment_no,
        tvtrcd_fl_tariff_id               = s.tvtrcd_fl_tariff_id,
        tvtrcd_Agreed_Rate                = s.tvtrcd_Agreed_Rate,
        tvtrcd_Agreed_cost                = s.tvtrcd_Agreed_cost,
        tvtrcd_charagable_quantity        = s.tvtrcd_charagable_quantity,
        tvtrcd_exchange_rate              = s.tvtrcd_exchange_rate,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl s
	inner join dwh.f_tripvendortariffrevcostheader fh
	on  tvtrch_ouinstance = tvtrcd_ouinstance
	and tvtrch_trip_plan_id = tvtrcd_trip_plan_id
	and tvtrch_buy_sell_type =tvtrcd_buy_sell_type
	and tvtrch_stage_of_derivation =tvtrcd_stage_of_derivation
	and tvtrch_trip_plan_hdr_sk = tvtrcd_trip_plan_hdr_sk
    WHERE t.tvtrcd_ouinstance = s.tvtrcd_ouinstance
    AND t.tvtrcd_trip_plan_id = s.tvtrcd_trip_plan_id
    AND t.tvtrcd_booking_request = s.tvtrcd_booking_request
    AND t.tvtrcd_unique_id = s.tvtrcd_unique_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_tripvendortariffrevcostdetail
    (
        tvtrcd_hdr_key,tvtrcd_ouinstance, tvtrcd_trip_plan_id, tvtrcd_booking_request, tvtrcd_unique_id, tvtrcd_leg_id, 
		tvtrcd_buy_sell_type, tvtrcd_stage_of_derivation, tvtrcd_date_of_stage, tvtrcd_contract_id, tvtrcd_tariff_id, 
		tvtrcd_tariff_type, tvtrcd_rate, tvtrcd_remarks, tvtrcd_trip_rev_cost_sk, tvtrcd_trip_plan_hdr_sk, tvtrcd_created_by, 
		tvtrcd_created_date, tvtrcd_modified_by, tvtrcd_modified_date, tvtrcd_time_stamp, tvtrcd_resource_type, tvtrcd_weight, 
		tvtrcd_weight_uom, tvtrcd_pallet, tvtrcd_chk_flag, tvtrcd_vendor_flag, tvtrcd_tariff_remarks, tvtrcd_resource_id, 
		tvtrcd_amendment_no, tvtrcd_fl_tariff_id, tvtrcd_Agreed_Rate, tvtrcd_Agreed_cost, tvtrcd_charagable_quantity, 
		tvtrcd_exchange_rate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        fh.tvtrch_key,s.tvtrcd_ouinstance, s.tvtrcd_trip_plan_id, s.tvtrcd_booking_request, s.tvtrcd_unique_id, s.tvtrcd_leg_id, 
		s.tvtrcd_buy_sell_type, s.tvtrcd_stage_of_derivation, s.tvtrcd_date_of_stage, s.tvtrcd_contract_id, s.tvtrcd_tariff_id, 
		s.tvtrcd_tariff_type, s.tvtrcd_rate, s.tvtrcd_remarks, s.tvtrcd_trip_rev_cost_sk, s.tvtrcd_trip_plan_hdr_sk, s.tvtrcd_created_by, 
		s.tvtrcd_created_date, s.tvtrcd_modified_by, s.tvtrcd_modified_date, s.tvtrcd_time_stamp, s.tvtrcd_resource_type, s.tvtrcd_weight,
		s.tvtrcd_weight_uom, s.tvtrcd_pallet, s.tvtrcd_chk_flag, s.tvtrcd_vendor_flag, s.tvtrcd_tariff_remarks, s.tvtrcd_resource_id, 
		s.tvtrcd_amendment_no, s.tvtrcd_fl_tariff_id, s.tvtrcd_Agreed_Rate, s.tvtrcd_Agreed_cost, s.tvtrcd_charagable_quantity,
		s.tvtrcd_exchange_rate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl s
	inner join dwh.f_tripvendortariffrevcostheader fh
	on  tvtrch_ouinstance = tvtrcd_ouinstance
	and tvtrch_trip_plan_id = tvtrcd_trip_plan_id
	and tvtrch_buy_sell_type =tvtrcd_buy_sell_type
	and tvtrch_stage_of_derivation =tvtrcd_stage_of_derivation
	and tvtrch_trip_plan_hdr_sk = tvtrcd_trip_plan_hdr_sk
    LEFT JOIN dwh.f_tripvendortariffrevcostdetail t
    ON s.tvtrcd_ouinstance = t.tvtrcd_ouinstance
    AND s.tvtrcd_trip_plan_id = t.tvtrcd_trip_plan_id
    AND s.tvtrcd_booking_request = t.tvtrcd_booking_request
    AND s.tvtrcd_unique_id = t.tvtrcd_unique_id
    WHERE t.tvtrcd_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl
    (
        tvtrcd_ouinstance, tvtrcd_trip_plan_id, tvtrcd_booking_request, tvtrcd_unique_id, tvtrcd_leg_id, tvtrcd_buy_sell_type, 
		tvtrcd_stage_of_derivation, tvtrcd_date_of_stage, tvtrcd_contract_id, tvtrcd_tariff_id, tvtrcd_tariff_type, tvtrcd_rate, 
		tvtrcd_remarks, tvtrcd_trip_rev_cost_sk, tvtrcd_trip_plan_hdr_sk, tvtrcd_created_by, tvtrcd_created_date, tvtrcd_modified_by, 
		tvtrcd_modified_date, tvtrcd_time_stamp, tvtrcd_resource_type, tvtrcd_weight, tvtrcd_weight_uom, tvtrcd_pallet, tvtrcd_chk_flag, 
		tvtrcd_vendor_flag, tvtrcd_tariff_remarks, tvtrcd_resource_id, tvtrcd_amendment_no, tvtrcd_fl_tariff_id, tvtrcd_Agreed_Rate, 
		tvtrcd_Agreed_cost, tvtrcd_charagable_quantity, tvtrcd_exchange_rate, etlcreateddatetime
    )
    SELECT
        tvtrcd_ouinstance, tvtrcd_trip_plan_id, tvtrcd_booking_request, tvtrcd_unique_id, tvtrcd_leg_id, tvtrcd_buy_sell_type, 
		tvtrcd_stage_of_derivation, tvtrcd_date_of_stage, tvtrcd_contract_id, tvtrcd_tariff_id, tvtrcd_tariff_type, tvtrcd_rate, 
		tvtrcd_remarks, tvtrcd_trip_rev_cost_sk, tvtrcd_trip_plan_hdr_sk, tvtrcd_created_by, tvtrcd_created_date, tvtrcd_modified_by, 
		tvtrcd_modified_date, tvtrcd_time_stamp, tvtrcd_resource_type, tvtrcd_weight, tvtrcd_weight_uom, tvtrcd_pallet, tvtrcd_chk_flag, 
		tvtrcd_vendor_flag, tvtrcd_tariff_remarks, tvtrcd_resource_id, tvtrcd_amendment_no, tvtrcd_fl_tariff_id, tvtrcd_Agreed_Rate, 
		tvtrcd_Agreed_cost, tvtrcd_charagable_quantity, tvtrcd_exchange_rate, etlcreateddatetime
    FROM stg.stg_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl;
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
ALTER PROCEDURE dwh.usp_f_tripvendortariffrevcostdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
