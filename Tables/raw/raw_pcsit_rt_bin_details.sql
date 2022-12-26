CREATE TABLE raw.raw_pcsit_rt_bin_details (
    raw_id bigint NOT NULL,
    bin_ou integer NOT NULL,
    bin_code character varying(40) NOT NULL COLLATE public.nocase,
    bin_desc character varying(1020) NOT NULL COLLATE public.nocase,
    bin_type character varying(200) COLLATE public.nocase,
    bin_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    bin_status_active character(40) COLLATE public.nocase,
    create_by character varying(50) COLLATE public.nocase,
    created_on timestamp without time zone DEFAULT now(),
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);