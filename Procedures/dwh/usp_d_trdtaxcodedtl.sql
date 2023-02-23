-- PROCEDURE: dwh.usp_d_trdtaxcodedtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_trdtaxcodedtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_trdtaxcodedtl(
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
		
--   IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
--                     AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
--     THEN		

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_trd_tax_code_dtl;

    UPDATE dwh.D_trdtaxcodedtl t
    SET
		trdtaxcodehdr_key		   = coalesce(h.trdtaxcodehdr_key,-1),
		trdtaxcodecompany_key	   = coalesce(c.company_key,-1),
        company_code               = s.company_code,
        tax_code                   = s.tax_code,
        sequence_no                = s.sequence_no,
        rate                       = s.rate,
        effective_from_date        = s.effective_from_date,
        effective_to_date          = s.effective_to_date,
        created_at                 = s.created_at,
        etlactiveind               = 1,
        etljobname                 = p_etljobname,
        envsourcecd                = p_envsourcecd,
        datasourcecd               = p_datasourcecd,
        etlupdatedatetime          = NOW()
    FROM stg.stg_trd_tax_code_dtl s
	left join dwh.d_trdtaxcodehdr h
	on h.company_code=s.company_code
	and h.tax_code=s.tax_code
	left join dwh.d_company c
	ON h.company_code  	= 	s.company_code
    WHERE t.company_code = s.company_code
    AND t.tax_code = s.tax_code
    AND t.sequence_no = s.sequence_no;
	
    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_trdtaxcodedtl
    (
      trdtaxcodehdr_key, trdtaxcodecompany_key,  company_code, tax_code, sequence_no, rate, effective_from_date, effective_to_date, created_at--, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )
    SELECT
     coalesce(h.trdtaxcodehdr_key,-1),coalesce(c.company_key,-1),   s.company_code, s.tax_code, s.sequence_no, s.rate, s.effective_from_date, s.effective_to_date, s.created_at--, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_trd_tax_code_dtl s
	inner join dwh.d_trdtaxcodehdr h
	on h.company_code=s.company_code
	and h.tax_code=s.tax_code
	left join dwh.d_company c
	ON c.company_code  	= 	s.company_code	
    LEFT JOIN dwh.D_trdtaxcodedtl t
    ON s.company_code = t.company_code
    AND s.tax_code = t.tax_code
    AND s.sequence_no = t.sequence_no
    WHERE t.company_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_trd_tax_code_dtl
    (
        company_code, tax_code, sequence_no, rate, effective_from_date, effective_to_date, created_at, etlcreateddatetime
    )
    SELECT
        company_code, tax_code, sequence_no, rate, effective_from_date, effective_to_date, created_at, etlcreateddatetime
    FROM stg.stg_trd_tax_code_dtl;
    
    END IF;
	
	--select * from ods.error order by 1 desc
	
--     ELSE    
--          p_errorid   := 0;
--          select 0 into inscnt;
--             select 0 into updcnt;
--          select 0 into srccnt;    
         
--          IF p_depsource IS NULL
--          THEN 
--          p_errordesc := 'The Dependent source cannot be NULL.';
--          ELSE
--          p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
--          END IF;
--          CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
--     END IF;	
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
	   
END;
$BODY$;
ALTER PROCEDURE dwh.usp_d_trdtaxcodedtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
