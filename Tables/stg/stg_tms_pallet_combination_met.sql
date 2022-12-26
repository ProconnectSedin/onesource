CREATE TABLE stg.stg_tms_pallet_combination_met (
    tms_language integer NOT NULL,
    tms_code_type character varying(1020) NOT NULL COLLATE public.nocase,
    tms_leg_beh character varying(1020) NOT NULL COLLATE public.nocase,
    tms_trans_type character varying(1020) NOT NULL COLLATE public.nocase,
    tms_comb_desc character varying(1020) NOT NULL COLLATE public.nocase,
    tms_seq_no integer NOT NULL,
    tms_created_date timestamp without time zone,
    tms_created_by character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);