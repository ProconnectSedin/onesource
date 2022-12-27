CREATE TABLE dwh.f_brconsignmentconsigneedetail (
    brccd_key bigint NOT NULL,
    br_key bigint NOT NULL,
    brccd_consignee_hdr_key bigint NOT NULL,
    ccd_ouinstance integer,
    ccd_br_id character varying(40) COLLATE public.nocase,
    ccd_consignee_id character varying(40) COLLATE public.nocase,
    ccd_consignee_name character varying(300) COLLATE public.nocase,
    ccd_consignee_contact_person character varying(100) COLLATE public.nocase,
    ccd_consignee_address_line1 character varying(300) COLLATE public.nocase,
    ccd_consignee_address_line2 character varying(300) COLLATE public.nocase,
    ccd_consignee_address_line3 character varying(200) COLLATE public.nocase,
    ccd_consignee_postal_code character varying(80) COLLATE public.nocase,
    ccd_consignee_subzone character varying(80) COLLATE public.nocase,
    ccd_consignee_city character varying(80) COLLATE public.nocase,
    ccd_consignee_zone character varying(80) COLLATE public.nocase,
    ccd_consignee_state character varying(80) COLLATE public.nocase,
    ccd_consignee_region character varying(80) COLLATE public.nocase,
    ccd_consignee_country character varying(80) COLLATE public.nocase,
    ccd_created_by character varying(60) COLLATE public.nocase,
    ccd_created_date timestamp without time zone,
    ccd_last_modified_date timestamp without time zone,
    ccd_last_modified_by character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_brconsignmentconsigneedetail ALTER COLUMN brccd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_brconsignmentconsigneedetail_brccd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_brconsignmentconsigneedetail
    ADD CONSTRAINT f_brconsignmentconsigneedetail_pkey PRIMARY KEY (brccd_key);

ALTER TABLE ONLY dwh.f_brconsignmentconsigneedetail
    ADD CONSTRAINT f_brconsignmentconsigneedetail_ukey UNIQUE (ccd_ouinstance, ccd_br_id);

ALTER TABLE ONLY dwh.f_brconsignmentconsigneedetail
    ADD CONSTRAINT f_brconsignmentconsigneedetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brconsignmentconsigneedetail
    ADD CONSTRAINT f_brconsignmentconsigneedetail_brccd_consignee_hdr_key_fkey FOREIGN KEY (brccd_consignee_hdr_key) REFERENCES dwh.d_consignee(consignee_hdr_key);

CREATE INDEX f_brconsignmentconsigneedetail_key_idx ON dwh.f_brconsignmentconsigneedetail USING btree (br_key, brccd_consignee_hdr_key);

CREATE INDEX f_brconsignmentconsigneedetail_key_idx1 ON dwh.f_brconsignmentconsigneedetail USING btree (ccd_ouinstance, ccd_br_id);