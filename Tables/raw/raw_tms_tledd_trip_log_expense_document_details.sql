CREATE TABLE raw.raw_tms_tledd_trip_log_expense_document_details (
    raw_id bigint NOT NULL,
    tledd_ouinstance integer NOT NULL,
    tledd_trip_plan character varying(72) COLLATE public.nocase,
    tledd_trip_leg_seq_id integer,
    tledd_rec_exp character varying(160) COLLATE public.nocase,
    tledd_exp_type character varying(160) COLLATE public.nocase,
    tledd_bill_no character varying(160) COLLATE public.nocase,
    tledd_doc_guid character varying(512) NOT NULL COLLATE public.nocase,
    tledd_document_id character varying(160) COLLATE public.nocase,
    tledd_document_date character varying(100) COLLATE public.nocase,
    tledd_remarks character varying(1020) COLLATE public.nocase,
    tledd_created_by character varying(120) COLLATE public.nocase,
    tledd_created_date character varying(100) COLLATE public.nocase,
    tledd_modified_by character varying(120) COLLATE public.nocase,
    tledd_modified_date character varying(100) COLLATE public.nocase,
    tled_timestamp integer,
    tledd_attachment character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_tledd_trip_log_expense_document_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_tledd_trip_log_expense_document_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_tledd_trip_log_expense_document_details
    ADD CONSTRAINT raw_tms_tledd_trip_log_expense_document_details_pkey PRIMARY KEY (raw_id);