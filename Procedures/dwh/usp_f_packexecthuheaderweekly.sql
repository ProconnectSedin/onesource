-- PROCEDURE: dwh.usp_f_packexecthuheaderweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_packexecthuheaderweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_packexecthuheaderweekly(
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
	 p_depsource VARCHAR(100);

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource
    
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;
	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) = NOW()::DATE)
    THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_pack_exec_thu_hdr;

    UPDATE dwh.F_PackExecTHUHeader t
    SET
        pack_exec_hdr_key                 = fh.pack_exe_hdr_key,
        pack_exec_loc_key             	  =  COALESCE(l.loc_key,-1),
        pack_exec_thu_key                 = COALESCE(dt.thu_key,-1),
        pack_exec_uom_key                 = COALESCE(u.uom_key,-1),
        pack_exec_thu_class               = s.wms_pack_thu_class,
        pack_exec_thu_qty                 = s.wms_pack_thu_qty,
        pack_exec_thu_weight              = s.wms_pack_thu_weight,
        pack_exec_thu_weight_uom          = s.wms_pack_thu_weight_uom,
        pack_exec_thu_su_chk              = s.wms_pack_thu_su_chk,
        pack_exec_uid1_ser_no             = s.wms_pack_uid1_ser_no,
        pack_exec_thuspace                = s.wms_pack_thuspace,
        pack_exec_length                  = s.wms_pack_length,
        pack_exec_breadth                 = s.wms_pack_breadth,
        pack_exec_height                  = s.wms_pack_height,
        pack_exec_uom                     = s.wms_pack_uom,
        pack_exec_volumeuom               = s.wms_pack_volumeuom,
        pack_exec_volume                  = s.wms_pack_volume,
        pack_exec_itm_serno_pkplan        = s.wms_pack_itm_serno_pkplan,
        pack_exec_itemslno                = s.wms_pack_itemslno,
        pack_exec_thu_id2                 = s.wms_pack_thu_id2,
        pack_exec_thu_sr_no2              = s.wms_pack_thu_sr_no2,
        etlactiveind                 	  = 1,
        etljobname                   	  = p_etljobname,
        envsourcecd                  	  = p_envsourcecd,
        datasourcecd                 	  = p_datasourcecd,
        etlupdatedatetime            	  = NOW()
    FROM stg.stg_wms_pack_exec_thu_hdr s
	
	INNER JOIN dwh.F_PackExecHeader fh
	ON   s.wms_pack_exec_ou 	=   fh.pack_exec_ou
	AND  s.wms_pack_loc_code	=   fh.pack_loc_code
  	AND  s.wms_pack_exec_no		=   fh.pack_exec_no
	
    LEFT JOIN dwh.d_location L      
     ON  s.wms_pack_exec_ou           = L.loc_ou  
     AND s.wms_pack_loc_code          = L.loc_code
			
    LEFT JOIN dwh.d_thu dt      
      ON s.wms_pack_thu_id             = dt.thu_id 
      AND s.wms_pack_exec_ou           = dt.thu_ou			
			
    LEFT JOIN dwh.d_uom u       
     ON s.wms_pack_exec_ou       	= u.mas_ouinstance
     AND s.wms_pack_uom      		= u.mas_uomcode

    WHERE 	t.pack_exec_ou 			= s.wms_pack_exec_ou
	AND		t.pack_exec_loc_code 	= s.wms_pack_loc_code
    AND 	t.pack_exec_no 			= s.wms_pack_exec_no
    AND 	t.pack_exec_thu_id 		= s.wms_pack_thu_id
    AND 	t.pack_exec_thu_sr_no 	= s.wms_pack_thu_sr_no;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

