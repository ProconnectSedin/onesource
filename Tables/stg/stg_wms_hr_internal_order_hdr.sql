-- Table: stg.stg_wms_hr_internal_order_hdr

-- DROP TABLE IF EXISTS stg.stg_wms_hr_internal_order_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_wms_hr_internal_order_hdr
(
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
    CONSTRAINT wms_hr_internal_order_hdr_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_wms_hr_internal_order_hdr
    OWNER to proconnect;
-- Index: stg_wms_hr_internal_order_hdr_idx

-- DROP INDEX IF EXISTS stg.stg_wms_hr_internal_order_hdr_idx;

CREATE INDEX IF NOT EXISTS stg_wms_hr_internal_order_hdr_idx
    ON stg.stg_wms_hr_internal_order_hdr USING btree
    (wms_in_ord_ou ASC NULLS LAST, wms_in_ord_no COLLATE public.nocase ASC NULLS LAST, wms_in_ord_location COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;