CREATE TABLE dwh.f_planningdetail (
    plph_dtl_key bigint NOT NULL,
    plph_hdr_key bigint NOT NULL,
    plpd_cust_key bigint NOT NULL,
    plpd_ouinstance integer,
    plpd_plan_run_no character varying(40) COLLATE public.nocase,
    plpd_doc_id character varying(40) COLLATE public.nocase,
    plpd_doc_type character varying(80) COLLATE public.nocase,
    plpd_from_location character varying(80) COLLATE public.nocase,
    plpd_to_location character varying(80) COLLATE public.nocase,
    plpd_leg_no character varying(40) COLLATE public.nocase,
    plpd_leg_behaviour character varying(80) COLLATE public.nocase,
    plpd_execution_plan character varying(40) COLLATE public.nocase,
    plpd_planning_cutoftime character varying(80) COLLATE public.nocase,
    plpd_created_by character varying(60) COLLATE public.nocase,
    plpd_created_date timestamp without time zone,
    plpd_last_modified_by character varying(60) COLLATE public.nocase,
    plpd_last_modified_date timestamp without time zone,
    plpd_failure_reason character varying(8000) COLLATE public.nocase,
    plpd_customercode character varying(80) COLLATE public.nocase,
    plpd_customer_name character varying(510) COLLATE public.nocase,
    plpd_trip_id character varying(80) COLLATE public.nocase,
    plpd_trip_status character varying(80) COLLATE public.nocase,
    plpd_thu character varying(80) COLLATE public.nocase,
    plpd_qty numeric(25,2),
    plpd_balance_qty numeric(25,2),
    plpd_planned_qty numeric(25,2),
    plpd_ship_from_desc character varying(510) COLLATE public.nocase,
    plpd_from_postcode character varying(80) COLLATE public.nocase,
    plpd_from_suburb character varying(80) COLLATE public.nocase,
    plpd_to_desc character varying(510) COLLATE public.nocase,
    plpd_to_postcode character varying(80) COLLATE public.nocase,
    plpd_to_suburb character varying(80) COLLATE public.nocase,
    plpd_pickup_date timestamp without time zone,
    plpd_pickup_timeslot character varying(80) COLLATE public.nocase,
    plpd_delivery_date timestamp without time zone,
    plpd_delivery_timeslot character varying(80) COLLATE public.nocase,
    plpd_volume numeric(25,2),
    plpd_palletspace numeric(25,2),
    plpd_grossweight numeric(25,2),
    plpd_plan_unique_id character varying(300) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_planningdetail ALTER COLUMN plph_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_planningdetail_plph_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_planningdetail
    ADD CONSTRAINT f_planningdetail_pkey PRIMARY KEY (plph_dtl_key);

ALTER TABLE ONLY dwh.f_planningdetail
    ADD CONSTRAINT f_planningdetail_ukey UNIQUE (plpd_ouinstance, plpd_plan_run_no, plpd_plan_unique_id);

ALTER TABLE ONLY dwh.f_planningdetail
    ADD CONSTRAINT f_planningdetail_plpd_cust_key_fkey FOREIGN KEY (plpd_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_planningdetail
    ADD CONSTRAINT f_planningdetail_plph_hdr_key_fkey FOREIGN KEY (plph_hdr_key) REFERENCES dwh.f_planningheader(plph_hdr_key);

CREATE INDEX f_planningdetail_key_idx ON dwh.f_planningdetail USING btree (plpd_cust_key);

CREATE INDEX f_planningdetail_key_idx1 ON dwh.f_planningdetail USING btree (plpd_ouinstance, plpd_plan_run_no, plpd_plan_unique_id);