CREATE TABLE stg.stg_pcsit_bin_unitconversion (
    rowid integer NOT NULL,
    conversion_from character varying(50) DEFAULT ''::character varying COLLATE public.nocase,
    conversion_to character varying(50) DEFAULT ''::character varying COLLATE public.nocase,
    conversion_value numeric DEFAULT 0 NOT NULL,
    del_status integer DEFAULT 0 NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);