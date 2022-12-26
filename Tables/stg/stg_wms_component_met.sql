CREATE TABLE stg.stg_wms_component_met (
    wms_componentname character varying(60) NOT NULL COLLATE public.nocase,
    wms_paramcategory character varying(40) NOT NULL COLLATE public.nocase,
    wms_paramtype character varying(100) NOT NULL COLLATE public.nocase,
    wms_paramcode character varying(32) NOT NULL COLLATE public.nocase,
    wms_paramdesc character varying(1020) NOT NULL COLLATE public.nocase,
    wms_langid integer NOT NULL,
    wms_optionvalue character varying(32) COLLATE public.nocase,
    wms_sequenceno integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);