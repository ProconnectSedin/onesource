-- PROCEDURE: click.usp_f_wmpscoreboard()

-- DROP PROCEDURE IF EXISTS click.usp_f_wmpscoreboard();

CREATE OR REPLACE PROCEDURE click.usp_f_wmpscoreboard(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
    p_errorid integer;
	p_errordesc character varying;
	p_depsource VARCHAR(100);
	
BEGIN

	TRUNCATE TABLE click.f_wmpscoreboard;
	
	INSERT INTO click.f_wmpscoreboard
	(ouid,datekey,orderqualifieddate,divisioncode,locationcode,locationname,locationcity,locationstate,
	statename,customerid,customername,slaactual,orfactual,dccactual)
	SELECT ouid,orderqualifieddatekey,orderqualifieddate,divisioncode,locationcode,locationname,locationcity,locationstate,
	statename,customerid,customername,SUM(slapercnt),AVG(orderfullfillmentpercnt),93 as dccactual
	FROM click.f_wmpoperations
	GROUP BY ouid,orderqualifieddatekey,orderqualifieddate,divisioncode,locationcode,locationname,locationcity,locationstate,
	statename,customerid,customername;
	
	UPDATE click.f_wmpscoreboard
	SET lockey = loc_key
	FROM click.d_location
	WHERE loc_code = locationcode;
	
	
	UPDATE click.f_wmpscoreboard 
	SET customerkey = customer_key
	FROM click.d_customer 
	WHERE customer_id = customerid;
	
	UPDATE click.f_wmpscoreboard 
	SET statename = geo_state_desc
	FROM click.d_geostatedetail 
	WHERE geo_state_code = locationstate;

UPDATE click.f_wmpscoreboard 
SET region = CASE WHEN locationstate = 'TN' THEN 'SOUTH' 
				 WHEN locationstate = 'RJ' THEN 'NORTH' 
				 WHEN locationstate = 'HR' THEN 'NORTH' 
				 WHEN locationstate = 'JK' THEN 'NORTH' 
				 WHEN locationstate = 'AP' THEN 'SOUTH' 
				 WHEN locationstate = 'GA' THEN 'SOUTHWEST' 
				 WHEN locationstate = 'BR' THEN 'EAST' 
				 WHEN locationstate = 'PY' THEN 'SOUTH' 
				 WHEN locationstate = 'DN' THEN 'NORTH' 
				 WHEN locationstate = 'CG' THEN 'N/A' 
				 WHEN locationstate = 'TG' THEN 'SOUTH' 
				 WHEN locationstate = 'WB' THEN 'EAST' 
				 WHEN locationstate = 'UP' THEN 'N/A' 
				 WHEN locationstate = 'GJ' THEN 'N/A' 
				 WHEN locationstate = 'KR' THEN 'SOUTH' 
				 WHEN locationstate = 'KL' THEN 'SOUTH' 
				 WHEN locationstate = 'AS' THEN 'NORTHEAST' 
				 WHEN locationstate = 'CH' THEN 'N/A' 
				 WHEN locationstate = 'MH' THEN 'WEST' 
				 WHEN locationstate = 'OR' THEN 'EAST' 
				 WHEN locationstate = 'UT' THEN 'N/A' 
				 WHEN locationstate = 'JR' THEN 'EAST' 
				 WHEN locationstate = 'PB' THEN 'NORTHWEST' 
				 WHEN locationstate = 'MP' THEN 'CENTRE' ELSE 'OTHERS' END;	
	-- 	select * from click.d_georegion 
-- 	UPDATE click.f_wmpscoreboard 
-- 	SET region = geo_reg_desc
-- 	FROM click.d_georegion 
-- 	WHERE geo_state_code = locationstate;
	
	UPDATE click.f_wmpscoreboard
	SET	slascore = CASE WHEN slascore IS NULL THEN 0.5 ELSE slascore END,
		orfscore = CASE WHEN orfscore IS NULL THEN 0.5 ELSE orfscore END,
		dccscore = CASE WHEN dccscore IS NULL THEN 0.5 ELSE dccscore END,
		inventoryaccuracyscore = CASE WHEN inventoryaccuracyscore IS NULL THEN 0.5 ELSE inventoryaccuracyscore END,
		absenteeismscore = CASE WHEN absenteeismscore IS NULL THEN 0.5 ELSE absenteeismscore END,
		attritionscore	=	CASE WHEN attritionscore IS NULL THEN 0.5 ELSE attritionscore END,
		accidentfreedayscore = CASE WHEN accidentfreedayscore IS NULL THEN 0.5 ELSE accidentfreedayscore END,
		securitygadgetsscore = CASE WHEN securitygadgetsscore IS NULL THEN 0.5 ELSE securitygadgetsscore END,
		npsscore = CASE WHEN npsscore IS NULL THEN 0.5 ELSE npsscore END,
		customerclaimscore = CASE WHEN customerclaimscore IS NULL THEN 0.5 ELSE customerclaimscore END,
		dcpscore = CASE WHEN dcpscore IS NULL THEN 0.5 ELSE dcpscore END;
	
	UPDATE click.f_wmpscoreboard
	SET slatarget = target_prcnt
	FROM click.d_WmpCategory
	WHERE category_code = 'OM'
	AND subcategory_code = 'SLA'
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	UPDATE click.f_wmpscoreboard
	SET slascore = score
	FROM click.d_WmpSlab
	WHERE category = 'OM'
	AND subcategory = 'SLA'
	AND slaactual BETWEEN COALESCE(slab_prcnt_from,0) AND COALESCE(slab_prcnt_to,100)
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	
	UPDATE click.f_wmpscoreboard
	SET orftarget = target_prcnt
	FROM click.d_WmpCategory
	WHERE category_code = 'OM'
	AND subcategory_code = 'ORF'
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	UPDATE click.f_wmpscoreboard
	SET orfscore = score
	FROM click.d_WmpSlab
	WHERE category = 'OM'
	AND subcategory = 'ORF'
	AND orfactual BETWEEN COALESCE(slab_prcnt_from,0) AND COALESCE(slab_prcnt_to,100)
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	UPDATE click.f_wmpscoreboard
	SET dcctarget = target_prcnt
	FROM click.d_WmpCategory
	WHERE category_code = 'OM'
	AND subcategory_code = 'DCC'
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	UPDATE click.f_wmpscoreboard
	SET dccscore = score
	FROM click.d_WmpSlab
	WHERE category = 'OM'
	AND subcategory = 'DCC'
	AND dccactual BETWEEN COALESCE(slab_prcnt_from,0) AND COALESCE(slab_prcnt_to,100)
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
 	UPDATE click.f_wmpscoreboard wmp
 	SET inventoryaccuracy = sinventoryaccuracy
	FROM (
		SELECT ouid,EXTRACT(month from stockcountdate) as stockmonth,divisioncode,locationcode,customerid,AVG(COALESCE(inventoryaccuracy,0)) as sinventoryaccuracy
		FROM click.f_WMPInventoryAccuracy
		GROUP BY ouid,EXTRACT(month from stockcountdate),divisioncode,locationcode,customerid
		) a
	WHERE 	wmp.ouid 	=	a.ouid
	AND 	EXTRACT (month from wmp.orderqualifieddate) = a.stockmonth 
	AND 	wmp.divisioncode =	a.divisioncode
	AND 	wmp.locationcode =  a.locationcode
	AND 	wmp.customerid	=	a.customerid;
	
	UPDATE click.f_wmpscoreboard
	SET inventoryaccuracy = 0.00
	WHERE inventoryaccuracy IS NULL;
	
	UPDATE click.f_wmpscoreboard
	SET inventoryaccuracytarget = target_prcnt
	FROM click.d_WmpCategory
	WHERE category_code = 'IM'
	AND subcategory_code = 'INA'
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	UPDATE click.f_wmpscoreboard
	SET inventoryaccuracyscore = score
	FROM click.d_WmpSlab
	WHERE category = 'IM'
	AND subcategory = 'INA'
	AND inventoryaccuracy BETWEEN COALESCE(slab_prcnt_from,0) AND COALESCE(slab_prcnt_to,100)
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	CREATE TEMP TABLE empcount
	AS
	SELECT wlcon as divcode,tmsht_date::Date as attdate,count(distinct employee_code) as cnt,0.00 as abspercnt 
	FROM click.f_attendance
	GROUP BY wlcon,tmsht_date;

	CREATE TEMP TABLE absentism
	AS
	SELECT wlcon as divsioncode,tmsht_date::Date as atddate,count(distinct employee_code) as acnt
	FROM click.f_attendance
	WHERE attendance_status IN ('AB','','EXABH','CO')
	GROUP BY wlcon,tmsht_date;

	Update empcount
	SET	abspercnt = (cast(COALESCE(acnt,0) as numeric(21,2))/cast(COALESCE(cnt,0) as numeric(21,2)))*100
	FROM absentism
	WHERE divsioncode = divcode
	AND atddate = attdate;	
	

	UPDATE click.f_wmpscoreboard
	SET absenteeismactual = cast(COALESCE(abspercnt,0.00) as numeric(20,2))
	FROM empcount
	WHERE divcode = divisioncode
	AND attdate	=	orderqualifieddate;
	
	UPDATE click.f_wmpscoreboard
	SET absenteeismtarget = target_prcnt
	FROM click.d_WmpCategory
	WHERE category_code = 'MM'
	AND subcategory_code = 'ABS'
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	UPDATE click.f_wmpscoreboard
	SET absenteeismscore = score
	FROM click.d_WmpSlab
	WHERE category = 'MM'
	AND subcategory = 'ABS'
	AND absenteeismactual BETWEEN COALESCE(slab_prcnt_from,0) AND COALESCE(slab_prcnt_to,100)
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	

	CREATE TEMP TABLE attritiontemp
	AS
	SELECT warehouse_code as divcode,EXTRACT (month from attendance_month) as attmonth,SUM(addition) as addition,SUM(COALESCE(emp_count,0)) as emp_count,
			SUM(COALESCE(seperation,0)) as seperation,0.00 as attrpercnt 
	FROM click.f_attrition 
	GROUP BY warehouse_code,EXTRACT (month from attendance_month);

	UPDATE click.f_wmpscoreboard
	SET attritionactual = CASE WHEN emp_count <> 0 AND addition <> 0 AND (emp_count-addition) <> 0  THEN ABS(cast(COALESCE(seperation,0) as numeric(21,2))/(cast(COALESCE(emp_count,0) as numeric(21,2))-cast(COALESCE(addition,0) as numeric(21,2)))*100) ELSE 0 END
	FROM attritiontemp
	WHERE divcode = divisioncode
	AND attmonth	=	EXTRACT (month from orderqualifieddate);
-- 	AND (emp_count <> 0 
-- 	OR addition <> 0);
	
	UPDATE click.f_wmpscoreboard
	SET attritiontarget = target_prcnt
	FROM click.d_WmpCategory
	WHERE category_code = 'MM'
	AND subcategory_code = 'ATR'
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	UPDATE click.f_wmpscoreboard
	SET attritionscore = score
	FROM click.d_WmpSlab
	WHERE category = 'MM'
	AND subcategory = 'ATR'
	AND attritionactual BETWEEN COALESCE(slab_prcnt_from,0) AND COALESCE(slab_prcnt_to,100)
	AND orderqualifieddate BETWEEN effective_from AND effective_to;
	
	
	UPDATE click.f_wmpscoreboard wmp
	SET accidentfreedayscore = score
	FROM click.f_wmpaccidentfreedays afd
	WHERE afd.wafc_ou	=	wmp.ouid 
	AND EXTRACT(MONTH FROM afd.wafc_date)	=	EXTRACT(MONTH FROM wmp.orderqualifieddate)
	AND afd.division_code	=	wmp.divisioncode 
	AND afd.location_code	=	wmp.locationcode
	AND afd.customer_id		=	wmp.customerid;
	
	

	CREATE TEMP TABLE wmpsecuritygadgets
	AS
	SELECT wsg_ou,division_code,location_code,wsg_date::date,
			LEAD(wsg_date,1) OVER(partition by wsg_ou,division_code,location_code order by wsg_date)::date as eff_to,score
	FROM click.f_wmpsecuritygadgets;
		/*
drop table wmpsecuritygadgets
	SELECT wsg_ou,division_code,location_code,MAX(wsg_date)::date as wsg_date,0 as sg_score 
	FROM click.f_wmpsecuritygadgets
	GROUP BY wsg_ou,division_code,location_code;
	
	UPDATE wmpsecuritygadgets wsg
	SET sg_score =  mwsg.score
	FROM click.f_wmpsecuritygadgets mwsg
	WHERE mwsg.wsg_ou = wsg.wsg_ou
	AND mwsg.division_code = wsg.division_code
	AND mwsg.location_code = wsg.location_code
	AND mwsg.wsg_date = wsg.wsg_date;
*/

	UPDATE click.f_wmpscoreboard wmp
	SET securitygadgetsscore = COALESCE(score,0.00)
	FROM wmpsecuritygadgets sg
	WHERE wmp.ouid	=	sg.wsg_ou
	AND wmp.orderqualifieddate >= sg.wsg_date
	AND wmp.orderqualifieddate < COALESCE(sg.eff_to,NOW()::DATE)
	AND wmp.divisioncode  = sg.division_code
	AND wmp.locationcode	=	sg.location_code;
	
	CREATE TEMP TABLE wmpnps
	AS
	SELECT wn_ou,division_code,location_code,wn_date::date,
		LEAD(wn_date,1) OVER(partition by wn_ou,division_code,location_code order by wn_date)::date as eff_to,score
	FROM click.f_wmpnps;
	
	/*
	SELECT wn_ou,division_code,location_code,MAX(wn_date)::date as wn_date,0 as nps_score 
	FROM click.f_wmpnps
	GROUP BY wn_ou,division_code,location_code;
	
	UPDATE wmpnps wnps
	SET nps_score =  mwnps.score
	FROM click.f_wmpnps mwnps
	WHERE mwnps.wn_ou = wnps.wn_ou
	AND mwnps.division_code = wnps.division_code
	AND mwnps.location_code = wnps.location_code
	AND mwnps.wn_date = wnps.wn_date;
*/
	UPDATE click.f_wmpscoreboard wmp
	SET npsscore = score
	FROM wmpnps nps
	WHERE wmp.ouid = nps.wn_ou
	AND wmp.orderqualifieddate >= nps.wn_date
	AND wmp.orderqualifieddate < COALESCE(nps.eff_to,NOW()::DATE)
	AND wmp.divisioncode  = nps.division_code
	AND wmp.locationcode = nps.location_code;
	

	CREATE TEMP TABLE WmpCustomerClaims
	AS 
	SELECT wcc_ou,division_code,location_code,wcc_date::date,
		LEAD(wcc_date,1) OVER(partition by wcc_ou,division_code,location_code order by wcc_date)::date as eff_to,customer_score
	FROM click.f_WmpCustomerClaims;
	/*
	SELECT wcc_ou,division_code,location_code,MAX(wcc_date)::date as wcc_date,0 as wcc_score
	FROM click.f_WmpCustomerClaims
	GROUP BY wcc_ou,division_code,location_code;

	UPDATE WmpCustomerClaims wcc
	SET wcc_score =  mwcc.customer_score
	FROM click.f_WmpCustomerClaims mwcc
	WHERE mwcc.wcc_ou = wcc.wcc_ou
	AND mwcc.division_code = wcc.division_code
	AND mwcc.location_code = wcc.location_code
	AND mwcc.wcc_date = wcc.wcc_date;
	*/
	UPDATE click.f_wmpscoreboard wmp
	SET customerclaimscore = customer_score
	FROM WmpCustomerClaims cc
	WHERE 	wmp.ouid = cc.wcc_ou
	AND wmp.orderqualifieddate	>= cc.wcc_date
	AND wmp.orderqualifieddate < COALESCE(cc.eff_to,NOW()::DATE)
	AND wmp.divisioncode 	=	cc.division_code
	AND wmp.locationcode	=	cc.location_code;
	

	UPDATE click.f_wmpscoreboard wmp
	SET dcpscore = dcp_score
	FROM click.f_WmpDCProfit cc
	WHERE cc.ouid	=	wmp.ouid 
	AND EXTRACT(MONTH FROM cc.dcp_date)	=	EXTRACT(MONTH FROM wmp.orderqualifieddate)
	AND cc.division_code	=	wmp.divisioncode 
	AND cc.location_code	=	wmp.locationcode
	AND cc.customer_id		=	wmp.customerid;
	
	UPDATE click.f_wmpscoreboard
 	SET totalopearationscore = (CAST (COALESCE(slascore) as numeric(20,2))*(CAST (20.00 as numeric(20,2))/100) + 
							  CAST (COALESCE(orfscore) as numeric(20,2))*(CAST (10 as numeric(20,2))/100) + 
							  CAST (COALESCE(dccscore) as numeric(20,2))*(CAST (10 as numeric(20,2))/100) + 
							  CAST (COALESCE(dcpscore) as numeric(20,2))*(CAST (15 as numeric(20,2))/100) + 
							  CAST (COALESCE(inventoryaccuracyscore) as numeric(20,2))*(CAST (15 as numeric(20,2))/100) + 
							  CAST (COALESCE(customerclaimscore) as numeric(20,2))*(CAST (10 as numeric(20,2))/100) + 
							  CAST (COALESCE(absenteeismscore) as numeric(20,2))*(CAST (5 as numeric(20,2))/100) + 
							  CAST (COALESCE(attritionscore) as numeric(20,2))*(CAST (5 as numeric(20,2))/100) + 
							  CAST (COALESCE(accidentfreedayscore) as numeric(20,2))*(CAST (5 as numeric(20,2))/100) + 
							  CAST (COALESCE(securitygadgetsscore) as numeric(20,2))*(CAST (2 as numeric(20,2))/100) + 
							  CAST (COALESCE(npsscore) as numeric(20,2))*(CAST (3 as numeric(20,2))/100));

-- 	UPDATE click.f_wmpscoreboard
-- 	SET totalopearationscore = CASE WHEN category_code = 'OM' AND subcategory_code = 'SLA' THEN CAST (COALESCE(slascore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'OM' AND subcategory_code = 'ORF' THEN CAST (COALESCE(orfscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'OM' AND subcategory_code = 'DCC' THEN CAST (COALESCE(dccscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'OM' AND subcategory_code = 'DCP' THEN CAST (COALESCE(dcpscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'IM' AND subcategory_code = 'INA' THEN CAST (COALESCE(inventoryaccuracyscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'IM' AND subcategory_code = 'CCB' THEN CAST (COALESCE(customerclaimscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'MM' AND subcategory_code = 'ABS' THEN CAST (COALESCE(absenteeismscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'MM' AND subcategory_code = 'ATR' THEN CAST (COALESCE(attritionscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'SS' AND subcategory_code = 'AFD' THEN CAST (COALESCE(accidentfreedayscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'SS' AND subcategory_code = 'SGD' THEN CAST (COALESCE(securitygadgetsscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END +
-- 							  CASE WHEN category_code = 'VOC' AND subcategory_code = 'NPS' THEN CAST (COALESCE(npsscore,0) as numeric(21,2))*(CAST (final_weightage_prcnt as numeric(20,2))*100) END
-- 	FROM click.d_WmpCategory
-- 	WHERE orderqualifieddate BETWEEN effective_from AND effective_to;

	
	
END;
$BODY$;
ALTER PROCEDURE click.usp_f_wmpscoreboard()
    OWNER TO proconnect;
