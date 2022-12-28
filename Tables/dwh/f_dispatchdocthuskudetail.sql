CREATE TABLE dwh.f_dispatchdocthuskudetail (
    ddtskud_key bigint NOT NULL,
    ddtd_key bigint NOT NULL,
    ddtsd_ou integer,
    ddtsd_dispatch_doc_no character varying(40) COLLATE public.nocase,
    ddtsd_thu_line_no character varying(300) COLLATE public.nocase,
    ddtsd_serial_no character varying(80) COLLATE public.nocase,
    ddtsd_child_thu_id character varying(80) COLLATE public.nocase,
    ddtsd_child_serial_no character varying(80) COLLATE public.nocase,
    ddtsd_sku_line_no character varying(300) COLLATE public.nocase,
    ddtsd_sku_id character varying(80) COLLATE public.nocase,
    ddtsd_sku_rate numeric(20,2),
    ddtsd_sku_quantity numeric(20,2),
    ddtsd_sku_value numeric(20,2),
    ddtsd_sku_batch_id character varying(80) COLLATE public.nocase,
    ddtsd_sku_mfg_date timestamp without time zone,
    ddtsd_sku_expiry_date timestamp without time zone,
    ddtsd_created_by character varying(60) COLLATE public.nocase,
    ddtsd_created_date timestamp without time zone,
    ddtsd_modified_by character varying(60) COLLATE public.nocase,
    ddtsd_modified_date timestamp without time zone,
    ddtsd_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchdocthuskudetail ALTER COLUMN ddtskud_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchdocthuskudetail_ddtskud_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchdocthuskudetail
    ADD CONSTRAINT f_dispatchdocthuskudetail_pkey PRIMARY KEY (ddtskud_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuskudetail
    ADD CONSTRAINT f_dispatchdocthuskudetail_ukey UNIQUE (ddtsd_ou, ddtsd_dispatch_doc_no, ddtsd_thu_line_no);

ALTER TABLE ONLY dwh.f_dispatchdocthuskudetail
    ADD CONSTRAINT f_dispatchdocthuskudetail_ddtd_key_fkey FOREIGN KEY (ddtd_key) REFERENCES dwh.f_dispatchdocthudetail(ddtd_key);

CREATE INDEX f_dispatchdocthuskudetail_key_idx ON dwh.f_dispatchdocthuskudetail USING btree (ddtd_key);

CREATE INDEX f_dispatchdocthuskudetail_key_idx1 ON dwh.f_dispatchdocthuskudetail USING btree (ddtsd_ou, ddtsd_dispatch_doc_no, ddtsd_thu_line_no);