CREATE TABLE click.f_wmpnps
(
	wmpnps_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
	wn_ou integer not NULL,
	wn_date timestamp without time zone,
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
	constraint wmpnps_pkey primary key(wmpnps_key)
)