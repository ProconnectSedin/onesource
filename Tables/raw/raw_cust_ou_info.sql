CREATE TABLE raw.raw_cust_ou_info (
    raw_id bigint NOT NULL,
    cou_lo character varying(80) NOT NULL COLLATE public.nocase,
    cou_bu character varying(80) NOT NULL COLLATE public.nocase,
    cou_ou integer NOT NULL,
    cou_cust_code character varying(72) NOT NULL COLLATE public.nocase,
    cou_dflt_billto_id character varying(24) COLLATE public.nocase,
    cou_dflt_shipto_id character varying(24) COLLATE public.nocase,
    cou_order_from_id character varying(24) COLLATE public.nocase,
    cou_dflt_billto_cust character varying(72) COLLATE public.nocase,
    cou_dflt_shipto_cust character varying(72) COLLATE public.nocase,
    cou_dflt_pricelist character varying(40) COLLATE public.nocase,
    cou_dflt_ship_pt integer,
    cou_language character varying(100) COLLATE public.nocase,
    cou_transport_mode character varying(20) COLLATE public.nocase,
    cou_sales_chnl character varying(20) COLLATE public.nocase,
    cou_order_type character varying(32) NOT NULL COLLATE public.nocase,
    cou_process_actn character varying(32) COLLATE public.nocase,
    cou_partshp_flag character varying(32) NOT NULL COLLATE public.nocase,
    cou_freight_term character varying(20) COLLATE public.nocase,
    cou_prfrd_carrier character varying(80) COLLATE public.nocase,
    cou_secstk_flag character varying(32) COLLATE public.nocase,
    cou_cons_sales character varying(32) COLLATE public.nocase,
    cou_cons_bill character varying(32) COLLATE public.nocase,
    cou_trnshp_flag character varying(32) COLLATE public.nocase,
    cou_inv_appl_flag character varying(32) NOT NULL COLLATE public.nocase,
    cou_auto_invauth_flag character varying(32) NOT NULL COLLATE public.nocase,
    cou_frtbillable_flag character varying(32) NOT NULL COLLATE public.nocase,
    cou_shiptol_pos integer,
    cou_shiptol_neg integer,
    cou_no_of_invcopies integer,
    cou_elgble_for_rebate character varying(32) COLLATE public.nocase,
    cou_reason_code character varying(20) COLLATE public.nocase,
    cou_penalrate_perc numeric,
    cou_shpment_delay_days integer,
    cou_cr_status character varying(32) COLLATE public.nocase,
    cou_status character varying(32) NOT NULL COLLATE public.nocase,
    cou_prev_status character varying(32) COLLATE public.nocase,
    cou_created_by character varying(120) NOT NULL COLLATE public.nocase,
    cou_created_date timestamp without time zone NOT NULL,
    cou_modified_by character varying(120) NOT NULL COLLATE public.nocase,
    cou_modified_date timestamp without time zone NOT NULL,
    cou_timestamp_value integer NOT NULL,
    cou_addnl1 character varying(1020) COLLATE public.nocase,
    cou_addnl2 character varying(1020) COLLATE public.nocase,
    cou_addnl3 integer,
    cou_company_code character varying(40) NOT NULL COLLATE public.nocase,
    cou_cust_priority character varying(80) COLLATE public.nocase,
    cou_sales_person character varying(24) COLLATE public.nocase,
    cou_templ_cust_code character varying(72) COLLATE public.nocase,
    cou_gen_from character varying(32) COLLATE public.nocase,
    cou_cust_loyalty character varying(20) COLLATE public.nocase,
    cou_cust_preference character varying(20) COLLATE public.nocase,
    cou_cust_frequency character varying(32) COLLATE public.nocase,
    cou_cust_cont_frequency character varying(80) COLLATE public.nocase,
    cou_cust_cont_preference character varying(80) COLLATE public.nocase,
    cou_wf_status character varying(100) COLLATE public.nocase,
    cou_revision_no integer DEFAULT 0 NOT NULL,
    cou_trade_type character varying(100) COLLATE public.nocase,
    cou_frt_appl character varying(160) COLLATE public.nocase,
    cou_cust_category character varying(60) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_cust_ou_info ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_cust_ou_info_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_cust_ou_info
    ADD CONSTRAINT raw_cust_ou_info_pkey PRIMARY KEY (raw_id);