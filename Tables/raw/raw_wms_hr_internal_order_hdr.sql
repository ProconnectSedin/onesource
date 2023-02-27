-- Table: raw.raw_wms_hr_internal_order_hdr

-- DROP TABLE IF EXISTS "raw".raw_wms_hr_internal_order_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_wms_hr_internal_order_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    wms_in_ord_location character varying(40) COLLATE public.nocase NOT NULL,
    wms_in_ord_no character varying(72) COLLATE public.nocase NOT NULL,
    wms_in_ord_ou integer NOT NULL,
    wms_in_ord_contract_id character varying(72) COLLATE public.nocase,
    wms_in_ord_date timestamp without time zone,
    wms_in_ord_typ character varying(32) COLLATE public.nocase,
    wms_in_ord_status character varying(32) COLLATE public.nocase,
    wms_in_ord_customer_id character varying(72) COLLATE public.nocase,
    wms_in_ord_vendor_id character varying(64) COLLATE public.nocase,
    wms_in_ord_pri_ref_doc_typ character varying(160) COLLATE public.nocase,
    wms_in_ord_pri_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_in_ord_pri_ref_doc_date timestamp without time zone,
    wms_in_ord_sec_ref_doc_typ character varying(160) COLLATE public.nocase,
    wms_in_ord_sec_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_in_ord_sec_ref_doc_date timestamp without time zone,
    wms_in_ord_amendno integer,
    wms_in_ord_timestamp integer,
    wms_in_ord_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_in_ord_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_in_ord_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_in_createdby character varying(120) COLLATE public.nocase,
    wms_in_created_date timestamp without time zone,
    wms_in_modifiedby character varying(120) COLLATE public.nocase,
    wms_in_modified_date timestamp without time zone,
    wms_in_ord_desc character varying(1020) COLLATE public.nocase,
    wms_in_ord_division character varying(40) COLLATE public.nocase,
    wms_in_ord_workflow_sts character varying(1020) COLLATE public.nocase,
    wms_in_ord_rerurn_for_reason character varying(1020) COLLATE public.nocase,
    wms_in_ord_cont_srv_type character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_wms_hr_internal_order_hdr_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_wms_hr_internal_order_hdr
    OWNER to proconnect;