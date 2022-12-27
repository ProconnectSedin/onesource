CREATE TABLE stg.stg_wms_tariff_type_master (
    wms_tar_lineno integer NOT NULL,
    wms_tar_ou integer NOT NULL,
    wms_tar_applicability integer,
    wms_tar_scr_code character varying(32) NOT NULL COLLATE public.nocase,
    wms_tar_type_code character varying(32) NOT NULL COLLATE public.nocase,
    wms_tar_tf_type character varying(1020) COLLATE public.nocase,
    wms_tar_display_tf_type character varying(1020) COLLATE public.nocase,
    wms_tar_created_by character varying(120) COLLATE public.nocase,
    wms_tar_created_date timestamp without time zone,
    wms_tar_modified_by character varying(120) COLLATE public.nocase,
    wms_tar_modified_date timestamp without time zone,
    wms_tar_timestamp integer,
    wms_tar_revenue_split character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_wms_tariff_type_master ALTER COLUMN wms_tar_lineno ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_wms_tariff_type_master_wms_tar_lineno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY stg.stg_wms_tariff_type_master
    ADD CONSTRAINT wms_tariff_type_master_pk PRIMARY KEY (wms_tar_lineno, wms_tar_ou);