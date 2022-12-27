CREATE TABLE stg.stg_tms_component_met (
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

ALTER TABLE ONLY stg.stg_tms_component_met
    ADD CONSTRAINT tms_component_met_pk PRIMARY KEY (tms_componentname, tms_paramcategory, tms_paramtype, tms_paramcode, tms_paramdesc, tms_langid);