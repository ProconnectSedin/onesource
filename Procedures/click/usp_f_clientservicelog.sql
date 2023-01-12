-- PROCEDURE: click.usp_f_clientservicelog()

-- DROP PROCEDURE IF EXISTS click.usp_f_clientservicelog();

CREATE OR REPLACE PROCEDURE click.usp_f_clientservicelog(
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
		from click.f_clientservicelog;
		
		--select * from click.f_clientservicelog limit 10;
		IF  v_maxdate = '1900-01-01'
		
		THEN
		
		 INSERT INTO click.f_clientservicelog
		(
			 cust_Id,   		client_Name,    service_Name,   service_Type,   agentdocketno,  
			 trackingstatus, 	status,         error_Message,  Location_ID,     Customer_ID,  
			Trip_Plan_ID,   		Ord_sono,    ip_Address,     csl_created_Date,	etlactiveind,
			etljobname, 		etlcreatedatetime,etlupdatedatetime, created_date
		)

   		 SELECT
			s.cust_Id,  s.client_Name,  s.service_Name,     s.service_Type,   client_json::json->>'Tracking_number'  ,  
			client_json::json->>'Current_status' ,	s.status,   s.error_Message,   s.key_Search1,  s.key_Search2,
			s.key_Search3, s.key_Search4,  s.ip_Address,   s.created_Date, s.etlactiveind,
			s.etljobname,s.etlcreatedatetime,s.etlupdatedatetime, NOW()
		
			from dwh.f_clientservicelog s
			left join dwh.d_customerlocation a
			on a.loc_code=s.key_Search1
			and a.loc_cust_code=s.key_Search2
			where s.service_type='Tracking' 
			 AND  1=1;
			--select * from dwh.d_customerlocation where loc_cust_code='0027'
			
			
			---loc_code='WB013P0027'limit 10;  --WB013P0027
			--select * from dwh.d_customer  where customer_id='0027'
			
			--select * from dwh.d_divloclist limit 10;
		ELSE
		
			UPDATE click.f_clientservicelog t
			set
				cust_Id			=s.cust_Id,
				client_Name		=s.client_Name,
				service_Name	=s.service_Name,
				service_Type	=s.service_Type,
				agentdocketno	=client_json::json->>'Tracking_number',
				trackingstatus	=client_json::json->>'Current_status',
				status			=s.status,
				error_Message	=s.error_Message,
				Location_ID		=s.key_Search1,
				Customer_ID		=s.key_Search2,
				Trip_Plan_ID	=s.key_Search3,
				Ord_sono		=s.key_Search4,
				ip_Address		=s.ip_Address,
				csl_created_Date=s.created_Date,
				etlactiveind	=s.etlactiveind,
				etljobname		=s.etljobname,
				etlcreatedatetime=s.etlcreatedatetime,
				etlupdatedatetime=s.etlupdatedatetime,
				updatedatetime=now()
				
				from dwh.f_clientservicelog s
				left join dwh.d_customerlocation a
				on a.loc_code=s.key_Search1
				and a.loc_cust_code=s.key_Search2
				where s.cust_id=t.cust_id
				and s.service_type='Tracking'
				and  COALESCE(s.etlupdatedatetime,s.etlcreatedatetime) >= v_maxdate;
				
				
			 INSERT INTO click.f_clientservicelog
				(
					 cust_Id,   		client_Name,    service_Name,   service_Type,   agentdocketno,  
					 trackingstatus, 	status,         error_Message,  Location_ID,     Customer_ID,  
					Trip_Plan_ID,   		Ord_sono,    ip_Address,     csl_created_Date,	etlactiveind,
					etljobname, 		etlcreatedatetime,etlupdatedatetime, created_date
				)
			 SELECT
				s.cust_Id,  s.client_Name,  s.service_Name,     s.service_Type,   client_json::json->>'Tracking_number'  ,  
				client_json::json->>'Current_status' ,	s.status,   s.error_Message,   s.key_Search1,  s.key_Search2,
				s.key_Search3, s.key_Search4,  s.ip_Address,   s.created_Date, s.etlactiveind,
				s.etljobname,s.etlcreatedatetime,s.etlupdatedatetime, NOW()	
				
				from dwh.f_clientservicelog s
				left join dwh.d_customerlocation a
				on a.loc_code=s.key_Search1
				and a.loc_cust_code=s.key_Search2
				left join click.f_clientservicelog t
				on t.cust_id=s.cust_id
				where s.service_type='Tracking'
				and  COALESCE(s.etlupdatedatetime,s.etlcreatedatetime) >= v_maxdate
				and t.cust_id is null;
				
			END IF;	
			
			--select * from dwh.d_customerlocation limit 10;
			
			EXCEPTION WHEN others THEN       
       
    GET stacked DIAGNOSTICS p_errorid = returned_sqlstate, p_errordesc = message_text;
	
	CALL ods.usp_etlerrorinsert('DWH','f_clientservicelog','DWtoClick',NULL,'De-Normalized','sp_ExceptionHandling',p_errorid,p_errordesc,null);
				
END;
$BODY$;
ALTER PROCEDURE click.usp_f_clientservicelog()
    OWNER TO proconnect;
