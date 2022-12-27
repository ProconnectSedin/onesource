CREATE TABLE raw.raw_tbp_voucher_hdr (
    raw_id bigint NOT NULL,
    current_key character varying(512) NOT NULL COLLATE public.nocase,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    component_name character varying(80) NOT NULL COLLATE public.nocase,
    bu_id character varying(80) NOT NULL COLLATE public.nocase,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    fb_voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    tran_type character varying(160) COLLATE public.nocase,
    tran_date timestamp without time zone,
    fb_voucher_date timestamp without time zone,
    con_ref_voucher_no character varying(72) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tbp_voucher_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tbp_voucher_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tbp_voucher_hdr
    ADD CONSTRAINT raw_tbp_voucher_hdr_pkey PRIMARY KEY (raw_id);