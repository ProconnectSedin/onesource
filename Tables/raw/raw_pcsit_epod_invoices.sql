CREATE TABLE raw.raw_pcsit_epod_invoices (
    raw_id bigint NOT NULL,
    invoiceno character varying(10) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);