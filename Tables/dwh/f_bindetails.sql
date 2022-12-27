CREATE TABLE dwh.f_bindetails (
    bin_dtl_key bigint NOT NULL,
    bin_loc_key bigint NOT NULL,
    bin_zone_key bigint NOT NULL,
    bin_ou integer,
    bin_code character varying(20) COLLATE public.nocase,
    bin_desc character varying(510) COLLATE public.nocase,
    bin_loc_code character varying(20) COLLATE public.nocase,
    bin_zone character varying(20) COLLATE public.nocase,
    bin_type character varying(510) COLLATE public.nocase,
    bin_cap_indicator numeric(20,2),
    bin_aisle character varying(20) COLLATE public.nocase,
    bin_level character varying(20) COLLATE public.nocase,
    bin_seq_no numeric(20,2),
    bin_blocked character varying(16) COLLATE public.nocase,
    bin_reason_code character varying(20) COLLATE public.nocase,
    bin_timestamp integer,
    bin_created_by character varying(60) COLLATE public.nocase,
    bin_created_dt timestamp without time zone,
    bin_modified_by character varying(60) COLLATE public.nocase,
    bin_modified_dt timestamp without time zone,
    bin_status character varying(510) COLLATE public.nocase,
    bin_stock_exist character varying(16) COLLATE public.nocase,
    bin_one_bin_one_pal integer,
    bin_permitted_uids numeric(20,2),
    bin_blocking_reason_ml character varying(80) COLLATE public.nocase,
    bin_blocked_pick_ml character varying(510) COLLATE public.nocase,
    bin_blocked_pawy_ml character varying(510) COLLATE public.nocase,
    bin_blocked_sa_ml character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    bin_typ_key bigint
);

ALTER TABLE dwh.f_bindetails ALTER COLUMN bin_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_bindetails_bin_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_bindetails
    ADD CONSTRAINT f_bindetails_pkey PRIMARY KEY (bin_dtl_key);

ALTER TABLE ONLY dwh.f_bindetails
    ADD CONSTRAINT f_bindetails_ukey UNIQUE (bin_ou, bin_code, bin_loc_code, bin_zone, bin_type);

ALTER TABLE ONLY dwh.f_bindetails
    ADD CONSTRAINT f_bindetails_bin_loc_key_fkey FOREIGN KEY (bin_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_bindetails
    ADD CONSTRAINT f_bindetails_bin_zone_key_fkey FOREIGN KEY (bin_zone_key) REFERENCES dwh.d_zone(zone_key);

CREATE INDEX f_bindetails_key_idx ON dwh.f_bindetails USING btree (bin_loc_key, bin_zone_key);

CREATE INDEX f_bindetails_key_idx1 ON dwh.f_bindetails USING btree (bin_ou, bin_code, bin_loc_code, bin_zone, bin_type);

CREATE INDEX f_bindetails_key_idx2 ON dwh.f_bindetails USING btree (bin_typ_key);