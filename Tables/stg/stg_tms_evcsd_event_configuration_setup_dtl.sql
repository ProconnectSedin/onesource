CREATE TABLE stg.stg_tms_evcsd_event_configuration_setup_dtl (
    evcsd_ouinstance integer NOT NULL,
    evcsd_event_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    evcsd_guid character varying(512) NOT NULL COLLATE public.nocase,
    evcsd_seq_num integer,
    evcsd_event_id character varying(160) COLLATE public.nocase,
    evcsd_event_description character varying(160) COLLATE public.nocase,
    evcsd_event_type character varying(160) COLLATE public.nocase,
    evcsd_remarks character varying(160) COLLATE public.nocase,
    evcsd_for_execution character(4) COLLATE public.nocase,
    evcsd_track_n_trace character(4) COLLATE public.nocase,
    evcsd_created_by character varying(120) COLLATE public.nocase,
    evcsd_created_date timestamp without time zone,
    evcsd_last_modified_by character varying(120) COLLATE public.nocase,
    evcsd_last_modified_date timestamp without time zone,
    evcsd_timestamp integer,
    evcsd_linked_vas character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_evcsd_event_configuration_setup_dtl
    ADD CONSTRAINT pk_tms_evcsd_event_configuration_setup_dtl PRIMARY KEY (evcsd_ouinstance, evcsd_guid);