-- Table: dwh.f_acapassetdoclinedtl

-- DROP TABLE IF EXISTS dwh.f_acapassetdoclinedtl;

CREATE TABLE IF NOT EXISTS dwh.f_acapassetdoclinedtl
(
    acapassetdoclinedtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    cap_number character varying(40) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    doc_type character varying(80) COLLATE public.nocase,
    doc_number character varying(40) COLLATE public.nocase,
    line_no integer,
    proposal_number character varying(40) COLLATE public.nocase,
    doc_amount numeric(13,2),
    pending_cap_amt numeric(13,2),
    cap_amount numeric(13,2),
    tag_group character varying(20) COLLATE public.nocase,
    doc_date timestamp without time zone,
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
    CONSTRAINT f_acapassetdoclinedtl_pkey PRIMARY KEY (acapassetdoclinedtl_key),
    CONSTRAINT f_acapassetdoclinedtl_ukey UNIQUE (ou_id, cap_number, asset_number, doc_type, doc_number, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_acapassetdoclinedtl
    OWNER to proconnect;
-- Index: f_acapassetdoclinedtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_acapassetdoclinedtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_acapassetdoclinedtl_key_idx1
    ON dwh.f_acapassetdoclinedtl USING btree
    (ou_id ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST, doc_number COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;