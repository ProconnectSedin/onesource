CREATE TABLE dwh.d_tarifftypegroup (
    tf_key bigint NOT NULL,
    tf_grp_code character varying(20) COLLATE public.nocase,
    tf_type_code character varying(20) COLLATE public.nocase,
    tf_type_desc character varying(510) COLLATE public.nocase,
    tf_formula character varying(8000) COLLATE public.nocase,
    tf_created_by character varying(60) COLLATE public.nocase,
    tf_created_date timestamp without time zone,
    tf_langid integer,
    tf_acc_flag character varying(20) COLLATE public.nocase,
    tariff_code character varying(80) COLLATE public.nocase,
    description character varying(8000) COLLATE public.nocase,
    formula character varying(8000) COLLATE public.nocase,
    tf_tariff_code_version character varying(80) COLLATE public.nocase,
    tf_br_remit_flag character varying(20) COLLATE public.nocase,
    tf_revenue_split character varying(80) COLLATE public.nocase,
    tf_basicsforop character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_tarifftypegroup ALTER COLUMN tf_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_tarifftypegroup_tf_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_tarifftypegroup
    ADD CONSTRAINT d_tarifftypegroup_pkey PRIMARY KEY (tf_key);

ALTER TABLE ONLY dwh.d_tarifftypegroup
    ADD CONSTRAINT d_tarifftypegroup_ukey UNIQUE (tf_grp_code, tf_type_code);