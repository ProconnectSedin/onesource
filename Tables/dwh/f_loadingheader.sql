CREATE TABLE dwh.f_loadingheader (
    loading_hdr_key bigint NOT NULL,
    loading_hdr_loc_key bigint NOT NULL,
    loading_hdr_emp_hdr_key bigint NOT NULL,
    loading_hdr_veh_key bigint NOT NULL,
    loading_hdr_eqp_key bigint NOT NULL,
    loading_loc_code character varying(20) COLLATE public.nocase,
    loading_exec_no character varying(40) COLLATE public.nocase,
    loading_exec_ou integer,
    loading_exec_date timestamp without time zone,
    loading_exec_status character varying(20) COLLATE public.nocase,
    loading_ld_sheet_no character varying(40) COLLATE public.nocase,
    loading_dock character varying(40) COLLATE public.nocase,
    loading_mhe character varying(60) COLLATE public.nocase,
    loading_employee character varying(40) COLLATE public.nocase,
    loading_packing_bay character varying(40) COLLATE public.nocase,
    loading_veh_type character varying(80) COLLATE public.nocase,
    loading_veh_no character varying(60) COLLATE public.nocase,
    loading_equip_type character varying(80) COLLATE public.nocase,
    loading_equip_no character varying(60) COLLATE public.nocase,
    loading_container_no character varying(40) COLLATE public.nocase,
    loading_person character varying(510) COLLATE public.nocase,
    loading_lsp character varying(40) COLLATE public.nocase,
    loading_created_by character varying(60) COLLATE public.nocase,
    loading_created_date timestamp without time zone,
    loading_modified_by character varying(60) COLLATE public.nocase,
    loading_modified_date timestamp without time zone,
    loading_timestamp integer,
    loading_manifest_no character varying(40) COLLATE public.nocase,
    loading_exec_startdate timestamp without time zone,
    loading_exec_enddate timestamp without time zone,
    loading_exe_urgent integer,
    loading_exec_seal_no character varying(510) COLLATE public.nocase,
    loading_booking_req character varying(40) COLLATE public.nocase,
    loading_gen_from character varying(20) COLLATE public.nocase,
    loading_rsn_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_loadingheader ALTER COLUMN loading_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_loadingheader_loading_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_pkey PRIMARY KEY (loading_hdr_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_ukey UNIQUE (loading_loc_code, loading_exec_no, loading_exec_ou);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_loading_hdr_emp_hdr_key_fkey FOREIGN KEY (loading_hdr_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_loading_hdr_eqp_key_fkey FOREIGN KEY (loading_hdr_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_loading_hdr_loc_key_fkey FOREIGN KEY (loading_hdr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_loading_hdr_veh_key_fkey FOREIGN KEY (loading_hdr_veh_key) REFERENCES dwh.d_vehicle(veh_key);

CREATE INDEX f_loadingheader_key_idx ON dwh.f_loadingheader USING btree (loading_hdr_emp_hdr_key, loading_hdr_eqp_key, loading_hdr_veh_key, loading_hdr_loc_key);