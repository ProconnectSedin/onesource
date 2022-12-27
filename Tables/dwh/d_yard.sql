CREATE TABLE dwh.d_yard (
    yard_key bigint NOT NULL,
    yard_id character varying(20) COLLATE public.nocase,
    yard_loc_code character varying(20) COLLATE public.nocase,
    yard_ou integer,
    yard_desc character varying(300) COLLATE public.nocase,
    yard_type character varying(80) COLLATE public.nocase,
    yard_status character varying(16) COLLATE public.nocase,
    yard_reason character varying(80) COLLATE public.nocase,
    yard_timestamp integer,
    yard_created_by character varying(60) COLLATE public.nocase,
    yard_created_dt timestamp without time zone,
    yard_modified_by character varying(60) COLLATE public.nocase,
    yard_modified_dt timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_yard ALTER COLUMN yard_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_yard_yard_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_yard
    ADD CONSTRAINT d_yard_pkey PRIMARY KEY (yard_key);

ALTER TABLE ONLY dwh.d_yard
    ADD CONSTRAINT d_yard_ukey UNIQUE (yard_id, yard_loc_code, yard_ou);