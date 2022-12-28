CREATE TABLE dwh.d_businessunit (
    bu_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    serial_no integer,
    btimestamp integer,
    bu_name character varying(500) COLLATE public.nocase,
    status character varying(60) COLLATE public.nocase,
    address_id character varying(80) COLLATE public.nocase,
    effective_from timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_businessunit ALTER COLUMN bu_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_businessunit_bu_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_businessunit
    ADD CONSTRAINT d_businessunit_pkey PRIMARY KEY (bu_key);

ALTER TABLE ONLY dwh.d_businessunit
    ADD CONSTRAINT d_businessunit_ukey UNIQUE (company_code, bu_id, serial_no);