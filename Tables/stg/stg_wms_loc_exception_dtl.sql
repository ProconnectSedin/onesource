CREATE TABLE stg.stg_wms_loc_exception_dtl (
    wms_loc_exc_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_exc_ou integer NOT NULL,
    wms_loc_exc_lineno integer NOT NULL,
    wms_loc_exc_date timestamp without time zone,
    wms_loc_exc_day character varying(160) COLLATE public.nocase,
    wms_loc_exc_shift_code character varying(160) COLLATE public.nocase,
    wms_loc_exc_shift_seqno integer NOT NULL,
    wms_loc_exc_holiday_code character varying(160) COLLATE public.nocase,
    wms_loc_state character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_loc_exception_dtl
    ADD CONSTRAINT wms_loc_exception_dtl_pk PRIMARY KEY (wms_loc_exc_loc_code, wms_loc_exc_ou, wms_loc_exc_lineno, wms_loc_exc_shift_seqno);