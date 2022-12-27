CREATE TABLE raw.raw_pcsit_epod_invoices (
    raw_id bigint NOT NULL,
    invoiceno character varying(10) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_epod_invoices ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_epod_invoices_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_epod_invoices
    ADD CONSTRAINT raw_pcsit_epod_invoices_pkey PRIMARY KEY (raw_id);