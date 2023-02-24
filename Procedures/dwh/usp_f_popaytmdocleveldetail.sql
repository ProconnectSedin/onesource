-- PROCEDURE: dwh.usp_f_popaytmdocleveldetail(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_popaytmdocleveldetail(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_popaytmdocleveldetail(
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
    FROM stg.stg_po_paytm_doclevel_detail;

    UPDATE dwh.F_popaytmdocleveldetail t
    SET
		paytm_suppkey					= coalesce(v.vendor_key,-1),
        paytm_poou                      = s.paytm_poou,
        paytm_pono                      = s.paytm_pono,
        paytm_poamendmentno             = s.paytm_poamendmentno,
        paytm_advancepayable            = s.paytm_advancepayable,
        paytm_payterm                   = s.paytm_payterm,
        paytm_paytosupplier             = s.paytm_paytosupplier,
        paytm_paymode                   = s.paytm_paymode,
        paytm_paymentstatus             = s.paytm_paymentstatus,
        paytm_advancepaid               = s.paytm_advancepaid,
        paytm_invoiceou                 = s.paytm_invoiceou,
        paytm_insuranceliability        = s.paytm_insuranceliability,
        paytm_ddchargesbornby           = s.paytm_ddchargesbornby,
        paytm_insuranceterm             = s.paytm_insuranceterm,
        paytm_insuranceamt              = s.paytm_insuranceamt,
        paytm_autoinvoice               = s.paytm_autoinvoice,
        paytm_incoterm                  = s.paytm_incoterm,
        paytm_addressid                 = s.paytm_addressid,
        paytm_transhipment              = s.paytm_transhipment,
        paytm_shippartial               = s.paytm_shippartial,
        paytm_incoplace                 = s.paytm_incoplace,
        paytm_createdby                 = s.paytm_createdby,
        paytm_createddate               = s.paytm_createddate,
        paytm_lastmodifiedby            = s.paytm_lastmodifiedby,
        paytm_lastmodifieddate          = s.paytm_lastmodifieddate,
        paytm_groption                  = s.paytm_groption,
        paytm_advancetolerance          = s.paytm_advancetolerance,
        paytm_invoicebeforegr           = s.paytm_invoicebeforegr,
        paytm_packingremarks            = s.paytm_packingremarks,
        paytm_shippingremarks           = s.paytm_shippingremarks,
        LCBG_App                        = s.LCBG_App,
        paytm_advancerequired           = s.paytm_advancerequired,
        etlactiveind                    = 1,
        etljobname                      = p_etljobname,
        envsourcecd                     = p_envsourcecd,
        datasourcecd                    = p_datasourcecd,
        etlupdatedatetime               = NOW()
    FROM stg.stg_po_paytm_doclevel_detail s
	left join dwh.d_vendor v
	ON v.vendor_id     = s.paytm_paytosupplier
	and v.vendor_ou=s.paytm_poou
    WHERE t.paytm_poou = s.paytm_poou
    AND t.paytm_pono  =  s.paytm_pono
    AND t.paytm_poamendmentno = s.paytm_poamendmentno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;  
    INSERT INTO dwh.F_popaytmdocleveldetail
    (
      paytm_suppkey,  paytm_poou, paytm_pono, paytm_poamendmentno, paytm_advancepayable, paytm_payterm, paytm_paytosupplier, paytm_paymode, paytm_paymentstatus, paytm_advancepaid, paytm_invoiceou, paytm_insuranceliability, paytm_ddchargesbornby, paytm_insuranceterm, paytm_insuranceamt, paytm_autoinvoice, paytm_incoterm, paytm_addressid, paytm_transhipment, paytm_shippartial, paytm_incoplace, paytm_createdby, paytm_createddate, paytm_lastmodifiedby, paytm_lastmodifieddate, paytm_groption, paytm_advancetolerance, paytm_invoicebeforegr, paytm_packingremarks, paytm_shippingremarks, LCBG_App, paytm_advancerequired, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
      coalesce(v.vendor_key,-1),  s.paytm_poou, s.paytm_pono, s.paytm_poamendmentno, s.paytm_advancepayable, s.paytm_payterm, s.paytm_paytosupplier, s.paytm_paymode, s.paytm_paymentstatus, s.paytm_advancepaid, s.paytm_invoiceou, s.paytm_insuranceliability, s.paytm_ddchargesbornby, s.paytm_insuranceterm, s.paytm_insuranceamt, s.paytm_autoinvoice, s.paytm_incoterm, s.paytm_addressid, s.paytm_transhipment, s.paytm_shippartial, s.paytm_incoplace, s.paytm_createdby, s.paytm_createddate, s.paytm_lastmodifiedby, s.paytm_lastmodifieddate, s.paytm_groption, s.paytm_advancetolerance, s.paytm_invoicebeforegr, s.paytm_packingremarks, s.paytm_shippingremarks, s.LCBG_App, s.paytm_advancerequired, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
     FROM stg.stg_po_paytm_doclevel_detail s
	left join dwh.d_vendor v
	ON v.vendor_id     = s.paytm_paytosupplier
	and v.vendor_ou=s.paytm_poou
  	LEFT JOIN dwh.F_popaytmdocleveldetail t
    ON s.paytm_poou = t.paytm_poou
    AND s.paytm_pono = t.paytm_pono
    AND s.paytm_poamendmentno = t.paytm_poamendmentno
    WHERE t.paytm_poou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_po_paytm_doclevel_detail
    (
        paytm_poou, paytm_pono, paytm_poamendmentno, paytm_advancepayable, paytm_payterm, paytm_paytosupplier, paytm_ptversion, paytm_paymode, paytm_paymentstatus, paytm_advancepaid, paytm_invoiceou, paytm_insuranceliability, paytm_ddchargesbornby, paytm_insuranceterm, paytm_insuranceamt, paytm_autoinvoice, paytm_incoterm, paytm_addressid, paytm_deliverypoint, paytm_packingterm, paytm_transmode, paytm_transhipment, paytm_shippartial, paytm_incoplace, paytm_createdby, paytm_createddate, paytm_lastmodifiedby, paytm_lastmodifieddate, paytm_groption, paytm_advancetolerance, paytm_invoicebeforegr, paytm_carrier, paytm_packingremarks, paytm_shippingremarks, paytm_reasoncode, paytm_policyno, paytm_lcno, paytm_lcamt, paytm_lcissdate, paytm_lcexpdate, LCBG_App, paytm_advancerequired, etlcreateddatetime
    )
    SELECT
        paytm_poou, paytm_pono, paytm_poamendmentno, paytm_advancepayable, paytm_payterm, paytm_paytosupplier, paytm_ptversion, paytm_paymode, paytm_paymentstatus, paytm_advancepaid, paytm_invoiceou, paytm_insuranceliability, paytm_ddchargesbornby, paytm_insuranceterm, paytm_insuranceamt, paytm_autoinvoice, paytm_incoterm, paytm_addressid, paytm_deliverypoint, paytm_packingterm, paytm_transmode, paytm_transhipment, paytm_shippartial, paytm_incoplace, paytm_createdby, paytm_createddate, paytm_lastmodifiedby, paytm_lastmodifieddate, paytm_groption, paytm_advancetolerance, paytm_invoicebeforegr, paytm_carrier, paytm_packingremarks, paytm_shippingremarks, paytm_reasoncode, paytm_policyno, paytm_lcno, paytm_lcamt, paytm_lcissdate, paytm_lcexpdate, LCBG_App, paytm_advancerequired, etlcreateddatetime
    FROM stg.stg_po_paytm_doclevel_detail;
    
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
ALTER PROCEDURE dwh.usp_f_popaytmdocleveldetail(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
