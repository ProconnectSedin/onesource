CREATE TABLE raw.raw_pcsit_lbh_weight_validation_tbl (
    raw_id bigint NOT NULL,
    tranou integer,
    locationcode character varying(100) COLLATE public.nocase,
    lvalue numeric,
    hvalue numeric,
    bvalue numeric,
    netwt numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_lbh_weight_validation_tbl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_lbh_weight_validation_tbl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_lbh_weight_validation_tbl
    ADD CONSTRAINT raw_pcsit_lbh_weight_validation_tbl_pkey PRIMARY KEY (raw_id);