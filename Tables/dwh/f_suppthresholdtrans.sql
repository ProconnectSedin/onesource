-- Table: dwh.f_suppthresholdtrans

-- DROP TABLE IF EXISTS dwh.f_suppthresholdtrans;

CREATE TABLE IF NOT EXISTS dwh.f_suppthresholdtrans
(
    suppthresholdtrans_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    supp_key bigint NOT NULL,
    date_key bigint NOT NULL,
    tran_no character varying(36) COLLATE public.nocase,
    tran_ou integer,
    tran_type character varying(80) COLLATE public.nocase,
    tran_amount numeric(13,2),
    tran_status character varying(50) COLLATE public.nocase,
    supplier_code character varying(32) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    tax_community character varying(50) COLLATE public.nocase,
    tax_region character varying(20) COLLATE public.nocase,
    tax_category character varying(80) COLLATE public.nocase,
    tax_class character varying(80) COLLATE public.nocase,
    tran_date timestamp without time zone,
    tax_code character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_suppthresholdtrans_pkey PRIMARY KEY (suppthresholdtrans_key),
    CONSTRAINT f_suppthresholdtrans_date_key_fkey FOREIGN KEY (date_key)
        REFERENCES dwh.d_date (datekey) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_suppthresholdtrans_supp_key_fkey FOREIGN KEY (supp_key)
        REFERENCES dwh.d_vendor (vendor_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_suppthresholdtrans
    OWNER to proconnect;
-- Index: f_suppthresholdtrans_key_idx1

-- DROP INDEX IF EXISTS dwh.f_suppthresholdtrans_key_idx1;

CREATE INDEX IF NOT EXISTS f_suppthresholdtrans_key_idx1
    ON dwh.f_suppthresholdtrans USING btree
    (tran_no COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_type COLLATE public.nocase ASC NULLS LAST, tax_type COLLATE public.nocase ASC NULLS LAST, tax_community COLLATE public.nocase ASC NULLS LAST, tax_region COLLATE public.nocase ASC NULLS LAST, tax_category COLLATE public.nocase ASC NULLS LAST, tax_class COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;