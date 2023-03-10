CREATE TABLE raw.raw_wms_gate_plan_dtl (
    raw_id bigint NOT NULL,
    wms_gate_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gate_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gate_pln_ou integer NOT NULL,
    wms_gate_pln_date timestamp without time zone,
    wms_gate_pln_status character varying(32) COLLATE public.nocase,
    wms_gate_purpose character varying(32) COLLATE public.nocase,
    wms_gate_flag character varying(32) COLLATE public.nocase,
    wms_gate_gate_no character varying(72) COLLATE public.nocase,
    wms_gate_expected_date timestamp without time zone,
    wms_gate_service_provider character varying(1020) COLLATE public.nocase,
    wms_gate_person character varying(240) COLLATE public.nocase,
    wms_gate_veh_type character varying(160) COLLATE public.nocase,
    wms_gate_vehicle_no character varying(120) COLLATE public.nocase,
    wms_gate_equip_type character varying(160) COLLATE public.nocase,
    wms_gate_equip_no character varying(120) COLLATE public.nocase,
    wms_gate_ref_doc_typ1 character varying(32) COLLATE public.nocase,
    wms_gate_ref_doc_no1 character varying(72) COLLATE public.nocase,
    wms_gate_ref_doc_typ2 character varying(32) COLLATE public.nocase,
    wms_gate_ref_doc_no2 character varying(72) COLLATE public.nocase,
    wms_gate_ref_doc_typ3 character varying(32) COLLATE public.nocase,
    wms_gate_ref_doc_no3 character varying(72) COLLATE public.nocase,
    wms_gate_instructions character varying(1020) COLLATE public.nocase,
    wms_gate_source_stage character varying(1020) COLLATE public.nocase,
    wms_gate_source_docno character varying(72) COLLATE public.nocase,
    wms_gate_exec_no character varying(72) COLLATE public.nocase,
    wms_gate_exec_ou integer,
    wms_gate_created_by character varying(120) COLLATE public.nocase,
    wms_gate_created_date timestamp without time zone,
    wms_gate_modified_by character varying(120) COLLATE public.nocase,
    wms_gate_modified_date timestamp without time zone,
    wms_gate_timestamp integer,
    wms_gate_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_gate_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_gate_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_gate_gatein_no character varying(72) COLLATE public.nocase,
    wms_gate_customer_name character varying(160) COLLATE public.nocase,
    wms_gate_vendor_name character varying(160) COLLATE public.nocase,
    wms_gate_from character varying(160) COLLATE public.nocase,
    wms_gate_to character varying(160) COLLATE public.nocase,
    wms_gate_noofunits integer,
    wms_gate_workflow_status character varying(1020) COLLATE public.nocase,
    wms_gate_rsnforreturn character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gate_plan_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gate_plan_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gate_plan_dtl
    ADD CONSTRAINT raw_wms_gate_plan_dtl_pkey PRIMARY KEY (raw_id);