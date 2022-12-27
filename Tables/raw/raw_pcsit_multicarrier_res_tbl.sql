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

ALTER TABLE raw.raw_pcsit_multicarrier_res_tbl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_multicarrier_res_tbl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcsit_multicarrier_res_tbl ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_multicarrier_res_tbl_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_multicarrier_res_tbl
    ADD CONSTRAINT raw_pcsit_multicarrier_res_tbl_pkey PRIMARY KEY (raw_id);