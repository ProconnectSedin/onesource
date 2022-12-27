CREATE TABLE click.d_oubumap (
    d_oubumap_key bigint NOT NULL,
    ou_id integer,
    bu_id character varying(40) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    serial_no integer,
    "timestamp" integer,
    map_status character varying(50) COLLATE public.nocase,
    effective_from timestamp without time zone,
    map_by character varying(60) COLLATE public.nocase,
    map_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_oubumap
    ADD CONSTRAINT d_oubumap_pkey PRIMARY KEY (d_oubumap_key);

ALTER TABLE ONLY click.d_oubumap
    ADD CONSTRAINT d_oubumap_ukey UNIQUE (ou_id, bu_id, company_code, serial_no);