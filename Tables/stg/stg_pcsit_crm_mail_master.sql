CREATE TABLE stg.stg_pcsit_crm_mail_master (
    row_id integer NOT NULL,
    name character varying(250) COLLATE public.nocase,
    region character varying(250) COLLATE public.nocase,
    designation character varying(250) COLLATE public.nocase,
    reporting character varying(250) COLLATE public.nocase,
    sec_reporting character varying(250) COLLATE public.nocase,
    mail_id character varying(250) COLLATE public.nocase,
    ramco_usr_name character varying(1000) COLLATE public.nocase,
    reporting_mail_id character varying(250) COLLATE public.nocase,
    sec_reporting_mail_id character varying(250) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);