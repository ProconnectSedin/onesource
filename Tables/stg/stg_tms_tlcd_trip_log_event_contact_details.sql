CREATE TABLE stg.stg_tms_tlcd_trip_log_event_contact_details (
    tlecd_ouinstance integer NOT NULL,
    tlecd_trip_plan character varying(72) NOT NULL COLLATE public.nocase,
    tlecd_trip_leg_seq_id integer,
    tlecd_event_id character varying(160) COLLATE public.nocase,
    tlecd_br_id character varying(160) COLLATE public.nocase,
    tlecd_con_guid character varying(512) NOT NULL COLLATE public.nocase,
    tlecd_contact_person character varying(180) COLLATE public.nocase,
    tlecd_contact_number character varying(80) COLLATE public.nocase,
    tlecd_email_id character varying(240) COLLATE public.nocase,
    tlecd_remarks character varying(1020) COLLATE public.nocase,
    tlecd_created_by character varying(120) COLLATE public.nocase,
    tlecd_created_date character varying(100) COLLATE public.nocase,
    tlecd_modified_by character varying(120) COLLATE public.nocase,
    tlecd_modified_date character varying(100) COLLATE public.nocase,
    tled_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_tlcd_trip_log_event_contact_details
    ADD CONSTRAINT pk_tms_tlcd_trip_log_event_contact_details PRIMARY KEY (tlecd_ouinstance, tlecd_con_guid);