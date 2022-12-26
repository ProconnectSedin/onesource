CREATE TABLE stg.stg_wms_fetched_route_ids (
    guid_val character varying(512) NOT NULL COLLATE public.nocase,
    route_id character varying(160) NOT NULL COLLATE public.nocase,
    route_match_level integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);