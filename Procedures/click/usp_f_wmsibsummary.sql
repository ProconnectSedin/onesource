-- PROCEDURE: click.usp_f_wmsibsummary()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmsibsummary();

CREATE OR REPLACE PROCEDURE click.usp_f_wmsibsummary(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	p_depsource VARCHAR(100);
	
BEGIN

		SELECT 	depsource
		INTO 	p_depsource
		FROM 	ods.dwhtoclickcontroldtl
		WHERE 	objectname = 'usp_f_wmsibsummary'; 

	IF EXISTS 
		 (
			 SELECT 1 FROM ods.dwhtoclickcontroldtl
			 WHERE	objectname = p_depsource
			 AND	status = 'completed'
			 AND	CAST(COALESCE(loadenddatetime,loadstartdatetime) AS DATE) >= NOW()::DATE
		 )
	THEN

 	TRUNCATE TABLE click.f_wmsinboundsummary RESTART IDENTITY;
	
--	DELETE FROM click.f_wmsinboundsummary WHERE asn_createddate >= (NOW() - INTERVAL '12 MONTHS')::DATE;

	INSERT INTO click.f_wmsinboundsummary
	(
		ou_id, 				customer_key, 		customer_id, 		datekey, 	
		asn_key,			asn_no,	asn_date,	item_group, 
		item_class, 		loc_key, 			loc_code, 			asn_type, 			inb_type,			grn_status,
		pway_status,			receivedlinecount,CUMvolume,CUCMvolume,
		receivedunit,
		grn_hht_ind,		
		pway_hht_ind
	
	)
	SELECT 
		fa.asn_ou,			fa.asn_cust_key,	fa.asn_cust_code,	d.datekey,
		fa.asn_key,	fa.asn_no,(COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE,	i.itm_itemgroup,
		i.itm_class,		fa.asn_loc_key,		fa.asn_location,	fa.asn_prefdoc_type,fa.asn_type,		fg.gr_pln_status,
		fp.pway_pln_status,
		COALESCE(COUNT(DISTINCT fg.gr_lineno),0) receivedline,
		CASE WHEN itm_volume_uom ='CUM' THEN COALESCE(SUM(itm_volume_calc),0) END CUMreceivedvolume,
		CASE WHEN itm_volume_uom ='CUCM' THEN COALESCE(SUM(itm_volume_calc),0) END CUCMreceivedvolume,
		COALESCE(SUM(fg.gr_item_qty),0) receivedunit,
		COALESCE(CASE WHEN MIN(fg.gr_gen_from) = 'WMS_MOB' THEN 1 ELSE 0 END,0) AS grn_hht,
		COALESCE(CASE WHEN MIN(fp.pway_gen_from) = 'WMS_MOB' THEN 1 ELSE 0 END,0) AS Pway_hht
	FROM click.f_asn fa
	INNER JOIN dwh.d_itemheader i
		ON  fa.asn_dtl_itm_hdr_key 	= i.itm_hdr_key
	INNER JOIN click.d_date d
		ON dateactual = (COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE
	LEFT JOIN click.f_grn fg
		ON  fa.asn_key				= fg.asn_key
	LEFT JOIN click.f_putaway fp
		ON  fg.grn_key 				= fp.grn_key
	WHERE 	fa.asn_status NOT IN('FR','UA','CNL')	
-- 	COALESCE(fa.asn_modified_date,fa.asn_created_date)::DATE >= (NOW() - INTERVAL '12 MONTHS')::DATE 
-- 	AND 	
	GROUP BY
		fa.asn_ou,			fa.asn_cust_key,	fa.asn_cust_code,	d.datekey,
		fa.asn_key,	fa.asn_no,(COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE,	i.itm_itemgroup,
		i.itm_class,		fa.asn_loc_key,		fa.asn_location,	fa.asn_prefdoc_type,fa.asn_type,		fg.gr_pln_status,
		fp.pway_pln_status,i.itm_volume_uom;
		
	/*	
	/*Update ReceivedLine, ReceivedVolume and ReceivedUnit column in Summary Table*/	
	
	UPDATE click.f_wmsinboundsummary wis
	SET
		receivedlinecount 	= COALESCE(s.receivedline,0),
		CUMvolume 			= COALESCE(s.CUMreceivedvolume,0),
		CUCMvolume 			= COALESCE(s.CUCMreceivedvolume,0),
		receivedunit 		= COALESCE(s.receivedunit,0)
	FROM
	(
		SELECT 
		
		asn_ou,				asn_cust_key,		datekey,	itm_itemgroup,	itm_class,		
		asn_loc_key,		asn_prefdoc_type,	asn_type,		gr_pln_status,
		pway_pln_status,
		SUM(receivedline) receivedline,
		SUM(CUMreceivedvolume) CUMreceivedvolume,
		SUM(CUCMreceivedvolume) CUCMreceivedvolume,
		SUM(receivedunit) receivedunit 
		FROM
		(
			SELECT
				fa.asn_ou,			fa.asn_cust_key,	d.datekey,	i.itm_itemgroup,	i.itm_class,		
				fa.asn_loc_key,		fa.asn_prefdoc_type,fa.asn_type,		fg.gr_pln_status,
				fp.pway_pln_status,			
				COALESCE(COUNT(DISTINCT fg.gr_lineno),0) receivedline,
				CASE WHEN itm_volume_uom ='CUM' THEN COALESCE(SUM(itm_volume_calc),0) END CUMreceivedvolume,
				CASE WHEN itm_volume_uom ='CUCM' THEN COALESCE(SUM(itm_volume_calc),0) END CUCMreceivedvolume,
				COALESCE(SUM(fg.gr_item_qty),0) receivedunit
			FROM click.f_asn fa
			INNER JOIN dwh.d_itemheader i
				ON  fa.asn_dtl_itm_hdr_key 	= i.itm_hdr_key
			INNER JOIN click.d_date d
			ON dateactual = (COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE
			LEFT JOIN click.f_grn fg
				ON  fa.asn_key				= fg.asn_key
			LEFT JOIN click.f_putaway fp
				ON  fg.grn_key 				= fp.grn_key
			
			WHERE fa.asn_status NOT IN('FR','UA','CNL')
			GROUP BY
				fa.asn_ou,			fa.asn_cust_key,	d.datekey,	i.itm_itemgroup,	i.itm_class,		
				fa.asn_loc_key,		fa.asn_prefdoc_type,fa.asn_type,		fg.gr_pln_status,
				fp.pway_pln_status,	itm_volume_uom	
				
		) sq
		GROUP BY
				asn_ou,				asn_cust_key,		datekey,	itm_itemgroup,	itm_class,		
				asn_loc_key,		asn_prefdoc_type,	asn_type,		gr_pln_status,
				pway_pln_status
	) s
	WHERE 	wis.ou_id 							= s.asn_ou
		AND wis.customer_key 					= s.asn_cust_key
		AND wis.datekey 						= s.datekey
		AND COALESCE(wis.item_group,'NULL') 	= COALESCE(s.itm_itemgroup,'NULL')
		AND COALESCE(wis.item_class,'NULL') 	= COALESCE(s.itm_class,'NULL')
		AND wis.loc_key 						= s.asn_loc_key
		AND COALESCE(wis.asn_type,'NULL') 		= COALESCE(s.asn_prefdoc_type,'NULL')
		AND COALESCE(wis.inb_type,'NULL') 		= COALESCE(s.asn_type,'NULL')	
		AND COALESCE(wis.grn_status,'NULL') 	= COALESCE(s.gr_pln_status,'NULL')	
		AND COALESCE(wis.pway_status,'NULL') 	= COALESCE(s.pway_pln_status,'NULL');	
		*/	
    ELSE	
	p_errorid   := 0;
		IF p_depsource IS NULL
			THEN 
			 	p_errordesc := 'The Dependent source cannot be NULL.';
			ELSE
				p_errordesc := 'The Dependent source '|| p_depsource || ' is not successfully executed. Please execute the source '|| p_depsource || ' then re-run the source.';
			END IF;
		CALL ods.usp_etlerrorinsert('DWH','usp_f_wmsibsummary','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
	END IF;

		
	EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','usp_f_wmsibsummary','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmsibsummary()
    OWNER TO proconnect;
