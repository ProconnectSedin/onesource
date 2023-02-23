-- PROCEDURE: dwh.usp_d_itmiouitemvarhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_itmiouitemvarhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_itmiouitemvarhdr(
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
    FROM stg.stg_itm_iou_itemvarhdr;

    UPDATE dwh.D_itmiouitemvarhdr t
    SET
        iou_itemcode                   = s.iou_itemcode,
        iou_variantcode                = s.iou_variantcode,
        iou_ou                         = s.iou_ou,
        iou_bu                         = s.iou_bu,
        iou_lo                         = s.iou_lo,
        iou_num_type                   = s.iou_num_type,
        iou_effectivefrom              = s.iou_effectivefrom,
        iou_effectiveto                = s.iou_effectiveto,
        iou_status                     = s.iou_status,
        iou_stdwhcode                  = s.iou_stdwhcode,
        iou_minissueqty                = s.iou_minissueqty,
        iou_stdcost                    = s.iou_stdcost,
        iou_stdcostperqty              = s.iou_stdcostperqty,
        iou_stdcostuom                 = s.iou_stdcostuom,
        iou_allocationmtd              = s.iou_allocationmtd,
        iou_allocationhorizon          = s.iou_allocationhorizon,
        iou_sales_usage                = s.iou_sales_usage,
        iou_mfg_source                 = s.iou_mfg_source,
        iou_production_usage           = s.iou_production_usage,
        iou_purchase_source            = s.iou_purchase_source,
        iou_maintenance_usage          = s.iou_maintenance_usage,
        iou_subcntract_source          = s.iou_subcntract_source,
        iou_stktransfer_source         = s.iou_stktransfer_source,
        iou_others_usage               = s.iou_others_usage,
        iou_returnable                 = s.iou_returnable,
        iou_hazardous                  = s.iou_hazardous,
        iou_backflushreqd              = s.iou_backflushreqd,
        iou_storagealloc               = s.iou_storagealloc,
        iou_qcclearence                = s.iou_qcclearence,
        iou_planningtype               = s.iou_planningtype,
        iou_abc                        = s.iou_abc,
        iou_disposition                = s.iou_disposition,
        iou_stockableflg               = s.iou_stockableflg,
        iou_lotnotypeno                = s.iou_lotnotypeno,
        iou_slnotypeno                 = s.iou_slnotypeno,
        iou_mainref4                   = s.iou_mainref4,
        iou_basref1                    = s.iou_basref1,
        iou_basref4                    = s.iou_basref4,
        iou_planref4                   = s.iou_planref4,
        iou_created_by                 = s.iou_created_by,
        iou_created_date               = s.iou_created_date,
        iou_modified_by                = s.iou_modified_by,
        iou_modified_date              = s.iou_modified_date,
        iou_plan_created_by            = s.iou_plan_created_by,
        iou_plan_created_date          = s.iou_plan_created_date,
        iou_plan_modified_by           = s.iou_plan_modified_by,
        iou_plan_modified_date         = s.iou_plan_modified_date,
        iou_timestamp                  = s.iou_timestamp,
        iou_manufact_source_pri        = s.iou_manufact_source_pri,
        iou_purchase_source_pri        = s.iou_purchase_source_pri,
        iou_catwght_ntol               = s.iou_catwght_ntol,
        iou_catwght_ptol               = s.iou_catwght_ptol,
        iou_hardallocationrqd          = s.iou_hardallocationrqd,
        iou_qcproduction               = s.iou_qcproduction,
        iou_testlevel                  = s.iou_testlevel,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_itm_iou_itemvarhdr s
    WHERE t.iou_itemcode = s.iou_itemcode
    AND t.iou_variantcode = s.iou_variantcode
    AND t.iou_ou = s.iou_ou
    AND t.iou_bu = s.iou_bu
    AND t.iou_lo = s.iou_lo;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_itmiouitemvarhdr
    (
        iou_itemcode, iou_variantcode, iou_ou, iou_bu, iou_lo, iou_num_type, iou_effectivefrom, iou_effectiveto, iou_status, iou_stdwhcode, iou_minissueqty, iou_stdcost, iou_stdcostperqty, iou_stdcostuom, iou_allocationmtd, iou_allocationhorizon, iou_sales_usage, iou_mfg_source, iou_production_usage, iou_purchase_source, iou_maintenance_usage, iou_subcntract_source, iou_stktransfer_source, iou_others_usage, iou_returnable, iou_hazardous, iou_backflushreqd, iou_storagealloc, iou_qcclearence, iou_planningtype, iou_abc, iou_disposition, iou_stockableflg, iou_lotnotypeno, iou_slnotypeno, iou_mainref4, iou_basref1, iou_basref4, iou_planref4, iou_created_by, iou_created_date, iou_modified_by, iou_modified_date, iou_plan_created_by, iou_plan_created_date, iou_plan_modified_by, iou_plan_modified_date, iou_timestamp, iou_manufact_source_pri, iou_purchase_source_pri, iou_catwght_ntol, iou_catwght_ptol, iou_hardallocationrqd, iou_qcproduction, iou_testlevel, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.iou_itemcode, s.iou_variantcode, s.iou_ou, s.iou_bu, s.iou_lo, s.iou_num_type, s.iou_effectivefrom, s.iou_effectiveto, s.iou_status, s.iou_stdwhcode, s.iou_minissueqty, s.iou_stdcost, s.iou_stdcostperqty, s.iou_stdcostuom, s.iou_allocationmtd, s.iou_allocationhorizon, s.iou_sales_usage, s.iou_mfg_source, s.iou_production_usage, s.iou_purchase_source, s.iou_maintenance_usage, s.iou_subcntract_source, s.iou_stktransfer_source, s.iou_others_usage, s.iou_returnable, s.iou_hazardous, s.iou_backflushreqd, s.iou_storagealloc, s.iou_qcclearence, s.iou_planningtype, s.iou_abc, s.iou_disposition, s.iou_stockableflg, s.iou_lotnotypeno, s.iou_slnotypeno, s.iou_mainref4, s.iou_basref1, s.iou_basref4, s.iou_planref4, s.iou_created_by, s.iou_created_date, s.iou_modified_by, s.iou_modified_date, s.iou_plan_created_by, s.iou_plan_created_date, s.iou_plan_modified_by, s.iou_plan_modified_date, s.iou_timestamp, s.iou_manufact_source_pri, s.iou_purchase_source_pri, s.iou_catwght_ntol, s.iou_catwght_ptol, s.iou_hardallocationrqd, s.iou_qcproduction, s.iou_testlevel, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_itm_iou_itemvarhdr s
    LEFT JOIN dwh.D_itmiouitemvarhdr t
    ON s.iou_itemcode = t.iou_itemcode
    AND s.iou_variantcode = t.iou_variantcode
    AND s.iou_ou = t.iou_ou
    AND s.iou_bu = t.iou_bu
    AND s.iou_lo = t.iou_lo
    WHERE t.iou_itemcode IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_itm_iou_itemvarhdr
    (
        iou_itemcode, iou_variantcode, iou_ou, iou_bu, iou_lo, iou_num_type, iou_effectivefrom, iou_effectiveto, iou_status, iou_stdwhcode, iou_minissueqty, iou_stdcost, iou_stdcostperqty, iou_stdcostuom, iou_allocationmtd, iou_allocationhorizon, iou_sales_usage, iou_mfg_source, iou_production_usage, iou_purchase_source, iou_maintenance_usage, iou_subcntract_source, iou_stktransfer_source, iou_others_usage, iou_returnable, iou_hazardous, iou_backflushreqd, iou_storagealloc, iou_qcclearence, iou_planningtype, iou_xyz, iou_abc, iou_fsn, iou_ved, iou_minqty, iou_maxqty, iou_safetystock, iou_disposition, iou_receipthorizon, iou_reserhorizon, iou_reorderactat, iou_reorderactby, iou_reorderlevel, iou_reorderqty, iou_stockableflg, iou_lotnotypeno, iou_slnotypeno, iou_mainref1, iou_mainref2, iou_mainref3, iou_mainref4, iou_basref1, iou_basref2, iou_basref3, iou_basref4, iou_planref1, iou_planref2, iou_planref3, iou_planref4, iou_created_by, iou_created_date, iou_modified_by, iou_modified_date, iou_plan_created_by, iou_plan_created_date, iou_plan_modified_by, iou_plan_modified_date, iou_timestamp, iou_manufact_source_pri, iou_purchase_source_pri, iou_subcon_source_pri, iou_stktran_source_pri, iou_catwght_ntol, iou_catwght_ptol, iou_hardallocationrqd, iou_qcproduction, iou_sublotnotypeno, iou_testlevel, iou_tariffno, etlcreateddatetime
    )
    SELECT
        iou_itemcode, iou_variantcode, iou_ou, iou_bu, iou_lo, iou_num_type, iou_effectivefrom, iou_effectiveto, iou_status, iou_stdwhcode, iou_minissueqty, iou_stdcost, iou_stdcostperqty, iou_stdcostuom, iou_allocationmtd, iou_allocationhorizon, iou_sales_usage, iou_mfg_source, iou_production_usage, iou_purchase_source, iou_maintenance_usage, iou_subcntract_source, iou_stktransfer_source, iou_others_usage, iou_returnable, iou_hazardous, iou_backflushreqd, iou_storagealloc, iou_qcclearence, iou_planningtype, iou_xyz, iou_abc, iou_fsn, iou_ved, iou_minqty, iou_maxqty, iou_safetystock, iou_disposition, iou_receipthorizon, iou_reserhorizon, iou_reorderactat, iou_reorderactby, iou_reorderlevel, iou_reorderqty, iou_stockableflg, iou_lotnotypeno, iou_slnotypeno, iou_mainref1, iou_mainref2, iou_mainref3, iou_mainref4, iou_basref1, iou_basref2, iou_basref3, iou_basref4, iou_planref1, iou_planref2, iou_planref3, iou_planref4, iou_created_by, iou_created_date, iou_modified_by, iou_modified_date, iou_plan_created_by, iou_plan_created_date, iou_plan_modified_by, iou_plan_modified_date, iou_timestamp, iou_manufact_source_pri, iou_purchase_source_pri, iou_subcon_source_pri, iou_stktran_source_pri, iou_catwght_ntol, iou_catwght_ptol, iou_hardallocationrqd, iou_qcproduction, iou_sublotnotypeno, iou_testlevel, iou_tariffno, etlcreateddatetime
    FROM stg.stg_itm_iou_itemvarhdr;
    
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
ALTER PROCEDURE dwh.usp_d_itmiouitemvarhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
