CREATE TABLE stg.stg_f_wmpdcprofit
(
	dcp_date timestamp without time zone,
	division_code character varying(72),
	Location_code character varying(72),
	Customer_id integer,
	dcp_score numeric(20,2),
	etlcreateddatetime timestamp(3) without time zone
)