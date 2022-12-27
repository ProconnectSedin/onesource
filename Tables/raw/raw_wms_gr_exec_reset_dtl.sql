CREATE TABLE raw.raw_wms_gr_exec_reset_dtl (
    raw_id bigint NOT NULL,
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_ou integer NOT NULL,
    wms_gr_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_lineno integer NOT NULL,
    wms_gr_plan_no character varying(72) COLLATE public.nocase,
    wms_gr_asn_serialno integer,
    wms_gr_po_no character varying(72) COLLATE public.nocase,
    wms_gr_asn_no character varying(72) COLLATE public.nocase,
    wms_gr_asn_line_no integer,
    wms_gr_cust_ser_no character varying(160) COLLATE public.nocase,
    wms_gr_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_gr_remarks character varying(1020) COLLATE public.nocase,
    wms_gr_item character varying(128) COLLATE public.nocase,
    wms_gr_item_desc character varying(3000) COLLATE public.nocase,
    wms_gr_asn_qty numeric,
    wms_gr_mst_uom character varying(40) COLLATE public.nocase,
    wms_gr_consignee character varying(160) COLLATE public.nocase,
    wms_gr_best_bef_date timestamp without time zone,
    wms_gr_supp_batch_no character varying(112) COLLATE public.nocase,
    wms_gr_exp_date timestamp without time zone,
    wms_asn_outbd_no character varying(72) COLLATE public.nocase,
    wms_asn_outbd_qty numeric,
    wms_gr_acpt_qty numeric,
    wms_gr_po_sno character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gr_exec_reset_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gr_exec_reset_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gr_exec_reset_dtl
    ADD CONSTRAINT raw_wms_gr_exec_reset_dtl_pkey PRIMARY KEY (raw_id);