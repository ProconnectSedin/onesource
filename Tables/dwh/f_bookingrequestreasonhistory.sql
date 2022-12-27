CREATE TABLE dwh.f_bookingrequestreasonhistory (
    br_bkreq_key bigint NOT NULL,
    br_hdr_key bigint NOT NULL,
    br_ouinstance integer,
    br_request_id character varying(40) COLLATE public.nocase,
    amend_no integer,
    br_status character varying(80) COLLATE public.nocase,
    reason_code character varying(80) COLLATE public.nocase,
    reason_desc character varying(510) COLLATE public.nocase,
    created_date character varying(50) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_bookingrequestreasonhistory ALTER COLUMN br_bkreq_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_bookingrequestreasonhistory_br_bkreq_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_bookingrequestreasonhistory
    ADD CONSTRAINT f_bookingrequestreasonhistory_pkey PRIMARY KEY (br_bkreq_key);

ALTER TABLE ONLY dwh.f_bookingrequestreasonhistory
    ADD CONSTRAINT f_bookingrequestreasonhistory_ukey UNIQUE (br_ouinstance, br_request_id, amend_no);

ALTER TABLE ONLY dwh.f_bookingrequestreasonhistory
    ADD CONSTRAINT f_bookingrequestreasonhistory_br_hdr_key_fkey FOREIGN KEY (br_hdr_key) REFERENCES dwh.f_bookingrequest(br_key);

CREATE INDEX f_bookingrequestreasonhistory_key_idx ON dwh.f_bookingrequestreasonhistory USING btree (br_ouinstance, br_request_id, amend_no);

CREATE INDEX f_bookingrequestreasonhistory_key_idx1 ON dwh.f_bookingrequestreasonhistory USING btree (br_hdr_key);