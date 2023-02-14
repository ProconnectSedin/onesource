-- PROCEDURE: dwh.usp_f_inboundamendheader(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_inboundamendheader(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_inboundamendheader(
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
    FROM stg.stg_wms_inbound_header_h;

    UPDATE dwh.F_InboundAmendHeader t
    SET
        inb_loc_key               = COALESCE(l.loc_key,-1),
        inb_refdoctype            = s.wms_inb_refdoctype,
        inb_refdocno              = s.wms_inb_refdocno,
        inb_refdocdate            = s.wms_inb_refdocdate,
        inb_orderdate             = s.wms_inb_orderdate,
        inb_status                = s.wms_inb_status,
        inb_custcode              = s.wms_inb_custcode,
        inb_vendorcode            = s.wms_inb_vendorcode,
        inb_address1              = s.wms_inb_address1,
        inb_address2              = s.wms_inb_address2,
        inb_address3              = s.wms_inb_address3,
        inb_postcode              = s.wms_inb_postcode,
        inb_country               = s.wms_inb_country,
        inb_state                 = s.wms_inb_state,
        inb_city                  = s.wms_inb_city,
        inb_phoneno               = s.wms_inb_phoneno,
        inb_secrefdoctype1        = s.wms_inb_secrefdoctype1,
        inb_secrefdoctype2        = s.wms_inb_secrefdoctype2,
        inb_secrefdocno1          = s.wms_inb_secrefdocno1,
        inb_secrefdocno2          = s.wms_inb_secrefdocno2,
        inb_secrefdocdate1        = s.wms_inb_secrefdocdate1,
        inb_secrefdocdate2        = s.wms_inb_secrefdocdate2,
        inb_shipmode              = s.wms_inb_shipmode,
        inb_instructions          = s.wms_inb_instructions,
        inb_created_by            = s.wms_inb_created_by,
        inb_created_date          = s.wms_inb_created_date,
        inb_modified_by           = s.wms_inb_modified_by,
        inb_modified_date         = s.wms_inb_modified_date,
        inb_timestamp             = s.wms_inb_timestamp,
        inb_contract_id           = s.wms_inb_contract_id,
        inb_custcode_h            = s.wms_inb_custcode_h,
        inb_type                  = s.wms_inb_type,
        etlactiveind              = 1,
        etljobname                = p_etljobname,
        envsourcecd               = p_envsourcecd,
        datasourcecd              = p_datasourcecd,
        etlupdatedatetime         = NOW()
    FROM stg.stg_wms_inbound_header_h s
    INNER JOIN dwh.f_inboundheader oh
     ON  s.wms_inb_loc_code = oh.inb_loc_code  
     and s.wms_inb_orderno =oh.inb_orderno 
     and s.wms_inb_ou = oh.inb_ou 
     LEFT JOIN dwh.d_location L      
        ON s.wms_inb_loc_code   = L.loc_code 
        AND s.wms_inb_ou        = L.loc_ou

    WHERE t.inb_loc_code = s.wms_inb_loc_code
    AND t.inb_orderno = s.wms_inb_orderno
    AND t.inb_ou = s.wms_inb_ou
    AND t.inb_amendno = s.wms_inb_amendno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_InboundAmendHeader
    (
          inb_loc_key,inb_loc_code, inb_orderno, inb_ou, inb_amendno, inb_refdoctype, inb_refdocno, inb_refdocdate, inb_orderdate, inb_status, inb_custcode, inb_vendorcode, inb_address1, inb_address2, inb_address3, inb_postcode, inb_country, inb_state, inb_city, inb_phoneno, inb_secrefdoctype1, inb_secrefdoctype2, inb_secrefdocno1, inb_secrefdocno2, inb_secrefdocdate1, inb_secrefdocdate2, inb_shipmode, inb_instructions, inb_created_by, inb_created_date, inb_modified_by, inb_modified_date, inb_timestamp, inb_contract_id, inb_custcode_h, inb_type, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
    COALESCE(l.loc_key,-1)  ,s.wms_inb_loc_code, s.wms_inb_orderno, s.wms_inb_ou, s.wms_inb_amendno, s.wms_inb_refdoctype, s.wms_inb_refdocno, s.wms_inb_refdocdate, s.wms_inb_orderdate, s.wms_inb_status, s.wms_inb_custcode, s.wms_inb_vendorcode, s.wms_inb_address1, s.wms_inb_address2, s.wms_inb_address3, s.wms_inb_postcode, s.wms_inb_country, s.wms_inb_state, s.wms_inb_city, s.wms_inb_phoneno, s.wms_inb_secrefdoctype1, s.wms_inb_secrefdoctype2, s.wms_inb_secrefdocno1, s.wms_inb_secrefdocno2, s.wms_inb_secrefdocdate1, s.wms_inb_secrefdocdate2, s.wms_inb_shipmode, s.wms_inb_instructions, s.wms_inb_created_by, s.wms_inb_created_date, s.wms_inb_modified_by, s.wms_inb_modified_date, s.wms_inb_timestamp, s.wms_inb_contract_id, s.wms_inb_custcode_h, s.wms_inb_type, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_inbound_header_h s
	 INNER JOIN dwh.f_inboundheader oh
     ON  s.wms_inb_loc_code = oh.inb_loc_code  
     and s.wms_inb_orderno =oh.inb_orderno 
     and s.wms_inb_ou = oh.inb_ou 
    LEFT JOIN dwh.d_location L      
        ON s.wms_inb_loc_code   = L.loc_code 
        AND s.wms_inb_ou        = L.loc_ou

    LEFT JOIN dwh.F_InboundAmendHeader t
    ON s.wms_inb_loc_code = t.inb_loc_code
    AND s.wms_inb_orderno = t.inb_orderno
    AND s.wms_inb_ou = t.inb_ou
    AND s.wms_inb_amendno = t.inb_amendno
    WHERE t.inb_loc_code IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_inbound_header_h
    (
        wms_inb_loc_code, wms_inb_orderno, wms_inb_ou, wms_inb_amendno, wms_inb_refdoctype, wms_inb_refdocno, wms_inb_refdocdate, wms_inb_orderdate, wms_inb_status, wms_inb_custcode, wms_inb_vendorcode, wms_inb_addressid, wms_inb_address1, wms_inb_address2, wms_inb_address3, wms_inb_unqaddress, wms_inb_postcode, wms_inb_country, wms_inb_state, wms_inb_city, wms_inb_phoneno, wms_inb_secrefdoctype1, wms_inb_secrefdoctype2, wms_inb_secrefdoctype3, wms_inb_secrefdocno1, wms_inb_secrefdocno2, wms_inb_secrefdocno3, wms_inb_secrefdocdate1, wms_inb_secrefdocdate2, wms_inb_secrefdocdate3, wms_inb_shipmode, wms_inb_shiptype, wms_inb_instructions, wms_inb_created_by, wms_inb_created_date, wms_inb_modified_by, wms_inb_modified_date, wms_inb_timestamp, wms_inb_userdefined1, wms_inb_userdefined2, wms_inb_userdefined3, wms_inb_operation_status, wms_inb_ord_type, wms_inb_contract_id, wms_inb_contract_amend_no, wms_inb_custcode_h, wms_inb_type, wms_inb_addr_loc_code, wms_inb_consignor_code, wms_inb_reason_code, etlcreateddatetime
    )
    SELECT
        wms_inb_loc_code, wms_inb_orderno, wms_inb_ou, wms_inb_amendno, wms_inb_refdoctype, wms_inb_refdocno, wms_inb_refdocdate, wms_inb_orderdate, wms_inb_status, wms_inb_custcode, wms_inb_vendorcode, wms_inb_addressid, wms_inb_address1, wms_inb_address2, wms_inb_address3, wms_inb_unqaddress, wms_inb_postcode, wms_inb_country, wms_inb_state, wms_inb_city, wms_inb_phoneno, wms_inb_secrefdoctype1, wms_inb_secrefdoctype2, wms_inb_secrefdoctype3, wms_inb_secrefdocno1, wms_inb_secrefdocno2, wms_inb_secrefdocno3, wms_inb_secrefdocdate1, wms_inb_secrefdocdate2, wms_inb_secrefdocdate3, wms_inb_shipmode, wms_inb_shiptype, wms_inb_instructions, wms_inb_created_by, wms_inb_created_date, wms_inb_modified_by, wms_inb_modified_date, wms_inb_timestamp, wms_inb_userdefined1, wms_inb_userdefined2, wms_inb_userdefined3, wms_inb_operation_status, wms_inb_ord_type, wms_inb_contract_id, wms_inb_contract_amend_no, wms_inb_custcode_h, wms_inb_type, wms_inb_addr_loc_code, wms_inb_consignor_code, wms_inb_reason_code, etlcreateddatetime
    FROM stg.stg_wms_inbound_header_h;
    END IF;

    EXCEPTION
        WHEN others THEN
        get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt; 
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_inboundamendheader(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
