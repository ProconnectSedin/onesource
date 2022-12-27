CREATE TABLE dwh.f_triplogagentdetail (
    tlad_log_agent_dtl_key bigint NOT NULL,
    plpth_hdr_key bigint NOT NULL,
    tlad_ouinstance integer,
    tlad_trip_plan_id character varying(40) COLLATE public.nocase,
    tlad_dispatch_doc_no character varying(40) COLLATE public.nocase,
    tlad_thu_line_no character varying(300) COLLATE public.nocase,
    tlad_thu_agent_qty numeric(25,2),
    tlad_thu_agent_weight numeric(25,2),
    tlad_thu_agent_volume numeric(25,2),
    tlad_ag_ref_doc_type character varying(80) COLLATE public.nocase,
    tlad_ag_ref_doc_no character varying(40) COLLATE public.nocase,
    tlad_ag_ref_doc_date timestamp without time zone,
    tlad_agent_remarks character varying(510) COLLATE public.nocase,
    tlad_thu_agent_qty_uom character varying(80) COLLATE public.nocase,
    tlad_thu_agent_weight_uom character varying(80) COLLATE public.nocase,
    tlad_thu_agent_volume_uom character varying(80) COLLATE public.nocase,
    tlad_timestamp integer,
    tlad_created_by character varying(60) COLLATE public.nocase,
    tlad_creation_date timestamp without time zone,
    tlad_last_modified_by character varying(60) COLLATE public.nocase,
    tlad_last_modified_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_triplogagentdetail ALTER COLUMN tlad_log_agent_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_triplogagentdetail_tlad_log_agent_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_triplogagentdetail
    ADD CONSTRAINT f_triplogagentdetail_pkey PRIMARY KEY (tlad_log_agent_dtl_key);

ALTER TABLE ONLY dwh.f_triplogagentdetail
    ADD CONSTRAINT f_triplogagentdetail_ukey UNIQUE (tlad_ouinstance, tlad_trip_plan_id, tlad_dispatch_doc_no, tlad_thu_line_no);

ALTER TABLE ONLY dwh.f_triplogagentdetail
    ADD CONSTRAINT f_triplogagentdetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

CREATE INDEX f_triplogagentdetail_key_idx ON dwh.f_triplogagentdetail USING btree (plpth_hdr_key);

CREATE INDEX f_triplogagentdetail_key_idx1 ON dwh.f_triplogagentdetail USING btree (tlad_ouinstance, tlad_trip_plan_id, tlad_dispatch_doc_no, tlad_thu_line_no);

CREATE INDEX f_triplogagentdetail_ndx ON dwh.f_triplogagentdetail USING btree (tlad_ouinstance, tlad_trip_plan_id, tlad_dispatch_doc_no);

CREATE INDEX f_triplogagentdetail_ndx3 ON dwh.f_triplogagentdetail USING btree (tlad_ag_ref_doc_no, tlad_trip_plan_id, tlad_ouinstance);