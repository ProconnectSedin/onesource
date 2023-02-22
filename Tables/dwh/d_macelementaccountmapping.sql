-- Table: dwh.d_macelementaccountmapping

-- DROP TABLE IF EXISTS dwh.d_macelementaccountmapping;

CREATE TABLE IF NOT EXISTS dwh.d_macelementaccountmapping
(
    macelementaccountmapping_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    ma_element_no character varying(80) COLLATE public.nocase,
    ma_account_no character varying(80) COLLATE public.nocase,
    ma_user_id integer,
    ma_datetime timestamp without time zone,
    ma_timestamp integer,
    ma_createdby character varying(80) COLLATE public.nocase,
    ma_createdate timestamp without time zone,
    ma_modifedby character varying(80) COLLATE public.nocase,
    ma_modifydate timestamp without time zone,
    bu_id character varying(40) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_macelementaccountmapping_pkey PRIMARY KEY (macelementaccountmapping_key),
    CONSTRAINT d_macelementaccountmapping_ukey UNIQUE (ou_id, company_code, ma_element_no, ma_account_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_macelementaccountmapping
    OWNER to proconnect;
-- Index: d_macelementaccountmapping_key_idx1

-- DROP INDEX IF EXISTS dwh.d_macelementaccountmapping_key_idx1;

CREATE INDEX IF NOT EXISTS d_macelementaccountmapping_key_idx1
    ON dwh.d_macelementaccountmapping USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, ma_element_no COLLATE public.nocase ASC NULLS LAST, ma_account_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;