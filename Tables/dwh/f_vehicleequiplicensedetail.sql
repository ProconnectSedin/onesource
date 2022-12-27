CREATE TABLE dwh.f_vehicleequiplicensedetail (
    vrvel_vhl_eqp_dtl_key bigint NOT NULL,
    vrvel_vendor_key bigint NOT NULL,
    vrvel_ouinstance integer,
    vrvel_tend_req_no character varying(40) COLLATE public.nocase,
    vrvel_line_no character varying(300) COLLATE public.nocase,
    vrvel_resp_line_no character varying(300) COLLATE public.nocase,
    vrvel_license_plate_no character varying(80) COLLATE public.nocase,
    vrvel_created_by character varying(60) COLLATE public.nocase,
    vrvel_created_date timestamp without time zone,
    vrvel_last_modified_by character varying(60) COLLATE public.nocase,
    vrvel_last_modified_date timestamp without time zone,
    vrvel_timestamp integer,
    vrvel_is_assigned character varying(30) COLLATE public.nocase,
    vrvel_tend_rpt_dt_time character varying(50) COLLATE public.nocase,
    vrvel_tend_cont_person1 character varying(80) COLLATE public.nocase,
    vrvel_tend_cont_det1 character varying(80) COLLATE public.nocase,
    vrvel_tend_cont_person2 character varying(80) COLLATE public.nocase,
    vrvel_tend_cont_det2 character varying(80) COLLATE public.nocase,
    vrvel_vendor_id character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_vehicleequiplicensedetail ALTER COLUMN vrvel_vhl_eqp_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_vehicleequiplicensedetail_vrvel_vhl_eqp_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_vehicleequiplicensedetail
    ADD CONSTRAINT f_vehicleequiplicensedetail_pkey PRIMARY KEY (vrvel_vhl_eqp_dtl_key);

ALTER TABLE ONLY dwh.f_vehicleequiplicensedetail
    ADD CONSTRAINT f_vehicleequiplicensedetail_ukey UNIQUE (vrvel_ouinstance, vrvel_tend_req_no, vrvel_line_no, vrvel_resp_line_no);

ALTER TABLE ONLY dwh.f_vehicleequiplicensedetail
    ADD CONSTRAINT f_vehicleequiplicensedetail_vrvel_vendor_key_fkey FOREIGN KEY (vrvel_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_vehicleequiplicensedetail_key_idx ON dwh.f_vehicleequiplicensedetail USING btree (vrvel_vendor_key);