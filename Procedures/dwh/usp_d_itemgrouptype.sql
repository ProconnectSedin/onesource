CREATE OR REPLACE PROCEDURE dwh.usp_d_itemgrouptype(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$
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

	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename,h.rawstorageflag
 
	INTO p_etljobname,p_envsourcecd,p_datasourcecd,p_batchid,p_taskname,p_rawstorageflag

	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_item_group_type;

	UPDATE dwh.d_itemgrouptype t
    SET 
        item_igt_category       = s.item_igt_category,
        item_igt_grouptypedesc  = s.item_igt_grouptypedesc,
        item_igt_usage          = s.item_igt_usage,
        item_igt_created_by     = s.item_igt_created_by,
        item_igt_created_date   = s.item_igt_created_date,
        item_igt_modified_by    = s.item_igt_modified_by,
        item_igt_modified_date  = s.item_igt_modified_date,
        item_igt_timestamp      = s.item_igt_timestamp,
        item_igt_created_langid = s.item_igt_created_langid,
        etlactiveind 			= 1,
		etljobname 				= p_etljobname,
		envsourcecd 			= p_envsourcecd ,
		datasourcecd 			= p_datasourcecd ,
		etlupdatedatetime 		= NOW()	
    FROM stg.stg_item_group_type s
    WHERE t.item_igt_grouptype  		= s.item_igt_grouptype
	AND t.item_igt_lo 			= s.item_igt_lo;
    
    
    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_itemgrouptype
	(
		item_igt_grouptype,
item_igt_lo,
item_igt_category,
item_igt_grouptypedesc,
item_igt_usage,
item_igt_created_by,
item_igt_created_date,
item_igt_modified_by,
item_igt_modified_date,
item_igt_timestamp,
item_igt_created_langid,
		etlactiveind,
        etljobname, 		envsourcecd, 	datasourcecd, 			etlcreatedatetime
	)
	
    SELECT 
		s.item_igt_grouptype,
s.item_igt_lo,
s.item_igt_category,
s.item_igt_grouptypedesc,
s.item_igt_usage,
s.item_igt_created_by,
s.item_igt_created_date,
s.item_igt_modified_by,
s.item_igt_modified_date,
s.item_igt_timestamp,
s.item_igt_created_langid,			1,
		p_etljobname,		p_envsourcecd,		p_datasourcecd,			NOW()
	FROM stg.stg_item_group_type s
    LEFT JOIN dwh.d_itemgrouptype t
    ON 	t.item_igt_grouptype  		= s.item_igt_grouptype
	AND t.item_igt_lo 			= s.item_igt_lo
    WHERE t.item_igt_grouptype IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	IF p_rawstorageflag = 1
	THEN

	
	INSERT INTO raw.raw_item_group_type
	(
	 item_igt_grouptype, item_igt_lo, item_igt_category, item_igt_grouptypedesc, item_igt_usage, 
        item_igt_created_by, item_igt_created_date, item_igt_modified_by, item_igt_modified_date, 
        item_igt_timestamp, item_igt_created_langid, etlcreateddatetime

)
	SELECT 
		 item_igt_grouptype, item_igt_lo, item_igt_category, item_igt_grouptypedesc, item_igt_usage, 
        item_igt_created_by, item_igt_created_date, item_igt_modified_by, item_igt_modified_date, 
        item_igt_timestamp, item_igt_created_langid, etlcreateddatetime

	FROM stg.stg_item_group_type;
	END IF;
	EXCEPTION  
       WHEN others THEN       
       
      get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);
    
        
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;