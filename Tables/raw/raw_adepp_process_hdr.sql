CREATE TABLE raw.raw_adepp_process_hdr (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    depr_proc_runno character varying(80) NOT NULL COLLATE public.nocase,
    depr_book character varying(80) NOT NULL COLLATE public.nocase,
    "timestamp" integer NOT NULL,
    process_status character varying(100) COLLATE public.nocase,
    process_date timestamp without time zone,
    fb_id character varying(80) COLLATE public.nocase,
    num_type character varying(40) COLLATE public.nocase,
    incl_rev character varying(160) COLLATE public.nocase,
    currency character varying(20) COLLATE public.nocase,
    pcost_center character varying(40) COLLATE public.nocase,
    fin_year character varying(40) COLLATE public.nocase,
    fp_upto character varying(40) COLLATE public.nocase,
    fp_start_date timestamp without time zone,
    fp_end_date timestamp without time zone,
    depr_basis character varying(160) COLLATE public.nocase,
    asset_class character varying(80) COLLATE public.nocase,
    depr_category character varying(160) COLLATE public.nocase,
    asset_number character varying(72) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    assets_selected character varying(80) COLLATE public.nocase,
    tag_selected character varying(80) COLLATE public.nocase,
    rec_selected character varying(80) COLLATE public.nocase,
    susp_total numeric,
    depr_total numeric,
    rev_depr_total numeric,
    rev_susp_total numeric,
    pbc_susp_total numeric,
    pbc_depr_total numeric,
    pbc_rev_depr_total numeric,
    pbc_rev_susp_total numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    fystartdate timestamp without time zone,
    fyenddate timestamp without time zone,
    asset_group character varying(100) COLLATE public.nocase,
    asset_location character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_adepp_process_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_adepp_process_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_adepp_process_hdr
    ADD CONSTRAINT raw_adepp_process_hdr_pkey PRIMARY KEY (raw_id);