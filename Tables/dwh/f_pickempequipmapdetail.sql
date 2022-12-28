CREATE TABLE dwh.f_pickempequipmapdetail (
    pick_emp_eqp_dtl_key bigint NOT NULL,
    pick_emp_eqp_dtl_key_loc_key bigint NOT NULL,
    pick_emp_eqp_dtl_key_emp_hdr_key bigint NOT NULL,
    pick_emp_eqp_dtl_key_eqp_key bigint NOT NULL,
    pick_emp_eqp_dtl_key_zone_key bigint NOT NULL,
    pick_loc_code character varying(20) COLLATE public.nocase,
    pick_ou integer,
    pick_lineno integer,
    pick_shift_code character varying(80) COLLATE public.nocase,
    pick_emp_code character varying(40) COLLATE public.nocase,
    pick_euip_code character varying(60) COLLATE public.nocase,
    pick_area character varying(510) COLLATE public.nocase,
    pick_zone character varying(20) COLLATE public.nocase,
    pick_bin_level character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_pickempequipmapdetail ALTER COLUMN pick_emp_eqp_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_pickempequipmapdetail_pick_emp_eqp_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pkey PRIMARY KEY (pick_emp_eqp_dtl_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_ukey UNIQUE (pick_loc_code, pick_ou, pick_lineno);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pick_emp_eqp_dtl_key_emp_hdr_key_fkey FOREIGN KEY (pick_emp_eqp_dtl_key_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pick_emp_eqp_dtl_key_eqp_key_fkey FOREIGN KEY (pick_emp_eqp_dtl_key_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pick_emp_eqp_dtl_key_loc_key_fkey FOREIGN KEY (pick_emp_eqp_dtl_key_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pick_emp_eqp_dtl_key_zone_key_fkey FOREIGN KEY (pick_emp_eqp_dtl_key_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_pickempequipmapdetail_key_idx ON dwh.f_pickempequipmapdetail USING btree (pick_loc_code, pick_ou, pick_lineno);

CREATE INDEX f_pickempequipmapdetail_key_idx1 ON dwh.f_pickempequipmapdetail USING btree (pick_emp_eqp_dtl_key_loc_key, pick_emp_eqp_dtl_key_emp_hdr_key, pick_emp_eqp_dtl_key_eqp_key, pick_emp_eqp_dtl_key_zone_key);