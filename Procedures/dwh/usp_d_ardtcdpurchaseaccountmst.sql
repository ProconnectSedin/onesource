-- PROCEDURE: dwh.usp_d_ardtcdpurchaseaccountmst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_ardtcdpurchaseaccountmst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_ardtcdpurchaseaccountmst(
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
    FROM stg.stg_ard_tcdpurchase_account_mst;

    UPDATE dwh.D_ardtcdpurchaseaccountmst t
    SET
        timestamp             = s.timestamp,
        account_code          = s.account_code,
        resou_id              = s.resou_id,
        createdby             = s.createdby,
        createddate           = s.createddate,
        etlactiveind          = 1,
        etljobname            = p_etljobname,
        envsourcecd           = p_envsourcecd,
        datasourcecd          = p_datasourcecd,
        etlupdatedatetime     = NOW()
    FROM stg.stg_ard_tcdpurchase_account_mst s
    WHERE t.company_code 	  = s.company_code
    AND   t.fb_id 		 	  = s.fb_id
    AND   t.tcd_code 		  = s.tcd_code
    AND   t.effective_from 	  = s.effective_from
    AND   t.tcd_vrnt 		  = s.tcd_vrnt
    AND   t.drcr_flag 		  = s.drcr_flag
    AND   t.supplier_group 	  = s.supplier_group
    AND   t.gr_ouid 		  = s.gr_ouid
    AND   t.gr_type 		  = s.gr_type
    AND   t.gr_folder 		  = s.gr_folder
    AND   t.trans_mode 		  = s.trans_mode
    AND   t.num_series 		  = s.num_series
    AND   t.tcd_class 		  = s.tcd_class
    AND   t.event 			  = s.event
    AND   t.tcd_type 		  = s.tcd_type
    AND   t.sequence_no 	  = s.sequence_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_ardtcdpurchaseaccountmst
    (
        company_code, 		fb_id, 				tcd_code, 		effective_from, 	tcd_vrnt, 
		drcr_flag, 			supplier_group, 	gr_ouid, 		gr_type, 			gr_folder, 
		trans_mode, 		num_series, 		tcd_class, 		event, 				tcd_type, 
		sequence_no, 		timestamp, 			account_code, 	resou_id, 			createdby, 
		createddate, 		etlactiveind, 		etljobname, 	envsourcecd, 		datasourcecd, 
		etlcreatedatetime
    )

    SELECT
        s.company_code, 	s.fb_id, 			s.tcd_code, 	s.effective_from, 	s.tcd_vrnt, 
		s.drcr_flag, 		s.supplier_group, 	s.gr_ouid, 		s.gr_type, 			s.gr_folder, 
		s.trans_mode, 		s.num_series, 		s.tcd_class, 	s.event, 			s.tcd_type, 
		s.sequence_no, 		s.timestamp, 		s.account_code, s.resou_id, 		s.createdby, 
		s.createddate, 		1, 					p_etljobname, 	p_envsourcecd, 		p_datasourcecd, 
		NOW()
    FROM stg.stg_ard_tcdpurchase_account_mst s
    LEFT JOIN dwh.D_ardtcdpurchaseaccountmst t
    ON 	  t.company_code 	  = s.company_code
    AND   t.fb_id 		 	  = s.fb_id
    AND   t.tcd_code 		  = s.tcd_code
    AND   t.effective_from 	  = s.effective_from
    AND   t.tcd_vrnt 		  = s.tcd_vrnt
    AND   t.drcr_flag 		  = s.drcr_flag
    AND   t.supplier_group 	  = s.supplier_group
    AND   t.gr_ouid 		  = s.gr_ouid
    AND   t.gr_type 		  = s.gr_type
    AND   t.gr_folder 		  = s.gr_folder
    AND   t.trans_mode 		  = s.trans_mode
    AND   t.num_series 		  = s.num_series
    AND   t.tcd_class 		  = s.tcd_class
    AND   t.event 			  = s.event
    AND   t.tcd_type 		  = s.tcd_type
    AND   t.sequence_no 	  = s.sequence_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ard_tcdpurchase_account_mst
    (
        company_code, 		fb_id, 				tcd_code, 			effective_from, 	tcd_vrnt, 
		drcr_flag, 			supplier_group, 	gr_ouid, 			gr_type, 			gr_folder, 
		trans_mode, 		num_series, 		tcd_class, 			event, 				tcd_type, 
		sequence_no, 		timestamp, 			account_code, 		effective_to, 		resou_id, 
		createdby, 			createddate, 		modifiedby, 		modifieddate, 		etlcreateddatetime
    )
    SELECT
        company_code, 		fb_id, 				tcd_code, 			effective_from, 	tcd_vrnt, 
		drcr_flag, 			supplier_group, 	gr_ouid, 			gr_type, 			gr_folder, 
		trans_mode, 		num_series, 		tcd_class, 			event, 				tcd_type, 
		sequence_no, 		timestamp, 			account_code, 		effective_to, 		resou_id, 
		createdby, 			createddate, 		modifiedby, 		modifieddate, 		etlcreateddatetime
    FROM stg.stg_ard_tcdpurchase_account_mst;
    
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
ALTER PROCEDURE dwh.usp_d_ardtcdpurchaseaccountmst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
