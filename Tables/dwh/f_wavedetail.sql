CREATE TABLE dwh.f_wavedetail (
    wave_dtl_key bigint NOT NULL,
    wave_loc_key bigint NOT NULL,
    wave_item_key bigint NOT NULL,
    wave_cust_key bigint NOT NULL,
    wave_hdr_key bigint NOT NULL,
    wave_loc_code character varying(20) COLLATE public.nocase,
    wave_no character varying(40) COLLATE public.nocase,
    wave_ou integer,
    wave_lineno integer,
    wave_so_no character varying(40) COLLATE public.nocase,
    wave_so_sr_no integer,
    wave_so_sch_no integer,
    wave_item_code character varying(80) COLLATE public.nocase,
    wave_qty numeric(13,2),
    wave_line_status character varying(20) COLLATE public.nocase,
    wave_outbound_no character varying(40) COLLATE public.nocase,
    wave_customer_code character varying(40) COLLATE public.nocase,
    wave_customer_item_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_wavedetail ALTER COLUMN wave_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_wavedetail_wave_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_pkey PRIMARY KEY (wave_dtl_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_ukey UNIQUE (wave_lineno, wave_no, wave_ou, wave_loc_code);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_wave_cust_key_fkey FOREIGN KEY (wave_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_wave_hdr_key_fkey FOREIGN KEY (wave_hdr_key) REFERENCES dwh.f_waveheader(wave_hdr_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_wave_item_key_fkey FOREIGN KEY (wave_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_wave_loc_key_fkey FOREIGN KEY (wave_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_wavedetail_key_idx ON dwh.f_wavedetail USING btree (wave_loc_key, wave_item_key, wave_cust_key, wave_hdr_key);

CREATE INDEX f_wavedetail_key_idx1 ON dwh.f_wavedetail USING btree (wave_lineno, wave_no, wave_loc_code, wave_ou);

CREATE INDEX f_wavedetail_key_idx2 ON dwh.f_wavedetail USING btree (wave_ou, wave_loc_key, wave_cust_key, wave_item_key, wave_so_no);

CREATE INDEX f_wavedetail_key_idx3 ON dwh.f_wavedetail USING btree (wave_loc_key, wave_cust_key, wave_so_no);

CREATE INDEX f_wavedetail_key_idx4 ON dwh.f_wavedetail USING btree (wave_loc_key, wave_so_no);

CREATE INDEX f_wavedetail_key_idx5 ON dwh.f_wavedetail USING btree (wave_so_no, wave_ou);