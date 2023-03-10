CREATE TABLE raw.raw_wms_gr_thu_dtl (
    raw_id bigint NOT NULL,
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_pln_ou integer NOT NULL,
    wms_gr_lineno integer NOT NULL,
    wms_gr_po_no character varying(72) COLLATE public.nocase,
    wms_gr_thu_id character varying(160) COLLATE public.nocase,
    wms_gr_thu_desc character varying(1020) COLLATE public.nocase,
    wms_gr_thu_class character varying(160) COLLATE public.nocase,
    wms_gr_thu_sno character varying(112) COLLATE public.nocase,
    wms_gr_thu_qty numeric,
    wms_gr_thu_owner character varying(1020) COLLATE public.nocase,
    wms_gr_thu_tod character varying(160) COLLATE public.nocase,
    wms_gr_pal_status character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gr_thu_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gr_thu_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gr_thu_dtl
    ADD CONSTRAINT raw_wms_gr_thu_dtl_pkey PRIMARY KEY (raw_id);