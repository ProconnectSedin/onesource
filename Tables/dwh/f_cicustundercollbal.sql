-- Table: dwh.f_cicustundercollbal

-- DROP TABLE IF EXISTS dwh.f_cicustundercollbal;

CREATE TABLE IF NOT EXISTS dwh.f_cicustundercollbal
(
    f_cicustundercollbal_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint,
    customer_key bigint,
    curr_key bigint,
    lo_id character varying(40) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    ou_id integer,
    fb_id character varying(40) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    cust_code character varying(40) COLLATE public.nocase,
    base_currency_code character varying(10) COLLATE public.nocase,
    balance_type character varying(10) COLLATE public.nocase,
    par_currency_code character varying(10) COLLATE public.nocase,
    "timestamp" integer,
    deposit_amount numeric(23,2),
    realized_amount numeric(23,2),
    undercoll_amount numeric(23,2),
    par_deposit_amount numeric(23,2),
    par_undercoll_amount numeric(23,2),
    par_realized_amount numeric(23,2),
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
    CONSTRAINT f_cicustundercollbal_pkey PRIMARY KEY (f_cicustundercollbal_key),
    CONSTRAINT f_cicustundercollbal_ukey UNIQUE (lo_id, bu_id, ou_id, fb_id, company_code, cust_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cicustundercollbal
    OWNER to proconnect;
-- Index: f_cicustundercollbal_key_idx

-- DROP INDEX IF EXISTS dwh.f_cicustundercollbal_key_idx;

CREATE INDEX IF NOT EXISTS f_cicustundercollbal_key_idx
    ON dwh.f_cicustundercollbal USING btree
    (lo_id COLLATE public.nocase ASC NULLS LAST, bu_id COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, cust_code COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;