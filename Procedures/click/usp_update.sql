CREATE OR REPLACE PROCEDURE click.usp_update()
    LANGUAGE plpgsql
    AS $$


DECLARE
  v_min INTEGER;
 v_max INTEGER;
 v_amendno_f INTEGER;
 v_createddate character varying(100);
 v_br_ouinstance INTEGER;
 v_br_request_id character varying(72);
 v_amend_no_stg INTEGER;
 v_rowid INTEGER;

BEGIN

-- UPDATE	click.F_Shipment_details csd
-- SET		from_pinicode	= brsd_from_postal_code,
-- 		to_pinicode		= brsd_to_postal_code,
-- 		br_key			= brsd_br_key
-- FROM	dwh.F_BRShipmentDetail dsd
-- WHERE	csd.ouinstance		= dsd.brsd_ouinstance
-- AND		csd.br_request_id	= dsd.brsd_br_id;



CREATE TEMP TABLE BOOKING_HISTORY
(
	ROW_ID  INTEGER GENERATED ALWAYS AS IDENTITY,
	rowid_stg integer,
    created_date character varying(100),
	br_ouinstance INTEGER,
	br_request_id character varying(72) ,
 	br_status varchar(50) ,
	amend_no INTEGER
);
  
  
  INSERT INTO BOOKING_HISTORY
  (rowid_stg,created_date,br_ouinstance,br_request_id,br_status,amend_no)
  SELECT row_id,created_date,br_ouinstance,br_request_id,br_status,AMEND_NO
  FROM STG.stg_tms_br_booking_request_reason_hist
  where amend_no is null
  --and br_request_id in('BR/WB4/22/00002917')
  order by 1;
  
  

 
  
  SELECT MIN(ROW_ID), MAX(ROW_ID) INTO v_min, v_max FROM BOOKING_HISTORY;
   
  
  
  WHILE(v_min<=v_max)
  loop
	  
	 
	   select created_date,br_ouinstance,br_request_id, rowid_stg
	  INTO  v_createddate,v_br_ouinstance,v_br_request_id, v_rowid
	  FROM BOOKING_HISTORY
	  WHERE ROW_ID=v_min;
	  
	 
	  IF EXISTS(SELECT 1 FROM dwh.f_bookingRequestReasonHistory 
			    WHERE br_ouinstance=v_br_ouinstance
				and br_request_id=v_br_request_id
				
				
			   )
	  THEN
	
		  select max(amend_no)
		  into v_amendno_f
		  from dwh.f_bookingRequestReasonHistory
		  where  br_ouinstance=v_br_ouinstance
		  and br_request_id=v_br_request_id ;
	  
				UPDATE stg.stg_tms_br_booking_request_reason_hist
	  			SET amend_no=v_amendno_f +1 
	  			WHERE br_ouinstance=v_br_ouinstance
				and br_request_id=v_br_request_id
				and created_date=v_createddate ;
		
	  END IF;
	  
	 
	  
	  if EXISTS(SELECT 1 FROM STG.stg_tms_br_booking_request_reason_hist 
			    WHERE br_ouinstance=v_br_ouinstance
				and br_request_id=v_br_request_id
			   and amend_no is not null
				
			   )
	  
	 	THEN
			  select max(amend_no)
			  into v_amend_no_stg
			  from STG.stg_tms_br_booking_request_reason_hist 
			  where  br_ouinstance=v_br_ouinstance
			  and br_request_id=v_br_request_id 
	 		  and amend_no is not null;
	  
		  
			UPDATE stg.stg_tms_br_booking_request_reason_hist
	  			SET amend_no=v_amend_no_stg +1 
	  			WHERE br_ouinstance=v_br_ouinstance
				and br_request_id=v_br_request_id
				and created_date=v_createddate
				AND row_id= v_rowid;
		 
	 	 else
	  	 
	  		UPDATE stg.stg_tms_br_booking_request_reason_hist
	  			SET amend_no= 1 
	  			WHERE br_ouinstance=v_br_ouinstance
				and br_request_id=v_br_request_id
				and created_date=v_createddate
				and row_id=v_rowid;
	      end if;
	    
	   v_min= v_min +1;
	  
	  	
	  
  end loop;

END;
$$;