CREATE TABLE click.d_exchangerate (
    d_exchangerate_key bigint NOT NULL,
    ou_id integer,
    exchrate_type character varying(20) COLLATE public.nocase,
    from_currency character varying(10) COLLATE public.nocase,
    to_currency character varying(10) COLLATE public.nocase,
    inverse_typeno character varying(10) COLLATE public.nocase,
    start_date timestamp without time zone,
    "timestamp" integer,
    end_date timestamp without time zone,
    exchange_rate numeric(13,0),
    tolerance_flag character varying(10) COLLATE public.nocase,
    tolerance_limit numeric(13,0),
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

ALTER TABLE ONLY click.d_exchangerate
    ADD CONSTRAINT d_exchangerate_pkey PRIMARY KEY (d_exchangerate_key);

ALTER TABLE ONLY click.d_exchangerate
    ADD CONSTRAINT d_exchangerate_ukey UNIQUE (ou_id, exchrate_type, from_currency, to_currency, inverse_typeno, start_date);

CREATE INDEX d_exchangerate_idx ON click.d_exchangerate USING btree (ou_id, exchrate_type, from_currency, to_currency, inverse_typeno, start_date);