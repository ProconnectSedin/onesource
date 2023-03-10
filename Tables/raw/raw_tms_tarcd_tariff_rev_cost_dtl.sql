CREATE TABLE raw.raw_tms_tarcd_tariff_rev_cost_dtl (
    raw_id bigint NOT NULL,
    tarcd_ouinstance integer NOT NULL,
    tarcd_trip_plan_id character varying(160) NOT NULL COLLATE public.nocase,
    tarcd_booking_request character varying(160) NOT NULL COLLATE public.nocase,
    tarcd_unique_id character varying(512) NOT NULL COLLATE public.nocase,
    tarcd_leg_id character varying(160) COLLATE public.nocase,
    tarcd_buy_sell_type character varying(160) COLLATE public.nocase,
    tarcd_stage_of_derivation character varying(160) COLLATE public.nocase,
    tarcd_date_of_stage timestamp without time zone,
    tarcd_contract_id character varying(160) COLLATE public.nocase,
    tarcd_tariff_id character varying(160) COLLATE public.nocase,
    tarcd_tariff_type character varying(160) COLLATE public.nocase,
    tarcd_rate numeric,
    tarcd_remarks character varying(1020) COLLATE public.nocase,
    tarcd_trip_rev_cost_sk character varying(512) COLLATE public.nocase,
    tarcd_trip_plan_hdr_sk character varying(512) COLLATE public.nocase,
    tarcd_created_by character varying(160) COLLATE public.nocase,
    tarcd_created_date character varying(160) COLLATE public.nocase,
    tarcd_modified_by character varying(160) COLLATE public.nocase,
    tarcd_modified_date timestamp without time zone,
    tarcd_time_stamp integer,
    tarcd_resource_type character varying(160) COLLATE public.nocase,
    tarcd_weight numeric,
    tarcd_weight_uom character varying(40) COLLATE public.nocase,
    tarcd_pallet numeric,
    tarcd_vendor_flag character(4) COLLATE public.nocase,
    tarcd_resource_id character varying(160) COLLATE public.nocase,
    tarcd_amendment_no integer,
    vehicle_cost numeric,
    equipment_1_cost numeric,
    equipment_2_cost numeric,
    driver_1_cost numeric,
    driver_2_cost numeric,
    handler_1_cost numeric,
    handler_2_cost numeric,
    tarcd_agreed_rate numeric,
    tarcd_agreed_cost numeric,
    tarcd_charagable_quantity numeric,
    tarcd_exchange_rate numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_tarcd_tariff_rev_cost_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_tarcd_tariff_rev_cost_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_tarcd_tariff_rev_cost_dtl
    ADD CONSTRAINT raw_tms_tarcd_tariff_rev_cost_dtl_pkey PRIMARY KEY (raw_id);