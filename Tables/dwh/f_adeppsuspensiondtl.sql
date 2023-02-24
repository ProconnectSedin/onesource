-- Table: dwh.f_adeppsuspensiondtl

-- DROP TABLE IF EXISTS dwh.f_adeppsuspensiondtl;

CREATE TABLE IF NOT EXISTS dwh.f_adeppsuspensiondtl
(
    adeppsuspensiondtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    adeppsuspensionhdr_key bigint NOT NULL,
    ou_id integer,
    depr_category character varying(80) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    suspension_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    cost_center character varying(20) COLLATE public.nocase,
    asset_location character varying(40) COLLATE public.nocase,
    susp_start_date timestamp without time zone,
    susp_end_date timestamp without time zone,
    status character varying(50) COLLATE public.nocase,
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
    CONSTRAINT f_adeppsuspensiondtl_pkey PRIMARY KEY (adeppsuspensiondtl_key),
    CONSTRAINT f_adeppsuspensiondtl_ukey UNIQUE (ou_id, depr_category, asset_number, tag_number, suspension_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adeppsuspensiondtl
    OWNER to proconnect;
-- Index: f_adeppsuspensiondtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_adeppsuspensiondtl_key_idx;

CREATE INDEX IF NOT EXISTS f_adeppsuspensiondtl_key_idx
    ON dwh.f_adeppsuspensiondtl USING btree
    (ou_id ASC NULLS LAST, suspension_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_adeppsuspensiondtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_adeppsuspensiondtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_adeppsuspensiondtl_key_idx1
    ON dwh.f_adeppsuspensiondtl USING btree
    (ou_id ASC NULLS LAST, depr_category COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, suspension_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;