create table raw.raw_wmpaccidentfreedays
(
	raw_id  bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
	wafc_ou integer not NULL,
	wafc_date timestamp without time zone,
	division_code character varying(72),
	location_code character varying(72),
	customer_id integer,
	Score numeric(20,2),
	etlcreatedatetime timestamp(3) without time zone
	
)