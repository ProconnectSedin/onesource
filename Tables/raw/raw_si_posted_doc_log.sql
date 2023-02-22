
CREATE TABLE IF NOT EXISTS "raw".raw_si_posted_doc_log
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_ou integer,
    tran_type character varying(20) COLLATE public.nocase,
    tran_no character varying(36) COLLATE public.nocase,
    term_no character varying(40) COLLATE public.nocase,
    amt_type character varying(50) COLLATE public.nocase,
    dr_doc_ou integer,
    dr_doc_type character varying(20) COLLATE public.nocase,
    dr_doc_no character varying(36) COLLATE public.nocase,
    cr_doc_ou integer,
    cr_doc_type character varying(20) COLLATE public.nocase,
    cr_doc_no character varying(36) COLLATE public.nocase,
    cr_doc_term character varying(40) COLLATE public.nocase,
    dr_doc_term character varying(40) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    tran_date timestamp without time zone,
    supplier_code character varying(32) COLLATE public.nocase,
    tran_currency character varying(10) COLLATE public.nocase,
    tran_amount numeric(20,2),
    exchange_rate numeric(20,2),
    basecur_erate numeric(20,2),
    par_exchange_rate numeric(20,2),
    par_base_amount numeric(20,2),
    posting_status character varying(10) COLLATE public.nocase,
    posting_date timestamp without time zone,
    batch_id character varying(256) COLLATE public.nocase,
    cross_curr_erate numeric(20,2),
    base_amount numeric(20,2),
    createdby character varying(120) COLLATE pg_catalog."default",
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE pg_catalog."default",
    modifieddate timestamp without time zone,
    account_code character varying(64) COLLATE public.nocase,
    account_type character varying(30) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    paid_amt numeric(20,2),
    requested_amt numeric(20,2),
    discount_amt numeric(20,2),
    penalty_amount numeric(20,2),
    adjusted_amount numeric(20,2),
    disc_availed numeric(20,2),
    check_no character varying(60) COLLATE public.nocase,
    base_adjusted_amount numeric(20,2),
    pbase_adjusted_amount numeric(20,2),
    log_pdc_flag character varying(24) COLLATE public.nocase,
    pdc_void_flag character varying(24) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone
)