CREATE TABLE raw.raw_pcsit_pod_saved_dtl (
    raw_id bigint NOT NULL,
    row_id integer NOT NULL,
    customer_id character varying(40) COLLATE public.nocase,
    invoice_no character varying(1000) COLLATE public.nocase,
    awb_no character varying(1000) COLLATE public.nocase,
    pod_name character varying(1000) COLLATE public.nocase,
    pod_path character varying(1000) COLLATE public.nocase,
    created_date timestamp without time zone,
    racmo_status character varying(1000) COLLATE public.nocase,
    updated_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_pod_saved_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_pod_saved_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcsit_pod_saved_dtl ALTER COLUMN row_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_pod_saved_dtl_row_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_pod_saved_dtl
    ADD CONSTRAINT raw_pcsit_pod_saved_dtl_pkey PRIMARY KEY (raw_id);