CREATE TABLE dwh.f_dispatchdocthuchilddetail (
    ddtcd_key bigint NOT NULL,
    ddtd_key bigint NOT NULL,
    ddtcd_ouinstance integer,
    ddtcd_dispatch_doc_no character varying(40) COLLATE public.nocase,
    ddtcd_thu_line_no character varying(300) COLLATE public.nocase,
    ddtcd_thu_child_line_no character varying(300) COLLATE public.nocase,
    ddtcd_thu_child_id character varying(80) COLLATE public.nocase,
    ddtcd_thu_child_serial_no character varying(80) COLLATE public.nocase,
    ddtcd_thu_child_qty numeric(13,2),
    ddtcd_created_by character varying(60) COLLATE public.nocase,
    ddtcd_created_date timestamp without time zone,
    ddtcd_last_modified_by character varying(60) COLLATE public.nocase,
    ddtcd_lst_modified_date timestamp without time zone,
    ddtcd_timestamp integer,
    ddtcd_main_thu_child_serial_no character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchdocthuchilddetail ALTER COLUMN ddtcd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchdocthuchilddetail_ddtcd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchdocthuchilddetail
    ADD CONSTRAINT f_dispatchdocthuchilddetail_pkey PRIMARY KEY (ddtcd_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuchilddetail
    ADD CONSTRAINT f_dispatchdocthuchilddetail_ukey UNIQUE (ddtcd_ouinstance, ddtcd_dispatch_doc_no, ddtcd_thu_line_no, ddtcd_thu_child_line_no);

ALTER TABLE ONLY dwh.f_dispatchdocthuchilddetail
    ADD CONSTRAINT f_dispatchdocthuchilddetail_ddtd_key_fkey FOREIGN KEY (ddtd_key) REFERENCES dwh.f_dispatchdocthudetail(ddtd_key);

CREATE INDEX f_dispatchdocthuchilddetail_key_idx ON dwh.f_dispatchdocthuchilddetail USING btree (ddtd_key);

CREATE INDEX f_dispatchdocthuchilddetail_key_idx1 ON dwh.f_dispatchdocthuchilddetail USING btree (ddtcd_ouinstance, ddtcd_dispatch_doc_no, ddtcd_thu_line_no, ddtcd_thu_child_line_no);