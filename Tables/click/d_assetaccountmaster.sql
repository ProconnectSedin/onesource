CREATE TABLE click.d_assetaccountmaster (
    d_asset_mst_key bigint NOT NULL,
    company_code character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    asset_usage character varying(40) COLLATE public.nocase,
    effective_from timestamp without time zone,
    sequence_no integer,
    "timestamp" integer,
    account_code character varying(80) COLLATE public.nocase,
    effective_to timestamp without time zone,
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

ALTER TABLE ONLY click.d_assetaccountmaster
    ADD CONSTRAINT d_assetaccountmaster_pkey PRIMARY KEY (d_asset_mst_key);

ALTER TABLE ONLY click.d_assetaccountmaster
    ADD CONSTRAINT d_assetaccountmaster_ukey UNIQUE (company_code, fb_id, asset_class, asset_usage, effective_from, sequence_no);