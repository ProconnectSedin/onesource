CREATE TABLE stg.stg_wms_putaway_bin_capacity_dtl (
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pway_pln_ou integer NOT NULL,
    wms_pway_lineno integer NOT NULL,
    wms_pway_item_ln_no integer,
    wms_pway_item character varying(128) COLLATE public.nocase,
    wms_pway_bin character varying(40) COLLATE public.nocase,
    wms_pway_occu_capacity numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_putaway_bin_capacity_dtl
    ADD CONSTRAINT wms_putaway_bin_capacity_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno);

CREATE INDEX stg_wms_putaway_bin_capacity_dtl_idx1 ON stg.stg_wms_putaway_bin_capacity_dtl USING btree (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno);