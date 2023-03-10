CREATE TABLE raw.raw_as_opaccount_dtl (
    raw_id bigint NOT NULL,
    opcoa_id character varying(40) NOT NULL COLLATE public.nocase,
    account_code character varying(128) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    account_desc character varying(160) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    account_group character varying(80) COLLATE public.nocase,
    account_class character varying(80) COLLATE public.nocase,
    ctrl_acctype character varying(160) COLLATE public.nocase,
    autopost_acctype character varying(160) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    consol_account character varying(128) COLLATE public.nocase,
    layout_code character varying(160) COLLATE public.nocase,
    account_status character varying(8) COLLATE public.nocase,
    active_from timestamp without time zone,
    active_to timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    createdlangid integer,
    schedule_code character varying(240) COLLATE public.nocase,
    status character varying(8) COLLATE public.nocase,
    revised_schedule_code character varying(240) COLLATE public.nocase,
    revised_layout_code character varying(160) COLLATE public.nocase,
    revised_neg_schedule_code character varying(100) COLLATE public.nocase,
    revised_neg_layout_code character varying(100) COLLATE public.nocase,
    workflow_status character varying(100) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    wf_flag character varying(48) COLLATE public.nocase,
    revised_asindas_layout_code character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_as_opaccount_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_as_opaccount_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_as_opaccount_dtl
    ADD CONSTRAINT raw_as_opaccount_dtl_pkey PRIMARY KEY (raw_id);