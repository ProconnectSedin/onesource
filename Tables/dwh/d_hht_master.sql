CREATE TABLE dwh.d_hht_master (
    d_hht_master_key bigint NOT NULL,
    hht_loc_key bigint NOT NULL,
    id integer,
    locationcode character varying(30) COLLATE public.nocase,
    locationdesc character varying(50) COLLATE public.nocase,
    brand character varying(50) COLLATE public.nocase,
    count integer,
    oldcount040220 integer,
    oldcount300920 integer,
    oldcount030321 integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_hht_master ALTER COLUMN d_hht_master_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_hht_master_d_hht_master_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_hht_master
    ADD CONSTRAINT d_hht_master_pkey PRIMARY KEY (d_hht_master_key);

ALTER TABLE ONLY dwh.d_hht_master
    ADD CONSTRAINT d_hht_master_hht_loc_key_fkey FOREIGN KEY (hht_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX d_hht_master_key_idx ON dwh.d_hht_master USING btree (hht_loc_key);