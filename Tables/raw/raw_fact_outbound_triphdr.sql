CREATE TABLE raw.raw_fact_outbound_triphdr (
    raw_id bigint NOT NULL,
    surrogatekey character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    refkey character varying(400) NOT NULL COLLATE public.nocase,
    trip_ou integer NOT NULL,
    trip_loc_code character varying(200) COLLATE public.nocase,
    trip_plan_id character varying(400) COLLATE public.nocase,
    trip_plan_planning_profile_id character varying(400) COLLATE public.nocase,
    trip_plan_status character varying(200) COLLATE public.nocase,
    trip_plan_date timestamp without time zone,
    trip_plan_end_date timestamp without time zone,
    trip_plan_from character varying(200) COLLATE public.nocase,
    trip_plan_to character varying(200) COLLATE public.nocase,
    vehicle_profile character varying(400) COLLATE public.nocase,
    vehicle_type character varying(400) COLLATE public.nocase,
    vehicle_id character varying(400) COLLATE public.nocase,
    vehicle_resource character varying(400) COLLATE public.nocase,
    agent_profile character varying(400) COLLATE public.nocase,
    agent_service character varying(400) COLLATE public.nocase,
    agent_id character varying(200) COLLATE public.nocase,
    agent_resource character varying(200) COLLATE public.nocase,
    created_by character varying(600) COLLATE public.nocase,
    created_date timestamp without time zone,
    last_modified_by character varying(600) COLLATE public.nocase,
    last_modified_date timestamp without time zone,
    agent_status character varying(600) COLLATE public.nocase,
    booking_request character varying(400) COLLATE public.nocase,
    trip_plan_from_type character varying(400) COLLATE public.nocase,
    trip_plan_to_type character varying(400) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_outbound_triphdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_outbound_triphdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_outbound_triphdr
    ADD CONSTRAINT raw_fact_outbound_triphdr_pkey PRIMARY KEY (raw_id);