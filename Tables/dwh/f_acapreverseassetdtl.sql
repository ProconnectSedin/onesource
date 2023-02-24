-- Table: dwh.f_acapreverseassetdtl

-- DROP TABLE IF EXISTS dwh.f_acapreverseassetdtl;

CREATE TABLE IF NOT EXISTS dwh.f_acapreverseassetdtl
(
    acap_reverse_asset_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    acap_reverse_asset_hdr_key bigint NOT NULL,
    ou_id integer,
    document_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    "timestamp" integer,
    tag_desc character varying(80) COLLATE public.nocase,
    depr_category character varying(80) COLLATE public.nocase,
    business_use numeric(25,2),
    inservice_date timestamp without time zone,
    asset_location character varying(40) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    tag_cost numeric(25,2),
    tag_status character varying(10) COLLATE public.nocase,
    inv_cycle character varying(30) COLLATE public.nocase,
    salvage_value numeric(25,2),
    manufacturer character varying(120) COLLATE public.nocase,
    bar_code character varying(40) COLLATE public.nocase,
    serial_no character varying(40) COLLATE public.nocase,
    warranty_no character varying(40) COLLATE public.nocase,
    model character varying(80) COLLATE public.nocase,
    custodian character varying(160) COLLATE public.nocase,
    book_value numeric(25,2),
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
    CONSTRAINT f_acapreverseassetdtl_pkey PRIMARY KEY (acap_reverse_asset_dtl_key),
    CONSTRAINT f_acapreverseassetdtl_ukey UNIQUE (ou_id, document_number, tag_number),
    CONSTRAINT f_acapreverseassetdtl_acap_reverse_asset_hdr_key_fkey FOREIGN KEY (acap_reverse_asset_hdr_key)
        REFERENCES dwh.f_acapreverseassethdr (acap_reverse_asset_hdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_acapreverseassetdtl
    OWNER to proconnect;