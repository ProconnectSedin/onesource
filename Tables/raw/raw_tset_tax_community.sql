-- Table: raw.raw_tset_tax_community

-- DROP TABLE IF EXISTS "raw".raw_tset_tax_community;

CREATE TABLE IF NOT EXISTS "raw".raw_tset_tax_community
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    predefined_type character varying(20) COLLATE public.nocase,
    multiple_tax_codes character varying(20) COLLATE public.nocase,
    surcharge character varying(20) COLLATE public.nocase,
    tax_rates character varying(20) COLLATE public.nocase,
    multiple_fin_years character varying(20) COLLATE public.nocase,
    tax_rate_assessee_type character varying(20) COLLATE public.nocase,
    taxcalc_applicable_at character varying(20) COLLATE public.nocase,
    tax_groups character varying(20) COLLATE public.nocase,
    tax_certif_applicable character varying(20) COLLATE public.nocase,
    tax_settl_process character varying(20) COLLATE public.nocase,
    tax_adjust_applicable character varying(20) COLLATE public.nocase,
    tax_reduce_amt character varying(50) COLLATE public.nocase,
    tax_mul_reg character varying(50) COLLATE public.nocase,
    tax_wh_reg_map character varying(50) COLLATE public.nocase,
    taxbasis_percentage integer,
    taxbasis_unit_rate integer,
    taxbasis_flat integer,
    created_at integer,
    created_by character varying(60) COLLATE public.nocase,
    addnl_param1 character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    addnl_param2 character varying(60) COLLATE public.nocase,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    "timestamp" integer,
    tax_cap_purchase character varying(10) COLLATE public.nocase,
    taxableamt_edit character varying(20) COLLATE public.nocase,
    quantity_edit character varying(20) COLLATE public.nocase,
    origin_stamp character varying(20) COLLATE public.nocase,
    inward_app character varying(20) COLLATE public.nocase,
    outward_app character varying(20) COLLATE public.nocase,
    centr_declared character varying(20) COLLATE public.nocase,
    taxcls_usage character varying(20) COLLATE public.nocase,
    centdecholevel character varying(20) COLLATE public.nocase,
    tax_credliab character varying(20) COLLATE public.nocase,
    autogentaxinv character varying(20) COLLATE public.nocase,
    clsdoctype character varying(20) COLLATE public.nocase,
    txdocno_sal character varying(20) COLLATE public.nocase,
    tax_adj_app_re character varying(80) COLLATE public.nocase,
    implement_date timestamp without time zone,
    availinpcronrecon character varying(20) COLLATE public.nocase,
    fueltaxcreditappl character varying(20) COLLATE public.nocase,
    tax_settl_process_cdtyp character varying(20) COLLATE public.nocase,
    location_reg_map character varying(20) COLLATE public.nocase,
    ewb_app character varying(80) COLLATE public.nocase,
    abatement_app character varying(80) COLLATE public.nocase,
    sametxrgfrdeptxtp character varying(20) COLLATE public.nocase,
    autogentaxadjvch character varying(20) COLLATE public.nocase,
    ret1_applicability_date timestamp without time zone,
    isd_app character varying(80) COLLATE public.nocase,
    dta_app character varying(30) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    CONSTRAINT raw_tset_tax_community_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_tset_tax_community
    OWNER to proconnect;