CREATE TABLE dwh.f_contractdetail (
    cont_dtl_key bigint NOT NULL,
    cont_hdr_key bigint NOT NULL,
    cont_id character varying(40) COLLATE public.nocase,
    cont_lineno integer,
    cont_ou integer,
    cont_tariff_id character varying(40) COLLATE public.nocase,
    cont_tariff_ser_id character varying(40) COLLATE public.nocase,
    cont_rate numeric(13,2),
    cont_min_change numeric(13,2),
    cont_min_change_added character varying(20) COLLATE public.nocase,
    cont_cost numeric(13,2),
    cont_margin_per numeric(13,2),
    cont_max_charge numeric(13,2),
    cont_rate_valid_from timestamp without time zone,
    cont_rate_valid_to timestamp without time zone,
    cont_basic_charge numeric(13,2),
    cont_reimbursable character varying(510) COLLATE public.nocase,
    cont_percentrate character varying(510) COLLATE public.nocase,
    cont_val_currency character varying(20) COLLATE public.nocase,
    cont_bill_currency character varying(20) COLLATE public.nocase,
    cont_exchange_rate_type character varying(20) COLLATE public.nocase,
    cont_discount numeric(13,2),
    cont_draft_bill_grp character varying(80) COLLATE public.nocase,
    cont_created_by character varying(60) COLLATE public.nocase,
    cont_created_dt timestamp without time zone,
    cont_modified_by character varying(60) COLLATE public.nocase,
    cont_modified_dt timestamp without time zone,
    cont_advance_chk character varying(10) COLLATE public.nocase,
    bill_pay_to_id character varying(510) COLLATE public.nocase,
    inco_terms character varying(510) COLLATE public.nocase,
    cont_bulk_remarks character varying(510) COLLATE public.nocase,
    cont_type_ml character varying(80) COLLATE public.nocase,
    cont_tariff_bill_stage character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_contractdetail ALTER COLUMN cont_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_contractdetail_cont_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_contractdetail
    ADD CONSTRAINT f_contractdetail_pkey PRIMARY KEY (cont_dtl_key);

ALTER TABLE ONLY dwh.f_contractdetail
    ADD CONSTRAINT f_contractdetail_ukey UNIQUE (cont_id, cont_lineno, cont_ou, cont_tariff_id);

CREATE INDEX f_contractdetail_key_idx ON dwh.f_contractdetail USING btree (cont_id, cont_lineno, cont_ou, cont_tariff_id);

CREATE INDEX f_contractdetail_key_idx1 ON dwh.f_contractdetail USING btree (cont_hdr_key);