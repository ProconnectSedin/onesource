CREATE TABLE stg.stg_not_trantype_met (
    tran_type character varying(512) NOT NULL COLLATE public.nocase,
    tran_desc character varying(512) NOT NULL COLLATE public.nocase,
    lang_id integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);