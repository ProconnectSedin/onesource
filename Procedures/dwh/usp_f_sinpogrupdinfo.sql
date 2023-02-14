-- PROCEDURE: dwh.usp_f_sinpogrupdinfo(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_sinpogrupdinfo(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_sinpogrupdinfo(
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
    FROM stg.stg_sin_2wpo_gr_aplan_upd_info;

    UPDATE dwh.f_sinpogrupdinfo t
    SET
        po_type                        = s.po_type,
        po_ou                          = s.po_ou,
        po_no                          = s.po_no,
        po_amend_no                    = s.po_amend_no,
        po_line_no                     = s.po_line_no,
        po_qty                         = s.po_qty,
        grinv_type                     = s.grinv_type,
        grinv_sequence_no              = s.grinv_sequence_no,
        grinv_ou                       = s.grinv_ou,
        grinv_no                       = s.grinv_no,
        grinv_line_no                  = s.grinv_line_no,
        grinv_qty                      = s.grinv_qty,
        grinv_aplan_upd_qty            = s.grinv_aplan_upd_qty,
        grinv_aplan_bal_upd_qty        = s.grinv_aplan_bal_upd_qty,
        proposal_no                    = s.proposal_no,
        cwip_acc_no                    = s.cwip_acc_no,
        inv_po_amount                  = s.inv_po_amount,
        inv_tran_amount                = s.inv_tran_amount,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_sin_2wpo_gr_aplan_upd_info s
    WHERE t.po_type = s.po_type
    AND t.po_ou = s.po_ou
    AND t.po_no = s.po_no
    AND t.po_amend_no = s.po_amend_no
    AND t.po_line_no = s.po_line_no
    AND t.grinv_type = s.grinv_type
    AND t.grinv_ou = s.grinv_ou
    AND t.grinv_no = s.grinv_no
    AND t.grinv_line_no = s.grinv_line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_sinpogrupdinfo
    (
        po_type, po_ou, po_no, po_amend_no, po_line_no, po_qty, grinv_type, grinv_sequence_no, grinv_ou, grinv_no, grinv_line_no, grinv_qty, grinv_aplan_upd_qty, grinv_aplan_bal_upd_qty, proposal_no, cwip_acc_no, inv_po_amount, inv_tran_amount, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.po_type, s.po_ou, s.po_no, s.po_amend_no, s.po_line_no, s.po_qty, s.grinv_type, s.grinv_sequence_no, s.grinv_ou, s.grinv_no, s.grinv_line_no, s.grinv_qty, s.grinv_aplan_upd_qty, s.grinv_aplan_bal_upd_qty, s.proposal_no, s.cwip_acc_no, s.inv_po_amount, s.inv_tran_amount, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_sin_2wpo_gr_aplan_upd_info s
    LEFT JOIN dwh.f_sinpogrupdinfo t
    ON s.po_type = t.po_type
    AND s.po_ou = t.po_ou
    AND s.po_no = t.po_no
    AND s.po_amend_no = t.po_amend_no
    AND s.po_line_no = t.po_line_no
    AND s.grinv_type = t.grinv_type
    AND s.grinv_ou = t.grinv_ou
    AND s.grinv_no = t.grinv_no
    AND s.grinv_line_no = t.grinv_line_no
    WHERE t.po_type IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_sin_2wpo_gr_aplan_upd_info
    (
        po_type, po_ou, po_no, po_amend_no, po_line_no, po_qty, grinv_type, grinv_sequence_no, grinv_ou, grinv_no, grinv_line_no, grinv_qty, grinv_aplan_upd_qty, grinv_aplan_bal_upd_qty, proposal_no, cwip_acc_no, inv_po_amount, inv_tran_amount, etlcreatedatetime
    )
    SELECT
        po_type, po_ou, po_no, po_amend_no, po_line_no, po_qty, grinv_type, grinv_sequence_no, grinv_ou, grinv_no, grinv_line_no, grinv_qty, grinv_aplan_upd_qty, grinv_aplan_bal_upd_qty, proposal_no, cwip_acc_no, inv_po_amount, inv_tran_amount, etlcreatedatetime
    FROM stg.stg_sin_2wpo_gr_aplan_upd_info;
    
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
ALTER PROCEDURE dwh.usp_f_sinpogrupdinfo(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
