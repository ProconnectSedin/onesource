-- PROCEDURE: dwh.usp_f_contractdetailhistoryweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_contractdetailhistoryweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_contractdetailhistoryweekly(
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

/*****************************************************************************************************************/
/* PROCEDURE		:	dwh.usp_f_contractdetailhistoryweekly														 				 */
/* DESCRIPTION		:	This sp is used to load f_contractdetailhistoryweekly table from stg_wms_contract_dtl_h        			 			 */
/*						Load Strategy: Insert/Update 															 */
/*						Sources: wms_contract_dtl_h_w					 		 									 */
/*****************************************************************************************************************/
/* DEVELOPMENT HISTORY																							 */
/*****************************************************************************************************************/
/* AUTHOR    		:	AKASH V																						 */
/* DATE				:	26-DEC-2022																				 */
/*****************************************************************************************************************/
/* MODIFICATION HISTORY																							 */
/*****************************************************************************************************************/
/* MODIFIED BY		:																							 */
/* DATE				:														 									 */
/* DESCRIPTION		:													  										 */
/*****************************************************************************************************************/
/* EXECUTION SAMPLE :CALL dwh.usp_f_contractdetailhistoryweekly('wms_contract_dtl_h_w','StgtoDW','f_contractdetailhistory',0,0,0,0,NULL,NULL);*/
/*****************************************************************************************************************/

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
	p_depsource VARCHAR(100);
    p_rawstorageflag integer;
    p_interval integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag,h.depsource,d.intervaldays
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource,p_interval
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

	
	IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
					AND CAST(COALESCE(lastupdateddate,createddate) AS DATE) >= NOW()::DATE)
	THEN

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_wms_contract_dtl_h;

    UPDATE dwh.F_ContractDetailHistory t
    SET
        cont_hdr_hst_key			   = fh.cont_hdr_hst_key,
        cont_tariff_id                 = s.wms_cont_tariff_id,
        cont_tariff_ser_id             = s.wms_cont_tariff_ser_id,
        cont_rate                      = s.wms_cont_rate,
        cont_min_change                = s.wms_cont_min_change,
        cont_min_change_added          = s.wms_cont_min_change_added,
        cont_cost                      = s.wms_cont_cost,
        cont_margin_per                = s.wms_cont_margin_per,
        cont_max_charge                = s.wms_cont_max_charge,
        cont_rate_valid_from           = s.wms_cont_rate_valid_from,
        cont_rate_valid_to             = s.wms_cont_rate_valid_to,
        cont_basic_charge              = s.wms_cont_basic_charge,
        cont_val_currency              = s.wms_cont_val_currency,
        cont_bill_currency             = s.wms_cont_bill_currency,
        cont_exchange_rate_type        = s.wms_cont_exchange_rate_type,
        cont_discount                  = s.wms_cont_discount,
        cont_last_day                  = s.wms_cont_last_day,
        cont_draft_bill_grp            = s.wms_cont_draft_bill_grp,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_wms_contract_dtl_h s
	INNER JOIN 	dwh.F_ContractHeaderHistory fh 
			ON  s.wms_cont_id 		= fh.cont_id 
			AND s.wms_cont_ou 		= fh.cont_ou
			AND s.wms_cont_amendno 	= fh.cont_amendno
    WHERE t.cont_id                        = s.wms_cont_id
	and	  t.cont_lineno                    = s.wms_cont_lineno
    and      t.cont_ou                        = s.wms_cont_ou
    and      t.cont_amendno                   = s.wms_cont_amendno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;	

