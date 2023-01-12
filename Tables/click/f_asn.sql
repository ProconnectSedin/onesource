-- Table: click.f_asn

-- DROP TABLE IF EXISTS click.f_asn;

CREATE TABLE IF NOT EXISTS click.f_asn
(
    asn_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    asn_itm_itemgroup character varying(80) COLLATE pg_catalog."default",
    asn_itm_class character varying(80) COLLATE pg_catalog."default",
    activeindicator integer,
    asn_cutofftime time without time zone,
    asn_qualifieddate timestamp without time zone,
    asn_qualifieddatekey bigint,
    CONSTRAINT f_asn_pkey PRIMARY KEY (asn_key),
    CONSTRAINT f_asn_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_lineno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_asn
    OWNER to proconnect;
-- Index: f_asn_date_idx

-- DROP INDEX IF EXISTS click.f_asn_date_idx;

CREATE INDEX IF NOT EXISTS f_asn_date_idx
    ON click.f_asn USING btree
    (asn_created_date ASC NULLS LAST, asn_modified_date ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_asn_inb_idx

-- DROP INDEX IF EXISTS click.f_asn_inb_idx;

CREATE INDEX IF NOT EXISTS f_asn_inb_idx
    ON click.f_asn USING btree
    (asn_ib_order COLLATE public.nocase ASC NULLS LAST, asn_loc_key ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_asn_join_idx

-- DROP INDEX IF EXISTS click.f_asn_join_idx;

CREATE INDEX IF NOT EXISTS f_asn_join_idx
    ON click.f_asn USING btree
    (asn_no COLLATE public.nocase ASC NULLS LAST, asn_ou ASC NULLS LAST, asn_location COLLATE public.nocase ASC NULLS LAST, asn_gate_no COLLATE public.nocase ASC NULLS LAST, asn_lineno ASC NULLS LAST, asn_prefdoc_type COLLATE public.nocase ASC NULLS LAST, asn_type COLLATE public.nocase ASC NULLS LAST, asn_status COLLATE public.nocase ASC NULLS LAST, asn_sup_asn_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_asn_key_idx

-- DROP INDEX IF EXISTS click.f_asn_key_idx;

CREATE INDEX IF NOT EXISTS f_asn_key_idx
    ON click.f_asn USING btree
    (asn_hr_key ASC NULLS LAST, asn_dtl_key ASC NULLS LAST, gate_exec_dtl_key ASC NULLS LAST, asn_loc_key ASC NULLS LAST, asn_date_key ASC NULLS LAST, asn_cust_key ASC NULLS LAST, asn_dtl_itm_hdr_key ASC NULLS LAST, gate_exec_dtl_veh_key ASC NULLS LAST)
    TABLESPACE pg_default;