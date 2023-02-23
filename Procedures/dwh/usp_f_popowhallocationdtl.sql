-- PROCEDURE: dwh.usp_f_popowhallocationdtl(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_popowhallocationdtl(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_popowhallocationdtl(
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
    FROM stg.stg_po_powh_allocation_dtl;

    UPDATE dwh.F_popowhallocationdtl t
    SET
		powh_whkey					 = coalesce(wh.wh_key,-1),
        powh_poou                    = s.powh_poou,
        powh_pono                    = s.powh_pono,
        powh_poamendmentno           = s.powh_poamendmentno,
        powh_polineno                = s.powh_polineno,
        powh_posubscheduleno         = s.powh_posubscheduleno,
        powh_scheduleno              = s.powh_scheduleno,
        powh_allocqty                = s.powh_allocqty,
        powh_balancequantity         = s.powh_balancequantity,
        powh_warehousecode           = s.powh_warehousecode,
        powh_ccusage                 = s.powh_ccusage,
        powh_createdby               = s.powh_createdby,
        powh_grrecdqty               = s.powh_grrecdqty,
        powh_createddate             = s.powh_createddate,
        powh_lastmodifiedby          = s.powh_lastmodifiedby,
        powh_graccpdqty              = s.powh_graccpdqty,
        powh_grretrndqty             = s.powh_grretrndqty,
        powh_lastmodifieddate        = s.powh_lastmodifieddate,
        powh_grrejdqty               = s.powh_grrejdqty,
        powh_grmovdqty               = s.powh_grmovdqty,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_po_powh_allocation_dtl s
	left join dwh.d_warehouse wh
	ON wh.wh_code	  =s.powh_warehousecode
    WHERE t.powh_poou = s.powh_poou
    AND t.powh_pono = s.powh_pono
    AND t.powh_poamendmentno = s.powh_poamendmentno
    AND t.powh_polineno = s.powh_polineno
    AND t.powh_posubscheduleno = s.powh_posubscheduleno
    AND t.powh_scheduleno = s.powh_scheduleno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_popowhallocationdtl
    (
      powh_whkey,  powh_poou, powh_pono, powh_poamendmentno, powh_polineno, powh_posubscheduleno, powh_scheduleno, powh_allocqty, powh_balancequantity, powh_warehousecode, powh_ccusage, powh_createdby, powh_grrecdqty, powh_createddate, powh_lastmodifiedby, powh_graccpdqty, powh_grretrndqty, powh_lastmodifieddate, powh_grrejdqty, powh_grmovdqty, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
     coalesce(wh.wh_key,-1),   s.powh_poou, s.powh_pono, s.powh_poamendmentno, s.powh_polineno, s.powh_posubscheduleno, s.powh_scheduleno, s.powh_allocqty, s.powh_balancequantity, s.powh_warehousecode, s.powh_ccusage, s.powh_createdby, s.powh_grrecdqty, s.powh_createddate, s.powh_lastmodifiedby, s.powh_graccpdqty, s.powh_grretrndqty, s.powh_lastmodifieddate, s.powh_grrejdqty, s.powh_grmovdqty, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_po_powh_allocation_dtl s
	left join dwh.d_warehouse wh
	ON wh.wh_code	  =s.powh_warehousecode	
    LEFT JOIN dwh.F_popowhallocationdtl t
    ON s.powh_poou = t.powh_poou
    AND s.powh_pono = t.powh_pono
    AND s.powh_poamendmentno = t.powh_poamendmentno
    AND s.powh_polineno = t.powh_polineno
    AND s.powh_posubscheduleno = t.powh_posubscheduleno
    AND s.powh_scheduleno = t.powh_scheduleno
    WHERE t.powh_poou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_po_powh_allocation_dtl
    (
        powh_poou, powh_pono, powh_poamendmentno, powh_polineno, powh_posubscheduleno, powh_scheduleno, powh_allocqty, powh_balancequantity, powh_warehousecode, powh_ccusage, powh_createdby, powh_grrecdqty, powh_createddate, powh_lastmodifiedby, powh_graccpdqty, powh_grretrndqty, powh_lastmodifieddate, powh_grrejdqty, powh_grmovdqty, etlcreateddatetime
    )
    SELECT
        powh_poou, powh_pono, powh_poamendmentno, powh_polineno, powh_posubscheduleno, powh_scheduleno, powh_allocqty, powh_balancequantity, powh_warehousecode, powh_ccusage, powh_createdby, powh_grrecdqty, powh_createddate, powh_lastmodifiedby, powh_graccpdqty, powh_grretrndqty, powh_lastmodifieddate, powh_grrejdqty, powh_grmovdqty, etlcreateddatetime
    FROM stg.stg_po_powh_allocation_dtl;
    
    END IF;
--     EXCEPTION WHEN others THEN
--         get stacked diagnostics
--             p_errorid   = returned_sqlstate,
--             p_errordesc = message_text;
--     CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
--        select 0 into inscnt;
--        select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_popowhallocationdtl(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
