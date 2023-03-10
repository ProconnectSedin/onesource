CREATE TABLE dwh.d_vendor (
    vendor_key bigint NOT NULL,
    vendor_id character varying(40) COLLATE public.nocase,
    vendor_ou integer,
    vendor_status character varying(20) COLLATE public.nocase,
    vendor_name character varying(120) COLLATE public.nocase,
    vendor_payterm character varying(40) COLLATE public.nocase,
    vendor_reason_code character varying(80) COLLATE public.nocase,
    vendor_classifcation character varying(510) COLLATE public.nocase,
    vendor_currency character varying(20) COLLATE public.nocase,
    vendor_for_self integer,
    vendor_created_by character varying(60) COLLATE public.nocase,
    vendor_created_date timestamp without time zone,
    vendor_modified_by character varying(60) COLLATE public.nocase,
    vendor_modified_date timestamp without time zone,
    vendor_timestamp integer,
    vendor_address1 character varying(300) COLLATE public.nocase,
    vendor_address2 character varying(300) COLLATE public.nocase,
    vendor_address3 character varying(300) COLLATE public.nocase,
    vendor_city character varying(80) COLLATE public.nocase,
    vendor_state character varying(80) COLLATE public.nocase,
    vendor_country character varying(80) COLLATE public.nocase,
    vendor_phone1 character varying(40) COLLATE public.nocase,
    vendor_phone2 character varying(40) COLLATE public.nocase,
    vendor_email character varying(510) COLLATE public.nocase,
    vendor_fax character varying(80) COLLATE public.nocase,
    vendor_url character varying(100) COLLATE public.nocase,
    vendor_subzone character varying(80) COLLATE public.nocase,
    vendor_timezone character varying(80) COLLATE public.nocase,
    vendor_zone character varying(80) COLLATE public.nocase,
    vendor_region character varying(80) COLLATE public.nocase,
    vendor_postal_code character varying(80) COLLATE public.nocase,
    vendor_agnt_reg character varying(20) COLLATE public.nocase,
    vendor_agnt_cha character varying(20) COLLATE public.nocase,
    vendor_carrier_road character varying(20) COLLATE public.nocase,
    vendor_carrier_rail character varying(20) COLLATE public.nocase,
    vendor_carrier_air character varying(20) COLLATE public.nocase,
    vendor_carrier_sea character varying(20) COLLATE public.nocase,
    vendor_sub_cntrct_veh character varying(20) COLLATE public.nocase,
    vendor_sub_cntrct_emp character varying(20) COLLATE public.nocase,
    vendor_lat numeric(13,2),
    vendor_long numeric(13,2),
    vendor_reg character varying(80) COLLATE public.nocase,
    vendor_dept character varying(80) COLLATE public.nocase,
    vendor_ln_business character varying(80) COLLATE public.nocase,
    vendor_rcti character varying(510) COLLATE public.nocase,
    vendor_gen_from character varying(60) COLLATE public.nocase,
    vendor_group character varying(80) COLLATE public.nocase,
    vendor_std_contract integer,
    vendor_final_bill_stage character varying(80) COLLATE public.nocase,
    vendor_allwdb_billto integer,
    vendor_insrnc_prvdr character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_vendor ALTER COLUMN vendor_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_vendor_vendor_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_vendor
    ADD CONSTRAINT d_vendor_pkey PRIMARY KEY (vendor_key);

ALTER TABLE ONLY dwh.d_vendor
    ADD CONSTRAINT d_vendor_ukey UNIQUE (vendor_id, vendor_ou);

CREATE INDEX d_vendor_idx_1 ON dwh.d_vendor USING btree (vendor_ou, vendor_id);