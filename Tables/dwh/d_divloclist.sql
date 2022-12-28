CREATE TABLE dwh.d_divloclist (
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
    etlupdatedatetime timestamp(3) without time zone,
    div_loc_hdr_key bigint,
    div_hdr_key bigint
);

ALTER TABLE dwh.d_divloclist ALTER COLUMN div_loc_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_divloclist_div_loc_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_divloclist
    ADD CONSTRAINT d_divloclist_pkey PRIMARY KEY (div_loc_key);

ALTER TABLE ONLY dwh.d_divloclist
    ADD CONSTRAINT d_divloclist_ukey UNIQUE (div_ou, div_code, div_lineno);