CREATE TABLE stg.stg_wms_route_info_dtl (
    wms_rou_route_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_rou_info_ou integer NOT NULL,
    wms_rou_info_lineno integer NOT NULL,
    wms_rou_seq_num integer,
    wms_rou_behaviour character varying(32) COLLATE public.nocase,
    wms_rou_legid character varying(72) COLLATE public.nocase,
    wms_rou_info_back_haul integer,
    wms_rou_rev_distribution numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);