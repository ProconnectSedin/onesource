CREATE TABLE raw.raw_pcsit_merchant_pan_mapping (
    raw_id bigint NOT NULL,
    cust_code character(40) COLLATE public.nocase,
    cust_pan character varying(80) COLLATE public.nocase,
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);