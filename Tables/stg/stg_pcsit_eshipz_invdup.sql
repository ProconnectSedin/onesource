CREATE TABLE stg.stg_pcsit_eshipz_invdup (
    id integer NOT NULL,
    invoicenumber character varying(100) COLLATE public.nocase,
    createdate timestamp without time zone DEFAULT now(),
    status character varying(100) COLLATE public.nocase,
    intiateddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);