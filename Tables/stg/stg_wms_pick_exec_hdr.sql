CREATE TABLE stg.stg_wms_pick_exec_hdr (
    wms_pick_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pick_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pick_exec_ou integer NOT NULL,
    wms_pick_exec_date timestamp without time zone,
    wms_pick_exec_status character varying(32) COLLATE public.nocase,
    wms_pick_pln_no character varying(72) COLLATE public.nocase,
    wms_pick_employee character varying(80) COLLATE public.nocase,
    wms_pick_mhe character varying(120) COLLATE public.nocase,
    wms_pick_staging_id character varying(72) COLLATE public.nocase,
    wms_pick_exec_start_date timestamp without time zone,
    wms_pick_exec_end_date timestamp without time zone,
    wms_pick_created_by character varying(120) COLLATE public.nocase,
    wms_pick_created_date timestamp without time zone,
    wms_pick_modified_by character varying(120) COLLATE public.nocase,
    wms_pick_modified_date timestamp without time zone,
    wms_pick_timestamp integer,
    wms_pick_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_pick_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_pick_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_pick_billing_status character varying(32) COLLATE public.nocase,
    wms_pick_bill_value numeric,
    wms_pick_steps character varying(80) COLLATE public.nocase,
    wms_pk_exe_urgent_cb character varying(1020) COLLATE public.nocase,
    wms_pick_gen_from character varying(32) COLLATE public.nocase,
    wms_pick_pln_type character varying(32) DEFAULT 'NR'::character varying COLLATE public.nocase,
    wms_pick_zone_pickby character varying(32) COLLATE public.nocase,
    wms_pick_reset_flg character varying(32) COLLATE public.nocase,
    wms_pick_system_date timestamp without time zone DEFAULT now(),
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_pick_exec_hdr
    ADD CONSTRAINT pk_wms_pick_exec_hdr PRIMARY KEY (wms_pick_loc_code, wms_pick_exec_no, wms_pick_exec_ou);