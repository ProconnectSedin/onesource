CREATE TABLE dwh.d_customerouinfo (
    cou_key bigint NOT NULL,
    cou_lo character varying(40) COLLATE public.nocase,
    cou_bu character varying(40) COLLATE public.nocase,
    cou_ou integer,
    cou_cust_code character varying(40) COLLATE public.nocase,
    cou_dflt_billto_id character varying(20) COLLATE public.nocase,
    cou_dflt_shipto_id character varying(20) COLLATE public.nocase,
    cou_order_from_id character varying(20) COLLATE public.nocase,
    cou_dflt_billto_cust character varying(40) COLLATE public.nocase,
    cou_dflt_shipto_cust character varying(40) COLLATE public.nocase,
    cou_dflt_pricelist character varying(20) COLLATE public.nocase,
    cou_dflt_ship_pt integer,
    cou_language character varying(100) COLLATE public.nocase,
    cou_transport_mode character varying(20) COLLATE public.nocase,
    cou_sales_chnl character varying(20) COLLATE public.nocase,
    cou_order_type character varying(20) COLLATE public.nocase,
    cou_process_actn character varying(20) COLLATE public.nocase,
    cou_partshp_flag character varying(20) COLLATE public.nocase,
    cou_freight_term character varying(20) COLLATE public.nocase,
    cou_prfrd_carrier character varying(40) COLLATE public.nocase,
    cou_secstk_flag character varying(20) COLLATE public.nocase,
    cou_cons_sales character varying(20) COLLATE public.nocase,
    cou_cons_bill character varying(20) COLLATE public.nocase,
    cou_trnshp_flag character varying(20) COLLATE public.nocase,
    cou_inv_appl_flag character varying(20) COLLATE public.nocase,
    cou_auto_invauth_flag character varying(20) COLLATE public.nocase,
    cou_frtbillable_flag character varying(20) COLLATE public.nocase,
    cou_no_of_invcopies integer,
    cou_elgble_for_rebate character varying(20) COLLATE public.nocase,
    cou_reason_code character varying(20) COLLATE public.nocase,
    cou_cr_status character varying(20) COLLATE public.nocase,
    cou_status character varying(20) COLLATE public.nocase,
    cou_prev_status character varying(20) COLLATE public.nocase,
    cou_created_by character varying(100) COLLATE public.nocase,
    cou_created_date timestamp without time zone,
    cou_modified_by character varying(100) COLLATE public.nocase,
    cou_modified_date timestamp without time zone,
    cou_timestamp_value integer,
    cou_company_code character varying(20) COLLATE public.nocase,
    cou_cust_priority character varying(40) COLLATE public.nocase,
    cou_sales_person character varying(20) COLLATE public.nocase,
    cou_cust_frequency character varying(20) COLLATE public.nocase,
    cou_wf_status character varying(100) COLLATE public.nocase,
    cou_revision_no integer,
    cou_trade_type character varying(100) COLLATE public.nocase,
    cou_frt_appl character varying(100) COLLATE public.nocase,
    cou_cust_category character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_customerouinfo ALTER COLUMN cou_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_customerouinfo_cou_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_customerouinfo
    ADD CONSTRAINT d_customerouinfo_pkey PRIMARY KEY (cou_key);

ALTER TABLE ONLY dwh.d_customerouinfo
    ADD CONSTRAINT d_customerouinfo_ukey UNIQUE (cou_cust_code, cou_lo, cou_bu, cou_ou);