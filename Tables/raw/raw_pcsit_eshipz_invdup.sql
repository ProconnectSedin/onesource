CREATE TABLE raw.raw_pcsit_eshipz_invdup (
    raw_id bigint NOT NULL,
    invoicenumber character varying(100) COLLATE public.nocase,
    createdate timestamp without time zone DEFAULT now(),
    status character varying(100) COLLATE public.nocase,
    intiateddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_eshipz_invdup ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_eshipz_invdup_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_eshipz_invdup
    ADD CONSTRAINT raw_pcsit_eshipz_invdup_pkey PRIMARY KEY (raw_id);