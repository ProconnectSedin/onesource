-- Table: dwh.f_custtdsinfo

-- DROP TABLE IF EXISTS dwh.f_custtdsinfo;

CREATE TABLE IF NOT EXISTS dwh.f_custtdsinfo
(
    custtdsinfo_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    comp_code_key bigint,
    ctds_lo character varying(40) COLLATE public.nocase,
    ctds_comp_code character varying(20) COLLATE public.nocase,
    ctds_cust_code character varying(36) COLLATE public.nocase,
    ctds_tax_type character varying(50) COLLATE public.nocase,
    ctds_tax_community character varying(50) COLLATE public.nocase,
    ctds_tax_option character varying(80) COLLATE public.nocase,
    ctds_serial_no integer,
    ctds_assessee_type character varying(80) COLLATE public.nocase,
    ctds_region_type character varying(50) COLLATE public.nocase,
    ctds_region_code character varying(20) COLLATE public.nocase,
    ctds_regd_no character varying(80) COLLATE public.nocase,
    ctds_category_code character varying(80) COLLATE public.nocase,
    ctds_class_code character varying(80) COLLATE public.nocase,
    ctds_default character varying(10) COLLATE public.nocase,
    ctds_taxrate_appl character varying(80) COLLATE public.nocase,
    ctds_special_rate numeric(13,2),
    ctds_dateof_issue timestamp without time zone,
    ctds_valid_upto timestamp without time zone,
    ctds_remarks character varying(512) COLLATE public.nocase,
    ctds_created_by character varying(60) COLLATE public.nocase,
    ctds_created_date timestamp without time zone,
    ctds_modified_by character varying(60) COLLATE public.nocase,
    ctds_modified_date timestamp without time zone,
    pan_no character varying(510) COLLATE public.nocase,
    aadhaar_no character varying(510) COLLATE public.nocase,
    tax_status character varying(510) COLLATE public.nocase,
    return_frequency character varying(510) COLLATE public.nocase,
    tax_regno_status character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_custtdsinfo_pkey PRIMARY KEY (custtdsinfo_key),
    CONSTRAINT f_custtdsinfo_ukey UNIQUE (ctds_lo, ctds_comp_code, ctds_cust_code, ctds_tax_type, ctds_tax_community, ctds_serial_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_custtdsinfo
    OWNER to proconnect;
-- Index: f_custtdsinfo_key_idx

-- DROP INDEX IF EXISTS dwh.f_custtdsinfo_key_idx;

CREATE INDEX IF NOT EXISTS f_custtdsinfo_key_idx
    ON dwh.f_custtdsinfo USING btree
    (ctds_lo COLLATE public.nocase ASC NULLS LAST, ctds_comp_code COLLATE public.nocase ASC NULLS LAST, ctds_cust_code COLLATE public.nocase ASC NULLS LAST, ctds_tax_type COLLATE public.nocase ASC NULLS LAST, ctds_tax_community COLLATE public.nocase ASC NULLS LAST, ctds_serial_no ASC NULLS LAST)
    TABLESPACE pg_default;