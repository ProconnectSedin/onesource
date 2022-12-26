CREATE TABLE stg.stg_component_metadata_table (
    componentname character varying(100) NOT NULL COLLATE public.nocase,
    paramcategory character varying(40) NOT NULL COLLATE public.nocase,
    paramtype character varying(60) NOT NULL COLLATE public.nocase,
    paramcode character varying(32) NOT NULL COLLATE public.nocase,
    optionvalue character varying(32) COLLATE public.nocase,
    sequenceno integer,
    paramdesc character varying(1020) COLLATE public.nocase,
    paramdesc_shd character varying(1020) COLLATE public.nocase,
    langid integer NOT NULL,
    cml_len integer,
    cml_translate character(8) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);