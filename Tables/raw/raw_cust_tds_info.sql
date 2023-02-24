-- Table: raw.raw_cust_tds_info

-- DROP TABLE IF EXISTS "raw".raw_cust_tds_info;

CREATE TABLE IF NOT EXISTS "raw".raw_cust_tds_info
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ctds_lo character varying(80) COLLATE public.nocase NOT NULL,
    ctds_comp_code character varying(40) COLLATE public.nocase NOT NULL,
    ctds_cust_code character varying(72) COLLATE public.nocase NOT NULL,
    ctds_tax_type character varying(100) COLLATE public.nocase NOT NULL,
    ctds_tax_community character varying(100) COLLATE public.nocase NOT NULL,
    ctds_tax_option character varying(160) COLLATE public.nocase,
    ctds_serial_no integer NOT NULL,
    ctds_assessee_type character varying(160) COLLATE public.nocase,
    ctds_region_type character varying(100) COLLATE public.nocase,
    ctds_region_code character varying(40) COLLATE public.nocase,
    ctds_regd_no character varying(160) COLLATE public.nocase,
    ctds_category_code character varying(160) COLLATE public.nocase NOT NULL,
    ctds_class_code character varying(160) COLLATE public.nocase NOT NULL,
    ctds_default character(4) COLLATE public.nocase NOT NULL,
    ctds_taxrate_appl character varying(160) COLLATE public.nocase NOT NULL,
    ctds_tax_code character varying(40) COLLATE public.nocase,
    ctds_special_rate numeric,
    ctds_cert_no character varying(80) COLLATE public.nocase,
    ctds_placeof_issue character varying(100) COLLATE public.nocase,
    ctds_dateof_issue timestamp without time zone,
    ctds_valid_upto timestamp without time zone,
    ctds_remarks character varying(1024) COLLATE public.nocase,
    ctds_created_by character varying(120) COLLATE public.nocase NOT NULL,
    ctds_created_date timestamp without time zone NOT NULL,
    ctds_modified_by character varying(120) COLLATE public.nocase NOT NULL,
    ctds_modified_date timestamp without time zone NOT NULL,
    ctds_addnl1 character varying(1020) COLLATE public.nocase,
    ctds_addnl2 character varying(1020) COLLATE public.nocase,
    ctds_addnl3 integer,
    ctds_address_id character varying(24) COLLATE public.nocase,
    pan_no character varying(1020) COLLATE public.nocase,
    aadhaar_no character varying(1020) COLLATE public.nocase,
    tax_status character varying(1020) COLLATE public.nocase,
    return_frequency character varying(1020) COLLATE public.nocase,
    tax_regno_status character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_cust_tds_info_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_cust_tds_info
    OWNER to proconnect;