CREATE TABLE dwh.f_contractdetailhistory (
    cont_dtl_hst_key bigint NOT NULL,
    cont_hdr_hst_key bigint NOT NULL,
    cont_id character varying(40) COLLATE public.nocase,
    cont_lineno integer,
    cont_ou integer,
    cont_amendno integer,
    cont_tariff_id character varying(40) COLLATE public.nocase,
    cont_tariff_ser_id character varying(40) COLLATE public.nocase,
    cont_rate numeric(25,2),
    cont_min_change numeric(25,2),
    cont_min_change_added character varying(20) COLLATE public.nocase,
    cont_cost numeric(25,2),
    cont_margin_per numeric(25,2),
    cont_max_charge numeric(25,2),
    cont_rate_valid_from timestamp without time zone,
    cont_rate_valid_to timestamp without time zone,
    cont_basic_charge numeric(25,2),
    cont_val_currency character varying(20) COLLATE public.nocase,
    cont_bill_currency character varying(20) COLLATE public.nocase,
    cont_exchange_rate_type character varying(20) COLLATE public.nocase,
    cont_discount numeric(25,2),
    cont_last_day character varying(20) COLLATE public.nocase,
    cont_draft_bill_grp character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_contractdetailhistory ALTER COLUMN cont_dtl_hst_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_contractdetailhistory_cont_dtl_hst_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_contractdetailhistory
    ADD CONSTRAINT f_contractdetailhistory_pkey PRIMARY KEY (cont_dtl_hst_key);

ALTER TABLE ONLY dwh.f_contractdetailhistory
    ADD CONSTRAINT f_contractdetailhistory_ukey UNIQUE (cont_id, cont_lineno, cont_ou, cont_amendno);

CREATE INDEX f_contractdetailhistory_key_idx ON dwh.f_contractdetailhistory USING btree (cont_id, cont_lineno, cont_ou, cont_amendno);

CREATE INDEX f_contractdetailhistory_key_idx1 ON dwh.f_contractdetailhistory USING btree (cont_hdr_hst_key);

CREATE INDEX f_contractdetailhistory_key_idx2 ON dwh.f_contractdetailhistory USING btree (cont_id, cont_ou, cont_amendno);