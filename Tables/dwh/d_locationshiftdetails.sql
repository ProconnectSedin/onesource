CREATE TABLE dwh.d_locationshiftdetails (
    loc_shft_dtl_key bigint NOT NULL,
    loc_ou character varying(20) COLLATE public.nocase,
    loc_code character varying(20) COLLATE public.nocase,
    loc_shft_lineno integer,
    loc_shft_shift character varying(80) COLLATE public.nocase,
    loc_shft_fr_time timestamp without time zone,
    loc_shft_to_time timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_locationshiftdetails ALTER COLUMN loc_shft_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_locationshiftdetails_loc_shft_dtl_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_locationshiftdetails
    ADD CONSTRAINT d_locationshiftdetails_pkey PRIMARY KEY (loc_shft_dtl_key);

ALTER TABLE ONLY dwh.d_locationshiftdetails
    ADD CONSTRAINT d_locationshiftdetails_ukey UNIQUE (loc_code, loc_shft_lineno, loc_ou);