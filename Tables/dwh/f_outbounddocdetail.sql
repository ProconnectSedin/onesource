CREATE TABLE dwh.f_outbounddocdetail (
    obd_dl_key bigint NOT NULL,
    obh_hr_key bigint NOT NULL,
    obd_loc_key bigint NOT NULL,
    oub_doc_loc_code character varying(80) COLLATE public.nocase,
    oub_outbound_ord character varying(510) COLLATE public.nocase,
    oub_doc_lineno integer,
    oub_doc_ou integer,
    oub_doc_type character varying(80) COLLATE public.nocase,
    oub_doc_attach character varying(510) COLLATE public.nocase,
    oub_doc_hdn_attach text COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_outbounddocdetail ALTER COLUMN obd_dl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_outbounddocdetail_obd_dl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_outbounddocdetail
    ADD CONSTRAINT f_outbounddocdetail_pkey PRIMARY KEY (obd_dl_key);

ALTER TABLE ONLY dwh.f_outbounddocdetail
    ADD CONSTRAINT f_outbounddocdetail_ukey UNIQUE (oub_doc_loc_code, oub_outbound_ord, oub_doc_lineno, oub_doc_ou);

ALTER TABLE ONLY dwh.f_outbounddocdetail
    ADD CONSTRAINT f_outbounddocdetail_obd_loc_key_fkey FOREIGN KEY (obd_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_outbounddocdetail_key_idx ON dwh.f_outbounddocdetail USING btree (obd_loc_key);

CREATE INDEX f_outbounddocdetail_key_idx1 ON dwh.f_outbounddocdetail USING btree (oub_doc_loc_code, oub_outbound_ord, oub_doc_lineno, oub_doc_ou);

CREATE INDEX f_outbounddocdetail_key_idx2 ON dwh.f_outbounddocdetail USING btree (oub_doc_ou, oub_doc_loc_code, oub_doc_loc_code);