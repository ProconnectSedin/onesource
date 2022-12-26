CREATE TABLE click.f_putaway (
    pway_key bigint NOT NULL,
    pway_pln_dtl_key bigint NOT NULL,
    pway_pln_itm_dtl_key bigint NOT NULL,
    pway_itm_dtl_key bigint NOT NULL,
    pway_exe_dtl_key bigint NOT NULL,
    grn_key bigint NOT NULL,
    pway_pln_dtl_loc_key bigint NOT NULL,
    pway_pln_dtl_date_key bigint NOT NULL,
    pway_pln_dtl_stg_mas_key bigint NOT NULL,
    pway_pln_dtl_emp_hdr_key bigint NOT NULL,
    pway_pln_itm_dtl_itm_hdr_key bigint NOT NULL,
    pway_pln_itm_dtl_zone_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_pln_no character varying(40) COLLATE public.nocase,
    pway_pln_ou integer,
    pway_pln_date timestamp without time zone,
    pway_pln_status character varying(20) COLLATE public.nocase,
    pway_stag_id character varying(40) COLLATE public.nocase,
    pway_mhe_id character varying(60) COLLATE public.nocase,
    pway_employee_id character varying(40) COLLATE public.nocase,
    pway_lineno integer,
    pway_po_no character varying(40) COLLATE public.nocase,
    pway_item character varying(80) COLLATE public.nocase,
    pway_zone character varying(20) COLLATE public.nocase,
    pway_allocated_qty numeric(20,0),
    pway_allocated_bin character varying(20) COLLATE public.nocase,
    pway_gr_no character varying(40) COLLATE public.nocase,
    pway_su_type character varying(20) COLLATE public.nocase,
    pway_su character varying(20) COLLATE public.nocase,
    pway_from_staging_id character varying(40) COLLATE public.nocase,
    pway_cross_dock integer,
    pway_stock_status character varying(20) COLLATE public.nocase,
    pway_exec_no character varying(40) COLLATE public.nocase,
    pway_exec_ou integer,
    pway_exec_status character varying(20) COLLATE public.nocase,
    pway_exec_start_date timestamp without time zone,
    pway_exec_end_date timestamp without time zone,
    pway_created_by character varying(60) COLLATE public.nocase,
    pway_created_date timestamp without time zone,
    pway_gen_from character varying(20) COLLATE public.nocase,
    pway_exec_lineno integer,
    pway_po_sr_no integer,
    pway_uid character varying(80) COLLATE public.nocase,
    pway_rqs_conformation integer,
    pway_actual_bin character varying(20) COLLATE public.nocase,
    pway_actual_bin_qty numeric(20,2),
    pway_reason character varying(80) COLLATE public.nocase,
    pway_item_ln_no integer,
    pway_bin character varying(20) COLLATE public.nocase,
    pway_occu_capacity numeric(20,2),
    created_date timestamp without time zone,
    modified_date timestamp without time zone,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    activeindicator integer
);