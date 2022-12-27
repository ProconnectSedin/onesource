CREATE TABLE dwh.d_customergrouphdr (
    cgh_key bigint NOT NULL,
    cgh_lo character varying(60) COLLATE public.nocase,
    cgh_bu character varying(60) COLLATE public.nocase,
    cgh_cust_group_code character varying(20) COLLATE public.nocase,
    cgh_control_group_flag character varying(20) COLLATE public.nocase,
    cgh_group_type_code character varying(20) COLLATE public.nocase,
    cgh_created_at integer,
    cgh_cust_group_desc character varying(100) COLLATE public.nocase,
    cgh_cust_group_desc_shd character varying(100) COLLATE public.nocase,
    cgh_reason_code character varying(20) COLLATE public.nocase,
    cgh_status character varying(20) COLLATE public.nocase,
    cgh_prev_status character varying(20) COLLATE public.nocase,
    cgh_created_by character varying(100) COLLATE public.nocase,
    cgh_created_date timestamp(3) without time zone,
    cgh_modified_by character varying(100) COLLATE public.nocase,
    cgh_modified_date timestamp(3) without time zone,
    cgh_timestamp_value integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_customergrouphdr ALTER COLUMN cgh_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_customergrouphdr_cgh_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_customergrouphdr
    ADD CONSTRAINT d_customergrouphdr_pkey PRIMARY KEY (cgh_key);

ALTER TABLE ONLY dwh.d_customergrouphdr
    ADD CONSTRAINT d_customergrouphdr_ukey UNIQUE (cgh_cust_group_code, cgh_group_type_code, cgh_control_group_flag, cgh_lo);