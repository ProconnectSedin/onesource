CREATE TABLE raw.raw_pcsit_eshipz_invdup (
    raw_id bigint NOT NULL,
    invoicenumber character varying(100) COLLATE public.nocase,
    createdate timestamp without time zone DEFAULT now(),
    status character varying(100) COLLATE public.nocase,
    intiateddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);