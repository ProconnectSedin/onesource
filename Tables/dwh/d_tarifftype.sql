CREATE TABLE dwh.d_tarifftype (
    tar_key bigint NOT NULL,
    tar_lineno integer,
    tar_ou integer,
    tar_applicability integer,
    tar_scr_code character varying(20) COLLATE public.nocase,
    tar_type_code character varying(20) COLLATE public.nocase,
    tar_tf_type character varying(510) COLLATE public.nocase,
    tar_display_tf_type character varying(510) COLLATE public.nocase,
    tar_created_by character varying(60) COLLATE public.nocase,
    tar_created_date timestamp without time zone,
    tar_modified_by character varying(60) COLLATE public.nocase,
    tar_modified_date timestamp without time zone,
    tar_timestamp integer,
    tar_revenue_split character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_tarifftype ALTER COLUMN tar_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_tarifftype_tar_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_tarifftype
    ADD CONSTRAINT d_tarifftype_pkey PRIMARY KEY (tar_key);

ALTER TABLE ONLY dwh.d_tarifftype
    ADD CONSTRAINT d_tarifftype_ukey UNIQUE (tar_lineno, tar_ou);