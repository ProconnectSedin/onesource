CREATE TABLE raw.raw_wms_gate_exec_dtl (
    raw_id bigint NOT NULL,
    wms_gate_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gate_pln_no character varying(72) COLLATE public.nocase,
    wms_gate_pln_ou integer,
    wms_gate_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_gate_exec_ou integer NOT NULL,
    wms_gate_exec_date timestamp without time zone,
    wms_gate_exec_status character varying(32) COLLATE public.nocase,
    wms_gate_exec_gateno character varying(72) COLLATE public.nocase,
    wms_gate_purpose character varying(32) COLLATE public.nocase,
    wms_gate_flag character varying(32) COLLATE public.nocase,
    wms_gate_actual_date timestamp without time zone,
    wms_gate_ser_provider character varying(1020) COLLATE public.nocase,
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
    wms_gate_employee character varying(80) COLLATE public.nocase,
    wms_gate_created_by character varying(120) COLLATE public.nocase,
    wms_gate_created_date timestamp without time zone,
    wms_gate_modified_by character varying(120) COLLATE public.nocase,
    wms_gate_modified_date timestamp without time zone,
    wms_gate_timestamp integer,
    wms_gate_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_gate_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_gate_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_gate_contwait_bil_status character varying(32) COLLATE public.nocase,
    wms_gate_bil_value numeric,
    wms_gate_gatein_no character varying(72) COLLATE public.nocase,
    wms_gate_customer_name character varying(160) COLLATE public.nocase,
    wms_gate_vendor_name character varying(160) COLLATE public.nocase,
    wms_gate_from character varying(160) COLLATE public.nocase,
    wms_gate_to character varying(160) COLLATE public.nocase,
    wms_gate_noofunits integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_gate_exec_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_gate_exec_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_gate_exec_dtl
    ADD CONSTRAINT raw_wms_gate_exec_dtl_pkey PRIMARY KEY (raw_id);