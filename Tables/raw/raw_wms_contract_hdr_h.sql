CREATE TABLE raw.raw_wms_contract_hdr_h (
    raw_id bigint NOT NULL,
    wms_cont_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_cont_ou integer NOT NULL,
    wms_cont_amendno integer NOT NULL,
    wms_cont_desc character varying(1020) COLLATE public.nocase,
    wms_cont_date timestamp without time zone,
    wms_cont_type character varying(32) COLLATE public.nocase,
    wms_cont_status character varying(32) COLLATE public.nocase,
    wms_cont_rsn_code character varying(160) COLLATE public.nocase,
    wms_cont_service_type character varying(160) COLLATE public.nocase,
    wms_cont_valid_from timestamp without time zone,
    wms_cont_valid_to timestamp without time zone,
    wms_cont_cust_contract_ref_no character varying(280) COLLATE public.nocase,
    wms_cont_customer_id character varying(72) COLLATE public.nocase,
    wms_cont_supp_contract_ref_no character varying(280) COLLATE public.nocase,
    wms_cont_vendor_id character varying(64) COLLATE public.nocase,
    wms_cont_ref_doc_type character varying(32) COLLATE public.nocase,
    wms_cont_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_cont_bill_freq character varying(32) COLLATE public.nocase,
    wms_cont_bill_date_day character varying(32) COLLATE public.nocase,
    wms_cont_billing_stage character varying(32) COLLATE public.nocase,
    wms_cont_currency character(20) COLLATE public.nocase,
    wms_cont_exchange_rate numeric,
    wms_cont_bulk_rate_chg_per numeric,
    wms_cont_division character varying(40) COLLATE public.nocase,
    wms_cont_location character varying(40) COLLATE public.nocase,
    wms_cont_remarks character varying(1020) COLLATE public.nocase,
    wms_cont_slab_type character varying(32) COLLATE public.nocase,
    wms_cont_timestamp integer,
    wms_cont_created_by character varying(120) COLLATE public.nocase,
    wms_cont_created_dt timestamp without time zone,
    wms_cont_modified_by character varying(120) COLLATE public.nocase,
    wms_cont_modified_dt timestamp without time zone,
    wms_cont_space_last_bill_dt timestamp without time zone,
    wms_cont_payment_type character varying(160) COLLATE public.nocase,
    wms_cont_std_cont_portal integer,
    wms_cont_vendor_group character varying(160) COLLATE public.nocase,
    wms_cont_cust_grp character varying(1020) COLLATE public.nocase,
    wms_cont_lag_time numeric,
    wms_cont_lag_time_uom character varying(32) COLLATE public.nocase,
    wms_cont_non_billable integer,
    wms_non_billable_chk integer,
    wms_cont_last_day character varying(32) COLLATE public.nocase,
    wms_cont_div_loc_cust integer,
    wms_cont_numbering_type character varying(40) COLLATE public.nocase,
    wms_cont_workflow_status character varying(1020) COLLATE public.nocase,
    wms_cont_reason_for_return character varying(1020) COLLATE public.nocase,
    wms_min_weight numeric,
    wms_volm_conversion numeric,
    wms_cont_plan_difot character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_contract_hdr_h ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_contract_hdr_h_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_contract_hdr_h
    ADD CONSTRAINT raw_wms_contract_hdr_h_pkey PRIMARY KEY (raw_id);