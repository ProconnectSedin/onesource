CREATE TABLE dwh.f_tariffrevcostdetail (
    tarcd_dtl_key bigint NOT NULL,
    tarcd_trip_hdr_key bigint NOT NULL,
    tarcd_ouinstance integer,
    tarcd_trip_plan_id character varying(80) COLLATE public.nocase,
    tarcd_booking_request character varying(80) COLLATE public.nocase,
    tarcd_unique_id character varying(300) COLLATE public.nocase,
    tarcd_leg_id character varying(80) COLLATE public.nocase,
    tarcd_buy_sell_type character varying(80) COLLATE public.nocase,
    tarcd_stage_of_derivation character varying(80) COLLATE public.nocase,
    tarcd_date_of_stage timestamp without time zone,
    tarcd_contract_id character varying(80) COLLATE public.nocase,
    tarcd_tariff_id character varying(80) COLLATE public.nocase,
    tarcd_tariff_type character varying(80) COLLATE public.nocase,
    tarcd_rate numeric(13,2),
    tarcd_remarks character varying(510) COLLATE public.nocase,
    tarcd_trip_rev_cost_sk character varying(300) COLLATE public.nocase,
    tarcd_trip_plan_hdr_sk character varying(300) COLLATE public.nocase,
    tarcd_created_by character varying(80) COLLATE public.nocase,
    tarcd_created_date character varying(80) COLLATE public.nocase,
    tarcd_resource_type character varying(80) COLLATE public.nocase,
    tarcd_weight numeric(13,2),
    tarcd_weight_uom character varying(20) COLLATE public.nocase,
    tarcd_pallet numeric(13,2),
    tarcd_vendor_flag character varying(10) COLLATE public.nocase,
    tarcd_resource_id character varying(80) COLLATE public.nocase,
    tarcd_amendment_no integer,
    tarcd_agreed_rate numeric(13,2),
    tarcd_agreed_cost numeric(13,2),
    tarcd_charagable_quantity numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_tariffrevcostdetail ALTER COLUMN tarcd_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_tariffrevcostdetail_tarcd_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_tariffrevcostdetail
    ADD CONSTRAINT f_tariffrevcostdetail_pkey PRIMARY KEY (tarcd_dtl_key);

ALTER TABLE ONLY dwh.f_tariffrevcostdetail
    ADD CONSTRAINT f_tariffrevcostdetail_ukey UNIQUE (tarcd_ouinstance, tarcd_trip_plan_id, tarcd_booking_request, tarcd_unique_id, tarcd_stage_of_derivation, tarcd_buy_sell_type);

CREATE INDEX f_tariffrevcostdetail_key_idx ON dwh.f_tariffrevcostdetail USING btree (tarcd_ouinstance, tarcd_trip_plan_id, tarcd_booking_request, tarcd_unique_id, tarcd_stage_of_derivation, tarcd_buy_sell_type);

CREATE INDEX f_tariffrevcostdetail_key_idx1 ON dwh.f_tariffrevcostdetail USING btree (tarcd_trip_hdr_key);