/*
	Delete from dwh.F_ContractDetailHistory t
	USING stg.stg_wms_contract_dtl_h s
	where t.cont_id                        = s.wms_cont_id
	and	  t.cont_lineno                    = s.wms_cont_lineno
    and   t.cont_ou                        = s.wms_cont_ou
    and   t.cont_amendno                   = s.wms_cont_amendno ;
	--and COALESCE(h.cont_modified_dt,h.cont_created_dt)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;

-- 	stg.stg_wms_contract_dtl_h
-- 	WHERE cont_id                        = wms_cont_id
-- 	AND	  cont_lineno                    = wms_cont_lineno
--     AND   cont_ou                        = wms_cont_ou
--     AND   cont_amendno                   = wms_cont_amendno;
	
*/

    INSERT INTO dwh.F_ContractDetailHistory
    (
		cont_hdr_hst_key	,
        cont_id				, cont_lineno		, cont_ou					, cont_amendno			, cont_tariff_id, 
		cont_tariff_ser_id	, cont_rate			, cont_min_change			, cont_min_change_added	, cont_cost, 
		cont_margin_per		, cont_max_charge	, cont_rate_valid_from		, cont_rate_valid_to	, cont_basic_charge, 
		cont_val_currency	, cont_bill_currency, cont_exchange_rate_type	, cont_discount			, cont_last_day, 
		cont_draft_bill_grp	, etlactiveind		, etljobname				, envsourcecd			, datasourcecd, 
		etlcreatedatetime
    )

    SELECT
		fh.cont_hdr_hst_key,
        s.wms_cont_id, 				s.wms_cont_lineno, 			s.wms_cont_ou, 					s.wms_cont_amendno, 			s.wms_cont_tariff_id, 
		s.wms_cont_tariff_ser_id, 	s.wms_cont_rate, 			s.wms_cont_min_change, 			s.wms_cont_min_change_added, 	s.wms_cont_cost, 
		s.wms_cont_margin_per, 		s.wms_cont_max_charge, 		s.wms_cont_rate_valid_from, 	s.wms_cont_rate_valid_to, 		s.wms_cont_basic_charge, 
		s.wms_cont_val_currency, 	s.wms_cont_bill_currency, 	s.wms_cont_exchange_rate_type, 	s.wms_cont_discount, 			s.wms_cont_last_day, 
		s.wms_cont_draft_bill_grp, 	1, 							p_etljobname, 					p_envsourcecd, 					p_datasourcecd, 
		NOW()
    FROM stg.stg_wms_contract_dtl_h s
	INNER JOIN 	dwh.F_ContractHeaderHistory fh 
			ON  s.wms_cont_id 		= fh.cont_id 
			AND s.wms_cont_ou 		= fh.cont_ou
			AND s.wms_cont_amendno 	= fh.cont_amendno
    LEFT JOIN dwh.F_ContractDetailHistory t
    ON    t.cont_id                        = s.wms_cont_id
	AND	  t.cont_lineno                    = s.wms_cont_lineno
    AND   t.cont_ou                        = s.wms_cont_ou
    AND   t.cont_amendno                   = s.wms_cont_amendno
    WHERE t.cont_id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;
--	select 0 into updcnt;
/*	
	UPDATE	dwh.F_ContractDetailHistory s
    SET		cont_hdr_hst_key	= fh.cont_hdr_hst_key,
	 		etlupdatedatetime	= NOW()
    FROM	dwh.F_ContractHeaderHistory fh  
    WHERE	s.cont_id 		= fh.cont_id 
	AND		s.cont_ou 		= fh.cont_ou
	AND		s.cont_amendno 	= fh.cont_amendno
    AND		COALESCE(fh.cont_modified_dt,fh.cont_created_dt)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;

*/	
   
     UPDATE dwh.f_contractdetailhistory t1
     SET etlactiveind =  0,
     etlupdatedatetime = Now()::timestamp
     FROM dwh.f_contractdetailhistory t
     LEFT join stg.stg_wms_contract_dtl_h s
		ON    t.cont_id                        = s.wms_cont_id
		and   t.cont_lineno                    = s.wms_cont_lineno
		and   t.cont_ou                        = s.wms_cont_ou
		and   t.cont_amendno                   = s.wms_cont_amendno
     WHERE t.cont_dtl_hst_key = t1.cont_dtl_hst_key
     AND   COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
     AND  s.wms_cont_id is null;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_wms_contract_dtl_h
    (
        wms_cont_id, wms_cont_lineno, wms_cont_ou, wms_cont_amendno, wms_cont_tariff_id, 
		wms_cont_tariff_ser_id, wms_cont_rate, wms_cont_min_change, wms_cont_min_change_added, wms_cont_cost, 
		wms_cont_margin_per, wms_cont_max_charge, wms_cont_rate_valid_from, wms_cont_rate_valid_to, wms_cont_basic_charge, 
		wms_cont_val_currency, wms_cont_bill_currency, wms_cont_exchange_rate_type, wms_cont_discount, wms_cont_last_day, 
		wms_cont_draft_bill_grp, etlcreateddatetime
    )
    SELECT
        wms_cont_id, wms_cont_lineno, wms_cont_ou, wms_cont_amendno, wms_cont_tariff_id, 
		wms_cont_tariff_ser_id, wms_cont_rate, wms_cont_min_change, wms_cont_min_change_added, wms_cont_cost, 
		wms_cont_margin_per, wms_cont_max_charge, wms_cont_rate_valid_from, wms_cont_rate_valid_to, wms_cont_basic_charge, 
		wms_cont_val_currency, wms_cont_bill_currency, wms_cont_exchange_rate_type, wms_cont_discount, wms_cont_last_day, 
		wms_cont_draft_bill_grp, etlcreateddatetime
    FROM stg.stg_wms_contract_dtl_h;
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
ALTER PROCEDURE dwh.usp_f_contractdetailhistoryweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
