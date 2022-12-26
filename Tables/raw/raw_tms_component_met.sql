CREATE TABLE raw.raw_tms_component_met (
    raw_id bigint NOT NULL,
    tms_componentname character varying(60) NOT NULL COLLATE public.nocase,
    tms_paramcategory character varying(40) NOT NULL COLLATE public.nocase,
    tms_paramtype character varying(100) NOT NULL COLLATE public.nocase,
    tms_paramcode character varying(32) NOT NULL COLLATE public.nocase,
    tms_paramdesc character varying(1020) NOT NULL COLLATE public.nocase,
    tms_langid integer NOT NULL,
    tms_optionvalue character varying(32) COLLATE public.nocase,
    tms_sequenceno integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);