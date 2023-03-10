CREATE TABLE stg.stg_tbp_voucher_hdr (
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

ALTER TABLE ONLY stg.stg_tbp_voucher_hdr
    ADD CONSTRAINT tbp_voucher_hdr_pkey PRIMARY KEY (current_key, company_code, component_name, bu_id, fb_id, fb_voucher_no);