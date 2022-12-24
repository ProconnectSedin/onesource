CREATE TABLE stg.stg_wms_putaway_conditions_dtl (
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