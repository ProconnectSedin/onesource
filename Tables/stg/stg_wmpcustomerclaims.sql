CREATE TABLE stg.stg_wmpcustomerclaims
(
	wcc_ou integer NOT NULL,
	wcc_date timestamp without time zone,
	division_code character varying(72),
	location_code character varying(72),
	customer_id integer,
	customer_Score numeric(20,2),
	etlcreatedatetime timestamp(3) without time zone
)