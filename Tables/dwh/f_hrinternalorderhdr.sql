-- Table: dwh.f_hrinternalorderhdr

-- DROP TABLE IF EXISTS dwh.f_hrinternalorderhdr;

CREATE TABLE IF NOT EXISTS dwh.f_hrinternalorderhdr
(
    hrinternalorderhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    loc_key bigint,
    vendor_key bigint,
    in_ord_location character varying(20) COLLATE public.nocase,
    in_ord_no character varying(36) COLLATE public.nocase,
    in_ord_ou integer,
    in_ord_contract_id character varying(36) COLLATE public.nocase,
    in_ord_date timestamp without time zone,
    in_ord_typ character varying(16) COLLATE public.nocase,
    in_ord_status character varying(16) COLLATE public.nocase,
    in_ord_customer_id character varying(36) COLLATE public.nocase,
    in_ord_vendor_id character varying(32) COLLATE public.nocase,
    in_ord_pri_ref_doc_typ character varying(80) COLLATE public.nocase,
    in_ord_pri_ref_doc_no character varying(36) COLLATE public.nocase,
    in_ord_pri_ref_doc_date timestamp without time zone,
    in_ord_amendno integer,
    in_ord_timestamp integer,
    in_createdby character varying(60) COLLATE public.nocase,
    in_created_date timestamp without time zone,
    in_modifiedby character varying(60) COLLATE public.nocase,
    in_modified_date timestamp without time zone,
    in_ord_desc character varying(510) COLLATE public.nocase,
    in_ord_division character varying(20) COLLATE public.nocase,
    in_ord_cont_srv_type character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_hrinternalorderhdr_pkey PRIMARY KEY (hrinternalorderhdr_key),
    CONSTRAINT f_hrinternalorderhdr_ukey UNIQUE (in_ord_location, in_ord_no, in_ord_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_hrinternalorderhdr
    OWNER to proconnect;
-- Index: f_hrinternalorderhdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_hrinternalorderhdr_key_idx;

CREATE INDEX IF NOT EXISTS f_hrinternalorderhdr_key_idx
    ON dwh.f_hrinternalorderhdr USING btree
    (in_ord_ou ASC NULLS LAST, in_ord_no COLLATE public.nocase ASC NULLS LAST, in_ord_location COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;