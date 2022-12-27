CREATE TABLE raw.raw_pcsit_pre_mailalert (
    raw_id bigint NOT NULL,
    locationcode character varying(20) COLLATE public.nocase,
    zone character varying(30) COLLATE public.nocase,
    region character varying(30) COLLATE public.nocase,
    tomailid character varying COLLATE public.nocase,
    ccmailid character varying COLLATE public.nocase,
    locationame character varying(200) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_pre_mailalert ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_pre_mailalert_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_pre_mailalert
    ADD CONSTRAINT raw_pcsit_pre_mailalert_pkey PRIMARY KEY (raw_id);