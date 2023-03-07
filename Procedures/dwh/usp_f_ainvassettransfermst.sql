-- PROCEDURE: dwh.usp_f_ainvassettransfermst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_ainvassettransfermst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_ainvassettransfermst(
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
    FROM stg.Stg_ainv_asset_transfer_mst;

    UPDATE dwh.F_ainvassettransfermst t
    SET
        timestamp               = s.timestamp,
        ou_id                   = s.ou_id,
        transfer_date           = s.transfer_date,
        asset_number            = s.asset_number,
        tag_number              = s.tag_number,
        recv_loc_code           = s.recv_loc_code,
        recv_cost_center        = s.recv_cost_center,
        remarks                 = s.remarks,
        asset_loc_code          = s.asset_loc_code,
        cost_center             = s.cost_center,
        asset_class_code        = s.asset_class_code,
        asset_group_code        = s.asset_group_code,
        asset_desc              = s.asset_desc,
        tag_desc                = s.tag_desc,
        confirm_reqd            = s.confirm_reqd,
        confirm_status          = s.confirm_status,
        createdby               = s.createdby,
        createddate             = s.createddate,
        dest_ouid               = s.dest_ouid,
        line_no                 = s.line_no,
        tran_out_no             = s.tran_out_no,
        tran_in_no              = s.tran_in_no,
        etlactiveind            = 1,
        etljobname              = p_etljobname,
        envsourcecd             = p_envsourcecd,
        datasourcecd            = p_datasourcecd,
        etlupdatedatetime       = NOW()
    FROM stg.Stg_ainv_asset_transfer_mst s
    WHERE t.ou_id = s.ou_id
    AND t.transfer_date = s.transfer_date
    AND t.asset_number = s.asset_number
    AND t.tag_number = s.tag_number
    AND t.line_no = s.line_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_ainvassettransfermst
    (
        timestamp, ou_id, transfer_date, asset_number, tag_number, recv_loc_code, recv_cost_center, remarks, asset_loc_code, cost_center, asset_class_code, asset_group_code, asset_desc, tag_desc, confirm_reqd, confirm_status, createdby, createddate, dest_ouid, line_no, tran_out_no, tran_in_no, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.timestamp, s.ou_id, s.transfer_date, s.asset_number, s.tag_number, s.recv_loc_code, s.recv_cost_center, s.remarks, s.asset_loc_code, s.cost_center, s.asset_class_code, s.asset_group_code, s.asset_desc, s.tag_desc, s.confirm_reqd, s.confirm_status, s.createdby, s.createddate, s.dest_ouid, s.line_no, s.tran_out_no, s.tran_in_no, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.Stg_ainv_asset_transfer_mst s
    LEFT JOIN dwh.F_ainvassettransfermst t
    ON s.ou_id = t.ou_id
    AND s.transfer_date = t.transfer_date
    AND s.asset_number = t.asset_number
    AND s.tag_number = t.tag_number
    AND s.line_no = t.line_no
    WHERE t.timestamp IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_ainv_asset_transfer_mst
    (
        timestamp, ou_id, transfer_date, asset_number, tag_number, recv_loc_code, recv_cost_center, remarks, asset_loc_code, cost_center, asset_class_code, asset_group_code, asset_desc, tag_desc, confirm_reqd, confirm_date, confirm_status, bu_id, createdby, createddate, modifiedby, modifieddate, dest_ouid, line_no, tran_out_no, tran_in_no, etlcreateddatetime
    )
    SELECT
        timestamp, ou_id, transfer_date, asset_number, tag_number, recv_loc_code, recv_cost_center, remarks, asset_loc_code, cost_center, asset_class_code, asset_group_code, asset_desc, tag_desc, confirm_reqd, confirm_date, confirm_status, bu_id, createdby, createddate, modifiedby, modifieddate, dest_ouid, line_no, tran_out_no, tran_in_no, etlcreateddatetime
    FROM stg.Stg_ainv_asset_transfer_mst;
    
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
ALTER PROCEDURE dwh.usp_f_ainvassettransfermst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
