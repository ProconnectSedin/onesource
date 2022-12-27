CREATE TABLE raw.raw_spy_paybatch_hdr (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    paybatch_no character varying(72) NOT NULL COLLATE public.nocase,
    ptimestamp integer NOT NULL,
    paybatch_notype character varying(40) COLLATE public.nocase,
    voucher_notype character varying(40) COLLATE public.nocase,
    request_date timestamp without time zone,
    pay_date timestamp without time zone,
    payment_route character varying(40) COLLATE public.nocase,
    elect_payment character varying(80) COLLATE public.nocase,
    pay_mode character varying(100) COLLATE public.nocase,
    paygroup_no character varying(40) COLLATE public.nocase,
    relpay_ou character varying(64) COLLATE public.nocase,
    pay_chargeby character varying(64) COLLATE public.nocase,
    priority character varying(48) COLLATE public.nocase,
    fb_id character varying(80) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    pay_currency character varying(20) COLLATE public.nocase,
    basecur_erate numeric,
    tran_type character varying(100) COLLATE public.nocase,
    remarks character varying(1020) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    doc_status character varying(48) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    unadjppchk_flag character varying(48) COLLATE public.nocase,
    consistency_stamp character varying(48) COLLATE public.nocase,
    workflow_status character varying(80) COLLATE public.nocase,
    bankcurrency character varying(20) COLLATE public.nocase,
    crosscur_erate numeric,
    bank_amount numeric,
    bank_base_amount numeric,
    unadjdebitchk_flag character varying(48) COLLATE public.nocase,
    ict_flag character varying(48) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    supplier_group character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_spy_paybatch_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_spy_paybatch_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_spy_paybatch_hdr
    ADD CONSTRAINT raw_spy_paybatch_hdr_pkey PRIMARY KEY (raw_id);