CREATE TABLE dwh.f_brshipmentdetail (
    brsd_key bigint NOT NULL,
    brsd_br_key bigint NOT NULL,
    brsd_ouinstance integer,
    brsd_br_id character varying(40) COLLATE public.nocase,
    brsd_from_ship_point_id character varying(40) COLLATE public.nocase,
    brsd_from_ship_point_name character varying(510) COLLATE public.nocase,
    brsd_from_contact_person character varying(100) COLLATE public.nocase,
    brsd_from_address_line1 character varying(300) COLLATE public.nocase,
    brsd_from_address_line2 character varying(300) COLLATE public.nocase,
    brsd_from_address_line3 character varying(300) COLLATE public.nocase,
    brsd_from_postal_code character varying(80) COLLATE public.nocase,
    brsd_from_subzone character varying(80) COLLATE public.nocase,
    brsd_from_city character varying(80) COLLATE public.nocase,
    brsd_from_zone character varying(80) COLLATE public.nocase,
    brsd_from_state character varying(80) COLLATE public.nocase,
    brsd_from_region character varying(80) COLLATE public.nocase,
    brsd_from_country character varying(80) COLLATE public.nocase,
    brsd_from_primary_phone character varying(80) COLLATE public.nocase,
    brsd_from_secondary_phone character varying(80) COLLATE public.nocase,
    brsd_from_pick_date timestamp without time zone,
    brsd_from_picktime_slot_from timestamp without time zone,
    brsd_from_picktime_slot_to timestamp without time zone,
    brsd_from_creation_date timestamp without time zone,
    brsd_from_created_by character varying(60) COLLATE public.nocase,
    brsd_from_last_modified_date timestamp without time zone,
    brsd_from_last_modified_by character varying(60) COLLATE public.nocase,
    brsd_to_ship_point_id character varying(40) COLLATE public.nocase,
    brsd_to_ship_point_name character varying(510) COLLATE public.nocase,
    brsd_to_contact_person character varying(100) COLLATE public.nocase,
    brsd_to_address_line1 character varying(300) COLLATE public.nocase,
    brsd_to_address_line2 character varying(300) COLLATE public.nocase,
    brsd_to_address_line3 character varying(300) COLLATE public.nocase,
    brsd_to_postal_code character varying(80) COLLATE public.nocase,
    brsd_to_subzone character varying(80) COLLATE public.nocase,
    brsd_to_city character varying(80) COLLATE public.nocase,
    brsd_to_zone character varying(80) COLLATE public.nocase,
    brsd_to_state character varying(80) COLLATE public.nocase,
    brsd_to_region character varying(80) COLLATE public.nocase,
    brsd_to_country character varying(80) COLLATE public.nocase,
    brsd_to_primary_phone character varying(80) COLLATE public.nocase,
    brsd_to_secondary_phone character varying(80) COLLATE public.nocase,
    brsd_to_creation_date timestamp without time zone,
    brsd_to_created_by character varying(60) COLLATE public.nocase,
    brsd_to_last_modified_date timestamp without time zone,
    brsd_to_last_modified_by character varying(60) COLLATE public.nocase,
    brsd_unique_id character varying(300) COLLATE public.nocase,
    brsd_to_delivery_date timestamp without time zone,
    brsd_to_deliverytime_slot_from timestamp without time zone,
    brsd_to_deliverytime_slot_to timestamp without time zone,
    brsd_to_consignee_same_as_ship_to character varying(10) COLLATE public.nocase,
    brsd_from_suburb character varying(80) COLLATE public.nocase,
    brsd_to_suburb character varying(80) COLLATE public.nocase,
    brsd_alternate_to_ship_point_id character varying(40) COLLATE public.nocase,
    brsd_alternate_to_ship_point_name character varying(510) COLLATE public.nocase,
    brsd_alternate_to_contact_person character varying(100) COLLATE public.nocase,
    brsd_alternate_to_address_line1 character varying(300) COLLATE public.nocase,
    brsd_alternate_to_address_line2 character varying(300) COLLATE public.nocase,
    brsd_alternate_to_postal_code character varying(80) COLLATE public.nocase,
    brsd_alternate_to_city character varying(80) COLLATE public.nocase,
    brsd_alternate_to_state character varying(80) COLLATE public.nocase,
    brsd_alternate_to_country character varying(80) COLLATE public.nocase,
    brsd_alternate_to_last_modified_date timestamp without time zone,
    brsd_alternate_to_last_modified_by character varying(60) COLLATE public.nocase,
    brsd_alternate_to_suburb character varying(80) COLLATE public.nocase,
    brsd_alternate_to_remarks character varying(8000) COLLATE public.nocase,
    brsd_from_email_id character varying(510) COLLATE public.nocase,
    brsd_to_email_id character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_brshipmentdetail ALTER COLUMN brsd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_brshipmentdetail_brsd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_brshipmentdetail
    ADD CONSTRAINT f_brshipmentdetail_pkey PRIMARY KEY (brsd_key);

ALTER TABLE ONLY dwh.f_brshipmentdetail
    ADD CONSTRAINT f_brshipmentdetail_ukey UNIQUE (brsd_ouinstance, brsd_br_id);

ALTER TABLE ONLY dwh.f_brshipmentdetail
    ADD CONSTRAINT f_brshipmentdetail_brsd_br_key_fkey FOREIGN KEY (brsd_br_key) REFERENCES dwh.f_bookingrequest(br_key);

CREATE INDEX f_brshipmentdetail_key_idx ON dwh.f_brshipmentdetail USING btree (brsd_ouinstance, brsd_br_id);

CREATE INDEX f_brshipmentdetail_key_idx1 ON dwh.f_brshipmentdetail USING btree (brsd_br_key);