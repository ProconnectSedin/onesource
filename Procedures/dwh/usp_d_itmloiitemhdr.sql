-- PROCEDURE: dwh.usp_d_itmloiitemhdr(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_itmloiitemhdr(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_itmloiitemhdr(
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
    FROM stg.stg_itm_loi_itemhdr;

    UPDATE dwh.d_itmloiitemhdr t
    SET
        loi_accountgroup            = s.loi_accountgroup,
        loi_itemdesc                = s.loi_itemdesc,
        loi_itemshortdesc           = s.loi_itemshortdesc,
        loi_variantallowd           = s.loi_variantallowd,
        loi_nextvariantno           = s.loi_nextvariantno,
        loi_templateflg             = s.loi_templateflg,
        loi_ac_created_by           = s.loi_ac_created_by,
        loi_ac_created_date         = s.loi_ac_created_date,
        loi_ac_modified_by          = s.loi_ac_modified_by,
        loi_ac_modified_date        = s.loi_ac_modified_date,
        loi_created_langid          = s.loi_created_langid,
        loi_modelvariant            = s.loi_modelvariant,
        etlactiveind                = 1,
        etljobname                  = p_etljobname,
        envsourcecd                 = p_envsourcecd,
        datasourcecd                = p_datasourcecd,
        etlupdatedatetime           = NOW()
    FROM stg.stg_itm_loi_itemhdr s
    WHERE   t.loi_itemcode 			= s.loi_itemcode
    AND 	t.loi_lo 				= s.loi_lo;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_itmloiitemhdr
    (
        loi_itemcode, 			loi_lo, 				loi_accountgroup, 		loi_itemdesc, 			loi_itemshortdesc, 
		loi_variantallowd, 		loi_nextvariantno, 		loi_templateflg, 		loi_ac_created_by, 		loi_ac_created_date, 
		loi_ac_modified_by, 	loi_ac_modified_date, 	loi_created_langid, 	loi_modelvariant, 		etlactiveind, 
		etljobname, 			envsourcecd, 			datasourcecd, 			etlcreatedatetime
    )

    SELECT
        s.loi_itemcode, 		s.loi_lo, 				s.loi_accountgroup, 	s.loi_itemdesc, 		s.loi_itemshortdesc, 
		s.loi_variantallowd, 	s.loi_nextvariantno, 	s.loi_templateflg, 		s.loi_ac_created_by, 	s.loi_ac_created_date, 
		s.loi_ac_modified_by, 	s.loi_ac_modified_date, s.loi_created_langid, 	s.loi_modelvariant, 	1, 
		p_etljobname, 			p_envsourcecd, 			p_datasourcecd, 		NOW()
    FROM stg.stg_itm_loi_itemhdr s
    LEFT JOIN dwh.d_itmloiitemhdr t
    ON 	  s.loi_itemcode = t.loi_itemcode
    AND   s.loi_lo 		 = t.loi_lo
    WHERE t.loi_itemcode IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_itm_loi_itemhdr
    (
        loi_itemcode, 			loi_lo, 				loi_accountgroup, 		loi_itemdesc, 		loi_itemshortdesc, 
		loi_variantallowd, 		loi_nextvariantno, 		loi_templateflg, 		loi_ac_created_by, 	loi_ac_created_date, 
		loi_ac_modified_by, 	loi_ac_modified_date, 	loi_created_langid, 	loi_modelvariant, 	etlcreateddatetime
    )
    SELECT
        loi_itemcode, 			loi_lo, 				loi_accountgroup, 		loi_itemdesc, 		loi_itemshortdesc, 
		loi_variantallowd, 		loi_nextvariantno, 		loi_templateflg, 		loi_ac_created_by, 	loi_ac_created_date, 
		loi_ac_modified_by, 	loi_ac_modified_date, 	loi_created_langid, 	loi_modelvariant, 	etlcreateddatetime
    FROM stg.stg_itm_loi_itemhdr;
    
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
ALTER PROCEDURE dwh.usp_d_itmloiitemhdr(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
