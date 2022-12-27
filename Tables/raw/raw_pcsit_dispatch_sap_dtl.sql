CREATE TABLE raw.raw_pcsit_dispatch_sap_dtl (
    raw_id bigint NOT NULL,
    billingdocument character varying(200) COLLATE public.nocase,
    billingdate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_dispatch_sap_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_dispatch_sap_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_dispatch_sap_dtl
    ADD CONSTRAINT raw_pcsit_dispatch_sap_dtl_pkey PRIMARY KEY (raw_id);