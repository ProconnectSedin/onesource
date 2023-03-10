CREATE TABLE raw.raw_wms_internal_order_hdr (
    raw_id bigint NOT NULL,
    wms_in_ord_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_in_ord_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_in_ord_ou integer NOT NULL,
    wms_in_ord_date timestamp without time zone,
    wms_in_ord_ref_doc_typ character varying(32) COLLATE public.nocase,
    wms_in_ord_customer_id character varying(72) COLLATE public.nocase,
    wms_in_ord_pri_ref_doc_typ character varying(160) COLLATE public.nocase,
    wms_in_ord_pri_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_in_ord_pri_ref_doc_date timestamp without time zone,
    wms_in_ord_sec_ref_doc_typ character varying(160) COLLATE public.nocase,
    wms_in_ord_sec_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_in_ord_sec_ref_doc_date timestamp without time zone,
    wms_in_ord_status character varying(32) COLLATE public.nocase,
    wms_in_ord_amendno integer,
    wms_in_ord_timestamp integer,
    wms_in_ord_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_in_ord_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_in_ord_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_in_createdby character varying(120) COLLATE public.nocase,
    wms_in_created_date timestamp without time zone,
    wms_in_modifiedby character varying(120) COLLATE public.nocase,
    wms_in_modified_date timestamp without time zone,
    wms_in_ord_contract_id character varying(72) COLLATE public.nocase,
    wms_in_ord_contract_amend_no integer,
    wms_in_ordprfee_bil_status character varying(32) COLLATE public.nocase,
    wms_in_ord_wf_status character varying(1020) COLLATE public.nocase,
    wms_in_ord_reasonforreturn character varying(1020) COLLATE public.nocase,
    wms_in_ord_stk_acc_level character varying(160) COLLATE public.nocase,
    wms_in_chporcn_sell_bil_status character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_internal_order_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_internal_order_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_internal_order_hdr
    ADD CONSTRAINT raw_wms_internal_order_hdr_pkey PRIMARY KEY (raw_id);