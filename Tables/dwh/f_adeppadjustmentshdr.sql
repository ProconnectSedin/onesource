-- Table: dwh.f_adeppadjustmentshdr

-- DROP TABLE IF EXISTS dwh.f_adeppadjustmentshdr;

CREATE TABLE IF NOT EXISTS dwh.f_adeppadjustmentshdr
(
    adepp_adjustments_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    document_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    depr_book character varying(40) COLLATE public.nocase,
    doc_status character varying(50) COLLATE public.nocase,
    tran_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    depr_total numeric(25,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    workflow_status character varying(50) COLLATE public.nocase,
    workflow_error character varying(40) COLLATE public.nocase,
    wf_guid character varying(260) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_adeppadjustmentshdr_pkey PRIMARY KEY (adepp_adjustments_hdr_key),
    CONSTRAINT f_adeppadjustmentshdr_ukey UNIQUE (ou_id, document_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adeppadjustmentshdr
    OWNER to proconnect;