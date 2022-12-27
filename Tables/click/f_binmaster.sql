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