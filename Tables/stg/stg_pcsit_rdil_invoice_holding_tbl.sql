CREATE TABLE stg.stg_pcsit_rdil_invoice_holding_tbl (
    locationcode character varying(10) COLLATE public.nocase,
    entrydate date,
    invoiceno character varying(100) COLLATE public.nocase,
    invoicedate date,
    invoicecreatedby character varying(50) COLLATE public.nocase,
    invoicecreateddatetime timestamp without time zone,
    invoiceholdtype character varying(100) COLLATE public.nocase,
    newdeliverydate timestamp without time zone,
    holdreason character varying(100) COLLATE public.nocase,
    remarks character varying(500) COLLATE public.nocase,
    createdby character varying(50) COLLATE public.nocase,
    createddate timestamp without time zone,
    guid character varying(255) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);