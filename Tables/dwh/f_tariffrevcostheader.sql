CREATE TABLE dwh.f_tariffrevcostheader (
    tarch_hdr_key bigint NOT NULL,
    tarch_trip_hdr_key bigint NOT NULL,
    tarch_ouinstance integer,
    tarch_trip_plan_id character varying(80) COLLATE public.nocase,
    tarch_unique_id character varying(300) COLLATE public.nocase,
    tarch_stage_of_derivation character varying(80) COLLATE public.nocase,
    tarch_buy_sell_type character varying(80) COLLATE public.nocase,
    tarch_rate numeric(13,0),
    tarch_trip_plan_hdr_sk character varying(300) COLLATE public.nocase,
    tarch_created_by character varying(80) COLLATE public.nocase,
    tarch_created_date character varying(80) COLLATE public.nocase,
    tarch_modified_by character varying(80) COLLATE public.nocase,
    tarch_modified_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tariffrevcostheader ALTER COLUMN tarch_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tariffrevcostheader_tarch_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tariffrevcostheader
    ADD CONSTRAINT f_tariffrevcostheader_pkey PRIMARY KEY (tarch_hdr_key);

ALTER TABLE ONLY dwh.f_tariffrevcostheader
    ADD CONSTRAINT f_tariffrevcostheader_ukey UNIQUE (tarch_ouinstance, tarch_trip_plan_id, tarch_unique_id, tarch_buy_sell_type, tarch_stage_of_derivation);

CREATE INDEX f_tariffrevcostheader_key_idx ON dwh.f_tariffrevcostheader USING btree (tarch_ouinstance, tarch_trip_plan_id, tarch_unique_id, tarch_buy_sell_type, tarch_stage_of_derivation);

CREATE INDEX f_tariffrevcostheader_key_idx1 ON dwh.f_tariffrevcostheader USING btree (tarch_trip_hdr_key);