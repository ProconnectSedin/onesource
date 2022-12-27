CREATE TABLE stg.stg_tms_resource_schedule_dtl (
    trsd_ouinstance integer NOT NULL,
    trsd_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    trsd_trip_beh character varying(160) COLLATE public.nocase,
    trsd_sch_status character varying(160) COLLATE public.nocase,
    trsd_resource_type character varying(160) COLLATE public.nocase,
    trsd_resource_id character varying(160) COLLATE public.nocase,
    trsd_sch_date_from timestamp without time zone,
    trsd_sch_date_to character varying(100) COLLATE public.nocase,
    trsd_sch_loc_from character varying(160) COLLATE public.nocase,
    trsd_sch_loc_to character varying(160) COLLATE public.nocase,
    trsd_created_by character varying(120) COLLATE public.nocase,
    trsd_created_date character varying(100) COLLATE public.nocase,
    trsd_modified_by character varying(120) COLLATE public.nocase,
    trsd_modified_date character varying(100) COLLATE public.nocase,
    trsd_act_date_from character varying(100) COLLATE public.nocase,
    trsd_act_date_to character varying(100) COLLATE public.nocase,
    trsd_ser_type character varying(1020) COLLATE public.nocase,
    trsd_sub_ser_type character varying(1020) COLLATE public.nocase,
    trsd_timestamp integer,
    trsd_vendor_id character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

CREATE INDEX stg_tms_resource_schedule_dtl_idx1 ON stg.stg_tms_resource_schedule_dtl USING btree (trsd_ouinstance, trsd_trip_plan_id, trsd_resource_type, trsd_resource_id);

CREATE INDEX stg_tms_resource_schedule_dtl_idx2 ON stg.stg_tms_resource_schedule_dtl USING btree (trsd_ouinstance, trsd_trip_plan_id);