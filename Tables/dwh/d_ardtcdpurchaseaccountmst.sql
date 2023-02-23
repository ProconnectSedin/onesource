-- Table: dwh.d_ardtcdpurchaseaccountmst

-- DROP TABLE IF EXISTS dwh.d_ardtcdpurchaseaccountmst;

CREATE TABLE IF NOT EXISTS dwh.d_ardtcdpurchaseaccountmst
(
    ard_tcd_pur_acct_mst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    tcd_code character varying(20) COLLATE public.nocase,
    effective_from timestamp without time zone,
    tcd_vrnt character varying(20) COLLATE public.nocase,
    drcr_flag character varying(8) COLLATE public.nocase,
    supplier_group character varying(40) COLLATE public.nocase,
    gr_ouid integer,
    gr_type character varying(50) COLLATE public.nocase,
    gr_folder character varying(80) COLLATE public.nocase,
    trans_mode character varying(50) COLLATE public.nocase,
    num_series character varying(20) COLLATE public.nocase,
    tcd_class character varying(40) COLLATE public.nocase,
    event character varying(8) COLLATE public.nocase,
    tcd_type character varying(8) COLLATE public.nocase,
    sequence_no integer,
    "timestamp" integer,
    account_code character varying(64) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ardtcdpurchaseaccountmst_pkey PRIMARY KEY (ard_tcd_pur_acct_mst_key),
    CONSTRAINT d_ardtcdpurchaseaccountmst_ukey UNIQUE (company_code, fb_id, tcd_code, effective_from, tcd_vrnt, drcr_flag, supplier_group, gr_ouid, gr_type, gr_folder, trans_mode, num_series, tcd_class, event, tcd_type, sequence_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ardtcdpurchaseaccountmst
    OWNER to proconnect;