-- Table: raw.raw_supp_addr_address

-- DROP TABLE IF EXISTS "raw".raw_supp_addr_address;

CREATE TABLE IF NOT EXISTS "raw".raw_supp_addr_address
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_addr_loid character varying(80) COLLATE public.nocase NOT NULL,
    supp_addr_supcode character varying(64) COLLATE public.nocase NOT NULL,
    supp_addr_addid character varying(24) COLLATE public.nocase NOT NULL,
    supp_addr_contperson character varying(180) COLLATE public.nocase,
    supp_addr_contperson_shd character varying(180) COLLATE public.nocase,
    supp_addr_address1 character varying(600) COLLATE public.nocase,
    supp_addr_address2 character varying(600) COLLATE public.nocase,
    supp_addr_address3 character varying(600) COLLATE public.nocase,
    supp_addr_city character varying(160) COLLATE public.nocase,
    supp_addr_state character varying(160) COLLATE public.nocase,
    supp_addr_country character varying(160) COLLATE public.nocase NOT NULL,
    supp_addr_zip character varying(80) COLLATE public.nocase,
    supp_addr_fax character varying(160) COLLATE public.nocase,
    supp_addr_phone character varying(80) COLLATE public.nocase,
    supp_addr_email character varying(1020) COLLATE public.nocase,
    supp_addr_createdby character varying(120) COLLATE public.nocase NOT NULL,
    supp_addr_createdate timestamp without time zone NOT NULL,
    supp_addr_modifiedby character varying(120) COLLATE public.nocase NOT NULL,
    supp_addr_modifieddate timestamp without time zone NOT NULL,
    supp_addr_mobileno character varying(80) COLLATE public.nocase,
    supp_addr_countrycode character varying(160) COLLATE public.nocase,
    supp_addr_statedesc character varying(160) COLLATE public.nocase,
    supp_addr_hobranchcode character varying(80) COLLATE public.nocase,
    supp_latitude numeric,
    supp_longitude numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_supp_addr_address_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_supp_addr_address
    OWNER to proconnect;