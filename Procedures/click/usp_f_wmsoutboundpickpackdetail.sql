CREATE PROCEDURE click.usp_f_wmsoutboundpickpackdetail()
    LANGUAGE plpgsql
    AS $$
DECLARE 
    p_errorid integer;
	p_errordesc character varying;
BEGIN

INSERT INTO click.f_outboundpickpackdetail(
	pickpack_ou,
	pickpack_lockey,
	pickpack_ordkey,
	pickpack_refdocno,
	pickexecstatus,
	picklineno,
	pickqty,
	pickemployee ,
	pickmechine ,
	pickhttflag ,
	pickthuwgt	
)
SELECT 
		sum1.ord_ou,
		sum1.ord_lockey,
		sum1.ord_key,
		sum1.ord_refdocno,
		PickH.pick_exec_status,
		COUNT(PickD.pick_lineno),
		SUM(PickD.pick_qty),
		COUNT(PickH.pick_employee),
		COUNT(PickH.pick_mhe),
		CASE WHEN PickH.pick_gen_from = 'WMS_MOB' THEN 1 ELSE 0 END HTTFlag,
		SUM(PickD.pick_exec_thu_wt)
FROM click.f_outboundorderdetail sum1
INNER JOIN dwh.f_pickingdetail PickD
ON  sum1.ord_ou =  PickD.pick_exec_ou
AND sum1.ord_lockey = PickD.pick_loc_key
AND sum1.ord_refdocno = PickD.pick_so_no
INNER JOIN dwh.f_pickingheader PickH
ON PickH.pick_hdr_key = PickD.pick_hdr_key
--WHERE pickD.pick_so_no = 'W310000070'
GROUP BY 
sum1.ord_ou,
sum1.ord_lockey,
sum1.ord_key,
sum1.ord_refdocno,
PickH.pick_exec_status,
PickH.pick_gen_from;

UPDATE click.f_outboundpickpackdetail t1
SET packexecstatus  = p1.packexecstatus,
	packlineno	 = p1.totlineno,
	packqty		 = p1.totpackqty,
	packtolqty 	 = p1.tottolqty,
	packemployee = p1.totemp
FROM 
	(	SELECT 
			sum1.ord_ou,
			sum1.ord_lockey,
			sum1.ord_key,
			sum1.ord_refdocno,
			PackH.pack_exec_status as packexecstatus,
			COUNT(PackD.pack_thu_lineno) as totlineno,
			SUM(PackD.pack_thu_pack_qty) as totpackqty,
			SUM(PackD.pack_tolerance_qty) as tottolqty,
			COUNT(PackH.pack_employee)	 as totemp
		FROM click.f_outboundorderdetail sum1
		LEFT JOIN dwh.F_PackExecTHUDetail PackD
		ON  sum1.ord_ou = PackD.pack_exec_ou
		AND sum1.ord_lockey  = PackD.pack_exec_loc_key
		AND sum1.ord_refdocno = PackD.pack_so_no
		LEFT JOIN dwh.F_PackExecHeader PackH
		ON PackH.pack_exe_hdr_key = PackD.pack_exec_hdr_key
		GROUP BY 
		sum1.ord_ou,
		sum1.ord_lockey,
		sum1.ord_key,
		sum1.ord_refdocno,
		PackH.pack_exec_status
	) P1
WHERE 	t1.pickpack_ordkey		=	p1.ord_key;
		
	EXCEPTION WHEN others THEN       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert('CLICK','f_wmsoutboundpickpackdetail','CLICK',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
			

END;
$$;