CREATE TABLE click.d_company (
    company_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    serial_no integer,
    ctimestamp integer,
    company_name character varying(150) COLLATE public.nocase,
    address1 character varying(100) COLLATE public.nocase,
    address2 character varying(100) COLLATE public.nocase,
    address3 character varying(100) COLLATE public.nocase,
    city character varying(100) COLLATE public.nocase,
    country character varying(100) COLLATE public.nocase,
    zip_code character varying(40) COLLATE public.nocase,
    phone_no character varying(40) COLLATE public.nocase,
    state character varying(100) COLLATE public.nocase,
    company_url character varying(100) COLLATE public.nocase,
    par_comp_code character varying(20) COLLATE public.nocase,
    base_currency character varying(20) COLLATE public.nocase,
    status character varying(60) COLLATE public.nocase,
    effective_from timestamp without time zone,
    para_base_flag character varying(10) COLLATE public.nocase,
    reg_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    company_id character varying(100) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_company
    ADD CONSTRAINT d_company_pkey PRIMARY KEY (company_key);

ALTER TABLE ONLY click.d_company
    ADD CONSTRAINT d_company_ukey UNIQUE (company_code, serial_no);