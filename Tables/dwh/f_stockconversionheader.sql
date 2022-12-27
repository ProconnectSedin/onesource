CREATE TABLE dwh.f_stockconversionheader (
    stk_con_hdr_key bigint NOT NULL,
    stk_con_loc_key bigint NOT NULL,
    stk_con_date_key bigint NOT NULL,
    stk_con_loc_code character varying(20) COLLATE public.nocase,
    stk_con_proposal_no character varying(40) COLLATE public.nocase,
    stk_con_proposal_ou integer,
    stk_con_proposal_date timestamp without time zone,
    stk_con_proposal_status character varying(20) COLLATE public.nocase,
    stk_con_proposal_type character varying(20) COLLATE public.nocase,
    stk_con_ref_doc_no character varying(40) COLLATE public.nocase,
    stk_con_approver character varying(50) COLLATE public.nocase,
    stk_con_remarks character varying(510) COLLATE public.nocase,
    stk_con_created_by character varying(60) COLLATE public.nocase,
    stk_con_created_date timestamp without time zone,
    stk_con_modified_by character varying(60) COLLATE public.nocase,
    stk_con_modified_date timestamp without time zone,
    stk_con_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_stockconversionheader ALTER COLUMN stk_con_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_stockconversionheader_stk_con_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_stockconversionheader
    ADD CONSTRAINT f_stockconversionheader_pkey PRIMARY KEY (stk_con_hdr_key);

ALTER TABLE ONLY dwh.f_stockconversionheader
    ADD CONSTRAINT f_stockconversionheader_ukey UNIQUE (stk_con_loc_code, stk_con_proposal_no, stk_con_proposal_ou);

ALTER TABLE ONLY dwh.f_stockconversionheader
    ADD CONSTRAINT f_stockconversionheader_stk_con_date_key_fkey FOREIGN KEY (stk_con_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_stockconversionheader
    ADD CONSTRAINT f_stockconversionheader_stk_con_loc_key_fkey FOREIGN KEY (stk_con_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_stockconversionheader_key_idx ON dwh.f_stockconversionheader USING btree (stk_con_loc_key, stk_con_date_key);