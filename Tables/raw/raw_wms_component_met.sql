CREATE TABLE raw.raw_wms_component_met (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_wms_component_met ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_component_met_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_component_met
    ADD CONSTRAINT raw_wms_component_met_pkey PRIMARY KEY (raw_id);