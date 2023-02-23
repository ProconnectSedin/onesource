-- Table: raw.raw_cust_group_dtl

-- DROP TABLE IF EXISTS "raw".raw_cust_group_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_cust_group_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cgd_lo character varying(80) COLLATE public.nocase NOT NULL,
    cgd_bu character varying(80) COLLATE public.nocase NOT NULL,
    cgd_control_group_flag character varying(32) COLLATE public.nocase NOT NULL,
    cgd_group_type_code character varying(20) COLLATE public.nocase NOT NULL,
    cgd_cust_group_code character varying(24) COLLATE public.nocase NOT NULL,
    cgd_line_no integer NOT NULL,
    cgd_customer_code character varying(72) COLLATE public.nocase NOT NULL,
    cgd_created_by character varying(120) COLLATE public.nocase NOT NULL,
    cgd_created_date timestamp without time zone NOT NULL,
    cgd_modified_by character varying(120) COLLATE public.nocase NOT NULL,
    cgd_modified_date timestamp without time zone NOT NULL,
    cgd_addnl1 character varying(1020) COLLATE public.nocase,
    cgd_addnl2 character varying(1020) COLLATE public.nocase,
    cgd_addnl3 integer,
    cgd_company_code character varying(40) COLLATE public.nocase NOT NULL,
    cgd_created_ou integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_cust_group_dtl_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_cust_group_dtl
    OWNER to proconnect;