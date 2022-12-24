CREATE TABLE stg.stg_pcsit_epod_invoices (
    invoiceno character varying(10) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);