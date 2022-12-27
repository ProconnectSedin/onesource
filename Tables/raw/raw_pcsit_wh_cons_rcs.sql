CREATE TABLE raw.raw_pcsit_wh_cons_rcs (
    raw_id bigint NOT NULL,
    wh_cong_id integer NOT NULL,
    wh_id integer,
    cong_id integer,
    created_by character varying(200) COLLATE public.nocase,
    created_date date DEFAULT now(),
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_wh_cons_rcs ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_wh_cons_rcs_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcsit_wh_cons_rcs ALTER COLUMN wh_cong_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_wh_cons_rcs_wh_cong_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_wh_cons_rcs
    ADD CONSTRAINT raw_pcsit_wh_cons_rcs_pkey PRIMARY KEY (raw_id);