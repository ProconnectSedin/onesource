CREATE TABLE stg.stg_emod_lo_bu_map (
    lo_id character varying(80) NOT NULL COLLATE public.nocase,
    bu_id character varying(80) NOT NULL COLLATE public.nocase,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    serial_no integer NOT NULL,
    btimestamp integer,
    lo_name character varying(160) COLLATE public.nocase,
    map_status character varying(100) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
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

ALTER TABLE ONLY stg.stg_emod_lo_bu_map
    ADD CONSTRAINT emod_lo_bu_map_pkey PRIMARY KEY (lo_id, bu_id, company_code, serial_no);