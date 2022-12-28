CREATE TABLE dwh.f_tenderrequirementdetail (
    trd_dtl_key bigint NOT NULL,
    trd_hdr_key bigint NOT NULL,
    trd_ouinstance integer,
    trd_tender_req_no character varying(40) COLLATE public.nocase,
    trd_tender_req_line_no character varying(300) COLLATE public.nocase,
    trd_ref_doc_type character varying(80) COLLATE public.nocase,
    trd_ref_doc_no character varying(80) COLLATE public.nocase,
    trd_from_geo character varying(80) COLLATE public.nocase,
    trd_from_geo_type character varying(80) COLLATE public.nocase,
    trd_to_geo character varying(80) COLLATE public.nocase,
    trd_to_geo_type character varying(80) COLLATE public.nocase,
    trd_req_for_vehicle character varying(10) COLLATE public.nocase,
    trd_req_for_equipment character varying(10) COLLATE public.nocase,
    trd_req_for_driver character varying(10) COLLATE public.nocase,
    trd_req_for_handler character varying(10) COLLATE public.nocase,
    trd_req_for_services character varying(10) COLLATE public.nocase,
    trd_req_for_schedule character varying(10) COLLATE public.nocase,
    trd_req_created_by character varying(60) COLLATE public.nocase,
    trd_req_created_date timestamp without time zone,
    trd_req_last_modified_by character varying(60) COLLATE public.nocase,
    trd_req_last_modified_date timestamp without time zone,
    trd_timestamp integer,
    trd_trip_plan_id character varying(40) COLLATE public.nocase,
    geo_city_desc character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tenderrequirementdetail ALTER COLUMN trd_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tenderrequirementdetail_trd_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tenderrequirementdetail
    ADD CONSTRAINT f_tenderrequirementdetail_pkey PRIMARY KEY (trd_dtl_key);

ALTER TABLE ONLY dwh.f_tenderrequirementdetail
    ADD CONSTRAINT f_tenderrequirementdetail_ukey UNIQUE (trd_ouinstance, trd_tender_req_no, trd_tender_req_line_no, trd_ref_doc_no);

ALTER TABLE ONLY dwh.f_tenderrequirementdetail
    ADD CONSTRAINT f_tenderrequirementdetail_trd_hdr_key_fkey FOREIGN KEY (trd_hdr_key) REFERENCES dwh.f_tenderrequirementheader(trh_hdr_key);

CREATE INDEX f_tenderrequirementdetail_key_idx ON dwh.f_tenderrequirementdetail USING btree (trd_hdr_key);