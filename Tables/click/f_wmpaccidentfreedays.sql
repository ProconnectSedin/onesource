CREATE TABLE click.f_wmpaccidentfreedays
(
	wmpaccidentfreedays_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
	wafc_ou integer not NULL,
	wafc_date timestamp without time zone,
	division_code character varying(72),
	location_code character varying(72),
	customer_id integer,
	Score numeric(20,2),
	etlactiveind integer,
    etljobname character varying(200),
    envsourcecd character varying(50), 
    datasourcecd character varying(50), 
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
	constraint wmpaccidentfreedays_pkey primary key (wmpaccidentfreedays_key)	
)