create table dwh.f_wmpcustomerclaims
(
	wmpcustomerclaims_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
	wcc_ou integer NOT NULL,
	wcc_date timestamp without time zone,
	division_code character varying(72),
	location_code character varying(72),
	customer_id integer,
	customer_Score numeric(20,2),
	etlactiveind integer,
    etljobname character varying(200),
    envsourcecd character varying(50), 
    datasourcecd character varying(50), 
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
	constraint wmpcustomerclaims_pkey primary key(wmpcustomerclaims_key)
)