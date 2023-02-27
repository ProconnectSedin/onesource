-- Table: dwh.f_adispretirementhdr

-- DROP TABLE IF EXISTS dwh.f_adispretirementhdr;

CREATE TABLE IF NOT EXISTS dwh.f_adispretirementhdr
(
    adisp_retirement_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    retirement_number character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    retirement_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    pay_category character varying(80) COLLATE public.nocase,
    proposal_number character varying(40) COLLATE public.nocase,
    gen_auth_invoice character varying(20) COLLATE public.nocase,
    retirement_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    num_type_cdi character varying(20) COLLATE public.nocase,
    workflow_status character varying(50) COLLATE public.nocase,
    workflow_error character varying(40) COLLATE public.nocase,
    wf_guid character varying(260) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_adispretirementhdr_pkey PRIMARY KEY (adisp_retirement_hdr_key),
    CONSTRAINT f_adispretirementhdr_ukey UNIQUE (ou_id, retirement_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adispretirementhdr
    OWNER to proconnect;