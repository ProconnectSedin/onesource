CREATE TABLE stg.stg_cust_group_hdr (
    cgh_lo character varying(80) NOT NULL COLLATE public.nocase,
    cgh_bu character varying(80) NOT NULL COLLATE public.nocase,
    cgh_cust_group_code character varying(24) NOT NULL COLLATE public.nocase,
    cgh_control_group_flag character varying(32) NOT NULL COLLATE public.nocase,
    cgh_group_type_code character varying(20) NOT NULL COLLATE public.nocase,
    cgh_created_at integer NOT NULL,
    cgh_cust_group_desc character varying(160) NOT NULL COLLATE public.nocase,
    cgh_cust_group_desc_shd character varying(160) NOT NULL COLLATE public.nocase,
    cgh_reason_code character varying(20) COLLATE public.nocase,
    cgh_status character varying(32) NOT NULL COLLATE public.nocase,
    cgh_prev_status character varying(32) NOT NULL COLLATE public.nocase,
    cgh_created_by character varying(120) NOT NULL COLLATE public.nocase,
    cgh_created_date timestamp without time zone NOT NULL,
    cgh_modified_by character varying(120) NOT NULL COLLATE public.nocase,
    cgh_modified_date timestamp without time zone NOT NULL,
    cgh_timestamp_value integer NOT NULL,
    cgh_addnl1 integer,
    cgh_addnl2 character varying(1020) COLLATE public.nocase,
    cgh_addnl3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_cust_group_hdr
    ADD CONSTRAINT cust_group_hdr_pk PRIMARY KEY (cgh_lo, cgh_cust_group_code, cgh_control_group_flag, cgh_group_type_code);