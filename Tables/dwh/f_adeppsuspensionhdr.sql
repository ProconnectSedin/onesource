-- Table: dwh.f_adeppsuspensionhdr

-- DROP TABLE IF EXISTS dwh.f_adeppsuspensionhdr;

CREATE TABLE IF NOT EXISTS dwh.f_adeppsuspensionhdr
(
    f_adeppsuspensionhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    suspension_no character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    suspension_desc character varying(80) COLLATE public.nocase,
    depr_book character varying(40) COLLATE public.nocase,
    susp_start_date timestamp without time zone,
    susp_end_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
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
    CONSTRAINT f_adeppsuspensionhdr_pkey PRIMARY KEY (f_adeppsuspensionhdr_key),
    CONSTRAINT f_adeppsuspensionhdr_ukey UNIQUE (ou_id, suspension_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adeppsuspensionhdr
    OWNER to proconnect;
-- Index: f_adeppsuspensionhdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_adeppsuspensionhdr_key_idx;

CREATE INDEX IF NOT EXISTS f_adeppsuspensionhdr_key_idx
    ON dwh.f_adeppsuspensionhdr USING btree
    (ou_id ASC NULLS LAST, suspension_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;