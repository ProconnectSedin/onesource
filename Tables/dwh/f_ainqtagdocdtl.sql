-- Table: dwh.f_ainqtagdocdtl

-- DROP TABLE IF EXISTS dwh.f_ainqtagdocdtl;

CREATE TABLE IF NOT EXISTS dwh.f_ainqtagdocdtl
(
    ainqtagdocdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    fb_id character varying(40) COLLATE public.nocase,
    cap_number character varying(40) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    doc_number character varying(40) COLLATE public.nocase,
    line_no integer,
    doc_amount numeric(20,2),
    doc_type character varying(80) COLLATE public.nocase,
    cap_amount numeric(20,2),
    proposal_number character varying(40) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ainqtagdocdtl_pkey PRIMARY KEY (ainqtagdocdtl_key),
    CONSTRAINT f_ainqtagdocdtl_ukey UNIQUE (ou_id, fb_id, cap_number, asset_number, tag_number, doc_number, line_no, doc_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ainqtagdocdtl
    OWNER to proconnect;
-- Index: f_ainqtagdocdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_ainqtagdocdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_ainqtagdocdtl_key_idx
    ON dwh.f_ainqtagdocdtl USING btree
    (ou_id ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, doc_number COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST, doc_type COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;