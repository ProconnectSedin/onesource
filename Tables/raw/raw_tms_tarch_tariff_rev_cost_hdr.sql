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

ALTER TABLE raw.raw_tms_tarch_tariff_rev_cost_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_tarch_tariff_rev_cost_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_tarch_tariff_rev_cost_hdr
    ADD CONSTRAINT raw_tms_tarch_tariff_rev_cost_hdr_pkey PRIMARY KEY (raw_id);