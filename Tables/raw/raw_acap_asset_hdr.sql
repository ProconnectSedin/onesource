CREATE TABLE raw.raw_acap_asset_hdr (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    cap_number character varying(72) NOT NULL COLLATE public.nocase,
    asset_number character varying(72) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    cap_date timestamp without time zone,
    cap_status character varying(100) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    asset_class character varying(80) COLLATE public.nocase,
    asset_group character varying(100) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    asset_desc character varying(160) COLLATE public.nocase,
    asset_cost numeric,
    asset_location character varying(80) COLLATE public.nocase,
    seq_no integer,
    as_on_date timestamp without time zone,
    asset_type character varying(40) COLLATE public.nocase,
    asset_status character varying(100) COLLATE public.nocase,
    transaction_date timestamp without time zone,
    account_code character varying(128) COLLATE public.nocase,
    asset_cost_befround numeric,
    asset_cost_diff numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    remarks character varying(1020) COLLATE public.nocase,
    workflow_status character varying(80) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    laccount_code character varying(128) COLLATE public.nocase,
    laccount_desc character varying(240) COLLATE public.nocase,
    lcost_center character varying(40) COLLATE public.nocase,
    lanalysis_code character varying(20) COLLATE public.nocase,
    lsubanalysis_code character varying(20) COLLATE public.nocase,
    asset_classification character varying(1020) COLLATE public.nocase,
    asset_category character varying(1020) COLLATE public.nocase,
    asset_cluster character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_acap_asset_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_acap_asset_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_acap_asset_hdr
    ADD CONSTRAINT raw_acap_asset_hdr_pkey PRIMARY KEY (raw_id);