CREATE TABLE raw.raw_pcsit_rdil_uncontrollable_tbl (
    raw_id bigint NOT NULL,
    locationcode character varying(10) COLLATE public.nocase,
    invoiceno character varying(100) COLLATE public.nocase,
    invoicedate date,
    invoiceholdtype character varying(100) COLLATE public.nocase,
    remarks character varying(500) COLLATE public.nocase,
    createdby character varying(50) COLLATE public.nocase,
    createddate timestamp without time zone,
    guid character varying(255) COLLATE public.nocase,
    tranou integer,
    type character varying(100) COLLATE public.nocase,
    activity character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_rdil_uncontrollable_tbl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_rdil_uncontrollable_tbl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_rdil_uncontrollable_tbl
    ADD CONSTRAINT raw_pcsit_rdil_uncontrollable_tbl_pkey PRIMARY KEY (raw_id);