CREATE TABLE dwh.d_customerlocdiv (
    wms_customer_key bigint NOT NULL,
    wms_customer_id character varying(36) COLLATE public.nocase,
    wms_customer_ou integer,
    wms_customer_lineno integer,
    wms_customer_type character varying(16) COLLATE public.nocase,
    wms_customer_code character varying(20) COLLATE public.nocase,
    wms_customer_itm_val_contract integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_customerlocdiv ALTER COLUMN wms_customer_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_customerlocdiv_wms_customer_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_customerlocdiv
    ADD CONSTRAINT d_customerlocdiv_pkey PRIMARY KEY (wms_customer_key);

ALTER TABLE ONLY dwh.d_customerlocdiv
    ADD CONSTRAINT d_customerlocdiv_ukey UNIQUE (wms_customer_id, wms_customer_ou, wms_customer_lineno);