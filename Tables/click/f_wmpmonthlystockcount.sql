CREATE TABLE click.f_wmpmonthlystockcount
(
	wmpmonthlystockcount_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
	msc_ou integer NOT NULL,
	msc_date timestamp without time zone,
	division_code character varying(72),
	Location_code character varying(72),
	Customer_id integer,
	msc_zone character varying(72),
	bin character varying(72),
	item_code character varying(72),
	Expected_qty numeric(20,2),
	available_qty numeric(20,2),	
	etlactiveind integer,
    etljobname character varying(200),
    envsourcecd character varying(50), 
    datasourcecd character varying(50), 
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
	constraint wmpmonthlystockcount_pk PRIMARY KEY(wmpmonthlystockcount_key)
)