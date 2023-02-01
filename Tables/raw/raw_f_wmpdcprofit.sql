
CREATE TABLE raw.raw_f_wmpdcprofit
(
	raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY,
	dcp_date timestamp without time zone,
	division_code character varying(72),
	Location_code character varying(72),
	Customer_id integer,
	dcp_score numeric(20,2),
	etlcreateddatetime timestamp(3) without time zone,
	constraint raw_f_wmpdcprofit_key PRIMARY KEY(raw_id)
)