CREATE TABLE click.d_locationshiftdetails (
    loc_shft_dtl_key bigint NOT NULL,
    loc_ou character varying(20) COLLATE public.nocase,
    loc_code character varying(20) COLLATE public.nocase,
    loc_shft_lineno integer,
    loc_shft_shift character varying(80) COLLATE public.nocase,
    loc_shft_fr_time timestamp without time zone,
    loc_shft_to_time timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);