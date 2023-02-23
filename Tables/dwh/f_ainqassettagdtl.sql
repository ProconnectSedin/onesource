-- Table: dwh.f_ainqassettagdtl

-- DROP TABLE IF EXISTS dwh.f_ainqassettagdtl;

CREATE TABLE IF NOT EXISTS dwh.f_ainqassettagdtl
(
    ainqassettagdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ainqassettagdtl_lockey bigint,
    ou_id integer,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    cap_number character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    asset_desc character varying(80) COLLATE public.nocase,
    tag_desc character varying(80) COLLATE public.nocase,
    asset_location character varying(40) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    inservice_date timestamp without time zone,
    tag_cost numeric(20,2),
    tag_status character varying(10) COLLATE public.nocase,
    depr_category character varying(80) COLLATE public.nocase,
    inv_cycle character varying(30) COLLATE public.nocase,
    salvage_value numeric(20,2),
    manufacturer character varying(120) COLLATE public.nocase,
    bar_code character varying(40) COLLATE public.nocase,
    serial_no character varying(40) COLLATE public.nocase,
    warranty_no character varying(40) COLLATE public.nocase,
    model character varying(80) COLLATE public.nocase,
    custodian character varying(160) COLLATE public.nocase,
    business_use numeric(20,2),
    book_value numeric(13,2),
    revalued_cost numeric(20,2),
    inv_due_date timestamp without time zone,
    inv_status character varying(50) COLLATE public.nocase,
    policy_count character varying(10) COLLATE public.nocase,
    transfer_date timestamp without time zone,
    legacy_asset_no character varying(40) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    proposal_number character varying(40) COLLATE public.nocase,
    cum_down_rev_cost numeric(20,2),
    cum_up_rev_cost numeric(20,2),
    depr_book character varying(40) COLLATE public.nocase,
    residualvalue numeric(20,2),
    usefullifeinmonths integer,
    ari_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ainqassettagdtl_pkey PRIMARY KEY (ainqassettagdtl_key),
    CONSTRAINT f_ainqassettagdtl_ukey UNIQUE (ou_id, asset_number, tag_number, cap_number, fb_id, depr_book)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ainqassettagdtl
    OWNER to proconnect;
-- Index: f_ainqassettagdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_ainqassettagdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_ainqassettagdtl_key_idx
    ON dwh.f_ainqassettagdtl USING btree
    (ou_id ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, depr_book COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;