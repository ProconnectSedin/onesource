CREATE TABLE stg.stg_tms_brprh_profile_hdr (
    brprh_ouinstance integer NOT NULL,
    brprh_profile_id character varying(72) NOT NULL COLLATE public.nocase,
    brprh_profile_desc character varying(1020) NOT NULL COLLATE public.nocase,
    brprh_status character varying(160) COLLATE public.nocase,
    brprh_default character(4) COLLATE public.nocase,
    brprh_credit_chk character(4) COLLATE public.nocase,
    brprh_contract_chk character(4) COLLATE public.nocase,
    brprh_route_chk character(4) COLLATE public.nocase,
    brprh_rateid_chk character(4) COLLATE public.nocase,
    brprh_genericrrate_chk character(4) COLLATE public.nocase,
    brprh_servicetype_chk character(4) COLLATE public.nocase,
    brprh_mode_chk character(4) COLLATE public.nocase,
    brprh_saleaccount_chk character(4) COLLATE public.nocase,
    brprh_creation_date timestamp without time zone,
    brprh_created_by character varying(120) COLLATE public.nocase,
    brprh_last_modified_date timestamp without time zone,
    brprh_last_modified_by character varying(120) COLLATE public.nocase,
    brprh_no_of_attempts integer,
    brprh_permanent_instructions character varying(1020) COLLATE public.nocase,
    brprh_documentation_chk character(4) COLLATE public.nocase,
    brprh_hazard_chk character(4) COLLATE public.nocase,
    brprh_delivery_by_tsl character(4) COLLATE public.nocase,
    brprh_pod_pic_chk character(4) COLLATE public.nocase,
    brprh_pod_remarks_chk character(4) COLLATE public.nocase,
    brprh_timestamp integer,
    brprh_weight_chk character(4) COLLATE public.nocase,
    brprh_leg_levl_derivation_chk character(4) COLLATE public.nocase,
    brprh_cutoff_alert time without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);