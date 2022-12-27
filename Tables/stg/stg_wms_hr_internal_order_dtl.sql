CREATE TABLE stg.stg_wms_hr_internal_order_dtl (
    wms_in_ord_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_in_ord_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_in_ord_lineno integer NOT NULL,
    wms_in_ord_ou integer NOT NULL,
    wms_in_ord_resource character varying(1020) COLLATE public.nocase,
    wms_in_ord_resource_typ character varying(1020) COLLATE public.nocase,
    wms_in_ord_unit character varying(160) COLLATE public.nocase,
    wms_in_ord_uom character varying(40) COLLATE public.nocase,
    wms_in_ord_from_date timestamp without time zone,
    wms_in_ord_to_date timestamp without time zone,
    wms_in_ord_tariff_id character varying(72) COLLATE public.nocase,
    wms_in_ord_bill_status character varying(32) COLLATE public.nocase,
    wms_in_ord_last_bil_date timestamp without time zone,
    wms_in_ord_cost numeric,
    wms_in_ord_cust_code character varying(72) COLLATE public.nocase,
    wms_in_ord_reimb_last_bil_date timestamp without time zone,
    wms_in_ord_reimb_bill_status character varying(32) COLLATE public.nocase,
    wms_in_ord_remarks character varying(1020) COLLATE public.nocase,
    wms_in_ord_tariff_desc character varying(1020) COLLATE public.nocase,
    wms_in_ord_pri_ref_doc_type character varying(160) COLLATE public.nocase,
    wms_in_ord_pri_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_in_ord_sub_srv_type character varying(160) COLLATE public.nocase,
    wms_in_ord_srv_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_hr_internal_order_dtl
    ADD CONSTRAINT wms_hr_internal_order_dtl_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou);