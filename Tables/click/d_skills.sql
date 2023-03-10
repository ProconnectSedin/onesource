CREATE TABLE click.d_skills (
    skl_key bigint NOT NULL,
    skl_ou integer,
    skl_code character varying(80) COLLATE public.nocase,
    skl_type character varying(80) COLLATE public.nocase,
    skl_desc character varying(510) COLLATE public.nocase,
    skl_currency character varying(20) COLLATE public.nocase,
    skl_status character varying(20) COLLATE public.nocase,
    skl_timestamp integer,
    skl_created_by character varying(60) COLLATE public.nocase,
    skl_created_dt timestamp without time zone,
    skl_modified_by character varying(60) COLLATE public.nocase,
    skl_modified_dt timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_skills
    ADD CONSTRAINT d_skills_pkey PRIMARY KEY (skl_key);

ALTER TABLE ONLY click.d_skills
    ADD CONSTRAINT d_skills_ukey UNIQUE (skl_ou, skl_code, skl_type);