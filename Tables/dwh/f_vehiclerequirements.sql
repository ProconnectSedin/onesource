CREATE TABLE dwh.f_vehiclerequirements (
    trvr_vhl_req_key bigint NOT NULL,
    trvr_ouinstance integer,
    trvr_tender_req_no character varying(40) COLLATE public.nocase,
    trvr_line_no character varying(300) COLLATE public.nocase,
    trvr_vehicle_type character varying(80) COLLATE public.nocase,
    trvr_no_of_vehicles integer,
    trvr_required_date_time timestamp without time zone,
    trvr_pref_vehicle_model character varying(80) COLLATE public.nocase,
    trvr_created_by character varying(60) COLLATE public.nocase,
    trvr_created_date timestamp without time zone,
    trvr_last_modified_by character varying(60) COLLATE public.nocase,
    trvr_last_modified_date timestamp without time zone,
    trvr_timestamp integer,
    trvr_for_period numeric(20,2),
    trvr_period_uom character varying(80) COLLATE public.nocase,
    trvr_ref_doc_no character varying(80) COLLATE public.nocase,
    trvr_ref_doc_type character varying(80) COLLATE public.nocase,
    trvr_tender_to character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_vehiclerequirements ALTER COLUMN trvr_vhl_req_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_vehiclerequirements_trvr_vhl_req_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_vehiclerequirements
    ADD CONSTRAINT f_vehiclerequirements_pkey PRIMARY KEY (trvr_vhl_req_key);