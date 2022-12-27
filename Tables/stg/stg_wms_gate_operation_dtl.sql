CREATE TABLE stg.stg_wms_gate_operation_dtl (
    wms_gate_opr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_gate_opr_ou integer NOT NULL,
    wms_gate_opr_shift_code character varying(160) COLLATE public.nocase,
    wms_gate_opr_from_time timestamp without time zone,
    wms_gate_opr_to_time timestamp without time zone,
    wms_gate_opr_lineno integer NOT NULL,
    wms_gate_opr_sun_day integer,
    wms_gate_opr_mon_day integer,
    wms_gate_opr_tue_day integer,
    wms_gate_opr_wed_day integer,
    wms_gate_opr_thu_day integer,
    wms_gate_opr_fri_day integer,
    wms_gate_opr_sat_day integer,
    wms_gate_timestamp integer,
    wms_gate_created_by character varying(120) COLLATE public.nocase,
    wms_gate_created_date timestamp without time zone,
    wms_gate_modified_by character varying(120) COLLATE public.nocase,
    wms_gate_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_gate_operation_dtl
    ADD CONSTRAINT wms_gate_operation_dtl_pk PRIMARY KEY (wms_gate_opr_loc_code, wms_gate_opr_ou, wms_gate_opr_lineno);