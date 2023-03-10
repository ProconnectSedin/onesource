CREATE TABLE raw.raw_fact_inbound_putaway (
    raw_id bigint NOT NULL,
    surrogatekey character varying(4000) COLLATE public.nocase,
    reference_no character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(500) COLLATE public.nocase,
    putaway_ou integer NOT NULL,
    putaway_location character varying(40) NOT NULL COLLATE public.nocase,
    asn_no character varying(72) NOT NULL COLLATE public.nocase,
    pway_pln_no character varying(144) COLLATE public.nocase,
    pway_pln_date timestamp without time zone,
    pway_pln_status character varying(200) COLLATE public.nocase,
    pway_stag_id character varying(72) COLLATE public.nocase,
    pway_mhe_id character varying(120) COLLATE public.nocase,
    pway_employee_id character varying(80) COLLATE public.nocase,
    pway_source_stage character varying(1020) COLLATE public.nocase,
    pway_created_by character varying(120) COLLATE public.nocase,
    pway_created_date timestamp without time zone,
    pway_modified_by character varying(120) COLLATE public.nocase,
    pway_modified_date timestamp without time zone,
    pway_output_pln character varying(1020) COLLATE public.nocase,
    pway_userdefined1 character varying(1020) COLLATE public.nocase,
    pway_userdefined2 character varying(1020) COLLATE public.nocase,
    pway_userdefined3 character varying(1020) COLLATE public.nocase,
    pway_type character varying(32) COLLATE public.nocase,
    pway_comp_flag character varying(32) COLLATE public.nocase,
    pway_by_flag character varying(32) COLLATE public.nocase,
    pway_lineno integer,
    pway_uid character varying(160) COLLATE public.nocase,
    pway_zone character varying(40) COLLATE public.nocase,
    pway_allocated_qty numeric,
    pway_allocated_bin character varying(40) COLLATE public.nocase,
    pway_su_type character varying(32) COLLATE public.nocase,
    pway_su_serial_no character varying(112) COLLATE public.nocase,
    pway_su character varying(40) COLLATE public.nocase,
    pway_from_staging_id character varying(72) COLLATE public.nocase,
    pway_cross_dock integer,
    pway_target_thu_serial_no character varying(112) COLLATE public.nocase,
    pway_stock_status character varying(32) COLLATE public.nocase,
    pway_staging character varying(72) COLLATE public.nocase,
    pway_exec_no character varying(200) COLLATE public.nocase,
    pway_exec_status character varying(200) COLLATE public.nocase,
    pway_exec_stag_id character varying(72) COLLATE public.nocase,
    pway_exec_mhe_id character varying(120) COLLATE public.nocase,
    pway_exec_employee_id character varying(80) COLLATE public.nocase,
    pway_exec_start_date timestamp without time zone,
    pway_exec_end_date timestamp without time zone,
    pway_completed integer,
    pway_exec_created_by character varying(120) COLLATE public.nocase,
    pway_exec_created_date timestamp without time zone,
    pway_exec_modified_by character varying(120) COLLATE public.nocase,
    pway_exec_modified_date timestamp without time zone,
    pway_exec_userdefined1 character varying(1020) COLLATE public.nocase,
    pway_exec_userdefined2 character varying(1020) COLLATE public.nocase,
    pway_exec_userdefined3 character varying(1020) COLLATE public.nocase,
    pway_exec_type character varying(32) COLLATE public.nocase,
    pway_exec_by_flag character varying(32) COLLATE public.nocase,
    pway_gen_from character varying(32) COLLATE public.nocase,
    pway_exec_lineno integer,
    pway_gr_lineno integer,
    pway_po_sr_no integer,
    pway_item character varying(256) COLLATE public.nocase,
    pway_exec_zone character varying(40) COLLATE public.nocase,
    pway_rqs_conformation integer,
    pway_exec_allocated_qty numeric,
    pway_exec_allocated_bin character varying(40) COLLATE public.nocase,
    pway_actual_bin character varying(40) COLLATE public.nocase,
    pway_actual_bin_qty numeric,
    pway_exec_su_type character varying(32) COLLATE public.nocase,
    pway_exec_su character varying(40) COLLATE public.nocase,
    pway_exec_from_staging_id character varying(72) COLLATE public.nocase,
    pway_reason character varying(160) COLLATE public.nocase,
    pway_exec_cross_dock integer,
    pway_actual_staging character varying(72) COLLATE public.nocase,
    pway_allocated_staging character varying(72) COLLATE public.nocase,
    pway_exec_stock_status character varying(32) COLLATE public.nocase,
    pway_exec_staging character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_inbound_putaway ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_inbound_putaway_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_inbound_putaway
    ADD CONSTRAINT raw_fact_inbound_putaway_pkey PRIMARY KEY (raw_id);