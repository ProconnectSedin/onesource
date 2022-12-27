CREATE TABLE raw.raw_item_group_type (
    raw_id bigint NOT NULL,
    item_igt_grouptype character varying(80) NOT NULL COLLATE public.nocase,
    item_igt_lo character varying(80) NOT NULL COLLATE public.nocase,
    item_igt_category character(8) NOT NULL COLLATE public.nocase,
    item_igt_grouptypedesc character varying(160) COLLATE public.nocase,
    item_igt_usage character(8) NOT NULL COLLATE public.nocase,
    item_igt_created_by character varying(120) NOT NULL COLLATE public.nocase,
    item_igt_created_date timestamp without time zone NOT NULL,
    item_igt_modified_by character varying(120) COLLATE public.nocase,
    item_igt_modified_date timestamp without time zone,
    item_igt_timestamp integer,
    item_igt_created_langid integer NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_item_group_type ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_item_group_type_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_item_group_type
    ADD CONSTRAINT raw_item_group_type_pkey PRIMARY KEY (raw_id);