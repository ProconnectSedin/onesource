CREATE TABLE click.d_division (
    div_key bigint NOT NULL,
    div_ou integer,
    div_code character varying(20) COLLATE public.nocase,
    div_desc character varying(510) COLLATE public.nocase,
    div_status character varying(20) COLLATE public.nocase,
    div_type character varying(80) COLLATE public.nocase,
    div_reason_code character varying(20) COLLATE public.nocase,
    div_user_def1 character varying(510) COLLATE public.nocase,
    div_user_def2 character varying(510) COLLATE public.nocase,
    div_user_def3 character varying(510) COLLATE public.nocase,
    div_timestamp integer,
    div_created_by character varying(60) COLLATE public.nocase,
    div_created_dt timestamp without time zone,
    div_modified_by character varying(60) COLLATE public.nocase,
    div_modified_dt timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_division
    ADD CONSTRAINT d_division_pkey PRIMARY KEY (div_key);

ALTER TABLE ONLY click.d_division
    ADD CONSTRAINT d_division_ukey UNIQUE (div_ou, div_code);