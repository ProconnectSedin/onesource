-- Table: dwh.f_amiginitialbalance

-- DROP TABLE IF EXISTS dwh.f_amiginitialbalance;

CREATE TABLE IF NOT EXISTS dwh.f_amiginitialbalance
(
    amiginitialbalance_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    depr_book character varying(40) COLLATE public.nocase,
    fin_year character varying(20) COLLATE public.nocase,
    fin_period character varying(20) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    fb_id character varying(40) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    asset_cost numeric(25,2),
    cum_depr_charge numeric(25,2),
    asset_book_val numeric(25,2),
    complete_status character varying(50) COLLATE public.nocase,
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
    CONSTRAINT f_amiginitialbalance_pkey PRIMARY KEY (amiginitialbalance_key),
    CONSTRAINT f_amiginitialbalance_ukey UNIQUE (ou_id, depr_book, fin_year, fin_period, asset_number, tag_number, fb_id, asset_class)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_amiginitialbalance
    OWNER to proconnect;
-- Index: f_amiginitialbalance_key_idx

-- DROP INDEX IF EXISTS dwh.f_amiginitialbalance_key_idx;

CREATE INDEX IF NOT EXISTS f_amiginitialbalance_key_idx
    ON dwh.f_amiginitialbalance USING btree
    (ou_id ASC NULLS LAST, depr_book COLLATE public.nocase ASC NULLS LAST, fin_year COLLATE public.nocase ASC NULLS LAST, fin_period COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, asset_class COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;