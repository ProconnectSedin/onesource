CREATE TABLE raw.raw_wms_outbound_vas_hdr (
    raw_id bigint NOT NULL,
    wms_oub_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_oub_ou integer NOT NULL,
    wms_oub_outbound_ord character varying(72) NOT NULL COLLATE public.nocase,
    wms_oub_lineno integer NOT NULL,
    wms_oub_vas_id character varying(72) COLLATE public.nocase,
    wms_oub_instructions character varying(1020) COLLATE public.nocase,
    wms_oub_sequence integer,
    wms_oub_created_by character varying(120) COLLATE public.nocase,
    wms_oub_modified_by character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);