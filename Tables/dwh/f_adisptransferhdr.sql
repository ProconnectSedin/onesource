-- Table: dwh.f_adisptransferhdr

-- DROP TABLE IF EXISTS dwh.f_adisptransferhdr;

CREATE TABLE IF NOT EXISTS dwh.f_adisptransferhdr
(
    adisp_transfer_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    transfer_number character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    transfer_date timestamp without time zone,
    transfer_status character varying(50) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    source_fb_id character varying(40) COLLATE public.nocase,
    destination_fb_id character varying(40) COLLATE public.nocase,
    confirmation_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    transfer_in_no character varying(40) COLLATE public.nocase,
    tcal_status_in character varying(30) COLLATE public.nocase,
    tcal_status character varying(30) COLLATE public.nocase,
    tran_type character varying(50) COLLATE public.nocase,
    transfer_in_status character varying(50) COLLATE public.nocase,
    transfer_in_numtyp character varying(20) COLLATE public.nocase,
    workflow_status character varying(50) COLLATE public.nocase,
    workflow_error character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_adisptransferhdr_pkey PRIMARY KEY (adisp_transfer_hdr_key),
    CONSTRAINT f_adisptransferhdr_ukey UNIQUE (ou_id, transfer_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adisptransferhdr
    OWNER to proconnect;