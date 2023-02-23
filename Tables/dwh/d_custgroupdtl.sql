-- Table: dwh.d_custgroupdtl

-- DROP TABLE IF EXISTS dwh.d_custgroupdtl;

CREATE TABLE IF NOT EXISTS dwh.d_custgroupdtl
(
    custgroupdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cgd_lo character varying(40) COLLATE public.nocase,
    cgd_bu character varying(40) COLLATE public.nocase,
    cgd_control_group_flag character varying(120) COLLATE public.nocase,
    cgd_group_type_code character varying(10) COLLATE public.nocase,
    cgd_cust_group_code character varying(20) COLLATE public.nocase,
    cgd_line_no integer,
    cgd_customer_code character varying(40) COLLATE public.nocase,
    cgd_created_by character varying(60) COLLATE public.nocase,
    cgd_created_date timestamp without time zone,
    cgd_modified_by character varying(60) COLLATE public.nocase,
    cgd_modified_date timestamp without time zone,
    cgd_addnl1 character varying(510) COLLATE public.nocase,
    cgd_addnl2 character varying(510) COLLATE public.nocase,
    cgd_addnl3 integer,
    cgd_company_code character varying(20) COLLATE public.nocase,
    cgd_created_ou integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_custgroupdtl_pkey PRIMARY KEY (custgroupdtl_key),
    CONSTRAINT d_custgroupdtl_ukey UNIQUE (cgd_lo, cgd_bu, cgd_control_group_flag, cgd_group_type_code, cgd_cust_group_code, cgd_line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_custgroupdtl
    OWNER to proconnect;