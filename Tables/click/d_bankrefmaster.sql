CREATE TABLE click.d_bankrefmaster (
    bank_ref_mst_key bigint NOT NULL,
    bank_ref_no character varying(40) COLLATE public.nocase,
    bank_status character varying(10) COLLATE public.nocase,
    btimestamp integer,
    bank_ptt_flag character varying(10) COLLATE public.nocase,
    bank_type character varying(60) COLLATE public.nocase,
    bank_name character varying(100) COLLATE public.nocase,
    address1 character varying(100) COLLATE public.nocase,
    address2 character varying(100) COLLATE public.nocase,
    address3 character varying(100) COLLATE public.nocase,
    city character varying(100) COLLATE public.nocase,
    state character varying(100) COLLATE public.nocase,
    country character varying(100) COLLATE public.nocase,
    clearing_no character varying(40) COLLATE public.nocase,
    swift_no character varying(40) COLLATE public.nocase,
    zip_code character varying(100) COLLATE public.nocase,
    creation_ou integer,
    modification_ou integer,
    effective_from timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    createdin character varying(60) COLLATE public.nocase,
    ifsccode character varying(40) COLLATE public.nocase,
    long_description character varying(500) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_bankrefmaster
    ADD CONSTRAINT d_bankrefmaster_pkey PRIMARY KEY (bank_ref_mst_key);

ALTER TABLE ONLY click.d_bankrefmaster
    ADD CONSTRAINT d_bankrefmaster_ukey UNIQUE (bank_ref_no, bank_status);