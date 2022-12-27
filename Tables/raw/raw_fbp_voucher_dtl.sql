CREATE TABLE raw.raw_fbp_voucher_dtl (
    raw_id bigint NOT NULL,
    parent_key character varying(512) NOT NULL COLLATE public.nocase,
    current_key character varying(512) NOT NULL COLLATE public.nocase,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    ou_id integer NOT NULL,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    fb_voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    serial_no integer NOT NULL,
    "timestamp" integer,
    account_code character varying(128) COLLATE public.nocase,
    drcr_flag character varying(24) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    base_amount numeric,
    par_base_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fbp_voucher_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fbp_voucher_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fbp_voucher_dtl
    ADD CONSTRAINT raw_fbp_voucher_dtl_pkey PRIMARY KEY (raw_id);