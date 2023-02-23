-- Table: raw.raw_tset_tax_region

-- DROP TABLE IF EXISTS "raw".raw_tset_tax_region;

CREATE TABLE IF NOT EXISTS "raw".raw_tset_tax_region
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tax_community character varying(100) COLLATE public.nocase NOT NULL,
    tax_type character varying(100) COLLATE public.nocase NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    tax_region character varying(40) COLLATE public.nocase NOT NULL,
    tax_region_desc character varying(160) COLLATE public.nocase NOT NULL,
    regd_no character varying(160) COLLATE public.nocase,
    effective_from_date timestamp without time zone NOT NULL,
    tax_region_type character varying(32) COLLATE public.nocase,
    created_at integer NOT NULL,
    created_by character varying(120) COLLATE public.nocase NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_by character varying(120) COLLATE public.nocase,
    modified_date timestamp without time zone,
    assessee_type character varying(100) COLLATE public.nocase,
    personresp character varying(240) COLLATE public.nocase,
    designation character varying(160) COLLATE public.nocase,
    addressid character varying(48) COLLATE public.nocase,
    fathersname character varying(240) COLLATE public.nocase,
    citaddressid character varying(48) COLLATE public.nocase,
    origin_stamp character varying(32) COLLATE public.nocase,
    inward_mand character varying(32) COLLATE public.nocase,
    outward_mand character varying(32) COLLATE public.nocase,
    grp_regd_no character varying(160) COLLATE public.nocase,
    encryption_key character varying COLLATE public.nocase,
    gst_user_name character varying(1020) COLLATE public.nocase,
    grossturnover_fy numeric,
    grossturnover_aprjun numeric,
    gsp_password character varying(160) COLLATE public.nocase,
    isd_reg character varying(160) COLLATE public.nocase NOT NULL DEFAULT 'N'::character varying,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_tset_tax_region
    OWNER to proconnect;