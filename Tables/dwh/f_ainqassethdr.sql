-- Table: dwh.f_ainqassethdr

-- DROP TABLE IF EXISTS dwh.f_ainqassethdr;

CREATE TABLE IF NOT EXISTS dwh.f_ainqassethdr
(
    ainqassethdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ainqassethdr_lockey bigint,
    ainqassethdr_datekey bigint,
    ou_id integer,
    cap_number character varying(40) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    cap_date timestamp without time zone,
    cap_status character varying(50) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    asset_group character varying(50) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    asset_desc character varying(80) COLLATE public.nocase,
    asset_cost numeric(13,2),
    asset_location character varying(40) COLLATE public.nocase,
    seq_no integer,
    as_on_date timestamp without time zone,
    asset_type character varying(20) COLLATE public.nocase,
    asset_status character varying(10) COLLATE public.nocase,
    transaction_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    depr_book character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ainqassethdr_pkey PRIMARY KEY (ainqassethdr_key),
    CONSTRAINT f_ainqassethdr_ukey UNIQUE (ou_id, cap_number, asset_number, depr_book)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ainqassethdr
    OWNER to proconnect;
-- Index: f_ainqassethdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_ainqassethdr_key_idx;

CREATE INDEX IF NOT EXISTS f_ainqassethdr_key_idx
    ON dwh.f_ainqassethdr USING btree
    (ou_id ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, depr_book COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;