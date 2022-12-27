CREATE TABLE dwh.f_brplanningprofiledetail (
    brppd_key bigint NOT NULL,
    brppd_cust_key bigint NOT NULL,
    brppd_loc_key bigint NOT NULL,
    brppd_ouinstance integer,
    brppd_profile_id character varying(80) COLLATE public.nocase,
    brppd_br_id character varying(80) COLLATE public.nocase,
    brppd_direct_entry character varying(10) COLLATE public.nocase,
    brppd_auto_entry character varying(10) COLLATE public.nocase,
    brppd_created_by character varying(60) COLLATE public.nocase,
    brppd_created_date timestamp without time zone,
    brppd_priority integer,
    brppd_param_priority character varying(80) COLLATE public.nocase,
    brppd_customer_id character varying(80) COLLATE public.nocase,
    brppd_customer_name character varying(510) COLLATE public.nocase,
    brppd_execution_plan character varying(80) COLLATE public.nocase,
    brppd_ship_from_id character varying(80) COLLATE public.nocase,
    brppd_ship_from_desc character varying(510) COLLATE public.nocase,
    brppd_ship_from_postal character varying(80) COLLATE public.nocase,
    brppd_ship_from_suburb character varying(80) COLLATE public.nocase,
    brppd_ship_to_id character varying(80) COLLATE public.nocase,
    brppd_ship_to_desc character varying(510) COLLATE public.nocase,
    brppd_ship_to_postal character varying(80) COLLATE public.nocase,
    brppd_ship_to_suburb character varying(80) COLLATE public.nocase,
    brppd_pickup_date timestamp without time zone,
    brppd_pickup_timeslot character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_brplanningprofiledetail ALTER COLUMN brppd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_brplanningprofiledetail_brppd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_brplanningprofiledetail
    ADD CONSTRAINT f_brplanningprofiledetail_pkey PRIMARY KEY (brppd_key);

ALTER TABLE ONLY dwh.f_brplanningprofiledetail
    ADD CONSTRAINT f_brplanningprofiledetail_ukey UNIQUE (brppd_ouinstance, brppd_profile_id, brppd_br_id);

ALTER TABLE ONLY dwh.f_brplanningprofiledetail
    ADD CONSTRAINT f_brplanningprofiledetail_brppd_cust_key_fkey FOREIGN KEY (brppd_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_brplanningprofiledetail
    ADD CONSTRAINT f_brplanningprofiledetail_brppd_loc_key_fkey FOREIGN KEY (brppd_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_brplanningprofiledetail_key_idx ON dwh.f_brplanningprofiledetail USING btree (brppd_ouinstance, brppd_profile_id, brppd_br_id);

CREATE INDEX f_brplanningprofiledetail_key_idx1 ON dwh.f_brplanningprofiledetail USING btree (brppd_cust_key, brppd_loc_key);