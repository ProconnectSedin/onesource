-- PROCEDURE: dwh.usp_d_itmlovvarianthdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_itmlovvarianthdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_itmlovvarianthdr(
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
    FROM stg.stg_itm_lov_varianthdr;

    UPDATE dwh.d_itmlovvarianthdr t
    SET
        lov_variantshortdesc         = s.lov_variantshortdesc,
        lov_engchangectrl            = s.lov_engchangectrl,
        lov_stockuom                 = s.lov_stockuom,
        lov_matlspecification        = s.lov_matlspecification,
        lov_created_ou               = s.lov_created_ou,
        lov_created_by               = s.lov_created_by,
        lov_created_date             = s.lov_created_date,
        lov_modified_by              = s.lov_modified_by,
        lov_modified_date            = s.lov_modified_date,
        lov_created_langid           = s.lov_created_langid,
        lov_itmvardesc               = s.lov_itmvardesc,
        lov_multiuom_track           = s.lov_multiuom_track,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_itm_lov_varianthdr s
    WHERE t.lov_itemcode 			 = s.lov_itemcode
    AND   t.lov_variantcode 		 = s.lov_variantcode
    AND   t.lov_lo 					 = s.lov_lo;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_itmlovvarianthdr
    (
        lov_itemcode, 		lov_variantcode, 			lov_lo, 			lov_variantshortdesc, 		lov_engchangectrl, 
		lov_stockuom, 		lov_matlspecification, 		lov_created_ou, 	lov_created_by, 			lov_created_date, 
		lov_modified_by, 	lov_modified_date, 			lov_created_langid, lov_itmvardesc, 			lov_multiuom_track, 
		etlactiveind, 		etljobname, 				envsourcecd, 		datasourcecd, 				etlcreatedatetime
    )

    SELECT
        s.lov_itemcode, 	s.lov_variantcode, 			s.lov_lo, 				s.lov_variantshortdesc, 	s.lov_engchangectrl, 
		s.lov_stockuom, 	s.lov_matlspecification, 	s.lov_created_ou, 		s.lov_created_by, 			s.lov_created_date, 
		s.lov_modified_by, 	s.lov_modified_date, 		s.lov_created_langid, 	s.lov_itmvardesc, 			s.lov_multiuom_track, 
		1, 					p_etljobname, 				p_envsourcecd, 			p_datasourcecd, 			NOW()
    FROM stg.stg_itm_lov_varianthdr s
    LEFT JOIN dwh.d_itmlovvarianthdr t
    ON 	s.lov_itemcode 		= t.lov_itemcode
    AND s.lov_variantcode 	= t.lov_variantcode
    AND s.lov_lo 			= t.lov_lo
    WHERE t.lov_itemcode IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_itm_lov_varianthdr
    (
        lov_itemcode, 		lov_variantcode, 	lov_lo, 				lov_variantshortdesc, 		lov_drgrevisionno, 
		lov_revisionno, 	lov_drgref, 		lov_engchangectrl, 		lov_stockuom, 				lov_matlspecification, 
		lov_segment, 		lov_family, 		lov_class, 				lov_commodity, 				lov_businessfunc, 
		lov_created_ou, 	lov_created_by, 	lov_created_date, 		lov_modified_by, 			lov_modified_date, 
		lov_created_langid, lov_itmvardesc, 	lov_processflag, 		lov_alternateuom, 			lov_multiuom_track, 
		etlcreateddatetime
    )
    SELECT
        lov_itemcode, 		lov_variantcode, 	lov_lo, 				lov_variantshortdesc, 		lov_drgrevisionno, 
		lov_revisionno, 	lov_drgref, 		lov_engchangectrl, 		lov_stockuom, 				lov_matlspecification, 
		lov_segment, 		lov_family, 		lov_class, 				lov_commodity, 				lov_businessfunc, 
		lov_created_ou, 	lov_created_by, 	lov_created_date, 		lov_modified_by, 			lov_modified_date, 
		lov_created_langid, lov_itmvardesc, 	lov_processflag, 		lov_alternateuom, 			lov_multiuom_track, 
		etlcreateddatetime
    FROM stg.stg_itm_lov_varianthdr;
    
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
ALTER PROCEDURE dwh.usp_d_itmlovvarianthdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
