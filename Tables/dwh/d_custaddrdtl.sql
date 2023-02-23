-- Table: dwh.d_custaddrdtl

-- DROP TABLE IF EXISTS dwh.d_custaddrdtl;

CREATE TABLE IF NOT EXISTS dwh.d_custaddrdtl
(
    custaddrdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    addr_lo character varying(40) COLLATE public.nocase,
    addr_cust_code character varying(36) COLLATE public.nocase,
    addr_lineno integer,
    addr_created_ou integer,
    addr_address_id character varying(12) COLLATE public.nocase,
    addr_addrline1 character varying(200) COLLATE public.nocase,
    addr_addrline2 character varying(80) COLLATE public.nocase,
    addr_addrline3 character varying(80) COLLATE public.nocase,
    addr_city character varying(80) COLLATE public.nocase,
    addr_state character varying(80) COLLATE public.nocase,
    addr_country character(10) COLLATE pg_catalog."default",
    addr_zip character varying(40) COLLATE public.nocase,
    addr_phone1 character varying(510) COLLATE public.nocase,
    addr_phone2 character varying(510) COLLATE public.nocase,
    addr_email character varying(510) COLLATE public.nocase,
    addr_fax character varying(510) COLLATE public.nocase,
    addr_inco_term character varying(30) COLLATE public.nocase,
    addr_del_area_code character varying(36) COLLATE public.nocase,
    addr_created_by character varying(60) COLLATE public.nocase,
    addr_created_date timestamp without time zone,
    addr_modified_by character varying(60) COLLATE public.nocase,
    addr_modified_date timestamp without time zone,
    addr_hobranchcode character varying(40) COLLATE public.nocase,
    addr_status character varying(50) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_custaddrdtl_pkey PRIMARY KEY (custaddrdtl_key),
    CONSTRAINT d_custaddrdtl_ukey UNIQUE (addr_lo, addr_cust_code, addr_lineno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_custaddrdtl
    OWNER to proconnect;