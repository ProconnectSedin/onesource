CREATE TABLE raw.raw_wms_gr_plan_dtl (
    raw_id bigint NOT NULL,
    wms_gr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gr_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gr_pln_ou integer NOT NULL,
    wms_gr_pln_date timestamp without time zone,
    wms_gr_pln_status character varying(32) COLLATE public.nocase,
    wms_gr_po_no character varying(72) COLLATE public.nocase,
    wms_gr_po_date timestamp without time zone,
    wms_gr_asn_no character varying(72) COLLATE public.nocase,
    wms_gr_asn_date timestamp without time zone,
    wms_gr_employee character varying(160) COLLATE public.nocase,
    wms_gr_remarks character varying(1020) COLLATE public.nocase,
    wms_gr_timestamp integer,
    wms_gr_source_stage character varying(1020) COLLATE public.nocase,
    wms_gr_source_docno character varying(72) COLLATE public.nocase,
    wms_gr_created_by character varying(120) COLLATE public.nocase,
    wms_gr_created_date timestamp without time zone,
    wms_gr_modified_by character varying(120) COLLATE public.nocase,
    wms_gr_modified_date timestamp without time zone,
    wms_gr_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_gr_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_gr_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_gr_staging_id character varying(72) COLLATE public.nocase,
    wms_gr_build_uid integer,
    wms_gr_notype character varying(1020) COLLATE public.nocase,
    wms_gr_notype_prefix character varying(1020) COLLATE public.nocase,
    wms_gr_ref_type character varying(1020) COLLATE public.nocase,
    wms_gr_employeename character varying(1020) COLLATE public.nocase,
    wms_gr_refdocno character varying(1020) COLLATE public.nocase,
    wms_gr_remark character varying(1020) COLLATE public.nocase,
    wms_gr_customerserialno character varying(1020) COLLATE public.nocase,
    wms_gr_pln_inv_type character varying(160) COLLATE public.nocase,
    wms_gr_pln_product_status character varying(160) COLLATE public.nocase,
    wms_gr_pln_coo character varying(200) COLLATE public.nocase,
    wms_gr_pln_item_attribute1 character varying(200) COLLATE public.nocase,
    wms_gr_pln_item_attribute2 character varying(200) COLLATE public.nocase,
    wms_gr_pln_item_attribute3 character varying(200) COLLATE public.nocase,
    wms_gr_pln_item_attribute4 character varying(200) COLLATE public.nocase,
    wms_gr_pln_item_attribute5 character varying(200) COLLATE public.nocase,
    wms_gr_pln_item_attribute10 character varying(1024) COLLATE public.nocase,
    wms_gr_pln_item_attribute6 character varying(1024) COLLATE public.nocase,
    wms_gr_stag_id character varying(1020) COLLATE public.nocase,
    wms_gr_pln_item_attribute7 character varying(1024) COLLATE public.nocase,
    wms_gr_pln_item_attribute8 character varying(1024) COLLATE public.nocase,
    wms_gr_pln_item_attribute9 character varying(1024) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gr_plan_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gr_plan_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gr_plan_dtl
    ADD CONSTRAINT raw_wms_gr_plan_dtl_pkey PRIMARY KEY (raw_id);