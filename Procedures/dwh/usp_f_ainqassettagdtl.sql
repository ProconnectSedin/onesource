-- PROCEDURE: dwh.usp_f_ainqassettagdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ainqassettagdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ainqassettagdtl(
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
    FROM stg.Stg_ainq_asset_tag_dtl;

    UPDATE dwh.F_ainqassettagdtl t
    SET
		ainqassettagdtl_lockey	  = coalesce(l.loc_key,-1),
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
        book_value                = s.book_value,
        revalued_cost             = s.revalued_cost,
        inv_due_date              = s.inv_due_date,
        inv_status                = s.inv_status,
        policy_count              = s.policy_count,
        transfer_date             = s.transfer_date,
        legacy_asset_no           = s.legacy_asset_no,
        createdby                 = s.createdby,
        createddate               = s.createddate,
        modifiedby                = s.modifiedby,
        modifieddate              = s.modifieddate,
        proposal_number           = s.proposal_number,
        cum_down_rev_cost         = s.cum_down_rev_cost,
        cum_up_rev_cost           = s.cum_up_rev_cost,
        depr_book                 = s.depr_book,
        residualvalue             = s.residualvalue,
        usefullifeinmonths        = s.usefullifeinmonths,
        ari_flag                  = s.ari_flag,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.Stg_ainq_asset_tag_dtl s
	left join  dwh.d_location l
	on l.loc_code = s.asset_location
	and l.loc_ou	  = s.ou_id
    WHERE t.ou_id = s.ou_id
    AND t.asset_number = s.asset_number
    AND t.tag_number = s.tag_number
    AND t.cap_number = s.cap_number
    AND t.fb_id = s.fb_id
    AND t.depr_book = s.depr_book;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ainqassettagdtl
    (
      ainqassettagdtl_lockey,  ou_id, asset_number, tag_number, cap_number, fb_id, asset_desc, tag_desc, asset_location, cost_center, inservice_date, tag_cost, tag_status, depr_category, inv_cycle, salvage_value, manufacturer, bar_code, serial_no, warranty_no, model, custodian, business_use, book_value, revalued_cost, inv_due_date, inv_status, policy_count, transfer_date, legacy_asset_no, createdby, createddate, modifiedby, modifieddate, proposal_number, cum_down_rev_cost, cum_up_rev_cost, depr_book, residualvalue, usefullifeinmonths, ari_flag, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
     coalesce(l.loc_key,-1),   s.ou_id, s.asset_number, s.tag_number, s.cap_number, s.fb_id, s.asset_desc, s.tag_desc, s.asset_location, s.cost_center, s.inservice_date, s.tag_cost, s.tag_status, s.depr_category, s.inv_cycle, s.salvage_value, s.manufacturer, s.bar_code, s.serial_no, s.warranty_no, s.model, s.custodian, s.business_use, s.book_value, s.revalued_cost, s.inv_due_date, s.inv_status, s.policy_count, s.transfer_date, s.legacy_asset_no, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.proposal_number, s.cum_down_rev_cost, s.cum_up_rev_cost, s.depr_book, s.residualvalue, s.usefullifeinmonths, s.ari_flag, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_ainq_asset_tag_dtl s
	left join  dwh.d_location l
	on l.loc_code = s.asset_location
	and l.loc_ou	  = s.ou_id	
    LEFT JOIN dwh.F_ainqassettagdtl t
    ON s.ou_id = t.ou_id
    AND s.asset_number = t.asset_number
    AND s.tag_number = t.tag_number
    AND s.cap_number = t.cap_number
    AND s.fb_id = t.fb_id
    AND s.depr_book = t.depr_book
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ainq_asset_tag_dtl
    (
        ou_id, asset_number, tag_number, cap_number, fb_id, timestamp, asset_desc, tag_desc, asset_location, cost_center, inservice_date, tag_cost, tag_status, depr_category, inv_cycle, salvage_value, manufacturer, bar_code, serial_no, warranty_no, model, custodian, business_use, reverse_remarks, book_value, revalued_cost, inv_date, inv_due_date, inv_status, softrev_run_no, insurable_value, policy_count, dest_fbid, transfer_date, legacy_asset_no, migration_status, createdby, createddate, modifiedby, modifieddate, proposal_number, cum_down_rev_cost, cum_up_rev_cost, split_date, depr_book, residualvalue, usefullifeinmonths, cum_imp_loss, ari_flag, asset_category, asset_cluster, asset_capacity, asset_capacity_uom, asset_appr_capacity, asset_cumdep_capacity, asset_usage_uptp, etlcreateddatetime
    )
    SELECT
        ou_id, asset_number, tag_number, cap_number, fb_id, timestamp, asset_desc, tag_desc, asset_location, cost_center, inservice_date, tag_cost, tag_status, depr_category, inv_cycle, salvage_value, manufacturer, bar_code, serial_no, warranty_no, model, custodian, business_use, reverse_remarks, book_value, revalued_cost, inv_date, inv_due_date, inv_status, softrev_run_no, insurable_value, policy_count, dest_fbid, transfer_date, legacy_asset_no, migration_status, createdby, createddate, modifiedby, modifieddate, proposal_number, cum_down_rev_cost, cum_up_rev_cost, split_date, depr_book, residualvalue, usefullifeinmonths, cum_imp_loss, ari_flag, asset_category, asset_cluster, asset_capacity, asset_capacity_uom, asset_appr_capacity, asset_cumdep_capacity, asset_usage_uptp, etlcreateddatetime
    FROM stg.Stg_ainq_asset_tag_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_ainqassettagdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
