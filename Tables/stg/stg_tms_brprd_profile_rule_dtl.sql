CREATE TABLE stg.stg_tms_brprd_profile_rule_dtl (
    brprr_ouinstance integer NOT NULL,
    brprr_profile_id character varying(72) NOT NULL COLLATE public.nocase,
    brprr_event character varying(160) NOT NULL COLLATE public.nocase,
    brprr_line_no integer,
    brprr_doc_type character varying(160) COLLATE public.nocase,
    brprr_doc_creation character(4) COLLATE public.nocase,
    brprr_priority integer,
    brprr_proforma character(4) COLLATE public.nocase,
    brprr_commercial character(4) COLLATE public.nocase,
    brprr_creation_date timestamp without time zone,
    brprr_created_by character varying(120) COLLATE public.nocase,
    brprr_last_modified_date timestamp without time zone,
    brprr_last_modified_by character varying(120) COLLATE public.nocase,
    brprr_timestamp integer,
    brprr_unique_id character varying(512) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);