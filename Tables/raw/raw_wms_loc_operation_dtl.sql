CREATE TABLE raw.raw_wms_loc_operation_dtl (
    raw_id bigint NOT NULL,
    wms_loc_opr_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_opr_ou integer NOT NULL,
    wms_loc_opr_shift_code character varying(160) COLLATE public.nocase,
    wms_loc_opr_lineno integer NOT NULL,
    wms_loc_opr_sun_day integer,
    wms_loc_opr_mon_day integer,
    wms_loc_opr_tue_day integer,
    wms_loc_opr_wed_day integer,
    wms_loc_opr_thu_day integer,
    wms_loc_opr_fri_day integer,
    wms_loc_opr_sat_day integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_loc_operation_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_loc_operation_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_loc_operation_dtl
    ADD CONSTRAINT raw_wms_loc_operation_dtl_pkey PRIMARY KEY (raw_id);