CREATE TABLE stg.stg_tms_mvtbr_multiple_vendor_thu_br_dtls (
    mvtbr_ouinstance integer NOT NULL,
    mvtbr_booking_req_no character varying(80) NOT NULL COLLATE public.nocase,
    mvtbr_thu character varying(320) COLLATE public.nocase,
    mvtbr_thu_line character varying(512) COLLATE public.nocase,
    mvtbr_thu_quantity numeric,
    mvtbr_actual_thu_quantity numeric,
    mvtbr_vendor_thu_id character varying(320) COLLATE public.nocase,
    mvtbr_transfertype character varying(160) COLLATE public.nocase,
    mvtbr_transfer_doc_no character varying(160) COLLATE public.nocase,
    mvtbr_vendor_ac_no character varying(160) COLLATE public.nocase,
    mvtbr_remarks character varying(1020) COLLATE public.nocase,
    mvtbr_guid character varying(512) NOT NULL COLLATE public.nocase,
    mvtbr_ethu_sealno character varying(160) COLLATE public.nocase,
    mvtbr_ethu_customsealno character varying(160) COLLATE public.nocase,
    mvtbr_ethu_serialno character varying(160) COLLATE public.nocase,
    mvtbr_creation_date timestamp without time zone,
    mvtbr_created_by character varying(120) COLLATE public.nocase,
    mvtbr_last_modified_date timestamp without time zone,
    mvtbr_last_modified_by character varying(120) COLLATE public.nocase,
    mvtbr_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_mvtbr_multiple_vendor_thu_br_dtls
    ADD CONSTRAINT pk_tms_mvtbr_multiple_vendor_thu_br_dtls PRIMARY KEY (mvtbr_ouinstance, mvtbr_guid);