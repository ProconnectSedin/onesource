CREATE TABLE raw.raw_jv_voucher_trn_hdr (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    voucher_no character varying(72) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    voucher_type character varying(80) COLLATE public.nocase,
    voucher_date timestamp without time zone,
    numbering_type character varying(40) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    ref_voucher_no character varying(72) COLLATE public.nocase,
    ref_voucher_type character varying(80) COLLATE public.nocase,
    rev_year character varying(40) COLLATE public.nocase,
    rev_period character varying(40) COLLATE public.nocase,
    control_total numeric,
    remarks character varying(1024) COLLATE public.nocase,
    recvchrtemp_no character varying(72) COLLATE public.nocase,
    voucher_status character varying(100) COLLATE public.nocase,
    converted_flag character varying(4) COLLATE public.nocase,
    authorised_by character varying(120) COLLATE public.nocase,
    authorised_date timestamp without time zone,
    base_amount numeric,
    component_id character varying(80) COLLATE public.nocase,
    doc_status character varying(48) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    tcal_exclusive_amt numeric,
    total_tcal_amount numeric,
    tcal_status character varying(48) COLLATE public.nocase,
    auto_gen_flag character varying(48) COLLATE public.nocase,
    source_fbid character varying(80) COLLATE public.nocase,
    source_tran_no character varying(72) COLLATE public.nocase,
    source_tran_ou character varying(80) COLLATE public.nocase,
    source_tran_type character varying(160) COLLATE public.nocase,
    source_tran_date timestamp without time zone,
    workflow_status character varying(80) COLLATE public.nocase,
    project_ou integer,
    project_code character varying(280) COLLATE public.nocase,
    afe_number character varying(72) COLLATE public.nocase,
    job_number character varying(72) COLLATE public.nocase,
    costcenter_hdr character varying(40) COLLATE public.nocase,
    revsal_date timestamp without time zone,
    voucher_sub_type character varying(80) COLLATE public.nocase,
    rev_remarks character varying(1020) COLLATE public.nocase,
    proposal_number character varying(1020) COLLATE public.nocase,
    ifb_usage character varying(160) COLLATE public.nocase,
    ifb_remarks character varying(400) COLLATE public.nocase,
    action_typ character varying(160) COLLATE public.nocase,
    ifb_tran_no character varying(72) COLLATE public.nocase,
    ifb_tran_ou integer,
    ifb_tran_type character varying(160) COLLATE public.nocase,
    writeoff_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_jv_voucher_trn_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_jv_voucher_trn_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_jv_voucher_trn_hdr
    ADD CONSTRAINT raw_jv_voucher_trn_hdr_pkey PRIMARY KEY (raw_id);