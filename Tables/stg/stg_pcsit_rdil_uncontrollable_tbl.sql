CREATE TABLE stg.stg_pcsit_rdil_uncontrollable_tbl (
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

CREATE INDEX stg_pcsit_rdil_uncontrollable_tbl_idx ON stg.stg_pcsit_rdil_uncontrollable_tbl USING btree (tranou, type, activity, locationcode, invoiceno, invoiceholdtype, invoicedate, guid, remarks);