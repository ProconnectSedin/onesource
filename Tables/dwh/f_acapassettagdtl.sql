-- Table: dwh.f_acapassettagdtl

-- DROP TABLE IF EXISTS dwh.f_acapassettagdtl;

CREATE TABLE IF NOT EXISTS dwh.f_acapassettagdtl
(
    acapassettagdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    account_code_key bigint NOT NULL,
    loc_key bigint NOT NULL,
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
    tag_cost numeric(13,2),
    proposal_number character varying(40) COLLATE public.nocase,
    tag_status character varying(50) COLLATE public.nocase,
    depr_category character varying(80) COLLATE public.nocase,
    inv_cycle character varying(30) COLLATE public.nocase,
    salvage_value numeric(13,2),
    manufacturer character varying(120) COLLATE public.nocase,
    bar_code character varying(40) COLLATE public.nocase,
    serial_no character varying(40) COLLATE public.nocase,
    warranty_no character varying(40) COLLATE public.nocase,
    model character varying(80) COLLATE public.nocase,
    custodian character varying(160) COLLATE public.nocase,
    business_use numeric(13,2),
    reverse_remarks character varying(200) COLLATE public.nocase,
    inv_date timestamp without time zone,
    inv_due_date timestamp without time zone,
    inv_status character varying(50) COLLATE public.nocase,
    policy_count character varying(10) COLLATE public.nocase,
    transfer_date timestamp without time zone,
    legacy_asset_no character varying(40) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    residualvalue numeric(13,2),
    usefullifeinmonths integer,
    laccount_code character varying(80) COLLATE public.nocase,
    laccount_desc character varying(120) COLLATE public.nocase,
    lcost_center character varying(20) COLLATE public.nocase,
    asset_category character varying(510) COLLATE public.nocase,
    asset_cluster character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_acapassettagdtl_pkey PRIMARY KEY (acapassettagdtl_key),
    CONSTRAINT f_acapassettagdtl_ukey UNIQUE (ou_id, asset_number, tag_number, cap_number, fb_id),
    CONSTRAINT f_acapassettagdtl_account_code_key_fkey FOREIGN KEY (account_code_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_acapassettagdtl_loc_key_fkey FOREIGN KEY (loc_key)
        REFERENCES dwh.d_location (loc_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_acapassettagdtl
    OWNER to proconnect;
-- Index: f_acapassettagdtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_acapassettagdtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_acapassettagdtl_key_idx1
    ON dwh.f_acapassettagdtl USING btree
    (ou_id ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, cap_number COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;