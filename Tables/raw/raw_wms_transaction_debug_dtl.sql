CREATE TABLE raw.raw_wms_transaction_debug_dtl (
    raw_id bigint NOT NULL,
    sessionid integer,
    guid character varying(512) COLLATE public.nocase,
    tran_no character varying(72) COLLATE public.nocase,
    ou integer,
    location character varying(40) COLLATE public.nocase,
    tran_type character varying(100) COLLATE public.nocase,
    line_no integer,
    remarks character varying COLLATE public.nocase,
    loginuser character varying(120) COLLATE public.nocase,
    insertdatetime timestamp without time zone,
    servicename character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_transaction_debug_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_transaction_debug_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_transaction_debug_dtl
    ADD CONSTRAINT raw_wms_transaction_debug_dtl_pkey PRIMARY KEY (raw_id);