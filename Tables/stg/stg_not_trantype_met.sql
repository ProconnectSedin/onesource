CREATE TABLE stg.stg_not_trantype_met (
    tran_type character varying(512) NOT NULL COLLATE public.nocase,
    tran_desc character varying(512) NOT NULL COLLATE public.nocase,
    lang_id integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_not_trantype_met
    ADD CONSTRAINT pk__not_trantype_met__483f914d PRIMARY KEY (tran_type, tran_desc, lang_id);