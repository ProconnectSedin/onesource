CREATE TABLE stg.stg_pcsit_pre_mailalert (
    id integer NOT NULL,
    locationcode character varying(20) COLLATE public.nocase,
    zone character varying(30) COLLATE public.nocase,
    region character varying(30) COLLATE public.nocase,
    tomailid character varying COLLATE public.nocase,
    ccmailid character varying COLLATE public.nocase,
    locationame character varying(200) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_pre_mailalert ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_pre_mailalert_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);