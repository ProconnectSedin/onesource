-- Table: raw.raw_cust_addr_dtl

-- DROP TABLE IF EXISTS "raw".raw_cust_addr_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_cust_addr_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    addr_lo character varying(80) COLLATE public.nocase NOT NULL,
    addr_cust_code character varying(72) COLLATE public.nocase NOT NULL,
    addr_lineno integer NOT NULL,
    addr_created_ou integer NOT NULL,
    addr_address_id character varying(24) COLLATE public.nocase NOT NULL,
    addr_addrline1 character varying(400) COLLATE public.nocase,
    addr_addrline2 character varying(160) COLLATE public.nocase,
    addr_addrline3 character varying(160) COLLATE public.nocase,
    addr_city character varying(160) COLLATE public.nocase,
    addr_state character varying(160) COLLATE public.nocase,
    addr_country character(20) COLLATE public.nocase,
    addr_zip character varying(80) COLLATE public.nocase,
    addr_phone1 character varying(1020) COLLATE public.nocase,
    addr_phone2 character varying(1020) COLLATE public.nocase,
    addr_email character varying(1020) COLLATE public.nocase,
    addr_fax character varying(1020) COLLATE public.nocase,
    addr_inco_term character varying(60) COLLATE public.nocase,
    addr_inco_place_air character varying(160) COLLATE public.nocase,
    addr_inco_place_road character varying(160) COLLATE public.nocase,
    addr_inco_place_rail character varying(160) COLLATE public.nocase,
    addr_inco_place_ship character varying(160) COLLATE public.nocase,
    addr_del_area_code character varying(72) COLLATE public.nocase NOT NULL,
    addr_created_by character varying(120) COLLATE public.nocase NOT NULL,
    addr_created_date timestamp without time zone NOT NULL,
    addr_modified_by character varying(120) COLLATE public.nocase NOT NULL,
    addr_modified_date timestamp without time zone NOT NULL,
    addr_addnl1 character varying(1020) COLLATE public.nocase,
    addr_addnl2 character varying(1020) COLLATE public.nocase,
    addr_addnl3 integer,
    addr_hobranchcode character varying(80) COLLATE public.nocase,
    addr_latitude numeric,
    addr_longitude numeric,
    addr_cust_name character varying(160) COLLATE public.nocase,
    addr_status character varying(100) COLLATE public.nocase,
    addr_reasoncode character varying(20) COLLATE public.nocase,
    addr_name character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_cust_addr_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_cust_addr_dtl
    OWNER to proconnect;