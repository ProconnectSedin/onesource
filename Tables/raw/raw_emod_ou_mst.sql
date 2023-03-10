CREATE TABLE raw.raw_emod_ou_mst (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    bu_id character varying(80) NOT NULL COLLATE public.nocase,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    address_id character varying(160) NOT NULL COLLATE public.nocase,
    serial_no integer NOT NULL,
    "timestamp" integer,
    default_flag character varying(48) COLLATE public.nocase,
    map_status character varying(100) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    latitude numeric,
    longitude numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_emod_ou_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_emod_ou_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_emod_ou_mst
    ADD CONSTRAINT emod_ou_mst_pkey PRIMARY KEY (raw_id);