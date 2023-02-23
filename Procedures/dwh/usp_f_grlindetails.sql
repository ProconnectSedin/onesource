-- PROCEDURE: dwh.usp_f_grlindetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_grlindetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_grlindetails(
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
    FROM stg.stg_gr_lin_details;

    UPDATE dwh.F_grlindetails t
    SET
	
		grlindetails_itm_hdr_key =    COALESCE(it.itm_hdr_key,-1),
		grlindetails_uom_key =    COALESCE(u.uom_key,-1),
		grlindetails_loc_key =    COALESCE(l.loc_key,-1),
        gr_lin_ouinstid             = s.gr_lin_ouinstid,
        gr_lin_grno                 = s.gr_lin_grno,
        gr_lin_grlineno             = s.gr_lin_grlineno,
        gr_lin_orderlineno          = s.gr_lin_orderlineno,
        gr_lin_orderschno           = s.gr_lin_orderschno,
        gr_lin_byprodsno            = s.gr_lin_byprodsno,
        gr_lin_linestatus           = s.gr_lin_linestatus,
        gr_lin_itemcode             = s.gr_lin_itemcode,
        gr_lin_itemvariant          = s.gr_lin_itemvariant,
        gr_lin_itemdesc             = s.gr_lin_itemdesc,
        gr_lin_itemdesc_shd         = s.gr_lin_itemdesc_shd,
        gr_lin_adhocitemcls         = s.gr_lin_adhocitemcls,
        gr_lin_orderqty             = s.gr_lin_orderqty,
        gr_lin_orderschqty          = s.gr_lin_orderschqty,
        gr_lin_proposalid           = s.gr_lin_proposalid,
        gr_lin_schdate              = s.gr_lin_schdate,
        gr_lin_receivedqty          = s.gr_lin_receivedqty,
        gr_lin_quarnqty             = s.gr_lin_quarnqty,
        gr_lin_acceptedqty          = s.gr_lin_acceptedqty,
        gr_lin_movedqty             = s.gr_lin_movedqty,
        gr_lin_delynoteqty          = s.gr_lin_delynoteqty,
        gr_lin_uom                  = s.gr_lin_uom,
        gr_lin_instype              = s.gr_lin_instype,
        gr_lin_matchtype            = s.gr_lin_matchtype,
        gr_lin_toltype              = s.gr_lin_toltype,
        gr_lin_tolplus              = s.gr_lin_tolplus,
        gr_lin_tolminus             = s.gr_lin_tolminus,
        gr_lin_frdate               = s.gr_lin_frdate,
        gr_lin_fadate               = s.gr_lin_fadate,
        gr_lin_fmdate               = s.gr_lin_fmdate,
        gr_lin_consrule             = s.gr_lin_consrule,
        gr_lin_bomrefer             = s.gr_lin_bomrefer,
        gr_lin_outputtype           = s.gr_lin_outputtype,
        gr_lin_ordrefdoctype        = s.gr_lin_ordrefdoctype,
        gr_lin_qlyattrib            = s.gr_lin_qlyattrib,
        gr_lin_createdby            = s.gr_lin_createdby,
        gr_lin_createdate           = s.gr_lin_createdate,
        gr_lin_modifiedby           = s.gr_lin_modifiedby,
        gr_lin_modifieddate         = s.gr_lin_modifieddate,
        gr_lin_po_cost              = s.gr_lin_po_cost,
        gr_lin_costper              = s.gr_lin_costper,
        gr_lin_fr_remarks           = s.gr_lin_fr_remarks,
        gr_lin_fa_remarks           = s.gr_lin_fa_remarks,
        gr_lin_fm_remarks           = s.gr_lin_fm_remarks,
        gr_lin_location             = s.gr_lin_location,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_gr_lin_details s
	LEFT JOIN dwh.d_itemheader it                   
          ON s.gr_lin_itemcode    = it.itm_code
           AND s.gr_lin_ouinstid     = it.itm_ou
	LEFT JOIN dwh.d_uom u           
       ON s.gr_lin_uom    = u.mas_uomcode 
           AND s.gr_lin_ouinstid     = u.mas_ouinstance

    LEFT JOIN dwh.d_location L              
          ON s.gr_lin_location                   = L.loc_code 
           AND s.gr_lin_ouinstid                        = L.loc_ou
    WHERE t.gr_lin_ouinstid = s.gr_lin_ouinstid
    AND t.gr_lin_grno = s.gr_lin_grno
    AND t.gr_lin_grlineno = s.gr_lin_grlineno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_grlindetails
    (
       grlindetails_itm_hdr_key,grlindetails_uom_key,grlindetails_loc_key ,gr_lin_ouinstid, gr_lin_grno, gr_lin_grlineno, gr_lin_orderlineno, gr_lin_orderschno, gr_lin_byprodsno, gr_lin_linestatus, gr_lin_itemcode, gr_lin_itemvariant, gr_lin_itemdesc, gr_lin_itemdesc_shd, gr_lin_adhocitemcls, gr_lin_orderqty, gr_lin_orderschqty, gr_lin_proposalid, gr_lin_schdate, gr_lin_receivedqty, gr_lin_quarnqty, gr_lin_acceptedqty, gr_lin_movedqty, gr_lin_delynoteqty, gr_lin_uom, gr_lin_instype, gr_lin_matchtype, gr_lin_toltype, gr_lin_tolplus, gr_lin_tolminus, gr_lin_frdate, gr_lin_fadate, gr_lin_fmdate, gr_lin_consrule, gr_lin_bomrefer, gr_lin_outputtype, gr_lin_ordrefdoctype, gr_lin_qlyattrib, gr_lin_createdby, gr_lin_createdate, gr_lin_modifiedby, gr_lin_modifieddate, gr_lin_po_cost, gr_lin_costper, gr_lin_fr_remarks, gr_lin_fa_remarks, gr_lin_fm_remarks, gr_lin_location, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
         COALESCE(it.itm_hdr_key,-1),COALESCE(u.uom_key,-1),COALESCE(l.loc_key,-1), s.gr_lin_ouinstid, s.gr_lin_grno, s.gr_lin_grlineno, s.gr_lin_orderlineno, s.gr_lin_orderschno, s.gr_lin_byprodsno, s.gr_lin_linestatus, s.gr_lin_itemcode, s.gr_lin_itemvariant, s.gr_lin_itemdesc, s.gr_lin_itemdesc_shd, s.gr_lin_adhocitemcls, s.gr_lin_orderqty, s.gr_lin_orderschqty, s.gr_lin_proposalid, s.gr_lin_schdate, s.gr_lin_receivedqty, s.gr_lin_quarnqty, s.gr_lin_acceptedqty, s.gr_lin_movedqty, s.gr_lin_delynoteqty, s.gr_lin_uom, s.gr_lin_instype, s.gr_lin_matchtype, s.gr_lin_toltype, s.gr_lin_tolplus, s.gr_lin_tolminus, s.gr_lin_frdate, s.gr_lin_fadate, s.gr_lin_fmdate, s.gr_lin_consrule, s.gr_lin_bomrefer, s.gr_lin_outputtype, s.gr_lin_ordrefdoctype, s.gr_lin_qlyattrib, s.gr_lin_createdby, s.gr_lin_createdate, s.gr_lin_modifiedby, s.gr_lin_modifieddate, s.gr_lin_po_cost, s.gr_lin_costper, s.gr_lin_fr_remarks, s.gr_lin_fa_remarks, s.gr_lin_fm_remarks, s.gr_lin_location, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_gr_lin_details s
	
		LEFT JOIN dwh.d_itemheader it                   
          ON s.gr_lin_itemcode    = it.itm_code
           AND s.gr_lin_ouinstid     = it.itm_ou
	LEFT JOIN dwh.d_uom u           
       ON s.gr_lin_uom    = u.mas_uomcode 
           AND s.gr_lin_ouinstid     = u.mas_ouinstance

    LEFT JOIN dwh.d_location L              
          ON s.gr_lin_location                   = L.loc_code 
           AND s.gr_lin_ouinstid                        = L.loc_ou
    LEFT JOIN dwh.F_grlindetails t
    ON s.gr_lin_ouinstid = t.gr_lin_ouinstid
    AND s.gr_lin_grno = t.gr_lin_grno
    AND s.gr_lin_grlineno = t.gr_lin_grlineno
    WHERE t.gr_lin_ouinstid IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_gr_lin_details
    (
        gr_lin_ouinstid, gr_lin_grno, gr_lin_grlineno, gr_lin_orderlineno, gr_lin_orderschno, gr_lin_byprodsno, gr_lin_linestatus, gr_lin_itemcode, gr_lin_itemvariant, gr_lin_itemdesc, gr_lin_itemdesc_shd, gr_lin_adhocitemcls, gr_lin_dwgrevno, gr_lin_orderqty, gr_lin_orderschqty, gr_lin_proposalid, gr_lin_schdate, gr_lin_receivedqty, gr_lin_receivebay, gr_lin_quarnqty, gr_lin_quarnbay, gr_lin_acceptedqty, gr_lin_rejectedqty, gr_lin_movedqty, gr_lin_delynoteqty, gr_lin_retnoteqty, gr_lin_returnqty, gr_lin_debitnoteqty, gr_lin_resupplyqty, gr_lin_postgrrejqty, gr_lin_uom, gr_lin_instype, gr_lin_matchtype, gr_lin_toltype, gr_lin_tolplus, gr_lin_tolminus, gr_lin_frdate, gr_lin_fadate, gr_lin_fmdate, gr_lin_consrule, gr_lin_bomrefer, gr_lin_outputtype, gr_lin_ordrefdoctype, gr_lin_ordrefdocno, gr_lin_ordrefdoclineno, gr_lin_qlyattrib, gr_lin_qltyremarks, gr_lin_createdby, gr_lin_createdate, gr_lin_modifiedby, gr_lin_modifieddate, gr_lin_po_cost, gr_lin_costper, gr_lin_fr_remarks, gr_lin_fa_remarks, gr_lin_fm_remarks, gr_lin_ProjectCode, gr_lin_ProjectOU, gr_lin_reftrkno, gr_lin_location, pending_cap_amount, cap_amt, writeoff_amt, writeoff_remarks, writeoff_JVno, etlcreateddatetime
    )
    SELECT
        gr_lin_ouinstid, gr_lin_grno, gr_lin_grlineno, gr_lin_orderlineno, gr_lin_orderschno, gr_lin_byprodsno, gr_lin_linestatus, gr_lin_itemcode, gr_lin_itemvariant, gr_lin_itemdesc, gr_lin_itemdesc_shd, gr_lin_adhocitemcls, gr_lin_dwgrevno, gr_lin_orderqty, gr_lin_orderschqty, gr_lin_proposalid, gr_lin_schdate, gr_lin_receivedqty, gr_lin_receivebay, gr_lin_quarnqty, gr_lin_quarnbay, gr_lin_acceptedqty, gr_lin_rejectedqty, gr_lin_movedqty, gr_lin_delynoteqty, gr_lin_retnoteqty, gr_lin_returnqty, gr_lin_debitnoteqty, gr_lin_resupplyqty, gr_lin_postgrrejqty, gr_lin_uom, gr_lin_instype, gr_lin_matchtype, gr_lin_toltype, gr_lin_tolplus, gr_lin_tolminus, gr_lin_frdate, gr_lin_fadate, gr_lin_fmdate, gr_lin_consrule, gr_lin_bomrefer, gr_lin_outputtype, gr_lin_ordrefdoctype, gr_lin_ordrefdocno, gr_lin_ordrefdoclineno, gr_lin_qlyattrib, gr_lin_qltyremarks, gr_lin_createdby, gr_lin_createdate, gr_lin_modifiedby, gr_lin_modifieddate, gr_lin_po_cost, gr_lin_costper, gr_lin_fr_remarks, gr_lin_fa_remarks, gr_lin_fm_remarks, gr_lin_ProjectCode, gr_lin_ProjectOU, gr_lin_reftrkno, gr_lin_location, pending_cap_amount, cap_amt, writeoff_amt, writeoff_remarks, writeoff_JVno, etlcreateddatetime
    FROM stg.stg_gr_lin_details;
    
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
ALTER PROCEDURE dwh.usp_f_grlindetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
