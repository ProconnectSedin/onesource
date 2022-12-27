CREATE TABLE stg.stg_pcsit_multicarrier_res_tbl (
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

ALTER TABLE stg.stg_pcsit_multicarrier_res_tbl ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_multicarrier_res_tbl_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);