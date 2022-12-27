CREATE TABLE dwh.f_binplanheader (
    bin_hdr_key bigint NOT NULL,
    bin_loc_key bigint NOT NULL,
    bin_loc_code character varying(20) COLLATE public.nocase,
    bin_pln_no character varying(40) COLLATE public.nocase,
    bin_pln_ou integer,
    bin_pln_date timestamp without time zone,
    bin_pln_status character varying(20) COLLATE public.nocase,
    bin_mhe character varying(60) COLLATE public.nocase,
    bin_employee character varying(40) COLLATE public.nocase,
    bin_created_by character varying(60) COLLATE public.nocase,
    bin_created_date timestamp without time zone,
    bin_modified_by character varying(60) COLLATE public.nocase,
    bin_modified_date timestamp without time zone,
    bin_timestamp integer,
    bin_refdoc_no character varying(40) COLLATE public.nocase,
    bin_gen_from character varying(20) COLLATE public.nocase,
    bin_source_docno character varying(40) COLLATE public.nocase,
    bin_source_stage character varying(510) COLLATE public.nocase,
    bin_fr_insp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);