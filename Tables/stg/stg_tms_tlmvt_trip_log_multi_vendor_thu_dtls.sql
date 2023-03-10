CREATE TABLE stg.stg_tms_tlmvt_trip_log_multi_vendor_thu_dtls (
    tlmvt_ouinstance integer NOT NULL,
    tlmvt_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    tlmvt_leg_seq integer NOT NULL,
    tlmvt_trip_dispatch character varying(72) NOT NULL COLLATE public.nocase,
    tlmvt_thu character varying(320) COLLATE public.nocase,
    tlmvt_thu_line character varying(512) COLLATE public.nocase,
    tlmvt_actual_thu_quantity numeric,
    tlmvt_vendor_thu_id character varying(320) COLLATE public.nocase,
    tlmvt_vendor_quantity numeric,
    tlmvt_transfertype character varying(160) COLLATE public.nocase,
    tlmvt_transfer_doc_no character varying(160) COLLATE public.nocase,
    tlmvt_vendor_ac_no character varying(160) COLLATE public.nocase,
    tlmvt_remarks character varying(1020) COLLATE public.nocase,
    tlmvt_guid character varying(512) NOT NULL COLLATE public.nocase,
    tlmvt_timestamp integer,
    tlmvt_created_by character varying(120) COLLATE public.nocase,
    tlmvt_creation_date timestamp without time zone,
    tlmvt_last_modified_by character varying(120) COLLATE public.nocase,
    tlmvt_last_modified_date timestamp without time zone,
    tlmvt_ethu_serial_no character varying(160) COLLATE public.nocase,
    tlmvt_ethu_seal_no character varying(160) COLLATE public.nocase,
    tlmvt_ethu_customs_seal_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_tlmvt_trip_log_multi_vendor_thu_dtls
    ADD CONSTRAINT tms_tlmvt_trip_log_mul_ven_thu_pk PRIMARY KEY (tlmvt_ouinstance, tlmvt_guid);