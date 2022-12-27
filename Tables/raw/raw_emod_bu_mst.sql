CREATE TABLE raw.raw_emod_bu_mst (
    raw_id bigint NOT NULL,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    bu_id character varying(80) NOT NULL COLLATE public.nocase,
    serial_no integer NOT NULL,
    btimestamp integer,
    bu_name character varying(1000) COLLATE public.nocase,
    status character varying(100) COLLATE public.nocase,
    address_id character varying(160) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_emod_bu_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_emod_bu_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_emod_bu_mst
    ADD CONSTRAINT raw_emod_bu_mst_pkey PRIMARY KEY (raw_id);