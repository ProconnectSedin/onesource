CREATE TABLE raw.raw_pcsit_obd_sadsap_dtl (
    raw_id bigint NOT NULL,
    location character varying(200) COLLATE public.nocase,
    itemcode character varying(200) COLLATE public.nocase,
    qty character varying(200) COLLATE public.nocase,
    flag character(2) COLLATE public.nocase,
    guid character varying(255) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_obd_sadsap_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_obd_sadsap_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_obd_sadsap_dtl
    ADD CONSTRAINT raw_pcsit_obd_sadsap_dtl_pkey PRIMARY KEY (raw_id);