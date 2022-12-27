CREATE TABLE raw.raw_lgt_clr_doc_gen_logs (
    raw_id bigint NOT NULL,
    guid character varying(400) COLLATE public.nocase,
    meta_trantype_code character varying(1020) COLLATE public.nocase,
    hostname character varying(800) COLLATE public.nocase,
    loginuser character varying(800) COLLATE public.nocase,
    updby character varying(800) COLLATE public.nocase,
    updtime timestamp without time zone,
    eventtype character varying(400) COLLATE public.nocase,
    tran_no character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_lgt_clr_doc_gen_logs ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_lgt_clr_doc_gen_logs_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_lgt_clr_doc_gen_logs
    ADD CONSTRAINT raw_lgt_clr_doc_gen_logs_pkey PRIMARY KEY (raw_id);