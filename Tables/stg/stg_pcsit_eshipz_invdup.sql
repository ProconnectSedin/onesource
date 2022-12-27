CREATE TABLE stg.stg_pcsit_eshipz_invdup (
    id integer NOT NULL,
    invoicenumber character varying(100) COLLATE public.nocase,
    createdate timestamp without time zone DEFAULT now(),
    status character varying(100) COLLATE public.nocase,
    intiateddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_eshipz_invdup ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_eshipz_invdup_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);