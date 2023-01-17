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
	
	TRUNCATE TABLE click.f_pnd_inb_actvity 
		RESTART IDENTITY;
		
		
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
			a.etlupdatedatetime,  COALESCE(c.asn_status,'pend') as asn_status,   COALESCE(d.gr_exec_status,'pend') as GRN_STATUS, max(d.gr_end_date),   COALESCE(f.pway_exec_status,'pend') AS PUTAWAY_STATUS, now(),
			(a.etlactiveind * b.etlactiveind)
	
		 from dwh.f_inboundheader a
		 inner join dwh.d_location b
		on b.loc_key=a.inb_loc_key
		left join dwh.f_asnheader c
			on c.asn_ib_order=a.inb_orderno
		and c.asn_loc_key=a.inb_loc_key
		left join dwh.f_goodsreceiptdetails d
		on d.gr_po_no=c.asn_prefdoc_no
		and d.gr_loc_key=c.asn_loc_key
		and d.gr_asn_no=c.asn_no
		left join dwh.f_putawayplanitemdetail e
		on e.pway_po_no=d.gr_po_no
		and e.pway_gr_no=d.gr_no
		left join dwh.f_putawayexecdetail f
		on 	f.pway_pln_dtl_key=e.pway_pln_dtl_key
		and  f.pway_pln_no=e.pway_pln_no
		where  f.pway_exec_status not in('CMPLTD','SHTCLS')
		
		group by a.inb_loc_key,c.asn_cust_key, a.inb_ou,a.inb_loc_code,b.loc_desc,a.inb_custcode,a.inb_orderno,a.inb_orderdate,c.asn_no,
		 c.asn_date,c.asn_prefdoc_type,	  c.asn_type, c.asn_prefdoc_no,c.asn_prefdoc_date,   a.etlcreatedatetime,
		  a.etlupdatedatetime,  c.asn_status ,d.gr_exec_status ,
		   f.pway_exec_status ,(a.etlactiveind * b.etlactiveind);
	

 
		
 		EXCEPTION WHEN others THEN       
       
     GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
        
     CALL ods.usp_etlerrorinsert('DWH','f_pnd_inb_actvity','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);

		
	
END;
$BODY$;
ALTER PROCEDURE click.usp_f_pnd_inb_actvity()
    OWNER TO proconnect;
