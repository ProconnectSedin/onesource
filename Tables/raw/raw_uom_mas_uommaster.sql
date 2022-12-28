CREATE TABLE raw.raw_uom_mas_uommaster (
    raw_id bigint NOT NULL,
    mas_ouinstance integer NOT NULL,
    mas_uomcode character varying(40) NOT NULL COLLATE public.nocase,
    mas_uomdesc character varying(160) NOT NULL COLLATE public.nocase,
    mas_fractions integer NOT NULL,
    mas_status character varying(32) NOT NULL COLLATE public.nocase,
    mas_reasoncode character varying(24) COLLATE public.nocase,
    mas_created_by character varying(120) NOT NULL COLLATE public.nocase,
    mas_created_date timestamp without time zone NOT NULL,
    mas_modified_by character varying(120) NOT NULL COLLATE public.nocase,
    mas_modified_date timestamp without time zone NOT NULL,
    mas_timestamp integer NOT NULL,
    mas_created_langid integer NOT NULL,
    mas_class character varying(80) COLLATE public.nocase,
    mas_length numeric,
    mas_breadth numeric,
    mas_height numeric,
    mas_max_weight numeric,
    mas_tare_weight numeric,
    mas_dimension_uom character varying(40) COLLATE public.nocase,
    mas_weight_uom character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_uom_mas_uommaster ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_uom_mas_uommaster_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_uom_mas_uommaster
    ADD CONSTRAINT raw_uom_mas_uommaster_pkey PRIMARY KEY (raw_id);