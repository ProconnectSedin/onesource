CREATE TABLE raw.raw_wms_veh_registration_dtl (
    raw_id bigint NOT NULL,
    wms_veh_ou integer NOT NULL,
    wms_veh_id character varying(120) NOT NULL COLLATE public.nocase,
    wms_veh_line_no integer NOT NULL,
    wms_veh_reg_no character varying(160) COLLATE public.nocase,
    wms_veh_address character varying(1020) COLLATE public.nocase,
    wms_veh_title_holder_name character varying(160) COLLATE public.nocase,
    wms_veh_issuing_auth character varying(160) COLLATE public.nocase,
    wms_veh_issuing_location character varying(40) COLLATE public.nocase,
    wms_veh_issuing_date timestamp without time zone,
    wms_veh_exp_date timestamp without time zone,
    wms_veh_remarks character varying(4000) COLLATE public.nocase,
    wms_veh_doc_type character varying(160) COLLATE public.nocase,
    wms_veh_doc_no character varying(160) COLLATE public.nocase,
    wms_veh_attachment character varying(1020) COLLATE public.nocase,
    wms_veh_attachment_hdn character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_veh_registration_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_veh_registration_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_veh_registration_dtl
    ADD CONSTRAINT raw_wms_veh_registration_dtl_pkey PRIMARY KEY (raw_id);