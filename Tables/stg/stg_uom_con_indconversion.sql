CREATE TABLE stg.stg_uom_con_indconversion (
    con_ouinstance integer NOT NULL,
    con_fromuomcode character varying(40) NOT NULL COLLATE public.nocase,
    con_touomcode character varying(40) NOT NULL COLLATE public.nocase,
    con_confact_ntr numeric NOT NULL,
    con_confact_dtr numeric NOT NULL,
    con_created_by character varying(120) NOT NULL COLLATE public.nocase,
    con_created_date timestamp without time zone NOT NULL,
    con_modified_by character varying(120) NOT NULL COLLATE public.nocase,
    con_modified_date timestamp without time zone NOT NULL,
    con_flag integer,
    con_convert_type character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_uom_con_indconversion
    ADD CONSTRAINT pk_uom_ind_conversion PRIMARY KEY (con_fromuomcode, con_touomcode);