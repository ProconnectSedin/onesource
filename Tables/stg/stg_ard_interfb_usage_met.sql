CREATE TABLE stg.stg_ard_interfb_usage_met (
    tran_type character varying(160) COLLATE public.nocase,
    usage_id character varying(80) NOT NULL COLLATE public.nocase,
    usage_type character varying(160) NOT NULL COLLATE public.nocase,
    ifb_type character varying(160) NOT NULL COLLATE public.nocase,
    contra_acc_type character varying(160) NOT NULL COLLATE public.nocase,
    entity character varying(160) NOT NULL COLLATE public.nocase,
    usage_desc character varying(1020) NOT NULL COLLATE public.nocase,
    created_by character varying(120) COLLATE public.nocase,
    created_date timestamp without time zone,
    modifed_by character varying(120) COLLATE public.nocase,
    modifed_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);