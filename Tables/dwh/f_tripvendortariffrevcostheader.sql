CREATE TABLE dwh.f_tripvendortariffrevcostheader (
    tvtrch_key bigint NOT NULL,
    tvtrch_trip_plan_hrd_key bigint NOT NULL,
    tvtrch_ouinstance integer,
    tvtrch_trip_plan_id character varying(80) COLLATE public.nocase,
    tvtrch_unique_id character varying(300) COLLATE public.nocase,
    tvtrch_stage_of_derivation character varying(80) COLLATE public.nocase,
    tvtrch_buy_sell_type character varying(80) COLLATE public.nocase,
    tvtrch_rate numeric(13,2),
    tvtrch_trip_plan_hdr_sk character varying(300) COLLATE public.nocase,
    tvtrch_created_by character varying(80) COLLATE public.nocase,
    tvtrch_created_date character varying(80) COLLATE public.nocase,
    tvtrch_modified_by character varying(80) COLLATE public.nocase,
    tvtrch_modified_date timestamp without time zone,
    tvtrch_time_stamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tripvendortariffrevcostheader ALTER COLUMN tvtrch_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripvendortariffrevcostheader_tvtrch_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostheader
    ADD CONSTRAINT f_tripvendortariffrevcostheader_pkey PRIMARY KEY (tvtrch_key);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostheader
    ADD CONSTRAINT f_tripvendortariffrevcostheader_ukey UNIQUE (tvtrch_ouinstance, tvtrch_trip_plan_id, tvtrch_unique_id, tvtrch_stage_of_derivation);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostheader
    ADD CONSTRAINT f_tripvendortariffrevcostheader_tvtrch_trip_plan_hrd_key_fkey FOREIGN KEY (tvtrch_trip_plan_hrd_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

CREATE INDEX f_tripvendortariffrevcostheader_key_idx ON dwh.f_tripvendortariffrevcostheader USING btree (tvtrch_ouinstance, tvtrch_trip_plan_id, tvtrch_unique_id, tvtrch_stage_of_derivation);