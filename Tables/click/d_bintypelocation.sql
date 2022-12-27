CREATE TABLE click.d_bintypelocation (
    bin_typ_key bigint NOT NULL,
    bin_typ_ou integer NOT NULL,
    bin_typ_code character varying(40) NOT NULL,
    bin_typ_loc_code character varying(20) NOT NULL,
    bin_typ_lineno integer NOT NULL,
    bin_typ_storage_unit character varying(20),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_bintypelocation
    ADD CONSTRAINT d_bintypelocation_pkey PRIMARY KEY (bin_typ_loc_code, bin_typ_code, bin_typ_lineno, bin_typ_ou);

ALTER TABLE ONLY click.d_bintypelocation
    ADD CONSTRAINT d_bintypelocation_ukey UNIQUE (bin_typ_key);