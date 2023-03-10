CREATE TABLE raw.raw_kdx_lead_header (
    raw_id bigint NOT NULL,
    kdx_ou integer NOT NULL,
    kdx_projectno character varying(72) NOT NULL COLLATE public.nocase,
    kdx_projdesc character varying(600) COLLATE public.nocase,
    kdx_num_type character varying(40) COLLATE public.nocase,
    kdx_custcode character varying(72) COLLATE public.nocase,
    kdx_sptype character varying(24) COLLATE public.nocase,
    kdx_addr_id character varying(24) COLLATE public.nocase,
    kdx_expord_date timestamp without time zone,
    kdx_expdel_date timestamp without time zone,
    kdx_eststart_date timestamp without time zone,
    kdx_estend_date timestamp without time zone,
    kdx_potord_value numeric,
    kdx_main_prod character varying(24) COLLATE public.nocase,
    kdx_prod_qty numeric,
    kdx_software character varying(24) COLLATE public.nocase,
    kdx_proj_stat character varying(24) COLLATE public.nocase,
    kdx_reason character varying(24) COLLATE public.nocase,
    kdx_reason_det character varying(4000) COLLATE public.nocase,
    kdx_salesper_code character varying(24) COLLATE public.nocase,
    kdx_ir_cost numeric,
    kdx_salesteam_code character varying(24) COLLATE public.nocase,
    kdx_prob_success character varying(24) COLLATE public.nocase,
    kdx_enq_type character varying(24) COLLATE public.nocase,
    kdx_int_type character varying(24) COLLATE public.nocase,
    kdx_campaign character varying(4000) COLLATE public.nocase,
    kdx_created_by character varying(120) COLLATE public.nocase,
    kdx_creatndt timestamp without time zone NOT NULL,
    kdx_edited_by character varying(120) COLLATE public.nocase,
    kdx_lstmoddt timestamp without time zone,
    kdx_timestamp integer,
    kdx_cost_center character varying(128) COLLATE public.nocase,
    kdx_currencycode character(20) COLLATE public.nocase,
    kdx_geography character varying(32) COLLATE public.nocase,
    kdx_lead_in_charge character varying(80) COLLATE public.nocase,
    kdx_line_of_business character varying(32) COLLATE public.nocase,
    kdx_solution_center character varying(32) COLLATE public.nocase,
    kdx_checklistcode character varying(72) COLLATE public.nocase,
    kdx_partner_code character varying(72) COLLATE public.nocase,
    kdx_proj_amendmnt_no integer,
    kdx_proj_review_no character varying(72) COLLATE public.nocase,
    kdx_proj_review_date timestamp without time zone,
    opp_preferences character varying(1020) COLLATE public.nocase,
    opp_potential_budg character varying(1020) COLLATE public.nocase,
    opp_remarks character varying(1020) COLLATE public.nocase,
    opp_accountid character varying(72) COLLATE public.nocase,
    lost_case_details character varying(1020) COLLATE public.nocase,
    channel_partner_details character varying(1020) COLLATE public.nocase,
    expected_purchase_time_range character varying(1020) COLLATE public.nocase,
    kdx_stage character varying(1020) COLLATE public.nocase,
    kdx_catagory character varying(1020) COLLATE public.nocase,
    kdx_prj_type character varying(1020) COLLATE public.nocase,
    kdx_pri_opp_oppid character varying(72) COLLATE public.nocase,
    kdx_estimated_revenue numeric,
    kdx_priority character varying(1020) COLLATE public.nocase,
    kdx_disq_resn character varying(80) COLLATE public.nocase,
    kdx_can_resn character varying(80) COLLATE public.nocase,
    kdx_group_remarks character varying(1020) COLLATE public.nocase,
    kdx_segment character varying(80) COLLATE public.nocase,
    kdx_industry character varying(80) COLLATE public.nocase,
    kdx_add_disqual_rem character varying(1020) COLLATE public.nocase,
    kdx_add_cancel_rem character varying(1020) COLLATE public.nocase,
    kdx_opp_est_status character varying(80) COLLATE public.nocase,
    kdx_comp_count integer,
    kdx_single_comp character varying(160) COLLATE public.nocase,
    kdx_emp_code character varying(80) COLLATE public.nocase,
    kdx_est_potential_qty numeric,
    kdx_lead_category character varying(160) COLLATE public.nocase,
    kdx_customer_name character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_kdx_lead_header ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_kdx_lead_header_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_kdx_lead_header
    ADD CONSTRAINT raw_kdx_lead_header_pkey PRIMARY KEY (raw_id);