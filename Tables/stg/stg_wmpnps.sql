CREATE TABLE stg.stg_wmpnps
(
	wn_ou integer not NULL,
	wn_date timestamp without time zone,
	division_code character varying(72),
	location_code character varying(72),
	customer_id integer,
	Score numeric(20,2),
	etlcreatedatetime timestamp(3) without time zone	
)