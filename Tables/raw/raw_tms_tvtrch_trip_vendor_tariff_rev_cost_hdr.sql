CREATE TABLE raw.raw_tms_tvtrch_trip_vendor_tariff_rev_cost_hdr (
    raw_id bigint NOT NULL,
    tvtrch_ouinstance integer NOT NULL,
    tvtrch_trip_plan_id character varying(160) NOT NULL COLLATE public.nocase,
    tvtrch_unique_id character varying(512) NOT NULL COLLATE public.nocase,
    tvtrch_stage_of_derivation character varying(160) NOT NULL COLLATE public.nocase,
    tvtrch_buy_sell_type character varying(160) COLLATE public.nocase,
    tvtrch_rate numeric,
    tvtrch_trip_plan_hdr_sk character varying(512) COLLATE public.nocase,
    tvtrch_created_by character varying(160) COLLATE public.nocase,
    tvtrch_created_date character varying(160) COLLATE public.nocase,
    tvtrch_modified_by character varying(160) COLLATE public.nocase,
    tvtrch_modified_date timestamp without time zone,
    tvtrch_time_stamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);