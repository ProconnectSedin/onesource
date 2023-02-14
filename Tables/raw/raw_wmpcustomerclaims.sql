create table raw.raw_wmpcustomerclaims
(
	raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
	wcc_ou integer NOT NULL,
	wcc_date timestamp without time zone,
	division_code character varying(72),
	location_code character varying(72),
	customer_id integer,
	customer_Score numeric(20,2),
	etlcreatedatetime timestamp(3) without time zone,
	constraint raw_wmpcustomerclaims_pkey primary key(raw_id)
	
)