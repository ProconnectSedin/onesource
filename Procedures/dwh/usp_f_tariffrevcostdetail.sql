-- PROCEDURE: dwh.usp_f_tariffrevcostdetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tariffrevcostdetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tariffrevcostdetail(
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
    FROM stg.stg_tms_tarcd_tariff_rev_cost_dtl;

    UPDATE dwh.F_TariffRevCostDetail t
    SET
	    tarcd_trip_hdr_key               = COALESCE(fh.plpth_hdr_key,-1),
        tarcd_leg_id                     = s.tarcd_leg_id,
        tarcd_date_of_stage              = s.tarcd_date_of_stage,
        tarcd_contract_id                = s.tarcd_contract_id,
        tarcd_tariff_id                  = s.tarcd_tariff_id,
        tarcd_tariff_type                = s.tarcd_tariff_type,
        tarcd_rate                       = s.tarcd_rate,
        tarcd_remarks                    = s.tarcd_remarks,
        tarcd_trip_rev_cost_sk           = s.tarcd_trip_rev_cost_sk,
        tarcd_trip_plan_hdr_sk           = s.tarcd_trip_plan_hdr_sk,
        tarcd_created_by                 = s.tarcd_created_by,
        tarcd_created_date               = s.tarcd_created_date,
        tarcd_resource_type              = s.tarcd_resource_type,
        tarcd_weight                     = s.tarcd_weight,
        tarcd_weight_uom                 = s.tarcd_weight_uom,
        tarcd_pallet                     = s.tarcd_pallet,
        tarcd_vendor_flag                = s.tarcd_vendor_flag,
        tarcd_resource_id                = s.tarcd_resource_id,
        tarcd_amendment_no               = s.tarcd_amendment_no,
        tarcd_Agreed_Rate                = s.tarcd_Agreed_Rate,
        tarcd_Agreed_cost                = s.tarcd_Agreed_cost,
        tarcd_charagable_quantity        = s.tarcd_charagable_quantity,
        etlactiveind                     = 1,
        etljobname                       = p_etljobname,
        envsourcecd                      = p_envsourcecd,
        datasourcecd                     = p_datasourcecd,
        etlupdatedatetime                = NOW()
    FROM stg.stg_tms_tarcd_tariff_rev_cost_dtl s
	LEFT join dwh.f_tripplanningheader fh
	ON		tarcd_ouinstance			=	fh.plpth_ouinstance
	AND		tarcd_trip_plan_id			=	fh.plpth_trip_plan_id
    WHERE	t.tarcd_ouinstance			=	s.tarcd_ouinstance
    AND		t.tarcd_trip_plan_id		=	s.tarcd_trip_plan_id
    AND		t.tarcd_booking_request		=	s.tarcd_booking_request
	AND		t.tarcd_stage_of_derivation =	s.tarcd_stage_of_derivation
	AND		t.tarcd_buy_sell_type       =	s.tarcd_buy_sell_type
    AND		t.tarcd_unique_id			=	s.tarcd_unique_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_TariffRevCostDetail
    (
        tarcd_trip_hdr_key,tarcd_ouinstance, tarcd_trip_plan_id, tarcd_booking_request, tarcd_unique_id, tarcd_leg_id, tarcd_buy_sell_type, 
		tarcd_stage_of_derivation, tarcd_date_of_stage, tarcd_contract_id, tarcd_tariff_id, tarcd_tariff_type, tarcd_rate, 
		tarcd_remarks, tarcd_trip_rev_cost_sk, tarcd_trip_plan_hdr_sk, tarcd_created_by, tarcd_created_date, tarcd_resource_type, 
		tarcd_weight, tarcd_weight_uom, tarcd_pallet, tarcd_vendor_flag, tarcd_resource_id, tarcd_amendment_no, tarcd_Agreed_Rate, 
		tarcd_Agreed_cost, tarcd_charagable_quantity, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(fh.plpth_hdr_key,-1),s.tarcd_ouinstance, s.tarcd_trip_plan_id, s.tarcd_booking_request, s.tarcd_unique_id, s.tarcd_leg_id, s.tarcd_buy_sell_type, 
		s.tarcd_stage_of_derivation, s.tarcd_date_of_stage, s.tarcd_contract_id, s.tarcd_tariff_id, s.tarcd_tariff_type, s.tarcd_rate, 
		s.tarcd_remarks, s.tarcd_trip_rev_cost_sk, s.tarcd_trip_plan_hdr_sk, s.tarcd_created_by, s.tarcd_created_date, s.tarcd_resource_type, 
		s.tarcd_weight, s.tarcd_weight_uom, s.tarcd_pallet, s.tarcd_vendor_flag, s.tarcd_resource_id, s.tarcd_amendment_no, s.tarcd_Agreed_Rate,
		s.tarcd_Agreed_cost, s.tarcd_charagable_quantity, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_tms_tarcd_tariff_rev_cost_dtl s
	LEFT JOIN dwh.f_tripplanningheader fh
	ON		tarcd_ouinstance			=	fh.plpth_ouinstance
	AND		tarcd_trip_plan_id			=	fh.plpth_trip_plan_id
    LEFT JOIN dwh.F_TariffRevCostDetail t
    ON		s.tarcd_ouinstance			=	t.tarcd_ouinstance
    AND		s.tarcd_trip_plan_id		=	t.tarcd_trip_plan_id
    AND		s.tarcd_booking_request		=	t.tarcd_booking_request
	AND		s.tarcd_stage_of_derivation =	t.tarcd_stage_of_derivation
	AND		s.tarcd_buy_sell_type       =	t.tarcd_buy_sell_type
    AND		s.tarcd_unique_id			=	t.tarcd_unique_id
    WHERE	t.tarcd_ouinstance IS NULL;
	

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_tms_tarcd_tariff_rev_cost_dtl
    (
        tarcd_ouinstance, tarcd_trip_plan_id, tarcd_booking_request, tarcd_unique_id, tarcd_leg_id, tarcd_buy_sell_type, 
		tarcd_stage_of_derivation, tarcd_date_of_stage, tarcd_contract_id, tarcd_tariff_id, tarcd_tariff_type, tarcd_rate, 
		tarcd_remarks, tarcd_trip_rev_cost_sk, tarcd_trip_plan_hdr_sk, tarcd_created_by, tarcd_created_date, tarcd_modified_by, 
		tarcd_modified_date, tarcd_time_stamp, tarcd_resource_type, tarcd_weight, tarcd_weight_uom, tarcd_pallet, tarcd_vendor_flag, 
		tarcd_resource_id, tarcd_amendment_no, Vehicle_cost, Equipment_1_cost, Equipment_2_cost, Driver_1_cost, Driver_2_cost, 
		Handler_1_cost, Handler_2_cost, tarcd_Agreed_Rate, tarcd_Agreed_cost, tarcd_charagable_quantity, tarcd_exchange_rate, etlcreateddatetime
    )
    SELECT
        tarcd_ouinstance, tarcd_trip_plan_id, tarcd_booking_request, tarcd_unique_id, tarcd_leg_id, tarcd_buy_sell_type, 
		tarcd_stage_of_derivation, tarcd_date_of_stage, tarcd_contract_id, tarcd_tariff_id, tarcd_tariff_type, tarcd_rate,
		tarcd_remarks, tarcd_trip_rev_cost_sk, tarcd_trip_plan_hdr_sk, tarcd_created_by, tarcd_created_date, tarcd_modified_by,
		tarcd_modified_date, tarcd_time_stamp, tarcd_resource_type, tarcd_weight, tarcd_weight_uom, tarcd_pallet, tarcd_vendor_flag,
		tarcd_resource_id, tarcd_amendment_no, Vehicle_cost, Equipment_1_cost, Equipment_2_cost, Driver_1_cost, Driver_2_cost, 
		Handler_1_cost, Handler_2_cost, tarcd_Agreed_Rate, tarcd_Agreed_cost, tarcd_charagable_quantity, tarcd_exchange_rate, etlcreateddatetime
    FROM stg.stg_tms_tarcd_tariff_rev_cost_dtl;
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
ALTER PROCEDURE dwh.usp_f_tariffrevcostdetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
