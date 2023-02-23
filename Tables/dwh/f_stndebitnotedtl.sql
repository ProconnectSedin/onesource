-- Table: dwh.f_stndebitnotedtl

-- DROP TABLE IF EXISTS dwh.f_stndebitnotedtl;

CREATE TABLE IF NOT EXISTS dwh.f_stndebitnotedtl
(
    stn_debit_note_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    stndebitnotedtl_vendor_key bigint NOT NULL,
    stndebitnotedtl_curr_key bigint NOT NULL,
    stndebitnotedtl_opcoa_key bigint NOT NULL,
    ou_id integer,
    trns_debit_note character varying(36) COLLATE public.nocase,
    tran_type character varying(20) COLLATE public.nocase,
    "timestamp" integer,
    notype_no character varying(20) COLLATE public.nocase,
    transfer_docno character varying(36) COLLATE public.nocase,
    tran_date timestamp without time zone,
    supplier_code character varying(32) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    account_code character varying(64) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    tran_amount numeric(25,2),
    exchange_rate numeric(25,2),
    pbcur_erate numeric(25,2),
    transferred_amt numeric(25,2),
    reason_code character varying(20) COLLATE public.nocase,
    comments character varying(512) COLLATE public.nocase,
    ref_doc_no character varying(36) COLLATE public.nocase,
    status character varying(4) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    batch_id character varying(256) COLLATE public.nocase,
    rev_doc_ou integer,
    rev_doc_no character varying(36) COLLATE public.nocase,
    rev_doc_date timestamp without time zone,
    rev_reasoncode character varying(20) COLLATE public.nocase,
    rev_remarks character varying(200) COLLATE public.nocase,
    rev_doc_trantype character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_stndebitnotedtl_pkey PRIMARY KEY (stn_debit_note_dtl_key),
    CONSTRAINT f_stndebitnotedtl_ukey UNIQUE (ou_id, trns_debit_note, tran_type),
    CONSTRAINT f_stndebitnotedtl_stndebitnotedtl_curr_key_fkey FOREIGN KEY (stndebitnotedtl_curr_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_stndebitnotedtl_stndebitnotedtl_opcoa_key_fkey FOREIGN KEY (stndebitnotedtl_opcoa_key)
        REFERENCES dwh.d_operationalaccountdetail (opcoa_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_stndebitnotedtl_stndebitnotedtl_vendor_key_fkey FOREIGN KEY (stndebitnotedtl_vendor_key)
        REFERENCES dwh.d_vendor (vendor_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_stndebitnotedtl
    OWNER to proconnect;