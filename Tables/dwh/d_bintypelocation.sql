CREATE TABLE dwh.d_bintypelocation (
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

ALTER TABLE dwh.d_bintypelocation ALTER COLUMN bin_typ_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_bintypelocation_bin_typ_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_bintypelocation
    ADD CONSTRAINT d_bintypelocation_pkey PRIMARY KEY (bin_typ_loc_code, bin_typ_code, bin_typ_lineno, bin_typ_ou);

ALTER TABLE ONLY dwh.d_bintypelocation
    ADD CONSTRAINT d_bintypelocation_ukey UNIQUE (bin_typ_key);