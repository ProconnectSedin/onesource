CREATE TABLE stg.stg_wms_bin_plan_hdr (
    wms_bin_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bin_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_bin_pln_ou integer NOT NULL,
    wms_bin_pln_date timestamp without time zone,
    wms_bin_pln_status character varying(32) COLLATE public.nocase,
    wms_bin_mhe character varying(120) COLLATE public.nocase,
    wms_bin_employee character varying(80) COLLATE public.nocase,
    wms_bin_created_by character varying(120) COLLATE public.nocase,
    wms_bin_created_date timestamp without time zone,
    wms_bin_modified_by character varying(120) COLLATE public.nocase,
    wms_bin_modified_date timestamp without time zone,
    wms_bin_timestamp integer,
    wms_bin_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_bin_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_bin_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_bin_refdoc_no character varying(72) COLLATE public.nocase,
    wms_bin_gen_from character varying(32) COLLATE public.nocase,
    wms_bin_source_docno character varying(72) COLLATE public.nocase,
    wms_bin_source_stage character varying(1020) COLLATE public.nocase,
    wms_bin_fr_insp integer,
    wms_bin_mul_repl character varying(32) COLLATE public.nocase,
    wms_bin_first_pln_no character varying(72) COLLATE public.nocase,
    wms_bin_comp_flag character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_bin_plan_hdr
    ADD CONSTRAINT wms_bin_plan_hdr_pk PRIMARY KEY (wms_bin_loc_code, wms_bin_pln_no, wms_bin_pln_ou);

CREATE INDEX stg_wms_bin_plan_hdr_key_idx2 ON stg.stg_wms_bin_plan_hdr USING btree (wms_bin_loc_code, wms_bin_pln_no, wms_bin_pln_ou);