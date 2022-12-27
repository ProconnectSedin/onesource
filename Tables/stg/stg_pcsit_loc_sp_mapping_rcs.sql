CREATE TABLE stg.stg_pcsit_loc_sp_mapping_rcs (
    rowid integer NOT NULL,
    sp_id character(40) COLLATE public.nocase,
    loc_id character(40) COLLATE public.nocase,
    created_by character varying(200) COLLATE public.nocase,
    created_date date DEFAULT now(),
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_loc_sp_mapping_rcs ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_loc_sp_mapping_rcs_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_pcsit_loc_sp_mapping_rcs
    ADD CONSTRAINT pk_pcsit_loc_sp_mapping_rcs PRIMARY KEY (rowid);