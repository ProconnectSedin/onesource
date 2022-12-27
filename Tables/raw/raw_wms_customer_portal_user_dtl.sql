CREATE TABLE raw.raw_wms_customer_portal_user_dtl (
    raw_id bigint NOT NULL,
    wms_customer_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_customer_ou integer NOT NULL,
    wms_customer_lineno integer NOT NULL,
    wms_customer_user_id character varying(160) COLLATE public.nocase,
    wms_customer_role character varying(160) COLLATE public.nocase,
    wms_customer_wms integer,
    wms_customer_tms integer,
    wms_customer_addl_custmap character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_customer_portal_user_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_customer_portal_user_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_customer_portal_user_dtl
    ADD CONSTRAINT raw_wms_customer_portal_user_dtl_pkey PRIMARY KEY (raw_id);