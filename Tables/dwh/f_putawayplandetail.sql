CREATE TABLE dwh.f_putawayplandetail (
    pway_pln_dtl_key bigint NOT NULL,
    pway_pln_dtl_loc_key bigint NOT NULL,
    pway_pln_dtl_date_key bigint NOT NULL,
    pway_pln_dtl_stg_mas_key bigint NOT NULL,
    pway_pln_dtl_emp_hdr_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_pln_no character varying(40) COLLATE public.nocase,
    pway_pln_ou integer,
    pway_pln_date timestamp without time zone,
    pway_pln_status character varying(20) COLLATE public.nocase,
    pway_stag_id character varying(40) COLLATE public.nocase,
    pway_mhe_id character varying(60) COLLATE public.nocase,
    pway_employee_id character varying(40) COLLATE public.nocase,
    pway_source_stage character varying(510) COLLATE public.nocase,
    pway_source_docno character varying(40) COLLATE public.nocase,
    pway_created_by character varying(60) COLLATE public.nocase,
    pway_created_date timestamp without time zone,
    pway_modified_by character varying(60) COLLATE public.nocase,
    pway_modified_date timestamp without time zone,
    pway_timestamp integer,
    pway_output_pln character varying(510) COLLATE public.nocase,
    pway_type character varying(20) COLLATE public.nocase,
    pway_comp_flag character varying(20) COLLATE public.nocase,
    pway_first_pln_no character varying(40) COLLATE public.nocase,
    pway_by_flag character varying(16) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_putawayplandetail ALTER COLUMN pway_pln_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_putawayplandetail_pway_pln_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pkey PRIMARY KEY (pway_pln_dtl_key);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_ukey UNIQUE (pway_loc_code, pway_pln_no, pway_pln_ou);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pway_pln_dtl_date_key_fkey FOREIGN KEY (pway_pln_dtl_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pway_pln_dtl_emp_hdr_key_fkey FOREIGN KEY (pway_pln_dtl_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pway_pln_dtl_loc_key_fkey FOREIGN KEY (pway_pln_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pway_pln_dtl_stg_mas_key_fkey FOREIGN KEY (pway_pln_dtl_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

CREATE INDEX f_putawayplandetail_date_idx ON dwh.f_putawayplandetail USING btree (pway_modified_date, pway_created_date);

CREATE INDEX f_putawayplandetail_key_idx ON dwh.f_putawayplandetail USING btree (pway_pln_dtl_date_key, pway_pln_dtl_loc_key, pway_pln_dtl_stg_mas_key, pway_pln_dtl_emp_hdr_key);

CREATE INDEX f_putawayplandetail_key_idx1 ON dwh.f_putawayplandetail USING btree (pway_loc_code, pway_pln_no, pway_pln_ou);