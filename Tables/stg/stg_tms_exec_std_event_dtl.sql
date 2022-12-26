CREATE TABLE stg.stg_tms_exec_std_event_dtl (
    tesed_ouinstance integer NOT NULL,
    tesed_behaviour character varying(160) NOT NULL COLLATE public.nocase,
    tesed_event_id character varying(160) COLLATE public.nocase,
    tesed_event_desc character varying(1020) COLLATE public.nocase,
    tesed_event_status character varying(160) COLLATE public.nocase,
    tesed_seq integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);