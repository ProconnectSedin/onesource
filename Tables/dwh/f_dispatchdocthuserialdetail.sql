CREATE TABLE dwh.f_dispatchdocthuserialdetail (
    ddtsd_key bigint NOT NULL,
    ddtd_key bigint NOT NULL,
    ddtsd_ouinstance integer,
    ddtsd_dispatch_doc_no character varying(40) COLLATE public.nocase,
    ddtsd_thu_line_no character varying(300) COLLATE public.nocase,
    ddtsd_thu_serial_line_no character varying(300) COLLATE public.nocase,
    ddtsd_thu_serial_no character varying(80) COLLATE public.nocase,
    ddtsd_thu_seal_no character varying(80) COLLATE public.nocase,
    ddtsd_un_code character varying(80) COLLATE public.nocase,
    ddtsd_class_code character varying(80) COLLATE public.nocase,
    ddtsd_hs_code character varying(80) COLLATE public.nocase,
    ddtsd_hazmat_code character varying(80) COLLATE public.nocase,
    ddtsd_hac_code character varying(10) COLLATE public.nocase,
    ddtsd_length numeric(20,2),
    ddtsd_breadth numeric(20,2),
    ddtsd_height numeric(20,2),
    ddtsd_lbh_uom character varying(30) COLLATE public.nocase,
    ddtsd_gross_weight numeric(20,2),
    ddtsd_gross_weight_uom character varying(30) COLLATE public.nocase,
    ddtsd_created_by character varying(60) COLLATE public.nocase,
    ddtsd_created_date timestamp without time zone,
    ddtsd_last_modified_by character varying(60) COLLATE public.nocase,
    ddtsd_lst_modified_date timestamp without time zone,
    ddtsd_timestamp integer,
    ddtsd_altqty numeric(20,2),
    ddtsd_altqty_uom character varying(30) COLLATE public.nocase,
    ddtsd_customs_sealno character varying(510) COLLATE public.nocase,
    ddtsd_container_type_specs character varying(8000) COLLATE public.nocase,
    ddtsd_container_size_specs character varying(8000) COLLATE public.nocase,
    ddtsd_customer_serial_no character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchdocthuserialdetail ALTER COLUMN ddtsd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchdocthuserialdetail_ddtsd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchdocthuserialdetail
    ADD CONSTRAINT f_dispatchdocthuserialdetail_pkey PRIMARY KEY (ddtsd_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuserialdetail
    ADD CONSTRAINT f_dispatchdocthuserialdetail_ukey UNIQUE (ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_thu_serial_line_no);

ALTER TABLE ONLY dwh.f_dispatchdocthuserialdetail
    ADD CONSTRAINT f_dispatchdocthuserialdetail_ddtd_key_fkey FOREIGN KEY (ddtd_key) REFERENCES dwh.f_dispatchdocthudetail(ddtd_key);

CREATE INDEX f_dispatchdocthuserialdetail_key_idx ON dwh.f_dispatchdocthuserialdetail USING btree (ddtd_key);

CREATE INDEX f_dispatchdocthuserialdetail_key_idx1 ON dwh.f_dispatchdocthuserialdetail USING btree (ddtsd_ouinstance, ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_thu_serial_line_no);