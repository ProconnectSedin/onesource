CREATE TABLE dwh.f_tbpvoucherhdr (
    tbpvoucherhdr_key bigint NOT NULL,
    company_key bigint NOT NULL,
    current_key character varying(300) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    component_name character varying(40) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    fb_voucher_no character varying(40) COLLATE public.nocase,
    s_timestamp integer,
    tran_type character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    fb_voucher_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);