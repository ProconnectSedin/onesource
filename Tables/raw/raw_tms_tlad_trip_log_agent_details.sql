CREATE TABLE raw.raw_tms_tlad_trip_log_agent_details (
    raw_id bigint NOT NULL,
    tlad_ouinstance integer NOT NULL,
    tlad_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    tlad_dispatch_doc_no character varying(72) NOT NULL COLLATE public.nocase,
    tlad_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    tlad_thu_agent_qty numeric,
    tlad_thu_agent_weight numeric,
    tlad_thu_agent_volume numeric,
    tlad_ag_ref_doc_type character varying(160) COLLATE public.nocase,
    tlad_ag_ref_doc_no character varying(72) COLLATE public.nocase,
    tlad_ag_ref_doc_date timestamp without time zone,
    tlad_agent_remarks character varying(1020) COLLATE public.nocase,
    tlad_thu_agent_qty_uom character varying(160) COLLATE public.nocase,
    tlad_thu_agent_weight_uom character varying(160) COLLATE public.nocase,
    tlad_thu_agent_volume_uom character varying(160) COLLATE public.nocase,
    tlad_timestamp integer,
    tlad_created_by character varying(120) COLLATE public.nocase,
    tlad_creation_date timestamp without time zone,
    tlad_last_modified_by character varying(120) COLLATE public.nocase,
    tlad_last_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_tlad_trip_log_agent_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_tlad_trip_log_agent_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_tlad_trip_log_agent_details
    ADD CONSTRAINT raw_tms_tlad_trip_log_agent_details_pkey PRIMARY KEY (raw_id);