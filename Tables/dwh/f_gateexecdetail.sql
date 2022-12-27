CREATE TABLE dwh.f_gateexecdetail (
    gate_exec_dtl_key bigint NOT NULL,
    gate_exec_dtl_loc_key bigint NOT NULL,
    gate_exec_dtl_veh_key bigint NOT NULL,
    gate_exec_dtl_eqp_key bigint NOT NULL,
    gate_exec_dtl_emp_hdr_key bigint NOT NULL,
    gate_loc_code character varying(20) COLLATE public.nocase,
    gate_pln_no character varying(40) COLLATE public.nocase,
    gate_pln_ou integer,
    gate_exec_no character varying(40) COLLATE public.nocase,
    gate_exec_ou integer,
    gate_exec_date timestamp without time zone,
    gate_exec_status character varying(20) COLLATE public.nocase,
    gate_exec_gateno character varying(40) COLLATE public.nocase,
    gate_purpose character varying(20) COLLATE public.nocase,
    gate_flag character varying(20) COLLATE public.nocase,
    gate_actual_date timestamp without time zone,
    gate_ser_provider character varying(510) COLLATE public.nocase,
    gate_person character varying(120) COLLATE public.nocase,
    gate_veh_type character varying(80) COLLATE public.nocase,
    gate_vehicle_no character varying(60) COLLATE public.nocase,
    gate_equip_type character varying(80) COLLATE public.nocase,
    gate_equip_no character varying(60) COLLATE public.nocase,
    gate_ref_doc_typ1 character varying(20) COLLATE public.nocase,
    gate_ref_doc_no1 character varying(40) COLLATE public.nocase,
    gate_ref_doc_typ2 character varying(20) COLLATE public.nocase,
    gate_ref_doc_no2 character varying(40) COLLATE public.nocase,
    gate_ref_doc_typ3 character varying(20) COLLATE public.nocase,
    gate_ref_doc_no3 character varying(40) COLLATE public.nocase,
    gate_instructions character varying(510) COLLATE public.nocase,
    gate_employee character varying(40) COLLATE public.nocase,
    gate_created_by character varying(60) COLLATE public.nocase,
    gate_created_date timestamp without time zone,
    gate_timestamp integer,
    gate_userdefined1 character varying(510) COLLATE public.nocase,
    gate_gatein_no character varying(40) COLLATE public.nocase,
    gate_customer_name character varying(80) COLLATE public.nocase,
    gate_vendor_name character varying(80) COLLATE public.nocase,
    gate_from character varying(80) COLLATE public.nocase,
    gate_to character varying(80) COLLATE public.nocase,
    gate_noofunits integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_gateexecdetail ALTER COLUMN gate_exec_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_gateexecdetail_gate_exec_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_pkey PRIMARY KEY (gate_exec_dtl_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_ukey UNIQUE (gate_loc_code, gate_exec_no, gate_exec_ou);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_gate_exec_dtl_emp_hdr_key_fkey FOREIGN KEY (gate_exec_dtl_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_gate_exec_dtl_eqp_key_fkey FOREIGN KEY (gate_exec_dtl_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_gate_exec_dtl_loc_key_fkey FOREIGN KEY (gate_exec_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_gate_exec_dtl_veh_key_fkey FOREIGN KEY (gate_exec_dtl_veh_key) REFERENCES dwh.d_vehicle(veh_key);

CREATE INDEX f_gateexecdetail_key_idx ON dwh.f_gateexecdetail USING btree (gate_exec_dtl_emp_hdr_key, gate_exec_dtl_eqp_key, gate_exec_dtl_veh_key, gate_exec_dtl_loc_key);

CREATE INDEX f_gateexecdetail_key_idx1 ON dwh.f_gateexecdetail USING btree (gate_loc_code, gate_exec_no, gate_exec_ou);