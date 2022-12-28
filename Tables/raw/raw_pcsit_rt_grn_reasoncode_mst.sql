CREATE TABLE raw.raw_pcsit_rt_grn_reasoncode_mst (
    raw_id bigint NOT NULL,
    sapreasons character varying COLLATE public.nocase,
    userreasons character varying COLLATE public.nocase,
    status character varying(30) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_rt_grn_reasoncode_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_rt_grn_reasoncode_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_rt_grn_reasoncode_mst
    ADD CONSTRAINT raw_pcsit_rt_grn_reasoncode_mst_pkey PRIMARY KEY (raw_id);