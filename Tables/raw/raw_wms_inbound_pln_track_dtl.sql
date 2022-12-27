CREATE TABLE raw.raw_wms_inbound_pln_track_dtl (
    raw_id bigint NOT NULL,
    wms_pln_lineno integer NOT NULL,
    wms_pln_ou integer NOT NULL,
    wms_pln_stage character varying(32) COLLATE public.nocase,
    wms_pln_pln_no character varying(72) COLLATE public.nocase,
    wms_pln_exe_no character varying(72) COLLATE public.nocase,
    wms_pln_exe_status character varying(32) COLLATE public.nocase,
    wms_pln_user character varying(120) COLLATE public.nocase,
    wms_pln_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_inbound_pln_track_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_inbound_pln_track_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_inbound_pln_track_dtl
    ADD CONSTRAINT raw_wms_inbound_pln_track_dtl_pkey PRIMARY KEY (raw_id);