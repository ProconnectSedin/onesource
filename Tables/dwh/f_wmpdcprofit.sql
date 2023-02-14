CREATE TABLE dwh.f_wmpdcprofit

(	
	wmpdcprofit_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
	dcp_date timestamp without time zone,
	division_code character varying(72),
	Location_code character varying(72),
	Customer_id integer,
	dcp_score numeric(20,2),
	etlactiveind integer,
    etljobname character varying(200),
    envsourcecd character varying(50), 
    datasourcecd character varying(50), 
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
	CONSTRAINT wmpdcprofit_pk PRIMARY KEY(wmpdcprofit_key)
)