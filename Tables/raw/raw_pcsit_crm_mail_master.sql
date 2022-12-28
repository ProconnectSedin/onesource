CREATE TABLE raw.raw_pcsit_crm_mail_master (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_pcsit_crm_mail_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_crm_mail_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcsit_crm_mail_master ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_crm_mail_master_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_crm_mail_master
    ADD CONSTRAINT raw_pcsit_crm_mail_master_pkey PRIMARY KEY (raw_id);