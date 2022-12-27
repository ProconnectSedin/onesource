CREATE TABLE stg.stg_sng_automail_pcklist (
    execid integer NOT NULL,
    wms_pack_exec_no character varying(400) COLLATE public.nocase,
    wms_pack_obd_no character varying(200) COLLATE public.nocase,
    created_date timestamp without time zone DEFAULT now(),
    status character(40) DEFAULT 'NEW'::bpchar COLLATE public.nocase,
    wms_pack_exec_end_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_sng_automail_pcklist ALTER COLUMN execid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_sng_automail_pcklist_execid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_sng_automail_pcklist
    ADD CONSTRAINT pk_sng_automail_pcklist PRIMARY KEY (execid);