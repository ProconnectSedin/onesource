CREATE TABLE dwh.d_warehouse (
    wh_key bigint NOT NULL,
    wh_code character varying(20) COLLATE public.nocase,
    wh_ou integer,
    wh_desc character varying(80) COLLATE public.nocase,
    wh_status character varying COLLATE public.nocase,
    wh_desc_shdw character varying(80) COLLATE public.nocase,
    wh_storage_type character varying(10) COLLATE public.nocase,
    nettable integer,
    finance_book character varying(40) COLLATE public.nocase,
    allocation_method character varying(10) COLLATE public.nocase,
    site_code character varying(20) COLLATE public.nocase,
    address1 character varying(80) COLLATE public.nocase,
    capital_warehouse integer,
    address2 character varying(80) COLLATE public.nocase,
    city character varying(80) COLLATE public.nocase,
    all_trans_allowed integer,
    state character varying(80) COLLATE public.nocase,
    all_itemtypes_allowed integer,
    zip_code character varying(40) COLLATE public.nocase,
    all_stk_status_allowed integer,
    country character varying(80) COLLATE public.nocase,
    created_by character varying(60) COLLATE public.nocase,
    created_dt timestamp without time zone,
    modified_by character varying(60),
    modified_dt timestamp without time zone,
    timestamp_value integer,
    tran_type character varying(40) COLLATE public.nocase,
    bonded_yn character varying(20) COLLATE public.nocase,
    location_code character varying(40) COLLATE public.nocase,
    location_desc character varying(510) COLLATE public.nocase,
    address3 character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_warehouse ALTER COLUMN wh_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_warehouse_wh_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_warehouse
    ADD CONSTRAINT d_warehouse_pkey PRIMARY KEY (wh_key);

ALTER TABLE ONLY dwh.d_warehouse
    ADD CONSTRAINT d_warehouse_ukey UNIQUE (wh_code, wh_ou);