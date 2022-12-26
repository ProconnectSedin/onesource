CREATE TABLE stg.stg_lgt_clr_doc_gen_logs (
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