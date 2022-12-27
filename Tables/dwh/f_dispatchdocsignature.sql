CREATE TABLE dwh.f_dispatchdocsignature (
    dds_key bigint NOT NULL,
    ddh_key bigint NOT NULL,
    dds_ouinstance integer,
    dds_trip_id character varying(80) COLLATE public.nocase,
    dds_seqno integer,
    dds_dispatch_doc_no character varying(40) COLLATE public.nocase,
    dds_name character varying(80) COLLATE public.nocase,
    dds_signature character varying COLLATE public.nocase,
    dds_remarks character varying(512) COLLATE public.nocase,
    dds_feedback character varying(50) COLLATE public.nocase,
    dds_signature_status character varying(50) COLLATE public.nocase,
    dds_id_type character varying(80) COLLATE public.nocase,
    dds_id_no character varying(80) COLLATE public.nocase,
    dds_designation character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchdocsignature ALTER COLUMN dds_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchdocsignature_dds_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchdocsignature
    ADD CONSTRAINT f_dispatchdocsignature_pkey PRIMARY KEY (dds_key);

ALTER TABLE ONLY dwh.f_dispatchdocsignature
    ADD CONSTRAINT f_dispatchdocsignature_ukey UNIQUE (dds_ouinstance, dds_trip_id, dds_seqno, dds_dispatch_doc_no);

ALTER TABLE ONLY dwh.f_dispatchdocsignature
    ADD CONSTRAINT f_dispatchdocsignature_ddh_key_fkey FOREIGN KEY (ddh_key) REFERENCES dwh.f_dispatchdocheader(ddh_key);

CREATE INDEX f_dispatchdocsignature_key_idx ON dwh.f_dispatchdocsignature USING btree (ddh_key);

CREATE INDEX f_dispatchdocsignature_key_idx1 ON dwh.f_dispatchdocsignature USING btree (dds_ouinstance, dds_trip_id, dds_seqno, dds_dispatch_doc_no);