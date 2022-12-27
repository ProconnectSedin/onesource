CREATE TABLE click.f_grn (
    grn_key bigint NOT NULL,
    gr_pln_key bigint NOT NULL,
    gr_dtl_key bigint NOT NULL,
    gr_itm_dtl_key bigint NOT NULL,
    asn_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_date_key bigint NOT NULL,
    gr_emp_hdr_key bigint NOT NULL,
    gr_itm_dtl_itm_hdr_key bigint NOT NULL,
    gr_itm_dtl_uom_key bigint NOT NULL,
    gr_itm_dtl_stg_mas_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_pln_no character varying(40) COLLATE public.nocase,
    gr_pln_ou integer,
    gr_pln_date timestamp without time zone,
    gr_pln_status character varying(20) COLLATE public.nocase,
    gr_po_no character varying(40) COLLATE public.nocase,
    gr_po_date timestamp without time zone,
    gr_asn_no character varying(40) COLLATE public.nocase,
    gr_asn_date timestamp without time zone,
    gr_employee character varying(80) COLLATE public.nocase,
    gr_staging_id character varying(40) COLLATE public.nocase,
    gr_ref_type character varying(510) COLLATE public.nocase,
    gr_item character varying(80) COLLATE public.nocase,
    gr_item_qty numeric(20,2),
    gr_lot_no character varying(60) COLLATE public.nocase,
    gr_acpt_qty numeric(20,2),
    gr_rej_qty numeric(20,2),
    gr_storage_unit character varying(20) COLLATE public.nocase,
    gr_mas_uom character varying(20) COLLATE public.nocase,
    gr_su_qty numeric(20,2),
    gr_itmexecution_date timestamp without time zone,
    gr_reasoncode character varying(80) COLLATE public.nocase,
    gr_cross_dock character varying(40) COLLATE public.nocase,
    gr_stock_status character varying(20) COLLATE public.nocase,
    gr_exec_no character varying(40) COLLATE public.nocase,
    gr_lineno integer,
    gr_no character varying(40) COLLATE public.nocase,
    gr_emp character varying(80) COLLATE public.nocase,
    gr_start_date timestamp without time zone,
    gr_end_date timestamp without time zone,
    gr_exec_status character varying(20) COLLATE public.nocase,
    gr_created_by character varying(60) COLLATE public.nocase,
    gr_exec_date timestamp without time zone,
    gr_gen_from character varying(16) COLLATE public.nocase,
    gr_created_date timestamp without time zone,
    gr_modified_date timestamp without time zone,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    activeindicator integer
);

ALTER TABLE click.f_grn ALTER COLUMN grn_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_grn_grn_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_grn
    ADD CONSTRAINT f_grn_pkey PRIMARY KEY (grn_key);

ALTER TABLE ONLY click.f_grn
    ADD CONSTRAINT f_grn_ukey UNIQUE (gr_asn_no, gr_loc_code, gr_pln_ou, gr_pln_no, gr_exec_no, gr_lineno);

CREATE INDEX f_gr_po_idx ON click.f_grn USING btree (gr_po_no, gr_loc_key);

CREATE INDEX f_grn_date_idx ON click.f_grn USING btree (gr_created_date, gr_modified_date);

CREATE INDEX f_grn_join_idx ON click.f_grn USING btree (gr_loc_code, gr_pln_ou, gr_pln_no, gr_asn_no, gr_exec_no, gr_lineno, gr_no, gr_po_no);

CREATE INDEX f_grn_key_idx ON click.f_grn USING btree (gr_pln_key, gr_dtl_key, gr_emp_hdr_key, gr_itm_dtl_key, asn_key, gr_loc_key, gr_date_key, gr_itm_dtl_itm_hdr_key, gr_itm_dtl_uom_key, gr_itm_dtl_stg_mas_key);