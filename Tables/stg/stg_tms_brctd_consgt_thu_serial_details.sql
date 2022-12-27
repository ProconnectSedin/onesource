CREATE TABLE stg.stg_tms_brctd_consgt_thu_serial_details (
    ctsd_ouinstance integer NOT NULL,
    ctsd_br_id character varying(72) NOT NULL COLLATE public.nocase,
    ctsd_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ctsd_thu_serial_line_no character varying(512) NOT NULL COLLATE public.nocase,
    ctsd_serial_no character varying(160) COLLATE public.nocase,
    ctsd_seat_no character varying(160) COLLATE public.nocase,
    ctsd_un_code character varying(160) COLLATE public.nocase,
    ctsd_class_code character varying(160) COLLATE public.nocase,
    ctsd_hs_code character varying(160) COLLATE public.nocase,
    ctsd_hazmat_code character varying(160) COLLATE public.nocase,
    ctsd_hac_code character(4) COLLATE public.nocase,
    ctsd_length numeric,
    ctsd_breadth numeric,
    ctsd_height numeric,
    ctsd_lbh_uom character varying(60) COLLATE public.nocase,
    ctsd_gross_weight numeric,
    ctsd_gross_weight_uom character varying(60) COLLATE public.nocase,
    ctsd_created_date timestamp without time zone,
    ctsd_created_by character varying(120) COLLATE public.nocase,
    ctsd_last_modified_by character varying(120) COLLATE public.nocase,
    ctsd_last_modified_date timestamp without time zone,
    ctsd_altqty numeric,
    ctsd_altqty_uom character varying(60) COLLATE public.nocase,
    ctsd_customer_serial_no character varying(160) COLLATE public.nocase,
    ctsd_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_brctd_consgt_thu_serial_details
    ADD CONSTRAINT pk_tms_brctd_consgt_thu_serial_details PRIMARY KEY (ctsd_ouinstance, ctsd_thu_line_no, ctsd_thu_serial_line_no);