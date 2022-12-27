CREATE TABLE click.d_financebook (
    fb_key bigint NOT NULL,
    fb_id character varying(40) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    serial_no integer,
    fb_type character varying(20) COLLATE public.nocase,
    ftimestamp integer,
    fb_desc character varying(250) COLLATE public.nocase,
    effective_from timestamp without time zone,
    status character varying(60) COLLATE public.nocase,
    resou_id integer,
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

ALTER TABLE ONLY click.d_financebook
    ADD CONSTRAINT d_financebook_pkey PRIMARY KEY (fb_key);

ALTER TABLE ONLY click.d_financebook
    ADD CONSTRAINT d_financebook_ukey UNIQUE (fb_id, company_code, serial_no, fb_type);