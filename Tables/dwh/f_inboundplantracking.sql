CREATE TABLE dwh.f_inboundplantracking (
    pln_tracking_key bigint NOT NULL,
    pln_date_key bigint NOT NULL,
    pln_lineno integer,
    pln_ou integer,
    pln_stage character varying(20) COLLATE public.nocase,
    pln_pln_no character varying(40) COLLATE public.nocase,
    pln_exe_no character varying(40) COLLATE public.nocase,
    pln_exe_status character varying(20) COLLATE public.nocase,
    pln_user character varying(60) COLLATE public.nocase,
    pln_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_inboundplantracking ALTER COLUMN pln_tracking_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_inboundplantracking_pln_tracking_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_inboundplantracking
    ADD CONSTRAINT f_inboundplantracking_pkey PRIMARY KEY (pln_tracking_key);

ALTER TABLE ONLY dwh.f_inboundplantracking
    ADD CONSTRAINT f_inboundplantracking_ukey UNIQUE (pln_lineno, pln_ou);

ALTER TABLE ONLY dwh.f_inboundplantracking
    ADD CONSTRAINT f_inboundplantracking_pln_date_key_fkey FOREIGN KEY (pln_date_key) REFERENCES dwh.d_date(datekey);

CREATE INDEX f_inboundplantracking_key_idx ON dwh.f_inboundplantracking USING btree (pln_date_key);

CREATE INDEX f_inboundplantracking_key_idx1 ON dwh.f_inboundplantracking USING btree (pln_lineno, pln_ou);