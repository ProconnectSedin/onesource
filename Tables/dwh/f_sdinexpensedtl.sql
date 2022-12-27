CREATE TABLE dwh.f_sdinexpensedtl (
    f_sdinexpensedtl_key bigint NOT NULL,
    account_key bigint NOT NULL,
    uom_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    line_no integer,
    s_timestamp integer,
    expense character varying(80) COLLATE public.nocase,
    usage character varying(80) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    item_qty numeric(13,2),
    item_rate numeric(13,2),
    rate_per numeric(13,2),
    item_amount numeric(13,2),
    remarks character varying(510) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    base_value numeric(13,2),
    accountcode character varying(80) COLLATE public.nocase,
    destou character varying(40) COLLATE public.nocase,
    visible_line_no integer,
    retentionml numeric(13,2),
    holdml numeric(13,2),
    trnsfr_inv_no character varying(40) COLLATE public.nocase,
    trnsfr_inv_date timestamp without time zone,
    trnsfr_inv_ou integer,
    draft_bill_lineno integer,
    draft_bill_no character varying(40) COLLATE public.nocase,
    draft_bill_ou integer,
    s_location character varying(80) COLLATE public.nocase,
    region character varying(80) COLLATE public.nocase,
    partytype character varying(20) COLLATE public.nocase,
    line_of_business character varying(80) COLLATE public.nocase,
    department character varying(80) COLLATE public.nocase,
    service_type character varying(80) COLLATE public.nocase,
    order_type character varying(80) COLLATE public.nocase,
    vehicle_type character varying(80) COLLATE public.nocase,
    activity_type character varying(80) COLLATE public.nocase,
    nature character varying(80) COLLATE public.nocase,
    own_tax_region character varying(20) COLLATE public.nocase,
    party_tax_region character varying(20) COLLATE public.nocase,
    decl_tax_region character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_sdinexpensedtl ALTER COLUMN f_sdinexpensedtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_sdinexpensedtl_f_sdinexpensedtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_sdinexpensedtl
    ADD CONSTRAINT f_sdinexpensedtl_pkey PRIMARY KEY (f_sdinexpensedtl_key);

ALTER TABLE ONLY dwh.f_sdinexpensedtl
    ADD CONSTRAINT f_sdinexpensedtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, s_timestamp);

ALTER TABLE ONLY dwh.f_sdinexpensedtl
    ADD CONSTRAINT f_sdinexpensedtl_account_key_fkey FOREIGN KEY (account_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

ALTER TABLE ONLY dwh.f_sdinexpensedtl
    ADD CONSTRAINT f_sdinexpensedtl_uom_key_fkey FOREIGN KEY (uom_key) REFERENCES dwh.d_uom(uom_key);

CREATE INDEX f_sdinexpensedtl_key_idx ON dwh.f_sdinexpensedtl USING btree (tran_type, tran_ou, tran_no, line_no, s_timestamp);