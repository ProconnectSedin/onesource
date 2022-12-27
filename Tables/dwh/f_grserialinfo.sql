CREATE TABLE dwh.f_grserialinfo (
    gr_gsi_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_exec_no character varying(40) COLLATE public.nocase,
    gr_exec_ou integer,
    gr_lineno integer,
    gr_po_no character varying(40) COLLATE public.nocase,
    gr_po_sno character varying(60) COLLATE public.nocase,
    gr_item character varying(510) COLLATE public.nocase,
    gr_serial_no character varying(60) COLLATE public.nocase,
    gr_status character varying(20) COLLATE public.nocase,
    gr_cust_sno character varying(60) COLLATE public.nocase,
    gr_3pl_sno character varying(60) COLLATE public.nocase,
    gr_lot_no character varying(60) COLLATE public.nocase,
    gr_item_lineno integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_grserialinfo ALTER COLUMN gr_gsi_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_grserialinfo_gr_gsi_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_grserialinfo
    ADD CONSTRAINT f_grserialinfo_pkey PRIMARY KEY (gr_gsi_key);

ALTER TABLE ONLY dwh.f_grserialinfo
    ADD CONSTRAINT f_grserialinfo_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou, gr_lineno, gr_serial_no);

ALTER TABLE ONLY dwh.f_grserialinfo
    ADD CONSTRAINT f_grserialinfo_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_grserialinfo_key_idx ON dwh.f_grserialinfo USING btree (gr_loc_key);

CREATE INDEX f_grserialinfo_key_idx1 ON dwh.f_grserialinfo USING btree (gr_loc_code, gr_exec_no, gr_exec_ou, gr_lineno, gr_serial_no);