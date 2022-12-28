CREATE TABLE stg.stg_wms_vendor_holidays_dtl (
    wms_vendor_id character varying(64) NOT NULL COLLATE public.nocase,
    wms_vendor_ou integer NOT NULL,
    wms_vendor_lineno integer NOT NULL,
    wms_vendor_holiday_calendar character varying(1020) COLLATE public.nocase,
    wms_vendor_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_vendor_holidays_dtl
    ADD CONSTRAINT wms_vendor_holidays_dtl_pk PRIMARY KEY (wms_vendor_id, wms_vendor_ou, wms_vendor_lineno);