CREATE TABLE raw.raw_wms_yard_dtl (
    raw_id bigint NOT NULL,
    wms_yard_id character varying(40) NOT NULL COLLATE public.nocase,
    wms_yard_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_yard_ou integer NOT NULL,
    wms_yard_lineno integer NOT NULL,
    wms_yard_parking_slot character varying(72) COLLATE public.nocase,
    wms_yard_parking_status character varying(32) COLLATE public.nocase,
    wms_yard_parking_prevstatus character varying(32) COLLATE public.nocase,
    wms_yard_parking_type character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_yard_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_yard_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_yard_dtl
    ADD CONSTRAINT raw_wms_yard_dtl_pkey PRIMARY KEY (raw_id);