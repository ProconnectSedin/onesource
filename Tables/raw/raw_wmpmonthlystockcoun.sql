create table raw.raw_wmpmonthlystockcount
(
	raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
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
	etlcreateddatetime timestamp(3) without time zone,
	CONSTRAINT wmpmonthlystockcount_pk primary key(raw_id)
)