-- PROCEDURE: dwh.usp_f_ainqassethdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ainqassethdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ainqassethdr(
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
    FROM stg.Stg_ainq_asset_hdr;

    UPDATE dwh.F_ainqassethdr t
    SET
		ainqassethdr_lockey		=coalesce(l.loc_key,-1),
		ainqassethdr_datekey	= coalesce(d.datekey,-1),
        ou_id                   = s.ou_id,
        cap_number              = s.cap_number,
        asset_number            = s.asset_number,
        cap_date                = s.cap_date,
        cap_status              = s.cap_status,
        fb_id                   = s.fb_id,
        num_type                = s.num_type,
        asset_class             = s.asset_class,
        asset_group             = s.asset_group,
        cost_center             = s.cost_center,
        asset_desc              = s.asset_desc,
        asset_cost              = s.asset_cost,
        asset_location          = s.asset_location,
        seq_no                  = s.seq_no,
        as_on_date              = s.as_on_date,
        asset_type              = s.asset_type,
        asset_status            = s.asset_status,
        transaction_date        = s.transaction_date,
        createdby               = s.createdby,
        createddate             = s.createddate,
        modifiedby              = s.modifiedby,
        modifieddate            = s.modifieddate,
        depr_book               = s.depr_book,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.Stg_ainq_asset_hdr s
	inner join dwh.d_location l
	on l.loc_code	= s.asset_location
	and l.loc_ou	= s.ou_id
	left join dwh.d_date d
	ON d.dateactual =s.transaction_date::date
    WHERE t.ou_id = s.ou_id
    AND t.cap_number = s.cap_number
    AND t.asset_number = s.asset_number
    AND t.depr_book = s.depr_book;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ainqassethdr
    (
      ainqassethdr_lockey, ainqassethdr_datekey, ou_id, cap_number, asset_number, cap_date, cap_status, fb_id, num_type, asset_class, asset_group, cost_center, asset_desc, asset_cost, asset_location, seq_no, as_on_date, asset_type, asset_status, transaction_date, createdby, createddate, modifiedby, modifieddate, depr_book, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
     coalesce(l.loc_key,-1), coalesce(d.datekey,-1),   s.ou_id, s.cap_number, s.asset_number, s.cap_date, s.cap_status, s.fb_id, s.num_type, s.asset_class, s.asset_group, s.cost_center, s.asset_desc, s.asset_cost, s.asset_location, s.seq_no, s.as_on_date, s.asset_type, s.asset_status, s.transaction_date, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.depr_book, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_ainq_asset_hdr s
	left join dwh.d_location l
	on l.loc_code	= s.asset_location
	and l.loc_ou	= s.ou_id	
	left join dwh.d_date d
	ON d.dateactual =s.transaction_date::date	
    LEFT JOIN dwh.F_ainqassethdr t
    ON s.ou_id = t.ou_id
    AND s.cap_number = t.cap_number
    AND s.asset_number = t.asset_number
    AND s.depr_book = t.depr_book
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ainq_asset_hdr
    (
        ou_id, cap_number, asset_number, timestamp, cap_date, cap_status, fb_id, num_type, asset_class, asset_group, cost_center, asset_desc, asset_cost, asset_location, seq_no, as_on_date, asset_type, asset_status, transaction_date, account_code, createdby, createddate, modifiedby, modifieddate, depr_book, asset_classification, etlcreateddatetime
    )
    SELECT
        ou_id, cap_number, asset_number, timestamp, cap_date, cap_status, fb_id, num_type, asset_class, asset_group, cost_center, asset_desc, asset_cost, asset_location, seq_no, as_on_date, asset_type, asset_status, transaction_date, account_code, createdby, createddate, modifiedby, modifieddate, depr_book, asset_classification, etlcreateddatetime
    FROM stg.Stg_ainq_asset_hdr;
    
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
ALTER PROCEDURE dwh.usp_f_ainqassethdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
