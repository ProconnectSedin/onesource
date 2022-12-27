CREATE TABLE dwh.d_uom (
    uom_key bigint NOT NULL,
    mas_ouinstance integer,
    mas_uomcode character varying(20) COLLATE public.nocase,
    mas_uomdesc character varying(80) COLLATE public.nocase,
    mas_fractions integer,
    mas_status character varying(20) COLLATE public.nocase,
    mas_reasoncode character varying(20) COLLATE public.nocase,
    mas_created_by character varying(60) COLLATE public.nocase,
    mas_created_date timestamp without time zone,
    mas_modified_by character varying(60) COLLATE public.nocase,
    mas_modified_date timestamp without time zone,
    mas_timestamp integer,
    mas_created_langid integer,
    mas_class character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_uom ALTER COLUMN uom_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_uom_uom_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_uom
    ADD CONSTRAINT d_uom_pkey PRIMARY KEY (uom_key);

ALTER TABLE ONLY dwh.d_uom
    ADD CONSTRAINT d_uom_ukey UNIQUE (mas_ouinstance, mas_uomcode);

CREATE INDEX d_uom_idx ON dwh.d_uom USING btree (mas_ouinstance, mas_uomcode);