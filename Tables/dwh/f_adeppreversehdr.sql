-- Table: dwh.f_adeppreversehdr

-- DROP TABLE IF EXISTS dwh.f_adeppreversehdr;

CREATE TABLE IF NOT EXISTS dwh.f_adeppreversehdr
(
    adepp_reverse_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    rev_doc_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    revr_option character varying(40) COLLATE public.nocase,
    depr_proc_runno character varying(40) COLLATE public.nocase,
    depr_total numeric(25,2),
    susp_total numeric(25,2),
    reversal_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    rev_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_adeppreversehdr_pkey PRIMARY KEY (adepp_reverse_hdr_key),
    CONSTRAINT f_adeppreversehdr_ukey UNIQUE (ou_id, rev_doc_no, depr_proc_runno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adeppreversehdr
    OWNER to proconnect;