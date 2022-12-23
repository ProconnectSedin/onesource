-- PROCEDURE: click.usp_f_pnd_inb_actvity()

-- DROP PROCEDURE IF EXISTS click.usp_f_pnd_inb_actvity();

CREATE OR REPLACE PROCEDURE click.usp_f_pnd_inb_actvity(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE 
   p_errorid integer;
	p_errordesc character varying;
BEGIN
	
-- 	update click.f_pnd_inb_actvity t
-- 	set
-- 		ou				=a.inb_ou,
-- 		location_code	=a.inb_loc_code,
-- 		Location_Name	=b.loc_desc,
-- 		Customer_Code	=a.inb_custcode,
-- 		order_no		=a.inb_orderno,
-- 		order_date		=a.inb_orderdate,
-- 		asn_no			=c.asn_no,
-- 		asn_date		=c.asn_date,
-- 		order_type		=c.asn_prefdoc_type,
-- 		asn_type		=c.asn_type,
-- 		invoice_no		=c.asn_prefdoc_no,
-- 		invoice_date	=c.asn_prefdoc_date,
-- 		asn_status      =COALESCE(c.asn_status,'pend'),
-- 		grn_status		=COALESCE(d.gr_exec_status,'pend'),
-- 		gr_exec_end_date=d.gr_end_date,
-- 		putaway_status	=COALESCE(e.pway_exec_status,'pend'),
-- 		modified_date	=now()
-- 		from dwh.f_inboundheader a
-- 		inner join dwh.d_location b
-- 		on b.loc_key=a.inb_loc_key
-- 		left join click.f_asn c
-- 		on c.asn_ib_order=a.inb_orderno
-- 		and c.asn_loc_key=a.inb_loc_key
-- 		left join click.f_grn d
-- 		on d.gr_po_no=c.asn_prefdoc_no
-- 		and d.gr_loc_key=c.asn_loc_key
-- 		left join click.f_putaway e
-- 		on e.pway_po_no=d.gr_po_no
-- 		and e.pway_pln_dtl_loc_key=d.gr_loc_key
-- 		where e.pway_exec_status not in('CMPLTD','SHTCLS');
		
		delete from click.f_pnd_inb_actvity 
		where order_date::DATE >= (CURRENT_DATE - INTERVAL '90 days')::DATE;
		
		INSERT INTO click.f_pnd_inb_actvity
		(
			loc_key,               cust_key,					OU, 		    location_code, 	    Location_Name, 
			Customer_Code, 			order_no,                 order_date,	     asn_no,			 asn_date,		
			order_type,				asn_type,                 invoice_no,	     invoice_date,		  asn_status,	
			grn_status,				gr_exec_end_date,         putaway_status,     created_date
		)
		
		select 
			a.inb_loc_key,        a.asn_cust_key,            a.inb_ou,		     a.inb_loc_code,  	   b.loc_desc,	
			a.inb_custcode,       a.inb_orderno,             a.inb_orderdate,	 c.asn_no,			   c.asn_date,		
			c.asn_prefdoc_type,	  c.asn_type,                c.asn_prefdoc_no,   c.asn_prefdoc_date,   COALESCE(c.asn_status,'pend') as asn_status,
			COALESCE(d.gr_exec_status,'pend') as GRN_STATUS, d.gr_end_date,   COALESCE(e.pway_exec_status,'pend') AS PUTAWAY_STATUS, now()
		
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
		where e.pway_exec_status not in('CMPLTD','SHTCLS');
		
			EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
    CALL ods.usp_etlerrorinsert('DWH','f_pnd_inb_actvity','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

		
	
END;
$BODY$;
ALTER PROCEDURE click.usp_f_pnd_inb_actvity()
    OWNER TO proconnect;
