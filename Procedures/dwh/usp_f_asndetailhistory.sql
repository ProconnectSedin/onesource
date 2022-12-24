-- PROCEDURE: dwh.usp_f_asndetailhistory(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_asndetailhistory(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_asndetailhistory(
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
    FROM stg.stg_wms_asn_detail_h;
    

    UPDATE dwh.F_ASNDetailHistory t
    SET
		asn_hdr_hst_key    			 = fh.asn_hdr_hst_key,
        asn_dtl_hst_loc_key 		 = COALESCE(l.loc_key,-1),
		asn_dtl_hst_itm_hdr_key 	 = COALESCE(i.itm_hdr_key,-1),
		asn_dtl_hst_thu_key 		 = COALESCE(th.thu_key,-1),
        asn_itm_code                 = s.wms_asn_itm_code,
        asn_qty                      = s.wms_asn_qty,
        asn_batch_no                 = s.wms_asn_batch_no,
        asn_srl_no                   = s.wms_asn_srl_no,
        asn_exp_date                 = s.wms_asn_exp_date,
        asn_thu_id                   = s.wms_asn_thu_id,
        asn_thu_desc                 = s.wms_asn_thu_desc,
        asn_thu_qty                  = s.wms_asn_thu_qty,
        po_lineno                    = s.wms_po_lineno,
        asn_rem                      = s.wms_asn_rem,
        asn_itm_height               = s.wms_asn_itm_height,
        asn_itm_volume               = s.wms_asn_itm_volume,
        asn_itm_weight               = s.wms_asn_itm_weight,
        asn_outboundorder_qty        = s.wms_asn_outboundorder_qty,
        asn_bestbeforedate           = s.wms_asn_bestbeforedate,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_wms_asn_detail_h s
	INNER JOIN 	dwh.f_asnheaderhistory fh 
			ON  s.wms_asn_ou 		= fh.asn_ou 
			AND s.wms_asn_location 	= fh.asn_location 
			AND s.wms_asn_no 		= fh.asn_no
			AND s.wms_asn_amendno 	= fh.asn_amendno
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_asn_location   = l.loc_code 
        AND s.wms_asn_ou         = l.loc_ou
	LEFT JOIN dwh.d_itemheader i 			
		ON  s.wms_asn_itm_code  = i.itm_code
		AND s.wms_asn_ou        = i.itm_ou
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_asn_thu_id  	= th.thu_id
		AND s.wms_asn_ou 		= th.thu_ou
    WHERE   t.asn_ou 		= s.wms_asn_ou
    AND 	t.asn_location  = s.wms_asn_location
    AND 	t.asn_no 		= s.wms_asn_no
    AND 	t.asn_amendno 	= s.wms_asn_amendno
    AND 	t.asn_lineno 	= s.wms_asn_lineno;
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;
/*
    SELECT 0 INTO updcnt ;

    Delete from dwh.F_ASNDetailHistory t
	USING stg.stg_wms_asn_detail_h s
	where   t.asn_ou 		= s.wms_asn_ou
    AND 	t.asn_location  = s.wms_asn_location
    AND 	t.asn_no 		= s.wms_asn_no
    AND 	t.asn_amendno 	= s.wms_asn_amendno
    AND 	t.asn_lineno 	= s.wms_asn_lineno;
	--and COALESCE(h.asn_modified_date,h.asn_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/
    INSERT INTO dwh.F_ASNDetailHistory
    (
		asn_hdr_hst_key,	  	asn_dtl_hst_loc_key,		asn_dtl_hst_itm_hdr_key,asn_dtl_hst_thu_key,
        asn_ou, 				asn_location, 				asn_no, 				asn_amendno, 	asn_lineno, 	asn_itm_code, 
		asn_qty, 				asn_batch_no, 				asn_srl_no, 			asn_exp_date, 	asn_thu_id, 	asn_thu_desc, 
		asn_thu_qty, 			po_lineno, 					asn_rem, 				asn_itm_height, asn_itm_volume, 
		asn_itm_weight, 		asn_outboundorder_qty, 		asn_bestbeforedate, 	etlactiveind, 	etljobname, 
		envsourcecd, 			datasourcecd, 				etlcreatedatetime
    )

    SELECT
		fh.asn_hdr_hst_key,		COALESCE(l.loc_key,-1),	COALESCE(i.itm_hdr_key,-1),	COALESCE(th.thu_key,-1),
        s.wms_asn_ou, 			s.wms_asn_location, 	s.wms_asn_no, 			s.wms_asn_amendno, 			 s.wms_asn_lineno, 
		s.wms_asn_itm_code, 	s.wms_asn_qty, 			s.wms_asn_batch_no, 	s.wms_asn_srl_no, 			 s.wms_asn_exp_date, 
		s.wms_asn_thu_id, 		s.wms_asn_thu_desc, 	s.wms_asn_thu_qty, 		s.wms_po_lineno, 			 s.wms_asn_rem, 
		s.wms_asn_itm_height, 	s.wms_asn_itm_volume, 	s.wms_asn_itm_weight,   s.wms_asn_outboundorder_qty, s.wms_asn_bestbeforedate, 
		1, 						p_etljobname, 			p_envsourcecd, 			p_datasourcecd, 			 NOW()
    FROM stg.stg_wms_asn_detail_h s
	INNER JOIN 	dwh.f_asnheaderhistory fh 
			ON  s.wms_asn_ou 		= fh.asn_ou 
			AND s.wms_asn_location 	= fh.asn_location 
			AND s.wms_asn_no 		= fh.asn_no
			AND s.wms_asn_amendno 	= fh.asn_amendno
	LEFT JOIN dwh.d_location l 		
		ON  s.wms_asn_location   = l.loc_code 
        AND s.wms_asn_ou         = l.loc_ou
	LEFT JOIN dwh.d_itemheader i 			
		ON  s.wms_asn_itm_code  = i.itm_code
		AND s.wms_asn_ou        = i.itm_ou
	LEFT JOIN dwh.d_thu th 		
		ON  s.wms_asn_thu_id  	= th.thu_id
		AND s.wms_asn_ou 		= th.thu_ou  
    LEFT JOIN dwh.F_ASNDetailHistory t
    ON 		s.wms_asn_ou 		= t.asn_ou
    AND 	s.wms_asn_location  = t.asn_location
    AND 	s.wms_asn_no 		= t.asn_no
    AND 	s.wms_asn_amendno 	= t.asn_amendno
    AND 	s.wms_asn_lineno 	= t.asn_lineno
    WHERE t.asn_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
/*	
	
	UPDATE	dwh.F_ASNDetailHistory s
    SET		asn_hdr_hst_key		= fh.asn_hdr_hst_key,
	 		etlupdatedatetime	= NOW()
    FROM	dwh.f_asnheaderhistory fh  
    WHERE	s.asn_ou 			= fh.asn_ou 
	AND		s.asn_location 		= fh.asn_location 
	AND		s.asn_no 			= fh.asn_no
	AND		s.asn_amendno 		= fh.asn_amendno
    AND		COALESCE(fh.asn_modified_date,fh.asn_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
	
*/	

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_asn_detail_h
    (
        wms_asn_ou, 			wms_asn_location, 		  wms_asn_no, 				 wms_asn_amendno, 	 wms_asn_lineno, 
		wms_asn_line_status, 	wms_asn_itm_code, 		  wms_asn_qty, 				 wms_asn_batch_no, 	 wms_asn_srl_no, 
		wms_asn_manfct_date, 	wms_asn_exp_date, 		  wms_asn_thu_id, 			 wms_asn_thu_desc, 	 wms_asn_thu_qty, 
		wms_po_lineno, 			wms_gr_flag, 	  		  wms_asn_rec_qty, 			 wms_asn_acc_qty, 	 wms_asn_rej_qty, 
		wms_asn_thu_srl_no, 	wms_asn_uid, 	  		  wms_asn_rem, 				 wms_asn_itm_height, wms_asn_itm_volume, 
		wms_asn_itm_weight, 	wms_asn_outboundorder_no, wms_asn_outboundorder_qty, wms_asn_consignee,  wms_asn_outboundorder_lineno, 
		wms_asn_bestbeforedate, etlcreateddatetime
    )
    SELECT
        wms_asn_ou, 			wms_asn_location, 		  wms_asn_no, 				 wms_asn_amendno, 	 wms_asn_lineno, 
		wms_asn_line_status, 	wms_asn_itm_code, 		  wms_asn_qty, 				 wms_asn_batch_no, 	 wms_asn_srl_no, 
		wms_asn_manfct_date, 	wms_asn_exp_date, 		  wms_asn_thu_id, 			 wms_asn_thu_desc, 	 wms_asn_thu_qty, 
		wms_po_lineno, 			wms_gr_flag, 	  		  wms_asn_rec_qty, 			 wms_asn_acc_qty, 	 wms_asn_rej_qty, 
		wms_asn_thu_srl_no, 	wms_asn_uid, 	  		  wms_asn_rem, 				 wms_asn_itm_height, wms_asn_itm_volume, 
		wms_asn_itm_weight, 	wms_asn_outboundorder_no, wms_asn_outboundorder_qty, wms_asn_consignee,  wms_asn_outboundorder_lineno, 
		wms_asn_bestbeforedate, etlcreateddatetime
    FROM stg.stg_wms_asn_detail_h;
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
ALTER PROCEDURE dwh.usp_f_asndetailhistory(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
