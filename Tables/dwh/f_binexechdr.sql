CREATE TABLE dwh.f_binexechdr (
    bin_hdr_key bigint NOT NULL,
    bin_loc_key bigint NOT NULL,
    bin_date_key bigint NOT NULL,
    bin_emp_hdr_key bigint NOT NULL,
    bin_loc_code character varying(20) COLLATE public.nocase,
    bin_exec_no character varying(40) COLLATE public.nocase,
    bin_exec_ou integer,
    bin_exec_status character varying(20) COLLATE public.nocase,
    bin_exec_date timestamp without time zone,
    bin_pln_no character varying(40) COLLATE public.nocase,
    bin_mhe_id character varying(60) COLLATE public.nocase,
    bin_employee_id character varying(40) COLLATE public.nocase,
    bin_exec_start_date timestamp without time zone,
    bin_exec_end_date timestamp without time zone,
    bin_created_by character varying(60) COLLATE public.nocase,
    bin_created_date timestamp without time zone,
    bin_modified_by character varying(60) COLLATE public.nocase,
    bin_modified_date timestamp without time zone,
    bin_timestamp integer,
    bin_refdoc_no character varying(40) COLLATE public.nocase,
    bin_gen_from character varying(20) COLLATE public.nocase,
    bin_fr_insp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_binexechdr ALTER COLUMN bin_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_binexechdr_bin_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_pkey PRIMARY KEY (bin_hdr_key);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_ukey UNIQUE (bin_loc_code, bin_exec_no, bin_exec_ou);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_bin_date_key_fkey FOREIGN KEY (bin_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_bin_emp_hdr_key_fkey FOREIGN KEY (bin_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_bin_loc_key_fkey FOREIGN KEY (bin_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_binexechdr_key_idx ON dwh.f_binexechdr USING btree (bin_loc_key, bin_emp_hdr_key, bin_date_key);