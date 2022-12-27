CREATE TABLE click.d_uomconversion (
    uom_con_key bigint NOT NULL,
    con_ouinstance integer,
    con_fromuomcode character varying(20) COLLATE public.nocase,
    con_touomcode character varying(20) COLLATE public.nocase,
    con_confact_ntr numeric(20,2),
    con_confact_dtr numeric(20,2),
    con_created_by character varying(60) COLLATE public.nocase,
    con_created_date timestamp without time zone,
    con_modified_by character varying(60) COLLATE public.nocase,
    con_modified_date timestamp without time zone,
    con_flag integer,
    con_convert_type character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_uomconversion
    ADD CONSTRAINT d_uomconversion_pkey PRIMARY KEY (uom_con_key);

ALTER TABLE ONLY click.d_uomconversion
    ADD CONSTRAINT d_uomconversion_ukey UNIQUE (con_fromuomcode, con_touomcode);