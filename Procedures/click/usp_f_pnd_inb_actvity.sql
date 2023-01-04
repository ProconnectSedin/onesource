-- PROCEDURE: click.usp_f_pnd_inb_actvity()

-- DROP PROCEDURE IF EXISTS click.usp_f_pnd_inb_actvity();

CREATE OR REPLACE PROCEDURE click.usp_f_pnd_inb_actvity(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
   p_errorid integer;
	p_errordesc character varying;
	v_maxdate date;
BEGIN
	
	
	SELECT (CASE WHEN MAX(etlcreatedatetime) <> NULL 
					THEN MAX(etlcreatedatetime)
				ELSE COALESCE(MAX(etlcreatedatetime),'1900-01-01') END)::DATE
	INTO v_maxdate
	from click.f_pnd_inb_actvity;
	
	
	IF v_maxdate = '1900-01-01'
	
	THEN
	
	INSERT INTO click.f_pnd_inb_actvity
		(
			loc_key,               cust_key,					OU, 		    location_code, 	    Location_Name, 
			Customer_Code, 			order_no,                 order_date,	     asn_no,			 asn_date,		
			order_type,				asn_type,                 invoice_no,	     invoice_date,		etlcreatedatetime,
			etlupdatedatetime,		asn_status,				  grn_status,		gr_exec_end_date,    putaway_status,     created_date,
			activeindicator
		)
		
		select 
			a.inb_loc_key,        c.asn_cust_key,            a.inb_ou,		     a.inb_loc_code,  	   b.loc_desc,	
			a.inb_custcode,       a.inb_orderno,             a.inb_orderdate,	 c.asn_no,			   c.asn_date,		
			c.asn_prefdoc_type,	  c.asn_type,                c.asn_prefdoc_no,   c.asn_prefdoc_date,   a.etlcreatedatetime,
			a.etlupdatedatetime,  COALESCE(c.asn_status,'pend') as asn_status,   COALESCE(d.gr_exec_status,'pend') as GRN_STATUS, d.gr_end_date,   COALESCE(e.pway_exec_status,'pend') AS PUTAWAY_STATUS, now(),
			(a.etlactiveind * b.etlactiveind)
		
		from dwh.f_inboundheader a
		inner join dwh.d_location b
		on b.loc_key=a.inb_loc_key
		left join click.f_asn c
		on c.asn_ib_order=a.inb_orderno
		and c.asn_loc_key=a.inb_loc_key
		left join click.f_grn d
		on d.gr_po_no=c.asn_prefdoc_no
		and d.gr_loc_key=c.asn_loc_key
		left join click.f_putaway e
		on e.pway_po_no=d.gr_po_no
		and e.pway_pln_dtl_loc_key=d.gr_loc_key
		where e.pway_exec_status not in('CMPLTD','SHTCLS')
		AND  1=1;
		
		--select * from dwh.f_inboundheader limit 10;
		
ELSE	
	
	
	update click.f_pnd_inb_actvity t
	set
		loc_key			=a.inb_loc_key,
		cust_key		=c.asn_cust_key,
		ou				=a.inb_ou,
		location_code	=a.inb_loc_code,
		Location_Name	=b.loc_desc,
		Customer_Code	=a.inb_custcode,
		order_no		=a.inb_orderno,
		order_date		=a.inb_orderdate,
		asn_no			=c.asn_no,
		asn_date		=c.asn_date,
		order_type		=c.asn_prefdoc_type,
		asn_type		=c.asn_type,
		invoice_no		=c.asn_prefdoc_no,
		invoice_date	=c.asn_prefdoc_date,
		asn_status      =COALESCE(c.asn_status,'pend'),
		grn_status		=COALESCE(d.gr_exec_status,'pend'),
		gr_exec_end_date=d.gr_end_date,
		putaway_status	=COALESCE(e.pway_exec_status,'pend'),
		etlupdatedatetime 		= NOW(),
		activeindicator	= (a.etlactiveind * b.etlactiveind)
		from dwh.f_inboundheader a
		inner join dwh.d_location b
		on b.loc_key=a.inb_loc_key
		left join click.f_asn c
		on c.asn_ib_order=a.inb_orderno
		and c.asn_loc_key=a.inb_loc_key
		left join click.f_grn d
		on d.gr_po_no=c.asn_prefdoc_no
		and d.gr_loc_key=c.asn_loc_key
		left join click.f_putaway e
		on e.pway_po_no=d.gr_po_no
		and e.pway_pln_dtl_loc_key=d.gr_loc_key
		where a.inb_orderno		= t.order_no
		AND   a.a.inb_loc_key	= t.loc_key
		AND   e.pway_exec_status not in('CMPLTD','SHTCLS')
		AND COALESCE(a.etlupdatedatetime,a.etlcreatedatetime) >= v_maxdate;
		
		--select * from dwh.f_inboundheader limit 10;
		--select * from click.f_pnd_inb_actvity limit 10;
		--select count(*) from dwh.f_inboundheader where inb_created_date::date>=(CURRENT_DATE - INTERVAL '90 days')::DATE;
-- 		delete from click.f_pnd_inb_actvity 
-- 		selecwhere order_date::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
	INSERT INTO click.f_pnd_inb_actvity
		(
			loc_key,               cust_key,					OU, 		    location_code, 	    Location_Name, 
			Customer_Code, 			order_no,                 order_date,	     asn_no,			 asn_date,		
			order_type,				asn_type,                 invoice_no,	     invoice_date,		etlcreatedatetime,
			etlupdatedatetime,		asn_status,				  grn_status,		gr_exec_end_date,    putaway_status,     created_date,
			activeindicator
		)
		
		select 
			a.inb_loc_key,        c.asn_cust_key,            a.inb_ou,		     a.inb_loc_code,  	   b.loc_desc,	
			a.inb_custcode,       a.inb_orderno,             a.inb_orderdate,	 c.asn_no,			   c.asn_date,		
			c.asn_prefdoc_type,	  c.asn_type,                c.asn_prefdoc_no,   c.asn_prefdoc_date,   a.etlcreatedatetime,
			a.etlupdatedatetime,  COALESCE(c.asn_status,'pend') as asn_status,   COALESCE(d.gr_exec_status,'pend') as GRN_STATUS, d.gr_end_date,   COALESCE(e.pway_exec_status,'pend') AS PUTAWAY_STATUS, now(),
			(a.etlactiveind * b.etlactiveind)
		
		FROM dwh.f_inboundheader a
		INNER JOIN dwh.d_location b
		ON b.loc_key=a.inb_loc_key
		LEFT JOIN click.f_asn c
		ON c.asn_ib_order=a.inb_orderno
		AND c.asn_loc_key=a.inb_loc_key
		LEFT JOIN click.f_grn d
		ON d.gr_po_no=c.asn_prefdoc_no
		AND d.gr_loc_key=c.asn_loc_key
		LEFT JOIN click.f_putaway e
		ON e.pway_po_no=d.gr_po_no
		AND e.pway_pln_dtl_loc_key=d.gr_loc_key
		LEFT JOIN click.f_pnd_inb_actvity t
		ON 	a.inb_orderno		= t.order_no
		AND a.a.inb_loc_key	= t.loc_key
		WHERE e.pway_exec_status not in('CMPLTD','SHTCLS')
		AND COALESCE(a.etlupdatedatetime,a.etlcreatedatetime) >= v_maxdate
		AND t.order_no IS NULL;
	END IF;	 
		
			EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_pnd_inb_actvity','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

		
	
END;
$BODY$;
ALTER PROCEDURE click.usp_f_pnd_inb_actvity()
    OWNER TO proconnect;
