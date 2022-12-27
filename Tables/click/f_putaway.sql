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

ALTER TABLE click.f_putaway ALTER COLUMN pway_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_putaway_pway_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_putaway
    ADD CONSTRAINT f_putaway_pkey PRIMARY KEY (pway_key);

CREATE INDEX f_putaway_date_idx ON click.f_putaway USING btree (created_date, modified_date);

CREATE INDEX f_putaway_join_idx ON click.f_putaway USING btree (pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno, pway_po_no, pway_item, pway_gr_no, pway_exec_no);

CREATE INDEX f_putaway_key_idx ON click.f_putaway USING btree (pway_pln_dtl_key, pway_pln_itm_dtl_key, pway_itm_dtl_key, pway_exe_dtl_key, grn_key, pway_pln_dtl_loc_key, pway_pln_dtl_date_key, pway_pln_dtl_stg_mas_key, pway_pln_dtl_emp_hdr_key, pway_pln_itm_dtl_itm_hdr_key, pway_pln_itm_dtl_zone_key);

CREATE INDEX f_putaway_po_idx ON click.f_putaway USING btree (pway_po_no, pway_pln_dtl_loc_key);