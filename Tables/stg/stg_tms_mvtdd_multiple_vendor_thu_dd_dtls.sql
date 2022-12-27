CREATE TABLE stg.stg_tms_mvtdd_multiple_vendor_thu_dd_dtls (
    mvtdd_ouinstance integer NOT NULL,
    mvtdd_dispatch_no character varying(80) NOT NULL COLLATE public.nocase,
    mvtdd_thu character varying(320) COLLATE public.nocase,
    mvtdd_thu_line character varying(512) COLLATE public.nocase,
    mvtdd_thu_quantity numeric,
    mvtdd_actual_thu_quantity numeric,
    mvtdd_vendor_thu_id character varying(320) COLLATE public.nocase,
    mvtdd_transfertype character varying(160) COLLATE public.nocase,
    mvtdd_transfer_doc_no character varying(160) COLLATE public.nocase,
    mvtdd_vendor_ac_no character varying(160) COLLATE public.nocase,
    mvtdd_remarks character varying(1020) COLLATE public.nocase,
    mvtdd_guid character varying(512) NOT NULL COLLATE public.nocase,
    mvtdd_timestamp integer,
    mvtdd_created_by character varying(120) COLLATE public.nocase,
    mvtdd_creation_date timestamp without time zone,
    mvtdd_last_modified_by character varying(120) COLLATE public.nocase,
    mvtdd_last_modified_date timestamp without time zone,
    mvtdd_ethu_serial_no character varying(160) COLLATE public.nocase,
    mvtdd_ethu_seal_no character varying(160) COLLATE public.nocase,
    mvtdd_ethu_custom_seal_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_mvtdd_multiple_vendor_thu_dd_dtls
    ADD CONSTRAINT pk_tms_mvtdd_multiple_vendor_thu_dd_dtls PRIMARY KEY (mvtdd_ouinstance, mvtdd_dispatch_no, mvtdd_guid);