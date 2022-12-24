CREATE TABLE stg.stg_item_group_type (
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