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