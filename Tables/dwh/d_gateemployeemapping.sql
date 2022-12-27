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

ALTER TABLE dwh.d_gateemployeemapping ALTER COLUMN gate_emp_map_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_gateemployeemapping_gate_emp_map_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_gateemployeemapping
    ADD CONSTRAINT d_gateemployeemapping_pkey PRIMARY KEY (gate_emp_map_key);

ALTER TABLE ONLY dwh.d_gateemployeemapping
    ADD CONSTRAINT d_gateemployeemapping_ukey UNIQUE (gate_loc_code, gate_ou, gate_lineno);