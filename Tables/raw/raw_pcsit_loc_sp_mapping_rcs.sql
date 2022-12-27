CREATE TABLE raw.raw_pcsit_loc_sp_mapping_rcs (
    raw_id bigint NOT NULL,
    rowid integer NOT NULL,
    sp_id character(40) COLLATE public.nocase,
    loc_id character(40) COLLATE public.nocase,
    created_by character varying(200) COLLATE public.nocase,
    created_date date DEFAULT now(),
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_loc_sp_mapping_rcs ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_loc_sp_mapping_rcs_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcsit_loc_sp_mapping_rcs ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_loc_sp_mapping_rcs_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_loc_sp_mapping_rcs
    ADD CONSTRAINT raw_pcsit_loc_sp_mapping_rcs_pkey PRIMARY KEY (raw_id);