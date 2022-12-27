CREATE TABLE stg.stg_tms_plph_planning_hdr (
    plph_ouinstance integer NOT NULL,
    plph_plan_run_no character varying(72) NOT NULL COLLATE public.nocase,
    plph_status character varying(160) COLLATE public.nocase,
    plph_description character varying(2000) COLLATE public.nocase,
    plph_planning_profile_no character varying(160) COLLATE public.nocase,
    plph_plan_location_no character varying(160) COLLATE public.nocase,
    plph_from_location character varying(160) COLLATE public.nocase,
    plph_to_location character varying(160) COLLATE public.nocase,
    plph_created_by character varying(120) COLLATE public.nocase,
    plph_created_date timestamp without time zone,
    plph_last_modified_by character varying(120) COLLATE public.nocase,
    plph_last_modified_date timestamp without time zone,
    plph_timestamp integer,
    plph_plan_mode character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_plph_planning_hdr
    ADD CONSTRAINT pk_tms_plph_planning_hdr PRIMARY KEY (plph_ouinstance, plph_plan_run_no);

CREATE INDEX stg_tms_plph_planning_hdr_key_idx2 ON stg.stg_tms_plph_planning_hdr USING btree (plph_ouinstance, plph_plan_run_no);