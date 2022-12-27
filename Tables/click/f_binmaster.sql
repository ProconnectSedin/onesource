CREATE TABLE click.f_binmaster (
    f_binmaster_key bigint NOT NULL,
    ou integer,
    division character varying(20) COLLATE public.nocase,
    bin_location character varying(20) COLLATE public.nocase,
    bin_type character varying(40) COLLATE public.nocase,
    bin_count numeric(20,2),
    bin_length numeric(20,2),
    bin_breadth numeric(20,2),
    bin_height numeric(20,2),
    bin_typ_dim_uom character varying(20),
    actual_bin_volume numeric(20,2),
    calculated_bin_volume numeric(20,2),
    volume_uom character varying(20) COLLATE public.nocase,
    createddate timestamp(3) without time zone,
    bin_div_key bigint,
    bin_typ_key bigint,
    bin_dtl_key bigint,
    bin_loc_key bigint
);

ALTER TABLE click.f_binmaster ALTER COLUMN f_binmaster_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_binmaster_f_binmaster_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_binmaster
    ADD CONSTRAINT f_binmaster_pkey PRIMARY KEY (f_binmaster_key);

ALTER TABLE ONLY click.f_binmaster
    ADD CONSTRAINT f_binmaster_ukey UNIQUE (bin_div_key, bin_typ_key, bin_dtl_key, bin_loc_key);