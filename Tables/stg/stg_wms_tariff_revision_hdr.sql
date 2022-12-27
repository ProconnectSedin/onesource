CREATE TABLE stg.stg_wms_tariff_revision_hdr (
    wms_tf_rev_validity_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_tf_rev_ou integer NOT NULL,
    wms_tf_rev_no integer,
    wms_tf_rev_desc character varying(1020) COLLATE public.nocase,
    wms_tf_rev_valid_from timestamp without time zone,
    wms_tf_rev_valid_to timestamp without time zone,
    wms_tf_rev_timestamp integer,
    wms_tf_rev_created_by character varying(120) COLLATE public.nocase,
    wms_tf_rev_created_dt timestamp without time zone,
    wms_tf_rev_modified_by character varying(120) COLLATE public.nocase,
    wms_tf_rev_modified_dt timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_tariff_revision_hdr
    ADD CONSTRAINT wms_tariff_revision_hdr_pk PRIMARY KEY (wms_tf_rev_validity_id, wms_tf_rev_ou);