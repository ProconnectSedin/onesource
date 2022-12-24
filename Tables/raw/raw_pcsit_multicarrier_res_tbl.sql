CREATE TABLE raw.raw_pcsit_multicarrier_res_tbl (
    raw_id bigint NOT NULL,
    rowid integer NOT NULL,
    invoice_no character varying(10000) COLLATE public.nocase,
    br_no character varying(1000) COLLATE public.nocase,
    trip_no character varying(1000) COLLATE public.nocase,
    mctid integer DEFAULT 0 NOT NULL,
    awb_no character varying(800) COLLATE public.nocase,
    mt_identify character varying(800) COLLATE public.nocase,
    req_mes text,
    status character varying(20) COLLATE public.nocase,
    res_mes text,
    remarks character varying(500) COLLATE public.nocase,
    created_date timestamp without time zone DEFAULT now(),
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);