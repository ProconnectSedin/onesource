CREATE TABLE stg.stg_pcsit_bin_unitconversion (
    rowid integer NOT NULL,
    conversion_from character varying(50) DEFAULT ''::character varying COLLATE public.nocase,
    conversion_to character varying(50) DEFAULT ''::character varying COLLATE public.nocase,
    conversion_value numeric DEFAULT 0 NOT NULL,
    del_status integer DEFAULT 0 NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_bin_unitconversion ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_bin_unitconversion_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_pcsit_bin_unitconversion
    ADD CONSTRAINT pk_pcsitd_bin_unitconversion PRIMARY KEY (rowid);