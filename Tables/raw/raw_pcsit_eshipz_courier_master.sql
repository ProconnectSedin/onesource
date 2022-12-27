CREATE TABLE raw.raw_pcsit_eshipz_courier_master (
    raw_id bigint NOT NULL,
    agentname character varying(400) COLLATE public.nocase,
    agentid character varying(40) COLLATE public.nocase,
    courier_name character varying(2000) COLLATE public.nocase,
    ramco_id character varying(600) COLLATE public.nocase,
    createdby character varying(200) COLLATE public.nocase,
    createddate date,
    location_code character varying(400) COLLATE public.nocase,
    location character varying(30) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_eshipz_courier_master ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_eshipz_courier_master_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_eshipz_courier_master
    ADD CONSTRAINT raw_pcsit_eshipz_courier_master_pkey PRIMARY KEY (raw_id);