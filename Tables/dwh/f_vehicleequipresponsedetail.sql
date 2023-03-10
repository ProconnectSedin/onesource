CREATE TABLE dwh.f_vehicleequipresponsedetail (
    vrve_vhl_dtl_key bigint NOT NULL,
    vrve_vendor_key bigint NOT NULL,
    vrve_ouinstance integer,
    vrve_tend_req_no character varying(40) COLLATE public.nocase,
    vrve_line_no character varying(300) COLLATE public.nocase,
    vrve_vendor_id character varying(80) COLLATE public.nocase,
    vrve_resp_status character varying(80) COLLATE public.nocase,
    vrve_resp_for character varying(80) COLLATE public.nocase,
    vrve_type character varying(80) COLLATE public.nocase,
    vrve_req_qty numeric(20,2),
    vrve_vend_ref_no character varying(80) COLLATE public.nocase,
    vrve_vend_ref_date timestamp without time zone,
    vrve_contract_id character varying(40) COLLATE public.nocase,
    vrve_confirm_status character varying(80) COLLATE public.nocase,
    vrve_confirm_qty numeric(20,2),
    vrve_rate numeric(20,2),
    vrve_created_by character varying(60) COLLATE public.nocase,
    vrve_created_date timestamp without time zone,
    vrve_last_modified_by character varying(60) COLLATE public.nocase,
    vrve_last_modified_date timestamp without time zone,
    vrve_confirm_price numeric(20,2),
    vrve_confirm_date timestamp without time zone,
    vrve_rpt_date_time character varying(50) COLLATE public.nocase,
    vrvel_remarks character varying(510) COLLATE public.nocase,
    vrvel_reject_code character varying(80) COLLATE public.nocase,
    vrve_for_period numeric(20,2),
    vrve_period_uom character varying(80) COLLATE public.nocase,
    vrve_from_geo character varying(80) COLLATE public.nocase,
    vrve_from_geo_type character varying(80) COLLATE public.nocase,
    vrve_to_geo character varying(80) COLLATE public.nocase,
    vrve_to_geo_type character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_vehicleequipresponsedetail ALTER COLUMN vrve_vhl_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_vehicleequipresponsedetail_vrve_vhl_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_vehicleequipresponsedetail
    ADD CONSTRAINT f_vehicleequipresponsedetail_pkey PRIMARY KEY (vrve_vhl_dtl_key);

ALTER TABLE ONLY dwh.f_vehicleequipresponsedetail
    ADD CONSTRAINT f_vehicleequipresponsedetail_ukey UNIQUE (vrve_ouinstance, vrve_tend_req_no, vrve_line_no);

ALTER TABLE ONLY dwh.f_vehicleequipresponsedetail
    ADD CONSTRAINT f_vehicleequipresponsedetail_vrve_vendor_key_fkey FOREIGN KEY (vrve_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_vehicleequipresponsedetail_key_idx ON dwh.f_vehicleequipresponsedetail USING btree (vrve_vendor_key);