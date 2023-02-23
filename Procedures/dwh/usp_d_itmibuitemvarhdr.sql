-- PROCEDURE: dwh.usp_d_itmibuitemvarhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_itmibuitemvarhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_itmibuitemvarhdr(
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
    FROM stg.stg_itm_ibu_itemvarhdr;

    UPDATE dwh.D_itmibuitemvarhdr t
    SET
        ibu_itemcode               = s.ibu_itemcode,
        ibu_variantcode            = s.ibu_variantcode,
        ibu_bu                     = s.ibu_bu,
        ibu_lo                     = s.ibu_lo,
        ibu_category               = s.ibu_category,
        ibu_itemtype               = s.ibu_itemtype,
        ibu_grsweight              = s.ibu_grsweight,
        ibu_grsuom                 = s.ibu_grsuom,
        ibu_grsvolume              = s.ibu_grsvolume,
        ibu_voluom                 = s.ibu_voluom,
        ibu_length                 = s.ibu_length,
        ibu_breadth                = s.ibu_breadth,
        ibu_height                 = s.ibu_height,
        ibu_dimenuom               = s.ibu_dimenuom,
        ibu_costingmtd             = s.ibu_costingmtd,
        ibu_lotnoctrl              = s.ibu_lotnoctrl,
        ibu_shelflifeperiod        = s.ibu_shelflifeperiod,
        ibu_retestperiod           = s.ibu_retestperiod,
        ibu_srnoctrl               = s.ibu_srnoctrl,
        ibu_planninglevel          = s.ibu_planninglevel,
        ibu_created_ou             = s.ibu_created_ou,
        ibu_created_by             = s.ibu_created_by,
        ibu_created_date           = s.ibu_created_date,
        ibu_modified_by            = s.ibu_modified_by,
        ibu_modified_date          = s.ibu_modified_date,
        ibu_accountgroup           = s.ibu_accountgroup,
        ibu_costingwght            = s.ibu_costingwght,
        ibu_sublotctrl             = s.ibu_sublotctrl,
        ibu_defpam                 = s.ibu_defpam,
        ibu_itmmix                 = s.ibu_itmmix,
        ibu_lotmix                 = s.ibu_lotmix,
        ibu_mfrmix                 = s.ibu_mfrmix,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_itm_ibu_itemvarhdr s
    WHERE t.ibu_itemcode = s.ibu_itemcode
    AND t.ibu_variantcode = s.ibu_variantcode
    AND t.ibu_bu = s.ibu_bu
    AND t.ibu_lo = s.ibu_lo;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_itmibuitemvarhdr
    (
        ibu_itemcode, ibu_variantcode, ibu_bu, ibu_lo, ibu_category, ibu_itemtype, ibu_grsweight, ibu_grsuom, ibu_grsvolume, ibu_voluom, ibu_length, ibu_breadth, ibu_height, ibu_dimenuom, ibu_costingmtd, ibu_lotnoctrl, ibu_shelflifeperiod, ibu_retestperiod, ibu_srnoctrl, ibu_planninglevel, ibu_created_ou, ibu_created_by, ibu_created_date, ibu_modified_by, ibu_modified_date, ibu_accountgroup, ibu_costingwght, ibu_sublotctrl, ibu_defpam, ibu_itmmix, ibu_lotmix, ibu_mfrmix, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ibu_itemcode, s.ibu_variantcode, s.ibu_bu, s.ibu_lo, s.ibu_category, s.ibu_itemtype, s.ibu_grsweight, s.ibu_grsuom, s.ibu_grsvolume, s.ibu_voluom, s.ibu_length, s.ibu_breadth, s.ibu_height, s.ibu_dimenuom, s.ibu_costingmtd, s.ibu_lotnoctrl, s.ibu_shelflifeperiod, s.ibu_retestperiod, s.ibu_srnoctrl, s.ibu_planninglevel, s.ibu_created_ou, s.ibu_created_by, s.ibu_created_date, s.ibu_modified_by, s.ibu_modified_date, s.ibu_accountgroup, s.ibu_costingwght, s.ibu_sublotctrl, s.ibu_defpam, s.ibu_itmmix, s.ibu_lotmix, s.ibu_mfrmix, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_itm_ibu_itemvarhdr s
    LEFT JOIN dwh.D_itmibuitemvarhdr t
    ON s.ibu_itemcode = t.ibu_itemcode
    AND s.ibu_variantcode = t.ibu_variantcode
    AND s.ibu_bu = t.ibu_bu
    AND s.ibu_lo = t.ibu_lo
    WHERE t.ibu_itemcode IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_itm_ibu_itemvarhdr
    (
        ibu_itemcode, ibu_variantcode, ibu_bu, ibu_lo, ibu_category, ibu_itemtype, ibu_grsweight, ibu_grsuom, ibu_grsvolume, ibu_voluom, ibu_length, ibu_breadth, ibu_height, ibu_dimenuom, ibu_costingmtd, ibu_lotnoctrl, ibu_shelflifeunit, ibu_shelflifeperiod, ibu_retestperiod, ibu_retestunit, ibu_srnoctrl, ibu_planninglevel, ibu_created_ou, ibu_created_by, ibu_created_date, ibu_modified_by, ibu_modified_date, ibu_accountgroup, ibu_costingwght, ibu_sublotctrl, ibu_defpam, ibu_itmmix, ibu_lotmix, ibu_mfrmix, etlcreatedatetime
    )
    SELECT
        ibu_itemcode, ibu_variantcode, ibu_bu, ibu_lo, ibu_category, ibu_itemtype, ibu_grsweight, ibu_grsuom, ibu_grsvolume, ibu_voluom, ibu_length, ibu_breadth, ibu_height, ibu_dimenuom, ibu_costingmtd, ibu_lotnoctrl, ibu_shelflifeunit, ibu_shelflifeperiod, ibu_retestperiod, ibu_retestunit, ibu_srnoctrl, ibu_planninglevel, ibu_created_ou, ibu_created_by, ibu_created_date, ibu_modified_by, ibu_modified_date, ibu_accountgroup, ibu_costingwght, ibu_sublotctrl, ibu_defpam, ibu_itmmix, ibu_lotmix, ibu_mfrmix, etlcreatedatetime
    FROM stg.stg_itm_ibu_itemvarhdr;
    
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
ALTER PROCEDURE dwh.usp_d_itmibuitemvarhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
