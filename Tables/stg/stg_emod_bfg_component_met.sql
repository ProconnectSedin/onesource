CREATE TABLE stg.stg_emod_bfg_component_met (
    bfg_code character varying(80) NOT NULL COLLATE public.nocase,
    component_id character varying(80) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    map_status character varying(100) COLLATE public.nocase,
    map_by character varying(120) COLLATE public.nocase,
    map_date timestamp without time zone,
    unmap_by character varying(120) COLLATE public.nocase,
    unmap_date timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_emod_bfg_component_met
    ADD CONSTRAINT emod_bfg_component_met_pkey PRIMARY KEY (bfg_code, component_id);