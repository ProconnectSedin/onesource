CREATE PROCEDURE dwh.d_stock_balance()
    LANGUAGE plpgsql
    AS $$

DECLARE
v_min integer;
v_max integer;
stk_bal integer;
in_qty int;
out_qty int;
in_out int;
date_aging1 timestamp without time zone;
date_aging2 timestamp without time zone;
no_of_days_Aging integer;

begin

CREATE TEMP TABLE STOCK_BALANCE
(
	row_id integer GENERATED ALWAYS AS IDENTITY,
	wms_stock_date timestamp without time zone,
	wms_stock_location character varying(50),
	wms_stock_zone character varying(50),
	wms_stock_bin_type character varying(50),
	wms_stock_bin character varying(50),
	wms_stock_in_qty integer,
	wms_stock_out_qty integer,
	stk_balance integer,
	aging_in_days integer
);

insert into STOCK_BALANCE(wms_stock_date,wms_stock_location,wms_stock_zone,wms_stock_bin_type,wms_stock_bin,wms_stock_in_qty,wms_stock_out_qty)
select stock_date,stock_location,stock_zone,stock_bin_type,stock_bin, sum(stock_in_qty),sum(stock_out_qty)
 from dwh.f_stockbinhistorydetail  
where stock_location='MH008P0148'
and stock_zone='NGD' and stock_bin_type='HL2'
and stock_bin='MB-08-C3'
group by stock_date,stock_location,stock_zone,stock_bin_type,stock_bin;

select min(row_id), max(row_id),0
into v_min, v_max,stk_bal
from STOCK_BALANCE;

while(v_min<=v_max)
loop

	select wms_stock_in_qty, wms_stock_out_qty, wms_stock_date
	into in_qty, out_qty, date_aging1
	from STOCK_BALANCE
	where row_id=v_min;
	
	if v_min>=2
	Then
		select stk_balance,wms_stock_date
		into stk_bal, date_aging2
		from STOCK_BALANCE
		where row_id=v_min-1;
	end if;
	
	no_of_days_Aging=DATE_PART('day',date_aging1-date_aging2);
	 in_out= in_qty-out_qty ;
	
	if no_of_days_Aging is null
	Then
		update STOCK_BALANCE set aging_in_days=0 where row_id=v_min;
	end if;
	
	if no_of_days_aging is not null
	Then
		update STOCK_BALANCE set aging_in_days=no_of_days_Aging where row_id=v_min;
	end if;
	
	
	if stk_bal=0
	Then
		if in_qty>0 and out_qty=0 and in_out>0
		Then
			update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
		end if;
		
		if in_qty=0 and out_qty=0 and in_out=0
		Then
			update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
		end if;
		
		if in_qty=0 and out_qty>0 and in_out<0
		Then
			update STOCK_BALANCE set stk_balance=0 where row_id=v_min ;
		end if;
		
		if in_qty>0 and out_qty>0 and in_out=0
		Then
			update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
		end if;
		
		if in_qty>0 and out_qty>0 and in_out>0
		Then
			update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
		end if;
		
	end if;
	
	if stk_bal >0
	Then
	
		if in_qty>0 and out_qty>0 and in_out>0
		Then
			update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
		end if;
		
		if in_qty>0 and out_qty>0 and in_out=0
		Then
			update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
		end if;
		
		if in_qty=0 and out_qty=0 and in_out=0
		Then
			update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
		end if;
		
		if in_qty>0 and out_qty=0 and in_out>0
		Then
			update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
		end if;
		
		if in_qty=0 and out_qty>0 and in_out<0
		Then
			 stk_bal=stk_bal + in_out ;
			
			if stk_bal>0
			Then
				update STOCK_BALANCE set stk_balance=stk_bal where row_id=v_min ;
			else
				update STOCK_BALANCE set stk_balance=0 where row_id=v_min ;
			end if;	
		end if;
		
		if in_qty>0 and out_qty>0
		
		Then
			if in_out<0
			Then 
				 stk_bal=stk_bal +in_out ;

				if stk_bal >0
				Then
				update STOCK_BALANCE set stk_balance=stk_bal where row_id=v_min ;
				else
				update STOCK_BALANCE set stk_balance=0 where row_id=v_min ;
				end if;
			end if;
		
			
			if in_out>0
			Then
				update STOCK_BALANCE set stk_balance=stk_bal + in_out where row_id=v_min ;
			end if;
		end if;
	end if;
	
	v_min=v_min +1 ;
	
end loop;



TRUNCATE table dwh.d_daily_stock_balance;
insert into dwh.d_daily_stock_balance
(
	wms_stock_date,wms_stock_location,wms_stock_zone,wms_stock_bin_type,wms_stock_bin,
	wms_stock_in_qty,wms_stock_out_qty,stk_balance,aging_in_days,created_date
)
select wms_stock_date,wms_stock_location,wms_stock_zone,wms_stock_bin_type,wms_stock_bin,
		wms_stock_in_qty,wms_stock_out_qty,stk_balance, aging_in_days,now()
		from STOCK_BALANCE;

end;
$$;