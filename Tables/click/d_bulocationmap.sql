CREATE TABLE click.d_bulocationmap (
    bu_loc_map_key bigint NOT NULL,
    lo_id character varying(40) COLLATE public.nocase,
    bu_id character varying(40) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    serial_no integer,
    btimestamp integer,
    lo_name character varying(100) COLLATE public.nocase,
    map_status character varying(60) COLLATE public.nocase,
    effective_from timestamp without time zone,
    map_by character varying(60) COLLATE public.nocase,
    map_date timestamp without time zone,
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

ALTER TABLE ONLY click.d_bulocationmap
    ADD CONSTRAINT d_bulocationmap_pkey PRIMARY KEY (bu_loc_map_key);

ALTER TABLE ONLY click.d_bulocationmap
    ADD CONSTRAINT d_bulocationmap_ukey UNIQUE (lo_id, bu_id, company_code, serial_no);