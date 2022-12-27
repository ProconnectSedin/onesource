CREATE TABLE dwh.f_tripvendortariffrevcostdetail (
    tvtrcd_dtl_key bigint NOT NULL,
    tvtrcd_hdr_key bigint NOT NULL,
    tvtrcd_ouinstance integer,
    tvtrcd_trip_plan_id character varying(80) COLLATE public.nocase,
    tvtrcd_booking_request character varying(80) COLLATE public.nocase,
    tvtrcd_unique_id character varying(300) COLLATE public.nocase,
    tvtrcd_leg_id character varying(80) COLLATE public.nocase,
    tvtrcd_buy_sell_type character varying(80) COLLATE public.nocase,
    tvtrcd_stage_of_derivation character varying(80) COLLATE public.nocase,
    tvtrcd_date_of_stage timestamp without time zone,
    tvtrcd_contract_id character varying(80) COLLATE public.nocase,
    tvtrcd_tariff_id character varying(80) COLLATE public.nocase,
    tvtrcd_tariff_type character varying(80) COLLATE public.nocase,
    tvtrcd_rate numeric(13,2),
    tvtrcd_remarks character varying(510) COLLATE public.nocase,
    tvtrcd_trip_rev_cost_sk character varying(300) COLLATE public.nocase,
    tvtrcd_trip_plan_hdr_sk character varying(300) COLLATE public.nocase,
    tvtrcd_created_by character varying(80) COLLATE public.nocase,
    tvtrcd_created_date character varying(80) COLLATE public.nocase,
    tvtrcd_modified_by character varying(80) COLLATE public.nocase,
    tvtrcd_modified_date timestamp without time zone,
    tvtrcd_time_stamp integer,
    tvtrcd_resource_type character varying(80) COLLATE public.nocase,
    tvtrcd_weight numeric(13,2),
    tvtrcd_weight_uom character varying(20) COLLATE public.nocase,
    tvtrcd_pallet numeric(13,2),
    tvtrcd_chk_flag character varying(10) COLLATE public.nocase,
    tvtrcd_vendor_flag character varying(10) COLLATE public.nocase,
    tvtrcd_tariff_remarks character varying(8000) COLLATE public.nocase,
    tvtrcd_resource_id character varying(80) COLLATE public.nocase,
    tvtrcd_amendment_no integer,
    tvtrcd_fl_tariff_id character varying(80) COLLATE public.nocase,
    tvtrcd_agreed_rate numeric(13,2),
    tvtrcd_agreed_cost numeric(13,2),
    tvtrcd_charagable_quantity numeric(13,2),
    tvtrcd_exchange_rate numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tripvendortariffrevcostdetail ALTER COLUMN tvtrcd_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tripvendortariffrevcostdetail_tvtrcd_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostdetail
    ADD CONSTRAINT f_tripvendortariffrevcostdetail_pkey PRIMARY KEY (tvtrcd_dtl_key);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostdetail
    ADD CONSTRAINT f_tripvendortariffrevcostdetail_ukey UNIQUE (tvtrcd_ouinstance, tvtrcd_trip_plan_id, tvtrcd_booking_request, tvtrcd_unique_id);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostdetail
    ADD CONSTRAINT f_tripvendortariffrevcostdetail_tvtrcd_hdr_key_fkey FOREIGN KEY (tvtrcd_hdr_key) REFERENCES dwh.f_tripvendortariffrevcostheader(tvtrch_key);

CREATE INDEX f_tripvendortariffrevcostdetail_key_idx ON dwh.f_tripvendortariffrevcostdetail USING btree (tvtrcd_ouinstance, tvtrcd_trip_plan_id, tvtrcd_booking_request, tvtrcd_unique_id);

CREATE INDEX f_tripvendortariffrevcostdetail_key_idx1 ON dwh.f_tripvendortariffrevcostdetail USING btree (tvtrcd_hdr_key);