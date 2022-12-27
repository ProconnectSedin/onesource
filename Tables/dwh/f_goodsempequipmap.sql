CREATE TABLE dwh.f_goodsempequipmap (
    gr_good_emp_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_loc_cod character varying(510) COLLATE public.nocase,
    gr_ou integer,
    gr_lineno integer,
    gr_shift_code character varying(510) COLLATE public.nocase,
    gr_emp_code character varying(20) COLLATE public.nocase,
    gr_area character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_goodsempequipmap ALTER COLUMN gr_good_emp_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_goodsempequipmap_gr_good_emp_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_goodsempequipmap
    ADD CONSTRAINT f_goodsempequipmap_pkey PRIMARY KEY (gr_good_emp_key);

ALTER TABLE ONLY dwh.f_goodsempequipmap
    ADD CONSTRAINT f_goodsempequipmap_ukey UNIQUE (gr_loc_cod, gr_ou, gr_lineno);

ALTER TABLE ONLY dwh.f_goodsempequipmap
    ADD CONSTRAINT f_goodsempequipmap_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_goodsempequipmap_key_idx ON dwh.f_goodsempequipmap USING btree (gr_loc_key);

CREATE INDEX f_goodsempequipmap_key_idx1 ON dwh.f_goodsempequipmap USING btree (gr_loc_cod, gr_ou, gr_lineno);