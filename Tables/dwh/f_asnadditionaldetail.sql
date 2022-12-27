CREATE TABLE dwh.f_asnadditionaldetail (
    asn_add_dl_key bigint NOT NULL,
    asn_hr_key bigint NOT NULL,
    asn_pop_loc_key bigint NOT NULL,
    asn_pop_asn_no character varying(40) COLLATE public.nocase,
    asn_pop_loc character varying(20) COLLATE public.nocase,
    asn_pop_ou integer,
    asn_pop_line_no integer,
    asn_pop_date_1 timestamp without time zone,
    asn_pop_date_2 timestamp without time zone,
    asn_pop_ud_1 character varying(510) COLLATE public.nocase,
    asn_pop_ud_2 character varying(510) COLLATE public.nocase,
    asn_pop_ud_3 character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_asnadditionaldetail ALTER COLUMN asn_add_dl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_asnadditionaldetail_asn_add_dl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_asnadditionaldetail
    ADD CONSTRAINT f_asnadditionaldetail_pkey PRIMARY KEY (asn_add_dl_key);

ALTER TABLE ONLY dwh.f_asnadditionaldetail
    ADD CONSTRAINT f_asnadditionaldetail_ukey UNIQUE (asn_pop_asn_no, asn_pop_loc, asn_pop_ou, asn_pop_line_no);

ALTER TABLE ONLY dwh.f_asnadditionaldetail
    ADD CONSTRAINT f_asnadditionaldetail_asn_pop_loc_key_fkey FOREIGN KEY (asn_pop_loc_key) REFERENCES dwh.d_location(loc_key) DEFERRABLE INITIALLY DEFERRED;

CREATE INDEX f_asnadditionaldetail_key_idx ON dwh.f_asnadditionaldetail USING btree (asn_pop_loc_key);

CREATE INDEX f_asnadditionaldetail_key_idx1 ON dwh.f_asnadditionaldetail USING btree (asn_pop_asn_no, asn_pop_loc, asn_pop_ou, asn_pop_line_no);