CREATE TABLE raw.raw_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl (
    raw_id bigint NOT NULL,
    tvtrcd_ouinstance integer NOT NULL,
    tvtrcd_trip_plan_id character varying(160) NOT NULL COLLATE public.nocase,
    tvtrcd_booking_request character varying(160) NOT NULL COLLATE public.nocase,
    tvtrcd_unique_id character varying(512) NOT NULL COLLATE public.nocase,
    tvtrcd_leg_id character varying(160) COLLATE public.nocase,
    tvtrcd_buy_sell_type character varying(160) COLLATE public.nocase,
    tvtrcd_stage_of_derivation character varying(160) COLLATE public.nocase,
    tvtrcd_date_of_stage timestamp without time zone,
    tvtrcd_contract_id character varying(160) COLLATE public.nocase,
    tvtrcd_tariff_id character varying(160) COLLATE public.nocase,
    tvtrcd_tariff_type character varying(160) COLLATE public.nocase,
    tvtrcd_rate numeric,
    tvtrcd_remarks character varying(1020) COLLATE public.nocase,
    tvtrcd_trip_rev_cost_sk character varying(512) COLLATE public.nocase,
    tvtrcd_trip_plan_hdr_sk character varying(512) COLLATE public.nocase,
    tvtrcd_created_by character varying(160) COLLATE public.nocase,
    tvtrcd_created_date character varying(160) COLLATE public.nocase,
    tvtrcd_modified_by character varying(160) COLLATE public.nocase,
    tvtrcd_modified_date timestamp without time zone,
    tvtrcd_time_stamp integer,
    tvtrcd_resource_type character varying(160) COLLATE public.nocase,
    tvtrcd_weight numeric,
    tvtrcd_weight_uom character varying(40) COLLATE public.nocase,
    tvtrcd_pallet numeric,
    tvtrcd_chk_flag character(4) COLLATE public.nocase,
    tvtrcd_vendor_flag character(4) COLLATE public.nocase,
    tvtrcd_tariff_remarks character varying(16000) COLLATE public.nocase,
    tvtrcd_resource_id character varying(160) COLLATE public.nocase,
    tvtrcd_amendment_no integer,
    tvtrcd_fl_tariff_id character varying(160) COLLATE public.nocase,
    tvtrcd_agreed_rate numeric,
    tvtrcd_agreed_cost numeric,
    tvtrcd_charagable_quantity numeric,
    tvtrcd_exchange_rate numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl
    ADD CONSTRAINT raw_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl_pkey PRIMARY KEY (raw_id);