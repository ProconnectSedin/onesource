CREATE TABLE stg.stg_wms_putaway_plan_dtl (
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pway_pln_ou integer NOT NULL,
    wms_pway_pln_date timestamp without time zone,
    wms_pway_pln_status character varying(32) NOT NULL COLLATE public.nocase,
    wms_pway_stag_id character varying(72) COLLATE public.nocase,
    wms_pway_mhe_id character varying(120) COLLATE public.nocase,
    wms_pway_employee_id character varying(80) COLLATE public.nocase,
    wms_pway_source_stage character varying(1020) COLLATE public.nocase,
    wms_pway_source_docno character varying(72) COLLATE public.nocase,
    wms_pway_created_by character varying(120) COLLATE public.nocase,
    wms_pway_created_date timestamp without time zone,
    wms_pway_modified_by character varying(120) COLLATE public.nocase,
    wms_pway_modified_date timestamp without time zone,
    wms_pway_timestamp integer,
    wms_pway_output_pln character varying(1020) COLLATE public.nocase,
    wms_pway_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_pway_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_pway_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_pway_type character varying(32) COLLATE public.nocase,
    wms_pway_comp_flag character varying(32) COLLATE public.nocase,
    wms_pway_first_pln_no character varying(72) COLLATE public.nocase,
    wms_pway_by_flag character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_putaway_plan_dtl
    ADD CONSTRAINT wms_putaway_plan_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou);

CREATE INDEX stg_wms_putaway_plan_dtl_key_idx1 ON stg.stg_wms_putaway_plan_dtl USING btree (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou);