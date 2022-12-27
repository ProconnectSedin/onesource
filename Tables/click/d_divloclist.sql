CREATE TABLE click.d_divloclist (
    div_loc_key bigint NOT NULL,
    div_ou integer,
    div_code character varying(20) COLLATE public.nocase,
    div_lineno integer,
    div_loc_code character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_divloclist
    ADD CONSTRAINT d_divloclist_pkey PRIMARY KEY (div_loc_key);

ALTER TABLE ONLY click.d_divloclist
    ADD CONSTRAINT d_divloclist_ukey UNIQUE (div_ou, div_code, div_lineno);