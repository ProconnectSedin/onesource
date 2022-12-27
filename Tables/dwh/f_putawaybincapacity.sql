CREATE TABLE dwh.f_putawaybincapacity (
    pway_bin_cap_key bigint NOT NULL,
    pway_pln_dtl_key bigint NOT NULL,
    pway_bin_cap_loc_key bigint NOT NULL,
    pway_bin_cap_itm_hdr_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_pln_no character varying(40) COLLATE public.nocase,
    pway_pln_ou integer,
    pway_lineno integer,
    pway_item_ln_no integer,
    pway_item character varying(80) COLLATE public.nocase,
    pway_bin character varying(20) COLLATE public.nocase,
    pway_occu_capacity numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_putawaybincapacity ALTER COLUMN pway_bin_cap_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_putawaybincapacity_pway_bin_cap_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_putawaybincapacity
    ADD CONSTRAINT f_putawaybincapacity_pkey PRIMARY KEY (pway_bin_cap_key);

ALTER TABLE ONLY dwh.f_putawaybincapacity
    ADD CONSTRAINT f_putawaybincapacity_ukey UNIQUE (pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno);

ALTER TABLE ONLY dwh.f_putawaybincapacity
    ADD CONSTRAINT f_putawaybincapacity_pway_bin_cap_itm_hdr_key_fkey FOREIGN KEY (pway_bin_cap_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_putawaybincapacity
    ADD CONSTRAINT f_putawaybincapacity_pway_bin_cap_loc_key_fkey FOREIGN KEY (pway_bin_cap_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_putawaybincapacity_key_idx ON dwh.f_putawaybincapacity USING btree (pway_pln_dtl_key, pway_bin_cap_loc_key, pway_bin_cap_itm_hdr_key);

CREATE INDEX f_putawaybincapacity_key_idx1 ON dwh.f_putawaybincapacity USING btree (pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno);