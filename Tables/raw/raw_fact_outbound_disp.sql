CREATE TABLE raw.raw_fact_outbound_disp (
    raw_id bigint NOT NULL,
    surrogatekey character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    refkey character varying(400) NOT NULL COLLATE public.nocase,
    disp_ou integer NOT NULL,
    disp_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    dispatch_ld_sheet_no character varying(72) COLLATE public.nocase,
    dispatch_ld_sheet_date timestamp without time zone,
    dispatch_ld_sheet_status character varying(32) COLLATE public.nocase,
    dispatch_lineno integer,
    dispatch_thu_id character varying(160) COLLATE public.nocase,
    dispatch_ship_point character varying(72) COLLATE public.nocase,
    dispatch_ship_mode character varying(160) COLLATE public.nocase,
    dispatch_pack_exec_no character varying(72) COLLATE public.nocase,
    dispatch_customer character varying(72) COLLATE public.nocase,
    dispatch_thu_desc character varying(1020) COLLATE public.nocase,
    dispatch_thu_class character varying(160) COLLATE public.nocase,
    dispatch_thu_sr_no character varying(112) COLLATE public.nocase,
    dispatch_exec_stage character varying(100) COLLATE public.nocase,
    dispatch_thu_weight numeric,
    dispatch_thu_wt_uom character varying(40) COLLATE public.nocase,
    dispatch_reasoncode_ml character varying(160) COLLATE public.nocase,
    dispatch_staging_id character varying(72) COLLATE public.nocase,
    dispatch_lsp character varying(64) COLLATE public.nocase,
    dispatch_created_by character varying(120) COLLATE public.nocase,
    dispatch_created_date timestamp without time zone,
    dispatch_userdefined1 character varying(1020) COLLATE public.nocase,
    dispatch_userdefined2 character varying(1020) COLLATE public.nocase,
    dispatch_userdefined3 character varying(1020) COLLATE public.nocase,
    dispatch_booking_req_no character varying(72) COLLATE public.nocase,
    dispatch_doc_code character varying(72) COLLATE public.nocase,
    dispatch_vehicle_code character varying(72) COLLATE public.nocase,
    dispatch_reason_code character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_outbound_disp ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_outbound_disp_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_outbound_disp
    ADD CONSTRAINT raw_fact_outbound_disp_pkey PRIMARY KEY (raw_id);