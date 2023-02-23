-- PROCEDURE: dwh.usp_f_poposhdscheduledtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_poposhdscheduledtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_poposhdscheduledtl(
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
    FROM stg.stg_po_poshd_schedule_dtl;

    UPDATE dwh.F_poposhdscheduledtl t
    SET
		poshd_datekey				  = coalesce(d.datekey,-1),
        poshd_poou                    = s.poshd_poou,
        poshd_pono                    = s.poshd_pono,
        poshd_poamendmentno           = s.poshd_poamendmentno,
        poshd_polineno                = s.poshd_polineno,
        poshd_scheduleno              = s.poshd_scheduleno,
        poshd_shddate                 = s.poshd_shddate,
        poshd_acusage                 = s.poshd_acusage,
        poshd_shdqty                  = s.poshd_shdqty,
        poshd_balqty                  = s.poshd_balqty,
        poshd_createdby               = s.poshd_createdby,
        poshd_lastmodifiedby          = s.poshd_lastmodifiedby,
        poshd_lastmodifieddate        = s.poshd_lastmodifieddate,
        poshd_createddate             = s.poshd_createddate,
        poshd_grrecdqty               = s.poshd_grrecdqty,
        poshd_graccpdqty              = s.poshd_graccpdqty,
        poshd_grmovdqty               = s.poshd_grmovdqty,
        etlactiveind                  = 1,
        etljobname                    = p_etljobname,
        envsourcecd                   = p_envsourcecd,
        datasourcecd                  = p_datasourcecd,
        etlupdatedatetime             = NOW()
    FROM stg.stg_po_poshd_schedule_dtl s
	left join dwh.d_date d
	ON d.dateactual  	=	s.poshd_shddate::date
    WHERE t.poshd_poou = s.poshd_poou
    AND t.poshd_pono = s.poshd_pono
    AND t.poshd_poamendmentno = s.poshd_poamendmentno
    AND t.poshd_polineno = s.poshd_polineno
    AND t.poshd_scheduleno = s.poshd_scheduleno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_poposhdscheduledtl
    (
      poshd_datekey,  poshd_poou, poshd_pono, poshd_poamendmentno, poshd_polineno, poshd_scheduleno, poshd_shddate, poshd_acusage, poshd_shdqty, poshd_balqty, poshd_createdby, poshd_lastmodifiedby, poshd_lastmodifieddate, poshd_createddate, poshd_grrecdqty, poshd_graccpdqty, poshd_grmovdqty, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      coalesce(d.datekey,-1),  s.poshd_poou, s.poshd_pono, s.poshd_poamendmentno, s.poshd_polineno, s.poshd_scheduleno, s.poshd_shddate, s.poshd_acusage, s.poshd_shdqty, s.poshd_balqty, s.poshd_createdby, s.poshd_lastmodifiedby, s.poshd_lastmodifieddate, s.poshd_createddate, s.poshd_grrecdqty, s.poshd_graccpdqty, s.poshd_grmovdqty, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_po_poshd_schedule_dtl s
	left join dwh.d_date d
	ON d.dateactual  	=	s.poshd_shddate::date	
    LEFT JOIN dwh.F_poposhdscheduledtl t
    ON s.poshd_poou = t.poshd_poou
    AND s.poshd_pono = t.poshd_pono
    AND s.poshd_poamendmentno = t.poshd_poamendmentno
    AND s.poshd_polineno = t.poshd_polineno
    AND s.poshd_scheduleno = t.poshd_scheduleno
    WHERE t.poshd_poou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_po_poshd_schedule_dtl
    (
        poshd_poou, poshd_pono, poshd_poamendmentno, poshd_polineno, poshd_scheduleno, poshd_shddate, poshd_acusage, poshd_analysiscode, poshd_subanalysiscode, poshd_shdqty, poshd_balqty, poshd_createdby, poshd_lastmodifiedby, poshd_lastmodifieddate, poshd_createddate, poshd_grrecdqty, poshd_graccpdqty, poshd_grretrndqty, poshd_grrejdqty, poshd_grmovdqty, poshd_despatchqty, poshd_solineno, poshd_soscheduleno, etlcreateddatetime
    )
    SELECT
        poshd_poou, poshd_pono, poshd_poamendmentno, poshd_polineno, poshd_scheduleno, poshd_shddate, poshd_acusage, poshd_analysiscode, poshd_subanalysiscode, poshd_shdqty, poshd_balqty, poshd_createdby, poshd_lastmodifiedby, poshd_lastmodifieddate, poshd_createddate, poshd_grrecdqty, poshd_graccpdqty, poshd_grretrndqty, poshd_grrejdqty, poshd_grmovdqty, poshd_despatchqty, poshd_solineno, poshd_soscheduleno, etlcreateddatetime
    FROM stg.stg_po_poshd_schedule_dtl;
    
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
ALTER PROCEDURE dwh.usp_f_poposhdscheduledtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
