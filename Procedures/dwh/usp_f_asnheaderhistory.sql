-- PROCEDURE: dwh.usp_f_asnheaderhistory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_asnheaderhistory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_asnheaderhistory(
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
    FROM stg.stg_wms_asn_header_h;

    UPDATE dwh.F_ASNHeaderHistory t
    SET
        asn_hdr_hst_loc_key		  = COALESCE(l.loc_key,-1),
		asn_hdr_hst_datekey		  = COALESCE(d.datekey,-1),
		asn_hdr_hst_customer_key  = COALESCE(c.customer_key,-1),
        asn_prefdoc_type          = s.wms_asn_prefdoc_type,
        asn_prefdoc_no            = s.wms_asn_prefdoc_no,
        asn_prefdoc_date          = s.wms_asn_prefdoc_date,
        asn_date                  = s.wms_asn_date,
        asn_status                = s.wms_asn_status,
        asn_ib_order              = s.wms_asn_ib_order,
        asn_ship_frm              = s.wms_asn_ship_frm,
        asn_ship_date             = s.wms_asn_ship_date,
        asn_dlv_date              = s.wms_asn_dlv_date,
        asn_sup_asn_no            = s.wms_asn_sup_asn_no,
        asn_sup_asn_date          = s.wms_asn_sup_asn_date,
        asn_sent_by               = s.wms_asn_sent_by,
        asn_rem                   = s.wms_asn_rem,
        asn_shp_ref_typ           = s.wms_asn_shp_ref_typ,
        asn_shp_ref_no            = s.wms_asn_shp_ref_no,
        asn_shp_ref_date          = s.wms_asn_shp_ref_date,
        asn_shp_carrier           = s.wms_asn_shp_carrier,
        asn_shp_mode              = s.wms_asn_shp_mode,
        asn_shp_vh_typ            = s.wms_asn_shp_vh_typ,
        asn_shp_vh_no             = s.wms_asn_shp_vh_no,
        asn_shp_eqp_typ           = s.wms_asn_shp_eqp_typ,
        asn_shp_eqp_no            = s.wms_asn_shp_eqp_no,
        asn_shp_grs_wt            = s.wms_asn_shp_grs_wt,
        asn_shp_wt_uom            = s.wms_asn_shp_wt_uom,
        asn_shp_pallt             = s.wms_asn_shp_pallt,
        asn_shp_rem               = s.wms_asn_shp_rem,
        asn_cnt_no                = s.wms_asn_cnt_no,
        asn_timestamp             = s.wms_asn_timestamp,
        asn_createdby             = s.wms_asn_createdby,
        asn_created_date          = s.wms_asn_created_date,
        asn_modifiedby            = s.wms_asn_modifiedby,
        asn_modified_date         = s.wms_asn_modified_date,
        asn_release_number        = s.wms_asn_release_number,
        asn_block_stage           = s.wms_asn_block_stage,
        asn_cust_code             = s.wms_asn_cust_code,
        dock_no                   = s.wms_dock_no,
        asn_reason_code           = s.wms_asn_reason_code,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_wms_asn_header_h s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_asn_location   = l.loc_code 
        AND s.wms_asn_ou         = l.loc_ou
	LEFT JOIN dwh.d_date d 			
		ON  s.wms_asn_date::date = d.dateactual
	LEFT JOIN dwh.d_customer c 		
		ON  s.wms_asn_cust_code  = c.customer_id
		AND s.wms_asn_ou 		 = c.customer_ou
    WHERE 	t.asn_ou 			= s.wms_asn_ou
    AND 	t.asn_location 		= s.wms_asn_location
    AND 	t.asn_no 			= s.wms_asn_no
    AND 	t.asn_amendno 		= s.wms_asn_amendno;
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;
/*
     SELECT 0 INTO updcnt ;

    Delete from dwh.F_ASNHeaderHistory t
	USING stg.stg_wms_asn_header_h s
	where	t.asn_ou 			= s.wms_asn_ou
    AND 	t.asn_location 		= s.wms_asn_location
    AND 	t.asn_no 			= s.wms_asn_no
    AND 	t.asn_amendno 		= s.wms_asn_amendno;
	--AND COALESCE(wms_asn_modified_date,wms_asn_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/    
    INSERT INTO dwh.F_ASNHeaderHistory
    (
		asn_hdr_hst_loc_key,  asn_hdr_hst_datekey,  asn_hdr_hst_customer_key,
        asn_ou, 			  asn_location, 		asn_no, 				asn_amendno, 		asn_prefdoc_type, 
		asn_prefdoc_no, 	  asn_prefdoc_date, 	asn_date, 				asn_status, 		asn_ib_order, 
		asn_ship_frm, 		  asn_ship_date, 		asn_dlv_date, 			asn_sup_asn_no, 	asn_sup_asn_date, 
		asn_sent_by, 		  asn_rem, 				asn_shp_ref_typ, 		asn_shp_ref_no, 	asn_shp_ref_date, 
		asn_shp_carrier, 	  asn_shp_mode, 		asn_shp_vh_typ, 		asn_shp_vh_no, 		asn_shp_eqp_typ, 
		asn_shp_eqp_no, 	  asn_shp_grs_wt, 		asn_shp_wt_uom, 		asn_shp_pallt, 		asn_shp_rem, 
		asn_cnt_no, 		  asn_timestamp, 		asn_createdby, 			asn_created_date, 	asn_modifiedby, 
		asn_modified_date, 	  asn_release_number, 	asn_block_stage, 		asn_cust_code, 		dock_no, 
		asn_reason_code, 	  etlactiveind, 		etljobname, 			envsourcecd, 		datasourcecd, 
		etlcreatedatetime
    )

    SELECT
		COALESCE(l.loc_key,-1),	 COALESCE(d.datekey,-1),	COALESCE(c.customer_key,-1),	
        s.wms_asn_ou, 			 s.wms_asn_location, 		s.wms_asn_no, 			s.wms_asn_amendno, 		s.wms_asn_prefdoc_type, 
		s.wms_asn_prefdoc_no, 	 s.wms_asn_prefdoc_date, 	s.wms_asn_date, 		s.wms_asn_status, 		s.wms_asn_ib_order, 
		s.wms_asn_ship_frm, 	 s.wms_asn_ship_date, 		s.wms_asn_dlv_date, 	s.wms_asn_sup_asn_no, 	s.wms_asn_sup_asn_date, 
		s.wms_asn_sent_by, 		 s.wms_asn_rem, 			s.wms_asn_shp_ref_typ, 	s.wms_asn_shp_ref_no, 	s.wms_asn_shp_ref_date, 
		s.wms_asn_shp_carrier, 	 s.wms_asn_shp_mode, 		s.wms_asn_shp_vh_typ, 	s.wms_asn_shp_vh_no, 	s.wms_asn_shp_eqp_typ, 
		s.wms_asn_shp_eqp_no, 	 s.wms_asn_shp_grs_wt, 		s.wms_asn_shp_wt_uom, 	s.wms_asn_shp_pallt, 	s.wms_asn_shp_rem, 
		s.wms_asn_cnt_no, 		 s.wms_asn_timestamp, 		s.wms_asn_createdby, 	s.wms_asn_created_date, s.wms_asn_modifiedby, 
		s.wms_asn_modified_date, s.wms_asn_release_number, 	s.wms_asn_block_stage, 	s.wms_asn_cust_code, 	s.wms_dock_no, 
		s.wms_asn_reason_code, 	 1, 						p_etljobname, 			p_envsourcecd, 			p_datasourcecd, 
		NOW()
    FROM stg.stg_wms_asn_header_h s
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_asn_location   = l.loc_code 
        AND s.wms_asn_ou         = l.loc_ou
	LEFT JOIN dwh.d_date d 			
		ON  s.wms_asn_date::date = d.dateactual
	LEFT JOIN dwh.d_customer c 		
		ON  s.wms_asn_cust_code  = c.customer_id
		AND s.wms_asn_ou 		 = c.customer_ou
    LEFT JOIN dwh.F_ASNHeaderHistory t
    ON s.wms_asn_ou = t.asn_ou
    AND s.wms_asn_location = t.asn_location
    AND s.wms_asn_no = t.asn_no
    AND s.wms_asn_amendno = t.asn_amendno
    WHERE t.asn_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_asn_header_h
    (
        wms_asn_ou, 			wms_asn_location, 		wms_asn_no, 			wms_asn_amendno, 		wms_asn_prefdoc_type, 
		wms_asn_prefdoc_no, 	wms_asn_prefdoc_date, 	wms_asn_date, 			wms_asn_status, 		wms_asn_operation_status, 
		wms_asn_ib_order, 		wms_asn_ship_frm, 		wms_asn_ship_date, 		wms_asn_dlv_loc, 		wms_asn_dlv_date, 
		wms_asn_sup_asn_no, 	wms_asn_sup_asn_date, 	wms_asn_sent_by, 		wms_asn_rem, 			wms_asn_shp_ref_typ, 
		wms_asn_shp_ref_no, 	wms_asn_shp_ref_date, 	wms_asn_shp_carrier,	wms_asn_shp_mode, 		wms_asn_shp_vh_typ, 
		wms_asn_shp_vh_no, 		wms_asn_shp_eqp_typ, 	wms_asn_shp_eqp_no, 	wms_asn_shp_grs_wt, 	wms_asn_shp_nt_wt, 
		wms_asn_shp_wt_uom, 	wms_asn_shp_vol, 		wms_asn_shp_vol_uom,	wms_asn_shp_pallt, 		wms_asn_shp_rem, 
		wms_asn_cnt_typ, 		wms_asn_cnt_no, 		wms_asn_cnt_qtyp, 		wms_asn_cnt_qsts, 		wms_asn_timestamp, 
		wms_asn_usrdf1, 		wms_asn_usrdf2, 		wms_asn_usrdf3, 		wms_asn_createdby, 		wms_asn_created_date, 
		wms_asn_modifiedby, 	wms_asn_modified_date, 	wms_asn_gen_frm, 		wms_asn_release_date, 	wms_asn_release_number, 
		wms_asn_block_stage,	wms_asn_cust_code, 		wms_asn_supp_code, 		wms_dock_no, 			wms_total_value, 
		wms_asn_gate_no, 		wms_asn_reason_code, 	etlcreateddatetime
    )
    SELECT
        wms_asn_ou, 			wms_asn_location, 		wms_asn_no, 			wms_asn_amendno, 		wms_asn_prefdoc_type, 
		wms_asn_prefdoc_no, 	wms_asn_prefdoc_date, 	wms_asn_date, 			wms_asn_status, 		wms_asn_operation_status, 
		wms_asn_ib_order, 		wms_asn_ship_frm, 		wms_asn_ship_date, 		wms_asn_dlv_loc, 		wms_asn_dlv_date, 
		wms_asn_sup_asn_no, 	wms_asn_sup_asn_date, 	wms_asn_sent_by, 		wms_asn_rem, 			wms_asn_shp_ref_typ, 
		wms_asn_shp_ref_no, 	wms_asn_shp_ref_date, 	wms_asn_shp_carrier,	wms_asn_shp_mode, 		wms_asn_shp_vh_typ, 
		wms_asn_shp_vh_no, 		wms_asn_shp_eqp_typ, 	wms_asn_shp_eqp_no, 	wms_asn_shp_grs_wt, 	wms_asn_shp_nt_wt, 
		wms_asn_shp_wt_uom, 	wms_asn_shp_vol, 		wms_asn_shp_vol_uom,	wms_asn_shp_pallt, 		wms_asn_shp_rem, 
		wms_asn_cnt_typ, 		wms_asn_cnt_no, 		wms_asn_cnt_qtyp, 		wms_asn_cnt_qsts, 		wms_asn_timestamp, 
		wms_asn_usrdf1, 		wms_asn_usrdf2, 		wms_asn_usrdf3, 		wms_asn_createdby, 		wms_asn_created_date, 
		wms_asn_modifiedby, 	wms_asn_modified_date, 	wms_asn_gen_frm, 		wms_asn_release_date, 	wms_asn_release_number, 
		wms_asn_block_stage,	wms_asn_cust_code, 		wms_asn_supp_code, 		wms_dock_no, 			wms_total_value, 
		wms_asn_gate_no, 		wms_asn_reason_code, 	etlcreateddatetime
    FROM stg.stg_wms_asn_header_h;
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
ALTER PROCEDURE dwh.usp_f_asnheaderhistory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
