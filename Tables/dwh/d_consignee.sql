CREATE TABLE dwh.d_consignee (
    consignee_hdr_key bigint NOT NULL,
    consignee_id character varying(40) COLLATE public.nocase,
    consignee_ou integer,
    consignee_desc character varying(300) COLLATE public.nocase,
    consignee_status character varying(20) COLLATE public.nocase,
    consignee_currency character varying(20) COLLATE public.nocase,
    consignee_address1 character varying(200) COLLATE public.nocase,
    consignee_address2 character varying(200) COLLATE public.nocase,
    consignee_city character varying(100) COLLATE public.nocase,
    consignee_state character varying(80) COLLATE public.nocase,
    consignee_country character varying(80) COLLATE public.nocase,
    consignee_postalcode character varying(80) COLLATE public.nocase,
    consignee_phone1 character varying(100) COLLATE public.nocase,
    consignee_customer_id character varying(40) COLLATE public.nocase,
    consignee_created_by character varying(60) COLLATE public.nocase,
    consignee_created_date timestamp without time zone,
    consignee_modified_by character varying(60) COLLATE public.nocase,
    consignee_modified_date timestamp without time zone,
    consignee_timestamp integer,
    consignee_zone character varying(80) COLLATE public.nocase,
    consignee_timezone character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_consignee ALTER COLUMN consignee_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_consignee_consignee_hdr_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_consignee
    ADD CONSTRAINT d_consignee_pkey PRIMARY KEY (consignee_hdr_key);

ALTER TABLE ONLY dwh.d_consignee
    ADD CONSTRAINT d_consignee_ukey UNIQUE (consignee_id, consignee_ou);