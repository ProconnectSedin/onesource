CREATE TABLE stg.stg_wms_veh_mas_hdr_h (
    wms_veh_veh_id character varying(120) NOT NULL COLLATE public.nocase,
    wms_veh_ou integer NOT NULL,
    wms_veh_lineno integer NOT NULL,
    wms_veh_owner_type character varying(160) COLLATE public.nocase,
    wms_veh_agency_id character varying(64) COLLATE public.nocase,
    wms_veh_agency_contact_no character varying(64) COLLATE public.nocase,
    wms_veh_from timestamp without time zone,
    wms_veh_to timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);