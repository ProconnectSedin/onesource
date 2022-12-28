CREATE TABLE stg.stg_wms_putaway_exec_dtl (
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pway_exec_ou integer NOT NULL,
    wms_pway_pln_no character varying(72) COLLATE public.nocase,
    wms_pway_pln_ou integer,
    wms_pway_exec_status character varying(32) NOT NULL COLLATE public.nocase,
    wms_pway_stag_id character varying(72) COLLATE public.nocase,
    wms_pway_mhe_id character varying(120) COLLATE public.nocase,
    wms_pway_employee_id character varying(80) COLLATE public.nocase,
    wms_pway_exec_start_date timestamp without time zone,
    wms_pway_exec_end_date timestamp without time zone,
    wms_pway_completed integer,
    wms_pway_created_by character varying(120) COLLATE public.nocase,
    wms_pway_created_date timestamp without time zone,
    wms_pway_modified_by character varying(120) COLLATE public.nocase,
    wms_pway_modified_date timestamp without time zone,
    wms_pway_timestamp integer,
    wms_pway_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_pway_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_pway_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_pway_billing_status character varying(32) COLLATE public.nocase,
    wms_pway_bill_value numeric,
    wms_pway_hdlpway_bil_status character varying(32) COLLATE public.nocase,
    wms_pway_lbchprhr_bil_status character varying(32) COLLATE public.nocase,
    wms_pway_pwaytchr_bil_status character varying(32) COLLATE public.nocase,
    wms_pway_hdlchcar_bil_status character varying(32) COLLATE public.nocase,
    wms_pway_type character varying(32) COLLATE public.nocase,
    wms_pway_by_flag character varying(32) COLLATE public.nocase,
    wms_pway_gen_from character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_putaway_exec_dtl
    ADD CONSTRAINT wms_putaway_exec_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_exec_no, wms_pway_exec_ou);

CREATE INDEX stg_wms_putaway_exec_dtl_key_idx1 ON stg.stg_wms_putaway_exec_dtl USING btree (wms_pway_loc_code, wms_pway_exec_no, wms_pway_exec_ou);