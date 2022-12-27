CREATE TABLE dwh.f_putawayempequipmap (
    pway_eqp_map_key bigint NOT NULL,
    pway_eqp_map_loc_key bigint NOT NULL,
    pway_eqp_map_eqp_key bigint NOT NULL,
    pway_eqp_map_zone_key bigint NOT NULL,
    pway_eqp_map_emp_hdr_key bigint NOT NULL,
    putaway_loc_code character varying(20) COLLATE public.nocase,
    putaway_ou integer,
    putaway_lineno integer,
    putaway_shift_code character varying(20) COLLATE public.nocase,
    putaway_emp_code character varying(40) COLLATE public.nocase,
    putaway_euip_code character varying(60) COLLATE public.nocase,
    putaway_area character varying(20) COLLATE public.nocase,
    putaway_zone character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_putawayempequipmap ALTER COLUMN pway_eqp_map_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_putawayempequipmap_pway_eqp_map_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pkey PRIMARY KEY (pway_eqp_map_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_ukey UNIQUE (putaway_loc_code, putaway_ou, putaway_lineno);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pway_eqp_map_emp_hdr_key_fkey FOREIGN KEY (pway_eqp_map_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pway_eqp_map_eqp_key_fkey FOREIGN KEY (pway_eqp_map_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pway_eqp_map_loc_key_fkey FOREIGN KEY (pway_eqp_map_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pway_eqp_map_zone_key_fkey FOREIGN KEY (pway_eqp_map_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_putawayempequipmap_key_idx ON dwh.f_putawayempequipmap USING btree (pway_eqp_map_eqp_key, pway_eqp_map_emp_hdr_key, pway_eqp_map_loc_key, pway_eqp_map_zone_key);

CREATE INDEX f_putawayempequipmap_key_idx1 ON dwh.f_putawayempequipmap USING btree (putaway_loc_code, putaway_ou, putaway_lineno);