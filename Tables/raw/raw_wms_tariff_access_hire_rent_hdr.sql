-- Table: raw.raw_wms_tariff_access_hire_rent_hdr

-- DROP TABLE IF EXISTS "raw".raw_wms_tariff_access_hire_rent_hdr;

CREATE TABLE IF NOT EXISTS "raw".raw_wms_tariff_access_hire_rent_hdr
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    wms_tf_acc_hrt_id character varying(72) COLLATE public.nocase NOT NULL,
    wms_tf_acc_hrt_ou integer NOT NULL,
    wms_tf_acc_hrt_desc character varying(1020) COLLATE public.nocase,
    wms_tf_acc_hrt_type_code character varying(32) COLLATE public.nocase,
    wms_tf_acc_hrt_status character varying(32) COLLATE public.nocase,
    wms_tf_acc_hrt_division character varying(64) COLLATE public.nocase,
    wms_tf_acc_hrt_location character varying(64) COLLATE public.nocase,
    wms_tf_acc_hrt_validity_id character varying(72) COLLATE public.nocase,
    wms_tf_acc_hrt_applicability character varying(160) COLLATE public.nocase,
    wms_tf_acc_hrt_type character varying(1020) COLLATE public.nocase,
    wms_tf_acc_hrt_time character varying(1020) COLLATE public.nocase,
    wms_tf_acc_hrt_min_charge_app integer,
    wms_tf_acc_hrt_uom character varying(40) COLLATE public.nocase,
    wms_tf_acc_hrt_from_space character varying(1020) COLLATE public.nocase,
    wms_tf_acc_hrt_to_space character varying(1020) COLLATE public.nocase,
    wms_tf_acc_hrt_timestamp integer,
    wms_tf_acc_hrt_created_by character varying(120) COLLATE public.nocase,
    wms_tf_acc_hrt_created_dt timestamp without time zone,
    wms_tf_acc_hrt_modified_by character varying(120) COLLATE public.nocase,
    wms_tf_acc_hrt_modified_dt timestamp without time zone,
    wms_tf_acc_hrt_multilvl_apprvl integer,
    wms_tf_acc_hrt_previous_status character varying(32) COLLATE public.nocase,
    wms_tf_acc_hrt_fr_sp numeric,
    wms_tf_acc_hrt_to_sp numeric,
    wms_tf_acc_hrt_dec_id character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT wms_tariff_access_hire_rent_hdr_pk PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_wms_tariff_access_hire_rent_hdr
    OWNER to proconnect;