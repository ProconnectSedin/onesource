CREATE TABLE stg.stg_wms_stage_mas_dtl (
    wms_stg_mas_ou integer NOT NULL,
    wms_stg_mas_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_stg_mas_loc character varying(40) NOT NULL COLLATE public.nocase,
    wms_stg_line_no integer NOT NULL,
    wms_stg_handl_eqp_type character varying(160) COLLATE public.nocase,
    wms_stg_vehicle_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_stage_mas_dtl
    ADD CONSTRAINT wms_stage_mas_dtl_pk PRIMARY KEY (wms_stg_mas_ou, wms_stg_mas_id, wms_stg_mas_loc, wms_stg_line_no);