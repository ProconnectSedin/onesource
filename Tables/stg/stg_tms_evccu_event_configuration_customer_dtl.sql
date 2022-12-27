CREATE TABLE stg.stg_tms_evccu_event_configuration_customer_dtl (
    evccu_ouinstance integer NOT NULL,
    evccu_event_profile_id character varying(160) NOT NULL COLLATE public.nocase,
    evccu_guid character varying(512) NOT NULL COLLATE public.nocase,
    evccu_customer_id character varying(160) COLLATE public.nocase,
    evccu_status character varying(160) COLLATE public.nocase,
    evccu_created_by character varying(120) COLLATE public.nocase,
    evccu_created_date timestamp without time zone,
    evccu_last_modified_by character varying(120) COLLATE public.nocase,
    evccu_last_modified_date timestamp without time zone,
    evccu_timestamp integer,
    evccu_vendor_id character varying(160) COLLATE public.nocase,
    evccu_leg_behaviour character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_evccu_event_configuration_customer_dtl
    ADD CONSTRAINT pk_tms_evccu_event_configuration_customer_dtl PRIMARY KEY (evccu_ouinstance, evccu_guid);