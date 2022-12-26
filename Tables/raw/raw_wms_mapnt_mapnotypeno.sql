CREATE TABLE raw.raw_wms_mapnt_mapnotypeno (
    raw_id bigint NOT NULL,
    wms_mapnt_notypeno character varying(40) NOT NULL COLLATE public.nocase,
    wms_mapnt_function character varying(32) NOT NULL COLLATE public.nocase,
    wms_mapnt_transaction character varying(1020) NOT NULL COLLATE public.nocase,
    wms_mapnt_tran_type character varying(1020) NOT NULL COLLATE public.nocase,
    wms_mapnt_line_no integer NOT NULL,
    wms_mapnt_ou integer NOT NULL,
    wms_mapnt_division character varying(40) COLLATE public.nocase,
    wms_mapnt_location character varying(40) COLLATE public.nocase,
    wms_mapnt_customer_id character varying(72) COLLATE public.nocase,
    wms_mapnt_default character varying(32) COLLATE public.nocase,
    wms_mapnt_map character varying(32) COLLATE public.nocase,
    wms_mapnt_timestamp integer,
    wms_mapnt_created_by character varying(120) COLLATE public.nocase,
    wms_mapnt_created_date timestamp without time zone,
    wms_mapnt_modified_by character varying(120) COLLATE public.nocase,
    wms_mapnt_modified_date timestamp without time zone,
    wms_mapnt_allocation_level character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);