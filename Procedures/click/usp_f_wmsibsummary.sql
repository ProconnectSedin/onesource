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
		ou_id, 				customer_key, 		customer_id, 		datekey, 			activeindicator,
		asn_key,			asn_no,				asn_prefdoc_no,		asn_sup_no,		asn_date,			
		loc_key, 			loc_code, 			asn_type, 			inb_type,		asn_status,gr_status,	pway_status,
		receivedlinecount,	CUMvolume,			receivedunit,		grn_hht_ind,	pway_hht_ind,
		asnphysicalwgt,		asnvolumetricwgt,	grnlinecount,		grnCUMvolume,	grnunit,
		grnphysicalwgt,		grnvolumetricwgt,	pwaylinecount,		pwayCUMvolume,	pwayunit,
		pwayphysicalwgt,	pwayvolumetricwgt,	asnqualifieddatekey,	grempcount,	pwayempcount,
		Totalshftworkhrs	
	)
	SELECT 
		fa.asn_ou,			fa.asn_cust_key,	fa.asn_cust_code,	d.datekey,		max(fa.activeindicator*i.etlactiveind),
		fa.asn_hr_key,		fa.asn_no,			fa.asn_prefdoc_no,	fa.asn_sup_asn_no,(COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE,	
		fa.asn_loc_key,		fa.asn_location,	fa.asn_type,fa.asn_prefdoc_type,fa.asn_status,fg.gr_exec_status,fp.pway_exec_status,
		COALESCE(COUNT(DISTINCT fa.asn_lineno),0) as receivedline,
		COALESCE(SUM((fa.asn_rec_qty*itm_volume_calc)/(1000000)),0) as CUMreceivedvolume,
		COALESCE(SUM(fa.asn_rec_qty),0) as receivedunit,
		COALESCE(CASE WHEN MIN(fg.gr_gen_from) = 'WMS_MOB' THEN 1 ELSE 0 END,0) AS grn_hht,
		COALESCE(CASE WHEN MIN(fp.pway_gen_from) = 'WMS_MOB' THEN 1 ELSE 0 END,0) AS Pway_hht,
		COALESCE(SUM(fa.asn_rec_qty*itm_weight),0)	as asnphysicalwgt,
		COALESCE((SUM(fa.asn_rec_qty*itm_weight)/5000),0)	as asnvolumetricwgt,
		COALESCE(COUNT(DISTINCT fg.gr_lineno),0) as grnlinecount,
		COALESCE(SUM((fg.gr_item_qty*itm_volume_calc)/(1000000)),0) as grnCUMvolume,
		COALESCE(SUM(fg.gr_item_qty),0) as grnunit,
		COALESCE(SUM(fg.gr_item_qty*itm_weight),0)	as grnphysicalwgt,
		COALESCE((SUM(fg.gr_item_qty*itm_weight)/5000),0)	as grnvolumetricwgt,
		COALESCE(COUNT(DISTINCT fp.pway_exec_lineno),0) as pwaylinecount,
		COALESCE(SUM((fp.pway_actual_bin_qty*itm_volume_calc)/(1000000)),0) as pwayCUMvolume,
		COALESCE(SUM(fp.pway_actual_bin_qty),0) as pwayunit,
		COALESCE(SUM(fp.pway_actual_bin_qty*itm_weight),0)	as pwayphysicalwgt,
		COALESCE((SUM(fp.pway_actual_bin_qty*itm_weight)/5000),0)	as pwayvolumetricwgt,
		MAX(asn_qualifieddatekey),
		COALESCE(COUNT(DISTINCT fg.gr_employee),0) as grempcount,
		COALESCE(COUNT(DISTINCT fp.pway_employee_id),0) as pwayempcount,
		MAX(loc_shft_to_time-loc_shft_fr_time)
	FROM click.f_asn fa
	INNER JOIN dwh.d_itemheader i
		ON  fa.asn_dtl_itm_hdr_key 	= i.itm_hdr_key
	INNER JOIN click.d_date d
		ON dateactual = (COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE
	INNER JOIN click.d_locationshiftdetails
	ON fa.asn_loc_key	= loc_key
	LEFT JOIN click.f_grn fg
		ON  fa.asn_key				= fg.asn_key
	LEFT JOIN click.f_putaway fp
		ON  fg.grn_key 				= fp.grn_key
	WHERE 	fa.asn_status NOT IN('FR','UA','CNL')	
-- 	COALESCE(fa.asn_modified_date,fa.asn_created_date)::DATE >= (NOW() - INTERVAL '12 MONTHS')::DATE 
-- 	AND 	
	GROUP BY
		fa.asn_ou,			fa.asn_cust_key,	fa.asn_cust_code,	d.datekey, 
		fa.asn_hr_key,		fa.asn_no,			fa.asn_prefdoc_no,	fa.asn_sup_asn_no,(COALESCE(fa.asn_modified_date,fa.asn_created_date))::DATE,	
		fa.asn_loc_key,		fa.asn_location,	fa.asn_prefdoc_type,fa.asn_status,fg.gr_exec_status,fp.pway_exec_status,fa.asn_type;
		
	
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
