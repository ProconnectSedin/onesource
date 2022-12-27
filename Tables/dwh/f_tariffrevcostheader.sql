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