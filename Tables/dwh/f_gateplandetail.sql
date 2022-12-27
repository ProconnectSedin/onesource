CREATE TABLE dwh.f_gateplandetail (
    gate_pln_dtl_key bigint NOT NULL,
    gate_pln_dtl_loc_key bigint NOT NULL,
    gate_pln_dtl_veh_key bigint NOT NULL,
    gate_pln_dtl_eqp_key bigint NOT NULL,
    gate_loc_code character varying(20) COLLATE public.nocase,
    gate_pln_no character varying(40) COLLATE public.nocase,
    gate_pln_ou integer,
    gate_pln_date timestamp without time zone,
    gate_pln_status character varying(20) COLLATE public.nocase,
    gate_purpose character varying(20) COLLATE public.nocase,
    gate_flag character varying(20) COLLATE public.nocase,
    gate_gate_no character varying(40) COLLATE public.nocase,
    gate_expected_date timestamp without time zone,
    gate_service_provider character varying(510) COLLATE public.nocase,
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
    gate_source_stage character varying(510) COLLATE public.nocase,
    gate_source_docno character varying(40) COLLATE public.nocase,
    gate_exec_no character varying(40) COLLATE public.nocase,
    gate_exec_ou integer,
    gate_created_by character varying(60) COLLATE public.nocase,
    gate_created_date timestamp without time zone,
    gate_modified_by character varying(60) COLLATE public.nocase,
    gate_modified_date timestamp without time zone,
    gate_timestamp integer,
    gate_gatein_no character varying(40) COLLATE public.nocase,
    gate_customer_name character varying(80) COLLATE public.nocase,
    gate_vendor_name character varying(80) COLLATE public.nocase,
    gate_from character varying(80) COLLATE public.nocase,
    gate_to character varying(80) COLLATE public.nocase,
    gate_noofunits integer,
    gate_workflow_status character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_gateplandetail ALTER COLUMN gate_pln_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_gateplandetail_gate_pln_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_pkey PRIMARY KEY (gate_pln_dtl_key);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_ukey UNIQUE (gate_loc_code, gate_pln_no, gate_pln_ou);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_gate_pln_dtl_eqp_key_fkey FOREIGN KEY (gate_pln_dtl_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_gate_pln_dtl_loc_key_fkey FOREIGN KEY (gate_pln_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_gate_pln_dtl_veh_key_fkey FOREIGN KEY (gate_pln_dtl_veh_key) REFERENCES dwh.d_vehicle(veh_key);

CREATE INDEX f_gateplandetail_key_idx ON dwh.f_gateplandetail USING btree (gate_pln_dtl_eqp_key, gate_pln_dtl_veh_key, gate_pln_dtl_loc_key);

CREATE INDEX f_gateplandetail_key_idx1 ON dwh.f_gateplandetail USING btree (gate_loc_code, gate_pln_no, gate_pln_ou);