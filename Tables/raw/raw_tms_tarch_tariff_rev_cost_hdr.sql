CREATE TABLE raw.raw_tms_tarch_tariff_rev_cost_hdr (
    raw_id bigint NOT NULL,
    tarch_ouinstance integer NOT NULL,
    tarch_trip_plan_id character varying(160) NOT NULL COLLATE public.nocase,
    tarch_unique_id character varying(512) NOT NULL COLLATE public.nocase,
    tarch_stage_of_derivation character varying(160) COLLATE public.nocase,
    tarch_buy_sell_type character varying(160) COLLATE public.nocase,
    tarch_rate numeric,
    tarch_trip_plan_hdr_sk character varying(512) COLLATE public.nocase,
    tarch_created_by character varying(160) COLLATE public.nocase,
    tarch_created_date character varying(160) COLLATE public.nocase,
    tarch_modified_by character varying(160) COLLATE public.nocase,
    tarch_modified_date timestamp without time zone,
    tarch_time_stamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);