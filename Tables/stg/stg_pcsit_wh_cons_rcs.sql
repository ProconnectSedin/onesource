CREATE TABLE stg.stg_pcsit_wh_cons_rcs (
    wh_cong_id integer NOT NULL,
    wh_id integer,
    cong_id integer,
    created_by character varying(200) COLLATE public.nocase,
    created_date date DEFAULT now(),
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_wh_cons_rcs ALTER COLUMN wh_cong_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_wh_cons_rcs_wh_cong_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_pcsit_wh_cons_rcs
    ADD CONSTRAINT pk_pcsit_wh_cons_rcs PRIMARY KEY (wh_cong_id);