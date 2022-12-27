CREATE TABLE click.f_asn (
    asn_key bigint NOT NULL,
    asn_hr_key bigint NOT NULL,
    asn_dtl_key bigint NOT NULL,
    gate_exec_dtl_key bigint NOT NULL,
    asn_loc_key bigint NOT NULL,
    asn_date_key bigint NOT NULL,
    asn_cust_key bigint NOT NULL,
    asn_dtl_itm_hdr_key bigint NOT NULL,
    gate_exec_dtl_veh_key bigint NOT NULL,
    asn_ou integer,
    asn_location character varying(20) COLLATE public.nocase,
    asn_no character varying(40) COLLATE public.nocase,
    asn_lineno integer,
    asn_prefdoc_type character varying(510) COLLATE public.nocase,
    asn_prefdoc_no character varying(40) COLLATE public.nocase,
    asn_prefdoc_date timestamp without time zone,
    asn_date timestamp without time zone,
    asn_status character varying(510) COLLATE public.nocase,
    asn_operation_status character varying(50) COLLATE public.nocase,
    asn_ib_order character varying(40) COLLATE public.nocase,
    asn_ship_frm character varying(20) COLLATE public.nocase,
    asn_dlv_date timestamp without time zone,
    asn_sup_asn_no character varying(40) COLLATE public.nocase,
    asn_sup_asn_date timestamp without time zone,
    asn_sent_by character varying(80) COLLATE public.nocase,
    asn_ship_date timestamp without time zone,
    asn_rem character varying(510) COLLATE public.nocase,
    asn_shp_ref_typ character varying(80) COLLATE public.nocase,
    asn_shp_ref_no character varying(40) COLLATE public.nocase,
    asn_shp_ref_date timestamp without time zone,
    asn_shp_carrier character varying(80) COLLATE public.nocase,
    asn_shp_mode character varying(80) COLLATE public.nocase,
    asn_shp_rem character varying(510) COLLATE public.nocase,
    asn_cust_code character varying(40) COLLATE public.nocase,
    asn_type character varying(20) COLLATE public.nocase,
    asn_reason_code character varying(80) COLLATE public.nocase,
    asn_gate_no character varying(80) COLLATE public.nocase,
    asn_created_date timestamp without time zone,
    asn_modified_date timestamp without time zone,
    gate_actual_date timestamp without time zone,
    gate_ser_provider character varying(510) COLLATE public.nocase,
    gate_veh_type character varying(80) COLLATE public.nocase,
    gate_vehicle_no character varying(60) COLLATE public.nocase,
    gate_employee character varying(40) COLLATE public.nocase,
    gate_created_date timestamp without time zone,
    asn_line_status character varying(50) COLLATE public.nocase,
    asn_itm_code character varying(80) COLLATE public.nocase,
    asn_qty numeric(20,2),
    asn_rec_qty numeric(20,2),
    asn_acc_qty numeric(20,2),
    asn_rej_qty numeric(20,2),
    asn_order_uom character varying(20) COLLATE public.nocase,
    asn_master_uom_qty numeric(20,2),
    etlcreatedatetime timestamp without time zone,
    etlupdatedatetime timestamp without time zone,
    createdatetime timestamp without time zone,
    updatedatetime timestamp without time zone,
    asn_itm_itemgroup character varying(80),
    asn_itm_class character varying(80),
    activeindicator integer
);

ALTER TABLE click.f_asn ALTER COLUMN asn_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_asn_asn_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_asn
    ADD CONSTRAINT f_asn_pkey PRIMARY KEY (asn_key);

ALTER TABLE ONLY click.f_asn
    ADD CONSTRAINT f_asn_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_lineno);

CREATE INDEX f_asn_date_idx ON click.f_asn USING btree (asn_created_date, asn_modified_date);

CREATE INDEX f_asn_inb_idx ON click.f_asn USING btree (asn_ib_order, asn_loc_key);

CREATE INDEX f_asn_join_idx ON click.f_asn USING btree (asn_no, asn_ou, asn_location, asn_gate_no, asn_lineno, asn_prefdoc_type, asn_type, asn_status, asn_sup_asn_no);

CREATE INDEX f_asn_key_idx ON click.f_asn USING btree (asn_hr_key, asn_dtl_key, gate_exec_dtl_key, asn_loc_key, asn_date_key, asn_cust_key, asn_dtl_itm_hdr_key, gate_exec_dtl_veh_key);