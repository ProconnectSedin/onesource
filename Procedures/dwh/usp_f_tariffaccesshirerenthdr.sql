-- PROCEDURE: dwh.usp_f_tariffaccesshirerenthdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_tariffaccesshirerenthdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_tariffaccesshirerenthdr(
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
    FROM stg.stg_wms_tariff_access_hire_rent_hdr;

    UPDATE dwh.F_tariffaccesshirerenthdr t
    SET

		tf_uomkey						  = coalesce(u.uom_key,-1),
        tf_acc_hrt_id                     = s.wms_tf_acc_hrt_id,
        tf_acc_hrt_ou                     = s.wms_tf_acc_hrt_ou,
        tf_acc_hrt_desc                   = s.wms_tf_acc_hrt_desc,
        tf_acc_hrt_type_code              = s.wms_tf_acc_hrt_type_code,
        tf_acc_hrt_status                 = s.wms_tf_acc_hrt_status,
        tf_acc_hrt_division               = s.wms_tf_acc_hrt_division,
        tf_acc_hrt_validity_id            = s.wms_tf_acc_hrt_validity_id,
        tf_acc_hrt_applicability          = s.wms_tf_acc_hrt_applicability,
        tf_acc_hrt_type                   = s.wms_tf_acc_hrt_type,
        tf_acc_hrt_time                   = s.wms_tf_acc_hrt_time,
        tf_acc_hrt_min_charge_app         = s.wms_tf_acc_hrt_min_charge_app,
        tf_acc_hrt_uom                    = s.wms_tf_acc_hrt_uom,
        tf_acc_hrt_from_space             = s.wms_tf_acc_hrt_from_space,
        tf_acc_hrt_to_space               = s.wms_tf_acc_hrt_to_space,
        tf_acc_hrt_timestamp              = s.wms_tf_acc_hrt_timestamp,
        tf_acc_hrt_created_by             = s.wms_tf_acc_hrt_created_by,
        tf_acc_hrt_created_dt             = s.wms_tf_acc_hrt_created_dt,
        tf_acc_hrt_modified_by            = s.wms_tf_acc_hrt_modified_by,
        tf_acc_hrt_modified_dt            = s.wms_tf_acc_hrt_modified_dt,
        tf_acc_hrt_multilvl_apprvl        = s.wms_tf_acc_hrt_multilvl_apprvl,
        tf_acc_hrt_previous_status        = s.wms_tf_acc_hrt_previous_status,
        tf_acc_hrt_fr_sp                  = s.wms_tf_acc_hrt_fr_sp,
        tf_acc_hrt_to_sp                  = s.wms_tf_acc_hrt_to_sp,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_wms_tariff_access_hire_rent_hdr s
	LEFT JOIN dwh.d_uom u
	on s.wms_tf_acc_hrt_uom = u.mas_uomcode
    WHERE t.tf_acc_hrt_id = s.wms_tf_acc_hrt_id
    AND t.tf_acc_hrt_ou = s.wms_tf_acc_hrt_ou;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_tariffaccesshirerenthdr
    (
        tf_uomkey,tf_acc_hrt_id, tf_acc_hrt_ou, tf_acc_hrt_desc, tf_acc_hrt_type_code, tf_acc_hrt_status, tf_acc_hrt_division, tf_acc_hrt_validity_id, tf_acc_hrt_applicability, tf_acc_hrt_type, tf_acc_hrt_time, tf_acc_hrt_min_charge_app, tf_acc_hrt_uom, tf_acc_hrt_from_space, tf_acc_hrt_to_space, tf_acc_hrt_timestamp, tf_acc_hrt_created_by, tf_acc_hrt_created_dt, tf_acc_hrt_modified_by, tf_acc_hrt_modified_dt, tf_acc_hrt_multilvl_apprvl, tf_acc_hrt_previous_status, tf_acc_hrt_fr_sp, tf_acc_hrt_to_sp, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        coalesce(u.uom_key,-1),s.wms_tf_acc_hrt_id, s.wms_tf_acc_hrt_ou, s.wms_tf_acc_hrt_desc, s.wms_tf_acc_hrt_type_code, s.wms_tf_acc_hrt_status, s.wms_tf_acc_hrt_division, s.wms_tf_acc_hrt_validity_id, s.wms_tf_acc_hrt_applicability, s.wms_tf_acc_hrt_type, s.wms_tf_acc_hrt_time, s.wms_tf_acc_hrt_min_charge_app, s.wms_tf_acc_hrt_uom, s.wms_tf_acc_hrt_from_space, s.wms_tf_acc_hrt_to_space, s.wms_tf_acc_hrt_timestamp, s.wms_tf_acc_hrt_created_by, s.wms_tf_acc_hrt_created_dt, s.wms_tf_acc_hrt_modified_by, s.wms_tf_acc_hrt_modified_dt, s.wms_tf_acc_hrt_multilvl_apprvl, s.wms_tf_acc_hrt_previous_status, s.wms_tf_acc_hrt_fr_sp, s.wms_tf_acc_hrt_to_sp, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_tariff_access_hire_rent_hdr s
	LEFT JOIN dwh.d_uom u
	on s.wms_tf_acc_hrt_uom = u.mas_uomcode
    LEFT JOIN dwh.F_tariffaccesshirerenthdr t
    ON s.wms_tf_acc_hrt_id = t.tf_acc_hrt_id
    AND s.wms_tf_acc_hrt_ou = t.tf_acc_hrt_ou
    WHERE t.tf_acc_hrt_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_tariff_access_hire_rent_hdr
    (
        wms_tf_acc_hrt_id, wms_tf_acc_hrt_ou, wms_tf_acc_hrt_desc, wms_tf_acc_hrt_type_code, wms_tf_acc_hrt_status, wms_tf_acc_hrt_division, wms_tf_acc_hrt_location, wms_tf_acc_hrt_validity_id, wms_tf_acc_hrt_applicability, wms_tf_acc_hrt_type, wms_tf_acc_hrt_time, wms_tf_acc_hrt_min_charge_app, wms_tf_acc_hrt_uom, wms_tf_acc_hrt_from_space, wms_tf_acc_hrt_to_space, wms_tf_acc_hrt_timestamp, wms_tf_acc_hrt_created_by, wms_tf_acc_hrt_created_dt, wms_tf_acc_hrt_modified_by, wms_tf_acc_hrt_modified_dt, wms_tf_acc_hrt_multilvl_apprvl, wms_tf_acc_hrt_previous_status, wms_tf_acc_hrt_fr_sp, wms_tf_acc_hrt_to_sp, wms_tf_acc_hrt_dec_id, etlcreateddatetime
    )
    SELECT
        wms_tf_acc_hrt_id, wms_tf_acc_hrt_ou, wms_tf_acc_hrt_desc, wms_tf_acc_hrt_type_code, wms_tf_acc_hrt_status, wms_tf_acc_hrt_division, wms_tf_acc_hrt_location, wms_tf_acc_hrt_validity_id, wms_tf_acc_hrt_applicability, wms_tf_acc_hrt_type, wms_tf_acc_hrt_time, wms_tf_acc_hrt_min_charge_app, wms_tf_acc_hrt_uom, wms_tf_acc_hrt_from_space, wms_tf_acc_hrt_to_space, wms_tf_acc_hrt_timestamp, wms_tf_acc_hrt_created_by, wms_tf_acc_hrt_created_dt, wms_tf_acc_hrt_modified_by, wms_tf_acc_hrt_modified_dt, wms_tf_acc_hrt_multilvl_apprvl, wms_tf_acc_hrt_previous_status, wms_tf_acc_hrt_fr_sp, wms_tf_acc_hrt_to_sp, wms_tf_acc_hrt_dec_id, etlcreateddatetime
    FROM stg.stg_wms_tariff_access_hire_rent_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_tariffaccesshirerenthdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
