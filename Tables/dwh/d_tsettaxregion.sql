-- Table: dwh.d_tsettaxregion

-- DROP TABLE IF EXISTS dwh.d_tsettaxregion;

CREATE TABLE IF NOT EXISTS dwh.d_tsettaxregion
(
    tsettaxregion_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tax_community character varying(50) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    tax_region character varying(20) COLLATE public.nocase,
    tax_region_desc character varying(80) COLLATE public.nocase,
    regd_no character varying(80) COLLATE public.nocase,
    effective_from_date timestamp without time zone,
    tax_region_type character varying(16) COLLATE public.nocase,
    created_at integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    assessee_type character varying(50) COLLATE public.nocase,
    personresp character varying(120) COLLATE public.nocase,
    designation character varying(80) COLLATE public.nocase,
    addressid character varying(24) COLLATE public.nocase,
    origin_stamp character varying(16) COLLATE public.nocase,
    inward_mand character varying(16) COLLATE public.nocase,
    outward_mand character varying(16) COLLATE public.nocase,
    isd_reg character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_tsettaxregion_pkey PRIMARY KEY (tsettaxregion_key),
    CONSTRAINT d_tsettaxregion_ukey UNIQUE (tax_community, tax_type, company_code, tax_region)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_tsettaxregion
    OWNER to proconnect;