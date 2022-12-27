CREATE TABLE raw.raw_wms_gate_exception_dtl (
    raw_id bigint NOT NULL,
    wms_gate_exc_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gate_exc_ou integer NOT NULL,
    wms_gate_exc_lineno integer NOT NULL,
    wms_gate_exc_date timestamp without time zone,
    wms_gate_exc_day character varying(160) COLLATE public.nocase,
    wms_gate_exc_shift_code character varying(160) COLLATE public.nocase,
    wms_gate_exc_shift_seqno integer NOT NULL,
    wms_gate_timestamp integer,
    wms_gate_created_by character varying(120) COLLATE public.nocase,
    wms_gate_created_date timestamp without time zone,
    wms_gate_modified_by character varying(120) COLLATE public.nocase,
    wms_gate_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gate_exception_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gate_exception_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gate_exception_dtl
    ADD CONSTRAINT raw_wms_gate_exception_dtl_pkey PRIMARY KEY (raw_id);