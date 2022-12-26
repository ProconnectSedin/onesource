CREATE TABLE dwh.d_gateemployeemapping (
    gate_emp_map_key bigint NOT NULL,
    gate_loc_code character varying(20) COLLATE public.nocase,
    gate_ou integer,
    gate_lineno integer,
    gate_shift_code character varying(80) COLLATE public.nocase,
    gate_emp_code character varying(40) COLLATE public.nocase,
    gate_area character varying(40) COLLATE public.nocase,
    gate_timestamp integer,
    gate_created_by character varying(60) COLLATE public.nocase,
    gate_created_date timestamp without time zone,
    gate_modified_by character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);