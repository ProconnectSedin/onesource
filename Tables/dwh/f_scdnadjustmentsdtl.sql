-- Table: dwh.f_scdnadjustmentsdtl

-- DROP TABLE IF EXISTS dwh.f_scdnadjustmentsdtl;

CREATE TABLE IF NOT EXISTS dwh.f_scdnadjustmentsdtl
(
    scdnadjustmentsdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(36) COLLATE public.nocase,
    ref_doc_type character varying(20) COLLATE public.nocase,
    ref_doc_no character varying(36) COLLATE public.nocase,
    "timestamp" integer,
    ref_doc_date timestamp without time zone,
    ref_doc_fb_id character varying(40) COLLATE public.nocase,
    ref_doc_current_os numeric(13,2),
    guid character varying(256) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_scdnadjustmentsdtl_pkey PRIMARY KEY (scdnadjustmentsdtl_key),
    CONSTRAINT f_scdnadjustmentsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, ref_doc_type, ref_doc_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_scdnadjustmentsdtl
    OWNER to proconnect;
-- Index: f_scdnadjustmentsdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_scdnadjustmentsdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_scdnadjustmentsdtl_key_idx
    ON dwh.f_scdnadjustmentsdtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, ref_doc_type COLLATE public.nocase ASC NULLS LAST, ref_doc_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;