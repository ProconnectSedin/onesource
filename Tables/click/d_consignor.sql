CREATE TABLE click.d_consignor (
    consignor_key bigint NOT NULL,
    consignor_id character varying(40) COLLATE public.nocase,
    consignor_ou integer,
    consignor_desc character varying(300) COLLATE public.nocase,
    consignor_status character varying(20) COLLATE public.nocase,
    consignor_currency character varying(20) COLLATE public.nocase,
    consignor_address1 character varying(200) COLLATE public.nocase,
    consignor_address2 character varying(200) COLLATE public.nocase,
    consignor_address3 character varying(200) COLLATE public.nocase,
    consignor_city character varying(100) COLLATE public.nocase,
    consignor_state character varying(80) COLLATE public.nocase,
    consignor_country character varying(80) COLLATE public.nocase,
    consignor_postalcode character varying(80) COLLATE public.nocase,
    consignor_phone1 character varying(100) COLLATE public.nocase,
    consignor_customer_id character varying(40) COLLATE public.nocase,
    consignor_created_by character varying(60) COLLATE public.nocase,
    consignor_created_date timestamp without time zone,
    consignor_modified_by character varying(60) COLLATE public.nocase,
    consignor_modified_date timestamp without time zone,
    consignor_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_consignor
    ADD CONSTRAINT d_consignor_pkey PRIMARY KEY (consignor_key);

ALTER TABLE ONLY click.d_consignor
    ADD CONSTRAINT d_consignor_ukey UNIQUE (consignor_id, consignor_ou);