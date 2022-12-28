CREATE TABLE raw.raw_pcsit_bin_unitconversion (
    raw_id bigint NOT NULL,
    rowid integer NOT NULL,
    conversion_from character varying(50) DEFAULT ''::character varying COLLATE public.nocase,
    conversion_to character varying(50) DEFAULT ''::character varying COLLATE public.nocase,
    conversion_value numeric DEFAULT 0 NOT NULL,
    del_status integer DEFAULT 0 NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_bin_unitconversion ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_bin_unitconversion_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcsit_bin_unitconversion ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_bin_unitconversion_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_bin_unitconversion
    ADD CONSTRAINT raw_pcsit_bin_unitconversion_pkey PRIMARY KEY (raw_id);