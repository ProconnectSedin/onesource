CREATE TABLE stg.stg_tms_evcld_event_configuration_loc_div_dtl (
    evcld_ouinstance integer NOT NULL,
    evcld_event_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    evcld_guid character varying(512) NOT NULL COLLATE public.nocase,
    evcld_division character varying(160) COLLATE public.nocase,
    evcld_location character varying(160) COLLATE public.nocase,
    evcld_status character varying(160) COLLATE public.nocase,
    evcld_created_by character varying(120) COLLATE public.nocase,
    evcld_created_date timestamp without time zone,
    evcld_last_modified_by character varying(120) COLLATE public.nocase,
    evcld_last_modified_date timestamp without time zone,
    evcld_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_evcld_event_configuration_loc_div_dtl
    ADD CONSTRAINT pk_tms_evcld_event_configuration_loc_div_dtl PRIMARY KEY (evcld_ouinstance, evcld_guid);