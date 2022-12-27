CREATE TABLE dwh.f_grthudetail (
    gr_thu_dtl_key bigint NOT NULL,
    gr_pln_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_pln_no character varying(40) COLLATE public.nocase,
    gr_pln_ou integer,
    gr_lineno integer,
    gr_po_no character varying(40) COLLATE public.nocase,
    gr_thu_id character varying(80) COLLATE public.nocase,
    gr_thu_desc character varying(510) COLLATE public.nocase,
    gr_thu_class character varying(80) COLLATE public.nocase,
    gr_thu_qty numeric(13,2),
    gr_pal_status character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_grthudetail ALTER COLUMN gr_thu_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_grthudetail_gr_thu_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_grthudetail
    ADD CONSTRAINT f_grthudetail_pkey PRIMARY KEY (gr_thu_dtl_key);

ALTER TABLE ONLY dwh.f_grthudetail
    ADD CONSTRAINT f_grthudetail_ukey UNIQUE (gr_loc_code, gr_pln_no, gr_pln_ou, gr_lineno);

ALTER TABLE ONLY dwh.f_grthudetail
    ADD CONSTRAINT f_grthudetail_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grthudetail
    ADD CONSTRAINT f_grthudetail_gr_pln_key_fkey FOREIGN KEY (gr_pln_key) REFERENCES dwh.f_grplandetail(gr_pln_key);

CREATE INDEX f_grthudetail_key_idx ON dwh.f_grthudetail USING btree (gr_loc_key);

CREATE INDEX f_grthudetail_key_idx1 ON dwh.f_grthudetail USING btree (gr_loc_code, gr_pln_no, gr_pln_ou, gr_lineno);