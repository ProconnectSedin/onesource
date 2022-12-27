CREATE TABLE dwh.f_putawayexecdetail (
    pway_exe_dtl_key bigint NOT NULL,
    pway_pln_dtl_key bigint,
    pway_exe_dtl_loc_key bigint NOT NULL,
    pway_exe_dtl_eqp_key bigint NOT NULL,
    pway_exe_dtl_stg_mas_key bigint NOT NULL,
    pway_exe_dtl_emp_hdr_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_exec_no character varying(40) COLLATE public.nocase,
    pway_exec_ou integer,
    pway_pln_no character varying(40) COLLATE public.nocase,
    pway_pln_ou integer,
    pway_exec_status character varying(20) COLLATE public.nocase,
    pway_stag_id character varying(40) COLLATE public.nocase,
    pway_mhe_id character varying(60) COLLATE public.nocase,
    pway_employee_id character varying(40) COLLATE public.nocase,
    pway_exec_start_date timestamp without time zone,
    pway_exec_end_date timestamp without time zone,
    pway_completed integer,
    pway_created_by character varying(60) COLLATE public.nocase,
    pway_created_date timestamp without time zone,
    pway_modified_by character varying(60) COLLATE public.nocase,
    pway_modified_date timestamp without time zone,
    pway_timestamp integer,
    pway_type character varying(20) COLLATE public.nocase,
    pway_by_flag character varying(20) COLLATE public.nocase,
    pway_gen_from character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_putawayexecdetail ALTER COLUMN pway_exe_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_putawayexecdetail_pway_exe_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pkey PRIMARY KEY (pway_exe_dtl_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_ukey UNIQUE (pway_loc_code, pway_exec_no, pway_exec_ou);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pway_exe_dtl_emp_hdr_key_fkey FOREIGN KEY (pway_exe_dtl_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pway_exe_dtl_eqp_key_fkey FOREIGN KEY (pway_exe_dtl_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pway_exe_dtl_loc_key_fkey FOREIGN KEY (pway_exe_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pway_exe_dtl_stg_mas_key_fkey FOREIGN KEY (pway_exe_dtl_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

CREATE INDEX f_putawayexecdetail_key_idx ON dwh.f_putawayexecdetail USING btree (pway_pln_dtl_key, pway_exe_dtl_loc_key, pway_exe_dtl_eqp_key, pway_exe_dtl_stg_mas_key, pway_exe_dtl_emp_hdr_key);

CREATE INDEX f_putawayexecdetail_key_idx1 ON dwh.f_putawayexecdetail USING btree (pway_loc_code, pway_exec_no, pway_exec_ou, pway_pln_no, pway_pln_ou);