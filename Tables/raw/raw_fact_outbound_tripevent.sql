CREATE TABLE raw.raw_fact_outbound_tripevent (
    raw_id bigint NOT NULL,
    surrogatekey character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    refkey character varying(400) NOT NULL COLLATE public.nocase,
    event_ou integer NOT NULL,
    event_location character varying(200) COLLATE public.nocase,
    trip_plan_id character varying(200) COLLATE public.nocase,
    trip_plan_line_no character varying(1000) COLLATE public.nocase,
    bkr_id character varying(200) COLLATE public.nocase,
    leg_behaviour character varying(200) COLLATE public.nocase,
    leg_no character varying(600) COLLATE public.nocase,
    event_id character varying(200) COLLATE public.nocase,
    actual_date_time timestamp without time zone,
    remarks1 character varying(1600) COLLATE public.nocase,
    reason_code character varying(1600) COLLATE public.nocase,
    reason_description character varying(1600) COLLATE public.nocase,
    remarks2 character varying(1600) COLLATE public.nocase,
    created_date timestamp without time zone,
    created_by character varying(600) COLLATE public.nocase,
    modified_date timestamp without time zone,
    modified_by character varying(200) COLLATE public.nocase,
    planned_datetime timestamp without time zone,
    trip_plan_unique_id character varying(600) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);