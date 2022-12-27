CREATE TABLE raw.raw_pcsit_ext_item_master (
    raw_id bigint NOT NULL,
    item_code character varying(250) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_ext_item_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_ext_item_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_ext_item_master
    ADD CONSTRAINT raw_pcsit_ext_item_master_pkey PRIMARY KEY (raw_id);