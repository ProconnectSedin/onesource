CREATE TABLE stg.stg_wms_draft_bill_hdr (
    wms_draft_bill_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_draft_bill_ou integer NOT NULL,
    wms_draft_bill_location character varying(40) COLLATE public.nocase,
    wms_draft_bill_division character varying(40) COLLATE public.nocase,
    wms_draft_bill_date timestamp without time zone,
    wms_draft_bill_status character varying(32) COLLATE public.nocase,
    wms_draft_bill_contract_id character varying(72) COLLATE public.nocase,
    wms_draft_bill_cust_cont_ref_no character varying(280) COLLATE public.nocase,
    wms_draft_bill_customer character varying(72) COLLATE public.nocase,
    wms_draft_bill_supplier character varying(64) COLLATE public.nocase,
    wms_draft_bill_currency character(20) COLLATE public.nocase,
    wms_draft_bill_cost_centre character varying(40) COLLATE public.nocase,
    wms_draft_bill_value numeric,
    wms_draft_bill_discount numeric,
    wms_draft_bill_total_value numeric,
    wms_draft_bill_inv_no character varying(72) COLLATE public.nocase,
    wms_draft_bill_inv_date timestamp without time zone,
    wms_draft_bill_inv_status character varying(32) COLLATE public.nocase,
    wms_draft_bill_timestamp integer,
    wms_draft_bill_created_by character varying(120) COLLATE public.nocase,
    wms_draft_bill_created_date timestamp without time zone,
    wms_draft_bill_modified_by character varying(120) COLLATE public.nocase,
    wms_draft_bill_modified_date timestamp without time zone,
    wms_draft_bill_contract_amend_no integer,
    wms_draft_bill_tran_type character varying(32) COLLATE public.nocase,
    wms_draft_bill_margin numeric,
    wms_draft_bill_gen_from character varying(100) COLLATE public.nocase,
    wms_draft_bill_booking_location character varying(40) COLLATE public.nocase,
    wms_draft_bill_period_from timestamp without time zone,
    wms_draft_bill_period_to timestamp without time zone,
    wms_draft_bill_remarks character varying(1020) COLLATE public.nocase,
    wms_draft_bill_workflow_status character varying(1020) COLLATE public.nocase,
    wms_draft_bill_reason_for_return character varying(1020) COLLATE public.nocase,
    wms_draft_bill_grp character varying(160) COLLATE public.nocase,
    wms_draft_bill_type character varying(1020) COLLATE public.nocase,
    wms_draft_bill_br_remittance_yn character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);