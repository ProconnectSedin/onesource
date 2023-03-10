CREATE TABLE dwh.f_triplogresourceintransitdetail (
    in_tran_dtl_key bigint NOT NULL,
    in_transit_ouinstance character varying(40) COLLATE public.nocase,
    in_transit_line_no character varying(300) COLLATE public.nocase,
    in_transit_trip_log character varying(40) COLLATE public.nocase,
    in_transit_latitude character varying(510) COLLATE public.nocase,
    in_transit_longitude character varying(510) COLLATE public.nocase,
    in_transit_date_time timestamp without time zone,
    in_transit_created_by character varying(60) COLLATE public.nocase,
    in_transit_created_date timestamp without time zone,
    in_transit_timestamp integer,
    in_transit_event character varying(80) COLLATE public.nocase,
    in_transit_leg_no integer,
    in_transit_driverid character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_triplogresourceintransitdetail ALTER COLUMN in_tran_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_triplogresourceintransitdetail_in_tran_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_triplogresourceintransitdetail
    ADD CONSTRAINT f_triplogresourceintransitdetail_pkey PRIMARY KEY (in_tran_dtl_key);