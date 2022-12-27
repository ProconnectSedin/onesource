CREATE TABLE stg.stg_tms_brctcd_consgt_thu_child_details (
    ctcd_ouinstance integer NOT NULL,
    ctcd_br_id character varying(72) NOT NULL COLLATE public.nocase,
    ctcd_br_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ctcd_child_thu character varying(160) COLLATE public.nocase,
    ctcd_child_thu_serial_no character varying(160) COLLATE public.nocase,
    ctcd_child_thu_qty numeric,
    ctcd_creation_date timestamp without time zone,
    ctcd_created_by character varying(120) COLLATE public.nocase,
    ctcd_last_modified_date timestamp without time zone,
    ctcd_last_modified_by character varying(120) COLLATE public.nocase,
    ctcd_child_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ctcd_child_thu_main_serial_no character varying(160) COLLATE public.nocase,
    ctcd_un_code character varying(160) COLLATE public.nocase,
    ctcd_hs_code character varying(160) COLLATE public.nocase,
    ctcd_hazmat_code character varying(160) COLLATE public.nocase,
    ctcd_hac_code character varying(160) COLLATE public.nocase,
    ctcd_class_code character varying(160) COLLATE public.nocase,
    ctcd_child_thu_length numeric,
    ctcd_child_thu_breadth numeric,
    ctcd_child_thu_height numeric,
    ctcd_child_thu_lbh_uom character varying(60) COLLATE public.nocase,
    ctcd_child_thu_gross_weight numeric,
    ctcd_child_thu_weight_uom character varying(60) COLLATE public.nocase,
    ctcd_chargeble_weight numeric,
    ctcd_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_brctcd_consgt_thu_child_details
    ADD CONSTRAINT pk_tms_brctcd_consgt_thu_child_details PRIMARY KEY (ctcd_ouinstance, ctcd_br_line_no, ctcd_child_thu_line_no);