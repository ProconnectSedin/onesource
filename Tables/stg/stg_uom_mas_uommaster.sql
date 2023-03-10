CREATE TABLE stg.stg_uom_mas_uommaster (
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

ALTER TABLE ONLY stg.stg_uom_mas_uommaster
    ADD CONSTRAINT pk_uom_mas_uommaster PRIMARY KEY (mas_uomcode);