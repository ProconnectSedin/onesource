CREATE TABLE dwh.d_customer (
    customer_key bigint NOT NULL,
    customer_id character varying(40) COLLATE public.nocase,
    customer_ou integer,
    customer_name character varying(80) COLLATE public.nocase,
    customer_status character varying(20) COLLATE public.nocase,
    customer_type character varying(20) COLLATE public.nocase,
    customer_description character varying(510) COLLATE public.nocase,
    customer_credit_term character varying(40) COLLATE public.nocase,
    customer_pay_term character varying(40) COLLATE public.nocase,
    customer_currency character varying(40) COLLATE public.nocase,
    customer_reason_code character varying(80) COLLATE public.nocase,
    customer_address1 character varying(300) COLLATE public.nocase,
    customer_address2 character varying(300) COLLATE public.nocase,
    customer_address3 character varying(300) COLLATE public.nocase,
    customer_city character varying(80) COLLATE public.nocase,
    customer_state character varying(80) COLLATE public.nocase,
    customer_country character varying(80) COLLATE public.nocase,
    customer_postal_code character varying(80) COLLATE public.nocase,
    customer_timezone character varying(80) COLLATE public.nocase,
    customer_contact_person character varying(100) COLLATE public.nocase,
    customer_phone1 character varying(40) COLLATE public.nocase,
    customer_phone2 character varying(40) COLLATE public.nocase,
    customer_fax character varying(80) COLLATE public.nocase,
    customer_email character varying(100) COLLATE public.nocase,
    customer_bill_same_as_customer integer,
    customer_bill_address1 character varying(300) COLLATE public.nocase,
    customer_bill_address2 character varying(300) COLLATE public.nocase,
    customer_bill_address3 character varying(300) COLLATE public.nocase,
    customer_bill_city character varying(80) COLLATE public.nocase,
    customer_bill_state character varying(80) COLLATE public.nocase,
    customer_bill_country character varying(80) COLLATE public.nocase,
    customer_bill_postal_code character varying(80) COLLATE public.nocase,
    customer_bill_contact_person character varying(100) COLLATE public.nocase,
    customer_bill_phone character varying(40) COLLATE public.nocase,
    customer_bill_fax character varying(80) COLLATE public.nocase,
    customer_ret_undelivered character varying(20) COLLATE public.nocase,
    customer_ret_same_as_customer integer,
    customer_ret_address1 character varying(300) COLLATE public.nocase,
    customer_ret_address2 character varying(300) COLLATE public.nocase,
    customer_ret_address3 character varying(300) COLLATE public.nocase,
    customer_ret_city character varying(80) COLLATE public.nocase,
    customer_ret_state character varying(80) COLLATE public.nocase,
    customer_ret_country character varying(80) COLLATE public.nocase,
    customer_ret_postal_code character varying(80) COLLATE public.nocase,
    customer_ret_contact_person character varying(90) COLLATE public.nocase,
    customer_ret_phone1 character varying(40) COLLATE public.nocase,
    customer_ret_fax character varying(80) COLLATE public.nocase,
    customer_timestamp integer,
    customer_created_by character varying(60) COLLATE public.nocase,
    customer_created_dt timestamp without time zone,
    customer_modified_by character varying(60) COLLATE public.nocase,
    customer_modified_dt timestamp without time zone,
    customer_br_valid_prof_id character varying(80) COLLATE public.nocase,
    customer_payment_typ character varying(510) COLLATE public.nocase,
    customer_geo_fence numeric(13,2),
    customer_bill_geo_fence numeric(13,2),
    customer_bill_longtitude numeric(13,2),
    customer_bill_latitude numeric(13,2),
    customer_bill_zone character varying(80) COLLATE public.nocase,
    customer_bill_sub_zone character varying(80) COLLATE public.nocase,
    customer_bill_region character varying(80) COLLATE public.nocase,
    customer_ret_geo_fence numeric(13,2),
    customer_ret_longtitude numeric(13,2),
    customer_ret_latitude numeric(13,2),
    customer_customer_grp character varying(80) COLLATE public.nocase,
    customer_industry_typ character varying(80) COLLATE public.nocase,
    allow_rev_protection integer,
    customer_invrep character varying(510) COLLATE public.nocase,
    customer_rcti integer,
    customer_gen_from character varying(60) COLLATE public.nocase,
    customer_bill_hrchy1 character varying(80) COLLATE public.nocase,
    customer_new_customer integer,
    customer_final_bill_stage character varying(80) COLLATE public.nocase,
    customer_allwdb_billto character varying(510) COLLATE public.nocase,
    customer_contact_person2 character varying(90) COLLATE public.nocase,
    cus_contact_person2_email character varying(120) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_customer ALTER COLUMN customer_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_customer_customer_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_customer
    ADD CONSTRAINT d_customer_pkey PRIMARY KEY (customer_key);

ALTER TABLE ONLY dwh.d_customer
    ADD CONSTRAINT d_customer_ukey UNIQUE (customer_id, customer_ou);

CREATE INDEX d_customer_idx ON dwh.d_customer USING btree (customer_ou, customer_id);