CREATE TABLE dwh.d_oumaster (
    ou_key bigint NOT NULL,
    ou_id integer,
    bu_id character varying(40) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    address_id character varying(80) COLLATE public.nocase,
    serial_no integer,
    otimestamp integer,
    default_flag character varying(30) COLLATE public.nocase,
    map_status character varying(50) COLLATE public.nocase,
    effective_from timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_oumaster ALTER COLUMN ou_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_oumaster_ou_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_oumaster
    ADD CONSTRAINT d_oumaster_pkey PRIMARY KEY (ou_key);

ALTER TABLE ONLY dwh.d_oumaster
    ADD CONSTRAINT d_oumaster_ukey UNIQUE (ou_id, bu_id, company_code, address_id, serial_no);