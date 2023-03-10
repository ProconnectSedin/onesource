CREATE TABLE raw.raw_fact_outbound_packexec (
    raw_id bigint NOT NULL,
    surrogatekey character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    refkey character varying(400) NOT NULL COLLATE public.nocase,
    packexec_ou integer NOT NULL,
    packexec_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    pack_pln_no character varying(72) COLLATE public.nocase,
    pack_lineno integer,
    pack_picklist_no character varying(72) COLLATE public.nocase,
    pack_so_sch_lineno integer,
    pack_item_batch_no character varying(112) COLLATE public.nocase,
    pack_so_qty numeric,
    pack_uid_sr_no character varying(112) COLLATE public.nocase,
    pack_thu_sr_no character varying(112) COLLATE public.nocase,
    pack_pre_packing_bay character varying(72) COLLATE public.nocase,
    pack_su character varying(40) COLLATE public.nocase,
    pack_su_type character varying(32) COLLATE public.nocase,
    pack_plan_qty numeric,
    pack_packed_from_uid_serno character varying(112) COLLATE public.nocase,
    pack_box_thu_id character varying(160) COLLATE public.nocase,
    pack_box_no character varying(72) COLLATE public.nocase,
    pack_pln_date timestamp without time zone,
    pack_pln_status character varying(32) COLLATE public.nocase,
    pack_source_stage character varying(1020) COLLATE public.nocase,
    pack_source_docno character varying(72) COLLATE public.nocase,
    pack_pln_created_by character varying(120) COLLATE public.nocase,
    pack_pln_created_date timestamp without time zone,
    pack_pln_modified_by character varying(120) COLLATE public.nocase,
    pack_pln_modified_date timestamp without time zone,
    pack_pln_userdefined1 character varying(1020) COLLATE public.nocase,
    pack_pln_userdefined2 character varying(1020) COLLATE public.nocase,
    pack_pln_userdefined3 character varying(1020) COLLATE public.nocase,
    pack_exec_no character varying(72) COLLATE public.nocase,
    pack_exec_date timestamp without time zone,
    pack_exec_status character varying(32) COLLATE public.nocase,
    pack_lot_no character varying(400) COLLATE public.nocase,
    pack_thu_id character varying(160) COLLATE public.nocase,
    pack_thu_lineno integer,
    pack_thu_item_code character varying(128) COLLATE public.nocase,
    pack_thu_item_qty numeric,
    pack_thu_pack_qty numeric,
    pack_thu_item_batch_no character varying(112) COLLATE public.nocase,
    pack_thu_item_sr_no character varying(112) COLLATE public.nocase,
    pack_thu_ser_no character varying(112) COLLATE public.nocase,
    pack_uid1_ser_no character varying(112) COLLATE public.nocase,
    pack_uid_ser_no character varying(112) COLLATE public.nocase,
    pack_allocated_qty numeric,
    pack_planned_qty numeric,
    pack_factory_pack character varying(80) COLLATE public.nocase,
    pack_source_thu_ser_no character varying(160) COLLATE public.nocase,
    pack_reason_code character varying(160) COLLATE public.nocase,
    pack_employee character varying(80) COLLATE public.nocase,
    pack_packing_bay character varying(72) COLLATE public.nocase,
    pack_pre_pack_bay character varying(72) COLLATE public.nocase,
    pack_exec_created_by character varying(120) COLLATE public.nocase,
    pack_exec_created_date timestamp without time zone,
    pack_exec_modified_by character varying(120) COLLATE public.nocase,
    pack_exec_modified_date timestamp without time zone,
    pack_exec_userdefined1 character varying(1020) COLLATE public.nocase,
    pack_exec_userdefined2 character varying(1020) COLLATE public.nocase,
    pack_exec_userdefined3 character varying(1020) COLLATE public.nocase,
    pack_exec_start_date timestamp without time zone,
    pack_exec_end_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_outbound_packexec ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_outbound_packexec_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_outbound_packexec
    ADD CONSTRAINT raw_fact_outbound_packexec_pkey PRIMARY KEY (raw_id);