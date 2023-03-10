CREATE TABLE dwh.f_dispatchheader (
    dispatch_hdr_key bigint NOT NULL,
    dispatch_hdr_loc_key bigint,
    dispatch_hdr_veh_key bigint,
    dispatch_loc_code character varying(20) COLLATE public.nocase,
    dispatch_ld_sheet_no character varying(40) COLLATE public.nocase,
    dispatch_ld_sheet_ou integer,
    dispatch_ld_sheet_date timestamp without time zone,
    dispatch_ld_sheet_status character varying(20) COLLATE public.nocase,
    dispatch_staging_id character varying(40) COLLATE public.nocase,
    dispatch_lsp character varying(80) COLLATE public.nocase,
    dispatch_source_stage character varying(510) COLLATE public.nocase,
    dispatch_source_docno character varying(40) COLLATE public.nocase,
    dispatch_created_by character varying(60) COLLATE public.nocase,
    dispatch_created_date timestamp without time zone,
    dispatch_modified_by character varying(60) COLLATE public.nocase,
    dispatch_modified_date timestamp without time zone,
    dispatch_timestamp integer,
    dispatch_booking_req_no character varying(40) COLLATE public.nocase,
    pack_disp_urgent integer,
    dispatch_doc_code character varying(40) COLLATE public.nocase,
    dispatch_vehicle_code character varying(40) COLLATE public.nocase,
    dispatch_reason_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchheader ALTER COLUMN dispatch_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchheader_dispatch_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchheader
    ADD CONSTRAINT f_dispatchheader_pkey PRIMARY KEY (dispatch_hdr_key);

ALTER TABLE ONLY dwh.f_dispatchheader
    ADD CONSTRAINT f_dispatchheader_ukey UNIQUE (dispatch_loc_code, dispatch_ld_sheet_no, dispatch_ld_sheet_ou);

ALTER TABLE ONLY dwh.f_dispatchheader
    ADD CONSTRAINT f_dispatchheader_dispatch_hdr_loc_key_fkey FOREIGN KEY (dispatch_hdr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_dispatchheader
    ADD CONSTRAINT f_dispatchheader_dispatch_hdr_veh_key_fkey FOREIGN KEY (dispatch_hdr_veh_key) REFERENCES dwh.d_vehicle(veh_key);

CREATE INDEX f_dispatchheader_key_idx ON dwh.f_dispatchheader USING btree (dispatch_hdr_loc_key, dispatch_hdr_veh_key);