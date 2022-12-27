CREATE TABLE raw.raw_wms_putaway_conditions_dtl (
    raw_id bigint NOT NULL,
    wms_pway_ou integer NOT NULL,
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_line_no integer NOT NULL,
    wms_pway_condition_id character varying(1020) COLLATE public.nocase,
    wms_pway_condi_status character varying(160) COLLATE public.nocase,
    wms_pway_description character varying(1020) COLLATE public.nocase,
    wms_pway_table character varying(160) COLLATE public.nocase,
    wms_pway_field character varying(160) COLLATE public.nocase,
    wms_pway_operator character varying(32) COLLATE public.nocase,
    wms_pway_value character varying(1020) COLLATE public.nocase,
    wms_pway_uom character varying(40) COLLATE public.nocase,
    wms_pway_classification character varying(1020) COLLATE public.nocase,
    wms_pway_destination_typ character varying(32) COLLATE public.nocase,
    wms_pway_destination_id character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_putaway_conditions_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_putaway_conditions_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_putaway_conditions_dtl
    ADD CONSTRAINT raw_wms_putaway_conditions_dtl_pkey PRIMARY KEY (raw_id);