--select * from  stg.stg_wms_pack_exec_thu_hdr where wms_pack_thu_sr_no='A006GRUF0114700'

    INSERT INTO dwh.F_PackExecTHUHeader
    (
        pack_exec_hdr_key ,pack_exec_loc_key ,pack_exec_thu_key ,pack_exec_uom_key,  pack_exec_loc_code, pack_exec_no, pack_exec_ou, pack_exec_thu_id, pack_exec_thu_class, pack_exec_thu_sr_no, pack_exec_thu_qty, pack_exec_thu_weight, pack_exec_thu_weight_uom, pack_exec_thu_su_chk, pack_exec_uid1_ser_no, pack_exec_thuspace, pack_exec_length, pack_exec_breadth, pack_exec_height, pack_exec_uom, pack_exec_volumeuom, pack_exec_volume, pack_exec_itm_serno_pkplan, pack_exec_itemslno, pack_exec_thu_id2, pack_exec_thu_sr_no2, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
    fh.pack_exe_hdr_key, COALESCE(l.loc_key,-1),COALESCE(dt.thu_key,-1),COALESCE(u.uom_key,-1),s.wms_pack_loc_code, s.wms_pack_exec_no, s.wms_pack_exec_ou, s.wms_pack_thu_id, s.wms_pack_thu_class, s.wms_pack_thu_sr_no, s.wms_pack_thu_qty, s.wms_pack_thu_weight, s.wms_pack_thu_weight_uom, s.wms_pack_thu_su_chk, s.wms_pack_uid1_ser_no, s.wms_pack_thuspace, s.wms_pack_length, s.wms_pack_breadth, s.wms_pack_height, s.wms_pack_uom, s.wms_pack_volumeuom, s.wms_pack_volume, s.wms_pack_itm_serno_pkplan, s.wms_pack_itemslno, s.wms_pack_thu_id2, s.wms_pack_thu_sr_no2, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_wms_pack_exec_thu_hdr s
	
	INNER JOIN dwh.F_PackExecHeader fh
	ON   s.wms_pack_exec_ou 	=   fh.pack_exec_ou
	AND  s.wms_pack_loc_code	=   fh.pack_loc_code
  	AND  s.wms_pack_exec_no		=   fh.pack_exec_no

    LEFT JOIN dwh.d_location L      
     ON  s.wms_pack_exec_ou           = L.loc_ou  
     AND s.wms_pack_loc_code          = L.loc_code
	
    LEFT JOIN dwh.d_thu dt      
    ON s.wms_pack_thu_id             = dt.thu_id 
    AND s.wms_pack_exec_ou           = dt.thu_ou
	
    LEFT JOIN dwh.d_uom u       
    ON s.wms_pack_exec_ou       	= u.mas_ouinstance
    AND s.wms_pack_uom      		= u.mas_uomcode 
    
    LEFT JOIN dwh.F_PackExecTHUHeader t
    ON 		t.pack_exec_ou 			= s.wms_pack_exec_ou
	AND		t.pack_exec_loc_code 	= s.wms_pack_loc_code
    AND 	t.pack_exec_no 			= s.wms_pack_exec_no
    AND 	t.pack_exec_thu_id 		= s.wms_pack_thu_id
    AND 	t.pack_exec_thu_sr_no 	= s.wms_pack_thu_sr_no
	
    WHERE t.pack_exec_ou IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	UPDATE dwh.F_PackExecTHUHeader t1
	SET     etlactiveind        =  0,
            etlupdatedatetime   = Now()::TIMESTAMP
	from dwh.F_PackExecTHUHeader t
	left join stg.stg_wms_pack_exec_thu_hdr s
	ON		t.pack_exec_ou 			= s.wms_pack_exec_ou
	AND		t.pack_exec_loc_code 	= s.wms_pack_loc_code
    AND 	t.pack_exec_no 			= s.wms_pack_exec_no
    AND 	t.pack_exec_thu_id 		= s.wms_pack_thu_id
    AND 	t.pack_exec_thu_sr_no 	= s.wms_pack_thu_sr_no
	Where 	t.pack_exec_thu_hdr_key = t1.pack_exec_thu_hdr_key
	AND     COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
     AND     s.wms_pack_exec_ou IS NULL;
	 
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_pack_exec_thu_hdr
    (
        wms_pack_loc_code, wms_pack_exec_no, wms_pack_exec_ou, wms_pack_thu_id, wms_pack_thu_class, wms_pack_thu_sr_no, wms_pack_thu_account, wms_pack_thu_consumable, wms_pack_thu_qty, wms_pack_thu_weight, wms_pack_thu_weight_uom, wms_pack_thu_su, wms_pack_thu_su_chk, wms_pack_uid1_ser_no, wms_pack_thuspace, wms_pack_length, wms_pack_breadth, wms_pack_height, wms_pack_uom, wms_pack_volumeuom, wms_pack_volume, wms_pack_itm_serno_pkplan, wms_pack_itemslno, wms_pack_thu_id2, wms_pack_thu_sr_no2, wms_packing_combination, wms_thu_max_pack_qty, etlcreateddatetime
    )
    SELECT
        wms_pack_loc_code, wms_pack_exec_no, wms_pack_exec_ou, wms_pack_thu_id, wms_pack_thu_class, wms_pack_thu_sr_no, wms_pack_thu_account, wms_pack_thu_consumable, wms_pack_thu_qty, wms_pack_thu_weight, wms_pack_thu_weight_uom, wms_pack_thu_su, wms_pack_thu_su_chk, wms_pack_uid1_ser_no, wms_pack_thuspace, wms_pack_length, wms_pack_breadth, wms_pack_height, wms_pack_uom, wms_pack_volumeuom, wms_pack_volume, wms_pack_itm_serno_pkplan, wms_pack_itemslno, wms_pack_thu_id2, wms_pack_thu_sr_no2, wms_packing_combination, wms_thu_max_pack_qty, etlcreateddatetime
    FROM stg.stg_wms_pack_exec_thu_hdr;
    
    END IF;
	
	ELSE    
         p_errorid   := 0;
         select 0 into inscnt;
            select 0 into updcnt;
         select 0 into srccnt;    
         
         IF p_depsource IS NULL
         THEN 
         p_errordesc := 'The Dependent source cannot be NULL.';
         ELSE
         p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source '|| p_sourceid||'.';
         END IF;
         CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,p_batchid,p_taskname,'sp_ExceptionHandling',p_errorid,p_errordesc,NULL);
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
ALTER PROCEDURE dwh.usp_f_packexecthuheaderweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
