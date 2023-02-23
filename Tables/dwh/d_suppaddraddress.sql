-- Table: dwh.d_suppaddraddress

-- DROP TABLE IF EXISTS dwh.d_suppaddraddress;

CREATE TABLE IF NOT EXISTS dwh.d_suppaddraddress
(
    suppaddraddress_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_addr_loid character varying(40) COLLATE public.nocase,
    supp_addr_supcode character varying(32) COLLATE public.nocase,
    supp_addr_addid character varying(12) COLLATE public.nocase,
    supp_addr_contperson character varying(90) COLLATE public.nocase,
    supp_addr_contperson_shd character varying(90) COLLATE public.nocase,
    supp_addr_address1 character varying(300) COLLATE public.nocase,
    supp_addr_address2 character varying(300) COLLATE public.nocase,
    supp_addr_address3 character varying(300) COLLATE public.nocase,
    supp_addr_city character varying(80) COLLATE public.nocase,
    supp_addr_state character varying(80) COLLATE public.nocase,
    supp_addr_country character varying(80) COLLATE public.nocase,
    supp_addr_zip character varying(40) COLLATE public.nocase,
    supp_addr_fax character varying(80) COLLATE public.nocase,
    supp_addr_phone character varying(40) COLLATE public.nocase,
    supp_addr_email character varying(510) COLLATE public.nocase,
    supp_addr_createdby character varying(60) COLLATE public.nocase,
    supp_addr_createdate timestamp without time zone,
    supp_addr_modifiedby character varying(60) COLLATE public.nocase,
    supp_addr_modifieddate timestamp without time zone,
    supp_addr_mobileno character varying(40) COLLATE public.nocase,
    supp_addr_countrycode character varying(80) COLLATE public.nocase,
    supp_addr_statedesc character varying(80) COLLATE public.nocase,
    supp_addr_hobranchcode character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_suppaddraddress_pkey PRIMARY KEY (suppaddraddress_key),
    CONSTRAINT d_suppaddraddress_ukey UNIQUE (supp_addr_loid, supp_addr_supcode, supp_addr_addid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_suppaddraddress
    OWNER to proconnect;