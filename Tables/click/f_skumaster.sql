CREATE TABLE click.f_skumaster (
    skumaster_key bigint NOT NULL,
    customer_key bigint,
    itm_hdr_key bigint,
    sku_ou integer,
    customer_code character varying(40),
    customer_name character varying(80),
    sku_code character varying(80),
    sku_name character varying(1500),
    sku_type character varying(80),
    sku_length numeric,
    sku_breadth numeric,
    sku_height numeric,
    lbh_uom character varying(20),
    wght_in_kg numeric,
    sku_wght_uom character varying(20),
    actual_vol_wght numeric,
    calc_vol_wght numeric,
    vol_wght_diff numeric,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updateddate timestamp(3) without time zone,
    wght_diff_percentage numeric(20,3),
    stack_height numeric(20,2),
    stack_count numeric(20,2),
    ex_location_key bigint,
    ex_itm_loc_code character varying(20),
    d_ex_itm_key bigint,
    ex_itm_line_no integer
);

ALTER TABLE click.f_skumaster ALTER COLUMN skumaster_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_skumaster_skumaster_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_skumaster
    ADD CONSTRAINT f_skumaster_pkey PRIMARY KEY (skumaster_key);

ALTER TABLE ONLY click.f_skumaster
    ADD CONSTRAINT f_skumaster_ukey UNIQUE (sku_ou, itm_hdr_key, d_ex_itm_key, ex_itm_line_no, customer_key);

CREATE INDEX f_skumaster_idx ON click.f_skumaster USING btree (sku_ou, sku_code);