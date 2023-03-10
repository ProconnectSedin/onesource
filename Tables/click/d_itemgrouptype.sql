CREATE TABLE click.d_itemgrouptype (
    item_igt_key bigint NOT NULL,
    item_igt_grouptype character varying(40) COLLATE public.nocase,
    item_igt_lo character varying(40) COLLATE public.nocase,
    item_igt_category character varying(10) COLLATE public.nocase,
    item_igt_grouptypedesc character varying(80) COLLATE public.nocase,
    item_igt_usage character varying(10) COLLATE public.nocase,
    item_igt_created_by character varying(60) COLLATE public.nocase,
    item_igt_created_date timestamp without time zone,
    item_igt_modified_by character varying(60) COLLATE public.nocase,
    item_igt_modified_date timestamp without time zone,
    item_igt_timestamp integer,
    item_igt_created_langid integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_itemgrouptype
    ADD CONSTRAINT d_itemgrouptype_pkey PRIMARY KEY (item_igt_key);

ALTER TABLE ONLY click.d_itemgrouptype
    ADD CONSTRAINT d_itemgrouptype_ukey UNIQUE (item_igt_grouptype, item_igt_lo);