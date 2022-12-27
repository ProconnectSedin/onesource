CREATE TABLE dwh.f_triplogexpensedocdetail (
    tledd_key bigint NOT NULL,
    tledd_ouinstance integer,
    tledd_trip_plan character varying(40) COLLATE public.nocase,
    tledd_trip_leg_seq_id integer,
    tledd_rec_exp character varying(80) COLLATE public.nocase,
    tledd_exp_type character varying(80) COLLATE public.nocase,
    tledd_bill_no character varying(80) COLLATE public.nocase,
    tledd_doc_guid character varying(300) COLLATE public.nocase,
    tledd_document_id character varying(80) COLLATE public.nocase,
    tledd_document_date character varying(50) COLLATE public.nocase,
    tledd_remarks character varying(510) COLLATE public.nocase,
    tledd_created_by character varying(60) COLLATE public.nocase,
    tledd_created_date character varying(50) COLLATE public.nocase,
    tledd_modified_by character varying(60) COLLATE public.nocase,
    tledd_modified_date character varying(50) COLLATE public.nocase,
    tled_timestamp integer,
    tledd_attachment character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_triplogexpensedocdetail ALTER COLUMN tledd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_triplogexpensedocdetail_tledd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_triplogexpensedocdetail
    ADD CONSTRAINT f_triplogexpensedocdetail_pkey PRIMARY KEY (tledd_key);

ALTER TABLE ONLY dwh.f_triplogexpensedocdetail
    ADD CONSTRAINT f_triplogexpensedocdetail_ukey UNIQUE (tledd_ouinstance, tledd_doc_guid);

CREATE INDEX f_triplogexpensedocdetail_key_idx ON dwh.f_triplogexpensedocdetail USING btree (tledd_ouinstance, tledd_doc_guid);