-- PROCEDURE: dwh.usp_f_outboundvasheaderweekly(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_outboundvasheaderweekly(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_outboundvasheaderweekly(
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
/* PROCEDURE		:	dwh.usp_f_outboundvasheaderweekly														 				 */
/* DESCRIPTION		:	This sp is used to load f_outboundvasheaderweekly table from stg_wms_outbound_vas_hdr        			 			 */
/*						Load Strategy: Insert/Update 															 */
/*						Sources: wms_outbound_vas_hdr_w					 		 									 */
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
/* EXECUTION SAMPLE :CALL dwh.usp_f_outboundvasheaderweekly('wms_outbound_vas_hdr_w','StgtoDW','f_outboundvasheader',0,0,0,0,NULL,NULL);*/
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
	SELECT d.jobname,h.envsourcecode,h.datasourcecode,d.latestbatchid,d.targetprocedurename, h.rawstorageflag,h.depsource, d.intervaldays
	INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag,p_depsource,p_interval
	FROM ods.controldetail d 
	INNER JOIN ods.controlheader h
		ON d.sourceid = h.sourceid
	WHERE 	d.sourceid 		= p_sourceId 
		AND d.dataflowflag 	= p_dataflowflag
		AND d.targetobject 	= p_targetobject;
		
		
		
 IF EXISTS(SELECT 1 FROM ods.controlheader WHERE sourceid = p_depsource AND status = 'Completed' 
                    AND COALESCE(lastupdateddate,createddate):: DATE >= NOW()::DATE)
    THEN

    SELECT COUNT(1) INTO srccnt
	FROM stg.stg_wms_outbound_vas_hdr;

	UPDATE dwh.f_outboundvasheader t
    SET  
	    obh_hr_key  = ob.obh_hr_key,
    	oub_loc_key					    = COALESCE(l.loc_key,-1),
		oub_vas_id                      =   s.wms_oub_vas_id,
		oub_instructions                =   s.wms_oub_instructions,
		oub_sequence                    =   s.wms_oub_sequence,
		oub_created_by                  =   s.wms_oub_created_by,
		oub_modified_by                 =   s.wms_oub_modified_by,
		etlactiveind 					= 1
		, etljobname 					= p_etljobname
		, envsourcecd 					= p_envsourcecd
		, datasourcecd 					= p_datasourcecd
		, etlupdatedatetime 			= NOW()	
    FROM stg.stg_wms_outbound_vas_hdr s
	
	INNER JOIN dwh.f_outboundheader ob
	
	   ON s.wms_oub_loc_code = ob.oub_loc_code 
	and s.wms_oub_outbound_ord =ob.oub_outbound_ord
	and s.wms_oub_ou = ob.oub_ou
	LEFT JOIN dwh.d_location L 		
		ON s.wms_oub_loc_code 	= L.loc_code 
        AND s.wms_oub_ou          = L.loc_ou
    WHERE t.oub_loc_code    =   s.wms_oub_loc_code
		AND t.oub_ou    =      s.wms_oub_ou
		AND t.oub_outbound_ord    =  s.wms_oub_outbound_ord
		AND t.oub_lineno    = s.wms_oub_lineno
		AND	    t.obh_hr_key  = ob.obh_hr_key;

/*
		DELETE FROM dwh.f_outboundvasheader FH
	    USING stg.stg_wms_outbound_vas_hdr OH
		WHERE FH.oub_ou              =      OH.wms_oub_ou
		AND FH.oub_loc_code       =      OH.wms_oub_loc_code
		AND FH.oub_outbound_ord    =      OH.wms_oub_outbound_ord
		AND FH.oub_lineno          =      OH.wms_oub_lineno;
-- 		and COALESCE(ob.oub_modified_date,ob.oub_created_date)::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
*/
    GET DIAGNOSTICS updcnt = ROW_COUNT;
--	select 0 into updcnt;

	INSERT INTO dwh.f_outboundvasheader
	(   obh_hr_key, oub_loc_key,oub_loc_code,               
		oub_ou,                     oub_outbound_ord,           
		oub_lineno,                 oub_vas_id,                 
		oub_instructions ,          oub_sequence ,              
		oub_created_by,     oub_modified_by,  etlactiveind					,
	  	etljobname				, envsourcecd, 
		datasourcecd			, etlcreatedatetime )
	
	SELECT 
       ob.obh_hr_key ,COALESCE(l.loc_key,-1), 
        OH.wms_oub_loc_code,
		OH.wms_oub_ou,	OH.wms_oub_outbound_ord,
		OH.wms_oub_lineno,	OH.wms_oub_vas_id,
		OH.wms_oub_instructions,	OH.wms_oub_sequence,
		OH.wms_oub_created_by,	OH.wms_oub_modified_by,   
		1 AS etlactiveind,				       p_etljobname,
		p_envsourcecd							, p_datasourcecd,          NOW()     
	FROM stg.stg_wms_outbound_vas_hdr OH
	INNER JOIN dwh.f_outboundheader ob
		ON OH.wms_oub_ou = ob.oub_ou 
		and OH.wms_oub_loc_code = ob.oub_loc_code
		and OH.wms_oub_outbound_ord =ob.oub_outbound_ord
	LEFT JOIN dwh.d_location L 		
		ON OH.wms_oub_loc_code 	= L.loc_code 
        AND OH.wms_oub_ou          = L.loc_ou
	LEFT JOIN dwh.f_outboundvasheader FH 	
		ON FH.oub_loc_code        =      OH.wms_oub_loc_code
		AND FH.oub_ou              =      OH.wms_oub_ou
		AND FH.oub_outbound_ord    =      OH.wms_oub_outbound_ord
		AND FH.oub_lineno          =      OH.wms_oub_lineno
		AND	 FH.obh_hr_key  = ob.obh_hr_key
		WHERE FH.oub_loc_code IS NULL;
    
    GET DIAGNOSTICS inscnt = ROW_COUNT;
	
	update dwh.f_outboundvasheader t1
	set etlactiveind =  0,
	etlupdatedatetime = Now()::timestamp
	from dwh.f_outboundvasheader t
	left join stg.stg_wms_outbound_vas_hdr s
	ON t.oub_loc_code    =   s.wms_oub_loc_code
	AND t.oub_ou    =      s.wms_oub_ou
	AND t.oub_outbound_ord    =  s.wms_oub_outbound_ord
	AND t.oub_lineno    = s.wms_oub_lineno
	where	    t.obh_hr_key  = t1.obh_hr_key
	AND COALESCE(t.etlupdatedatetime,t.etlcreatedatetime)::date >= NOW()::DATE
	AND s.wms_oub_ou is null;
	
    IF p_rawstorageflag = 1
    THEN
	
	INSERT INTO raw.raw_wms_outbound_vas_hdr
	(	wms_oub_loc_code,
     wms_oub_ou,
     wms_oub_outbound_ord,
     wms_oub_lineno,
     wms_oub_vas_id,
     wms_oub_instructions,
     wms_oub_sequence,
     wms_oub_created_by,
     wms_oub_modified_by,
	 etlcreateddatetime	)
	SELECT  
		wms_oub_loc_code,	wms_oub_ou,
		wms_oub_outbound_ord,	wms_oub_lineno,
		wms_oub_vas_id,	wms_oub_instructions,
		wms_oub_sequence,	wms_oub_created_by,
		wms_oub_modified_by,          etlcreateddatetime
	FROM stg.stg_wms_outbound_vas_hdr;
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
    
     EXCEPTION  
       WHEN others THEN       
       
    get stacked diagnostics
        p_errorid   = returned_sqlstate,
        p_errordesc = message_text;

    CALL ods.usp_etlerrorinsert(p_sourceid,p_targetobject,p_dataflowflag,
                                p_batchid,p_taskname,'sp_ExceptionHandling',
                                p_errorid,p_errordesc,null);

       select 0 into inscnt;
       select 0 into updcnt;   
  
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_outboundvasheaderweekly(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
