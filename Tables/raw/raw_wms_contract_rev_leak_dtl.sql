CREATE TABLE raw.raw_wms_contract_rev_leak_dtl (
    raw_id bigint NOT NULL,
    wms_cont_rev_lkge_contid character varying(72) COLLATE public.nocase,
    wms_cont_rev_lkge_ou integer NOT NULL,
    wms_cont_rev_lkge_line_no integer NOT NULL,
    wms_cont_rev_lkge_doc_type character varying(1020) COLLATE public.nocase,
    wms_cont_rev_lkge_doc_no character varying(72) COLLATE public.nocase,
    wms_cont_rev_lkge_cust_id character varying(72) COLLATE public.nocase,
    wms_cont_rev_lkge_revenue numeric,
    wms_cont_rev_lkge_created_by character varying(120) COLLATE public.nocase,
    wms_cont_rev_lkge_created_date timestamp without time zone,
    wms_cont_rev_lkge_modified_by character varying(120) COLLATE public.nocase,
    wms_cont_rev_lkge_modified_date timestamp without time zone,
    wms_cont_rev_lkge_timestamp integer,
    wms_cont_rev_lkge_flag character varying(48) COLLATE public.nocase,
    wms_cont_rev_lkge_triggering_no character varying(72) COLLATE public.nocase,
    wms_cont_rev_lkge_triggering_type character varying(32) COLLATE public.nocase,
    wms_cont_rev_lkge_tariffid character varying(72) COLLATE public.nocase,
    wms_cont_rev_lkge_triggering_date timestamp without time zone,
    wms_cont_rev_lkge_doc_date timestamp without time zone,
    wms_cont_rev_lkge_location character varying(40) COLLATE public.nocase,
    wms_cont_rev_lkge_supplier character varying(64) COLLATE public.nocase,
    wms_cont_rev_lkge_remarks character varying(1020) COLLATE public.nocase,
    wms_cont_rev_lkge_revenue_leakage timestamp without time zone,
    wms_cont_rev_lkge_tariff_type character varying(160) COLLATE public.nocase,
    wms_cont_rev_lkge_booking_location character varying(40) COLLATE public.nocase,
    wms_cont_rev_lkge_reason character varying COLLATE public.nocase,
    wms_cont_rev_lkge_total_amount numeric,
    wms_cont_rev_lkge_group_flag character varying(32) COLLATE public.nocase,
    wms_cont_rev_lkge_resource_type character varying(1020) COLLATE public.nocase,
    wms_cont_rev_lkge_billable character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_contract_rev_leak_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_contract_rev_leak_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_contract_rev_leak_dtl
    ADD CONSTRAINT raw_wms_contract_rev_leak_dtl_pkey PRIMARY KEY (raw_id);