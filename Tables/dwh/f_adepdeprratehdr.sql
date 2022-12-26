CREATE TABLE dwh.f_adepdeprratehdr (
    f_adepdeprratehdr_key bigint NOT NULL,
    ou_id integer,
    asset_class character varying(40) COLLATE public.nocase,
    depr_rate_id character varying(40) COLLATE public.nocase,
    a_timestamp integer,
    depr_rate_desc character varying(80) COLLATE public.nocase,
    depr_rate_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);