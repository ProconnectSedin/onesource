CREATE TABLE stg.stg_wms_pick_emp_equip_map_dtl (
    wms_pick_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pick_ou integer NOT NULL,
    wms_pick_lineno integer NOT NULL,
    wms_pick_shift_code character varying(160) COLLATE public.nocase,
    wms_pick_emp_code character varying(80) COLLATE public.nocase,
    wms_pick_euip_code character varying(120) COLLATE public.nocase,
    wms_pick_area character varying(1020) COLLATE public.nocase,
    wms_pick_zone character varying(40) COLLATE public.nocase,
    wms_pick_bin_level character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_pick_emp_equip_map_dtl
    ADD CONSTRAINT wms_pick_emp_equip_map_dtl_pkey PRIMARY KEY (wms_pick_loc_code, wms_pick_ou, wms_pick_lineno);

CREATE INDEX stg_wms_pick_emp_equip_map_dtl_idx ON stg.stg_wms_pick_emp_equip_map_dtl USING btree (wms_pick_loc_code, wms_pick_ou, wms_pick_lineno);