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

ALTER TABLE dwh.f_adepdeprratehdr ALTER COLUMN f_adepdeprratehdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_adepdeprratehdr_f_adepdeprratehdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_adepdeprratehdr
    ADD CONSTRAINT f_adepdeprratehdr_pkey PRIMARY KEY (f_adepdeprratehdr_key);

ALTER TABLE ONLY dwh.f_adepdeprratehdr
    ADD CONSTRAINT f_adepdeprratehdr_ukey UNIQUE (ou_id, asset_class, depr_rate_id);

CREATE INDEX f_adepdeprratehdr_key_idx ON dwh.f_adepdeprratehdr USING btree (ou_id, asset_class, depr_rate_id);