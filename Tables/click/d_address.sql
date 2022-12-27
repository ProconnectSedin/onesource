CREATE TABLE click.d_address (
    address_key bigint NOT NULL,
    address_id character varying(100) COLLATE public.nocase,
    atimestamp integer,
    address1 character varying(100) COLLATE public.nocase,
    address2 character varying(100) COLLATE public.nocase,
    address3 character varying(100) COLLATE public.nocase,
    address_desc character varying(250) COLLATE public.nocase,
    city character varying(100) COLLATE public.nocase,
    state character varying(100) COLLATE public.nocase,
    country character varying(100) COLLATE public.nocase,
    phone_no character varying(40) COLLATE public.nocase,
    url character varying(100) COLLATE public.nocase,
    zip_code character varying(40) COLLATE public.nocase,
    createdby character varying(100) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(100) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    state_code integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_address
    ADD CONSTRAINT d_adress_pkey PRIMARY KEY (address_key);

ALTER TABLE ONLY click.d_address
    ADD CONSTRAINT d_adress_ukey UNIQUE (address_id);