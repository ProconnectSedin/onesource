-- PROCEDURE: dwh.usp_d_aplanbudgethdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_aplanbudgethdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_aplanbudgethdr(
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
    FROM stg.stg_aplan_budget_hdr;

    UPDATE dwh.D_aplanbudgethdr t
    SET
        ou_id                             = s.ou_id,
        financial_year                    = s.financial_year,
        budget_number                     = s.budget_number,
        timestamp                         = s.timestamp,
        budget_date                       = s.budget_date,
        numbering_typeno                  = s.numbering_typeno,
        total_base_req_amount             = s.total_base_req_amount,
        total_base_alloc_amount           = s.total_base_alloc_amount,
        total_base_variance_amount        = s.total_base_variance_amount,
        budget_status                     = s.budget_status,
        doc_type                          = s.doc_type,
        utilized_amount                   = s.utilized_amount,
        total_proposed_amount             = s.total_proposed_amount,
        amendment_number                  = s.amendment_number,
        total_alloc_amount                = s.total_alloc_amount,
        total_utilized_amount             = s.total_utilized_amount,
        total_base_bal_amount             = s.total_base_bal_amount,
        createdby                         = s.createdby,
        createddate                       = s.createddate,
        modifiedby                        = s.modifiedby,
        modifieddate                      = s.modifieddate,
        etlactiveind                      = 1,
        etljobname                        = p_etljobname,
        envsourcecd                       = p_envsourcecd,
        datasourcecd                      = p_datasourcecd,
        etlupdatedatetime                 = NOW()
    FROM stg.stg_aplan_budget_hdr s
    WHERE	t.ou_id				=	s.ou_id
    AND		t.financial_year	=	s.financial_year
    AND		t.budget_number		=	s.budget_number;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.D_aplanbudgethdr
    (
        ou_id, financial_year, budget_number, timestamp, budget_date, numbering_typeno, total_base_req_amount, total_base_alloc_amount, total_base_variance_amount, budget_status, doc_type, utilized_amount, total_proposed_amount, amendment_number, total_alloc_amount, total_utilized_amount, total_base_bal_amount, createdby, createddate, modifiedby, modifieddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.ou_id, s.financial_year, s.budget_number, s.timestamp, s.budget_date, s.numbering_typeno, s.total_base_req_amount, s.total_base_alloc_amount, s.total_base_variance_amount, s.budget_status, s.doc_type, s.utilized_amount, s.total_proposed_amount, s.amendment_number, s.total_alloc_amount, s.total_utilized_amount, s.total_base_bal_amount, s.createdby, s.createddate, s.modifiedby, s.modifieddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_aplan_budget_hdr s
    LEFT JOIN dwh.D_aplanbudgethdr t
    ON s.ou_id = t.ou_id
    AND s.financial_year = t.financial_year
    AND s.budget_number = t.budget_number
    WHERE t.ou_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_aplan_budget_hdr
    (
        ou_id, financial_year, budget_number, timestamp, budget_date, numbering_typeno, total_base_req_amount, total_base_alloc_amount, total_base_variance_amount, budget_status, doc_type, utilized_amount, total_proposed_amount, amendment_number, total_alloc_amount, total_utilized_amount, total_base_bal_amount, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    )
    SELECT
        ou_id, financial_year, budget_number, timestamp, budget_date, numbering_typeno, total_base_req_amount, total_base_alloc_amount, total_base_variance_amount, budget_status, doc_type, utilized_amount, total_proposed_amount, amendment_number, total_alloc_amount, total_utilized_amount, total_base_bal_amount, createdby, createddate, modifiedby, modifieddate, etlcreateddatetime
    FROM stg.stg_aplan_budget_hdr;
    
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
ALTER PROCEDURE dwh.usp_d_aplanbudgethdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
