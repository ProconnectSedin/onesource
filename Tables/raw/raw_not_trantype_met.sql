CREATE TABLE raw.raw_not_trantype_met (
    raw_id bigint NOT NULL,
    tran_type character varying(512) NOT NULL COLLATE public.nocase,
    tran_desc character varying(512) NOT NULL COLLATE public.nocase,
    lang_id integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_not_trantype_met ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_not_trantype_met_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_not_trantype_met
    ADD CONSTRAINT raw_not_trantype_met_pkey PRIMARY KEY (raw_id);