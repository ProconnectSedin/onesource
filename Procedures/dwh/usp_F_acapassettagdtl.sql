-- PROCEDURE: dwh.usp_F_acapassettagdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_F_acapassettagdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_F_acapassettagdtl(
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
    FROM stg.Stg_acap_asset_tag_dtl;

    UPDATE dwh.F_acapassettagdtl t
    SET
		account_code_key  		  = COALESCE(acc.opcoa_key, -1), 
		loc_key  				  = COALESCE(l.loc_key,-1),  
        ou_id                     = s.ou_id,
        asset_number              = s.asset_number,
        tag_number                = s.tag_number,
        cap_number                = s.cap_number,
        fb_id                     = s.fb_id,
        asset_desc                = s.asset_desc,
        tag_desc                  = s.tag_desc,
        asset_location            = s.asset_location,
        cost_center               = s.cost_center,
        inservice_date            = s.inservice_date,
        tag_cost                  = s.tag_cost,
        proposal_number           = s.proposal_number,
        tag_status                = s.tag_status,
        depr_category             = s.depr_category,
        inv_cycle                 = s.inv_cycle,
        salvage_value             = s.salvage_value,
        manufacturer              = s.manufacturer,
        bar_code                  = s.bar_code,
        serial_no                 = s.serial_no,
        warranty_no               = s.warranty_no,
        model                     = s.model,
        custodian                 = s.custodian,
        business_use              = s.business_use,
        reverse_remarks           = s.reverse_remarks,
        inv_date                  = s.inv_date,
        inv_due_date              = s.inv_due_date,
        inv_status                = s.inv_status,
        policy_count              = s.policy_count,
        transfer_date             = s.transfer_date,
        legacy_asset_no           = s.legacy_asset_no,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        residualvalue             = s.residualvalue,
        usefullifeinmonths        = s.usefullifeinmonths,
        LAccount_code             = s.LAccount_code,
        LAccount_desc             = s.LAccount_desc,
        Lcost_center              = s.Lcost_center,
        asset_category            = s.asset_category,
        asset_cluster             = s.asset_cluster,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.Stg_acap_asset_tag_dtl s
		LEFT JOIN dwh.d_operationalaccountdetail acc
        	ON acc.account_code             = s.LAccount_code
    	LEFT JOIN dwh.d_location L              
       		ON s.asset_location                   = L.loc_code 
       		AND s.ou_id                        = L.loc_ou
    WHERE t.ou_id = s.ou_id
    AND t.asset_number = s.asset_number
    AND t.tag_number = s.tag_number
    AND t.cap_number = s.cap_number
    AND t.fb_id = s.fb_id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_acapassettagdtl
    (
       	account_code_key,loc_key,ou_id, asset_number, tag_number, cap_number, fb_id, asset_desc, tag_desc, asset_location, cost_center, inservice_date, tag_cost, proposal_number, tag_status, depr_category, inv_cycle, salvage_value, manufacturer, bar_code, serial_no, warranty_no, model, custodian, business_use, reverse_remarks, inv_date, inv_due_date, inv_status, policy_count, transfer_date, legacy_asset_no, createdby, createddate, modifiedby, modifieddate, residualvalue, usefullifeinmonths, LAccount_code, LAccount_desc, Lcost_center, asset_category, asset_cluster, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      COALESCE(acc.opcoa_key, -1), COALESCE(l.loc_key,-1), s.ou_id, s.asset_number, s.tag_number, s.cap_number, s.fb_id, s.asset_desc, s.tag_desc, s.asset_location, s.cost_center, s.inservice_date, s.tag_cost, s.proposal_number, s.tag_status, s.depr_category, s.inv_cycle, s.salvage_value, s.manufacturer, s.bar_code, s.serial_no, s.warranty_no, s.model, s.custodian, s.business_use, s.reverse_remarks, s.inv_date, s.inv_due_date, s.inv_status, s.policy_count, s.transfer_date, s.legacy_asset_no, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.residualvalue, s.usefullifeinmonths, s.LAccount_code, s.LAccount_desc, s.Lcost_center, s.asset_category, s.asset_cluster, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_acap_asset_tag_dtl s
	LEFT JOIN dwh.d_operationalaccountdetail acc
        	ON acc.account_code             = s.LAccount_code
    	LEFT JOIN dwh.d_location L              
       		ON s.asset_location                   = L.loc_code 
       		AND s.ou_id                        = L.loc_ou
    LEFT JOIN dwh.F_acapassettagdtl t
    ON s.ou_id = t.ou_id
    AND s.asset_number = t.asset_number
    AND s.tag_number = t.tag_number
    AND s.cap_number = t.cap_number
    AND s.fb_id = t.fb_id
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_acap_asset_tag_dtl
    (
        ou_id, asset_number, tag_number, cap_number, fb_id, timestamp, asset_desc, tag_desc, asset_location, cost_center, inservice_date, tag_cost, proposal_number, tag_status, depr_category, inv_cycle, salvage_value, manufacturer, bar_code, serial_no, warranty_no, model, custodian, business_use, reverse_remarks, book_value, revalued_cost, inv_date, inv_due_date, inv_status, softrev_run_no, insurable_value, policy_count, dest_fbid, transfer_date, legacy_asset_no, migration_status, tag_cost_orig, tag_cost_diff, createdby, createddate, modifiedby, modifieddate, amend_status, residualvalue, usefullifeinmonths, Remaining_loy, Remaining_lom, Remaining_lod, CUMDEP, assign_date, loan_mapped, LAccount_code, LAccount_desc, Lcost_center, LAnalysis_code, LSubAnalysis_code, asset_category, asset_cluster, asset_capacity, asset_capacity_uom, etlcreateddatetime
    )
    SELECT
        ou_id, asset_number, tag_number, cap_number, fb_id, timestamp, asset_desc, tag_desc, asset_location, cost_center, inservice_date, tag_cost, proposal_number, tag_status, depr_category, inv_cycle, salvage_value, manufacturer, bar_code, serial_no, warranty_no, model, custodian, business_use, reverse_remarks, book_value, revalued_cost, inv_date, inv_due_date, inv_status, softrev_run_no, insurable_value, policy_count, dest_fbid, transfer_date, legacy_asset_no, migration_status, tag_cost_orig, tag_cost_diff, createdby, createddate, modifiedby, modifieddate, amend_status, residualvalue, usefullifeinmonths, Remaining_loy, Remaining_lom, Remaining_lod, CUMDEP, assign_date, loan_mapped, LAccount_code, LAccount_desc, Lcost_center, LAnalysis_code, LSubAnalysis_code, asset_category, asset_cluster, asset_capacity, asset_capacity_uom, etlcreateddatetime
    FROM stg.Stg_acap_asset_tag_dtl;
    
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

ALTER PROCEDURE dwh.usp_F_acapassettagdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
