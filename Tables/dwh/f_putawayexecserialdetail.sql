CREATE TABLE dwh.f_putawayexecserialdetail (
    pway_exec_serial_dtl_key bigint NOT NULL,
    pway_exe_dtl_key bigint NOT NULL,
    pway_exec_serial_dtl_loc_key bigint NOT NULL,
    pway_exec_serial_dtl_zone_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_exec_no character varying(40) COLLATE public.nocase,
    pway_exec_ou integer,
    pway_lineno integer,
    pway_itm_lineno integer,
    pway_zone character varying(20) COLLATE public.nocase,
    pway_bin character varying(20) COLLATE public.nocase,
    pway_serialno character varying(60) COLLATE public.nocase,
    pway_lotno character varying(60) COLLATE public.nocase,
    pway_cust_sno character varying(60) COLLATE public.nocase,
    pway_3pl_sno character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_putawayexecserialdetail ALTER COLUMN pway_exec_serial_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_putawayexecserialdetail_pway_exec_serial_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_pkey PRIMARY KEY (pway_exec_serial_dtl_key);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_ukey UNIQUE (pway_loc_code, pway_exec_no, pway_exec_ou, pway_lineno);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_pway_exe_dtl_key_fkey FOREIGN KEY (pway_exe_dtl_key) REFERENCES dwh.f_putawayexecdetail(pway_exe_dtl_key);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_pway_exec_serial_dtl_loc_key_fkey FOREIGN KEY (pway_exec_serial_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_pway_exec_serial_dtl_zone_key_fkey FOREIGN KEY (pway_exec_serial_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_putawayexecserialdetail_key_idx ON dwh.f_putawayexecserialdetail USING btree (pway_exe_dtl_key, pway_exec_serial_dtl_loc_key, pway_exec_serial_dtl_zone_key);

CREATE INDEX f_putawayexecserialdetail_key_idx1 ON dwh.f_putawayexecserialdetail USING btree (pway_loc_code, pway_exec_no, pway_exec_ou, pway_lineno);