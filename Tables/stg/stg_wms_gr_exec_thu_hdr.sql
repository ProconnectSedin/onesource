CREATE TABLE stg.stg_wms_gr_exec_thu_hdr (
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_exec_ou integer NOT NULL,
    wms_gr_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_gr_thu_sno character varying(112) NOT NULL COLLATE public.nocase,
    wms_gr_thu_desc character varying(1020) COLLATE public.nocase,
    wms_gr_thu_class character varying(160) COLLATE public.nocase,
    wms_gr_thu_qty numeric,
    wms_gr_thu_owner character varying(160) COLLATE public.nocase,
    wms_gr_thu_consumables character varying(128) COLLATE public.nocase,
    wms_gr_thu_sr_status character varying(32) COLLATE public.nocase,
    wms_gr_thu_tod character varying(160) COLLATE public.nocase,
    wms_gr_thu_su character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_thu_uid_ser_no character varying(160) NOT NULL COLLATE public.nocase,
    wms_gr_pal_status character varying(160) COLLATE public.nocase,
    wms_gr_thu_consumables_qty numeric,
    wms_gr_thu_su2 character varying(40) COLLATE public.nocase,
    wms_gr_thu_uid2_ser_no character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_gr_exec_thu_hdr
    ADD CONSTRAINT wms_gr_exec_thu_hdr_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou, wms_gr_thu_id, wms_gr_thu_sno, wms_gr_thu_su, wms_gr_thu_uid_ser_no);