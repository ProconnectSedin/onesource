CREATE TABLE stg.stg_ramco_location_mapping (
    id integer,
    source_computer_id character varying(50) COLLATE public.nocase,
    source_site_id character varying(50) COLLATE public.nocase,
    target_computer_id character varying(50) COLLATE public.nocase,
    target_site_id character varying(50) COLLATE public.nocase,
    description character varying(100) COLLATE public.nocase,
    dash_desc character varying(600) COLLATE public.nocase,
    group_desc character varying(200) COLLATE public.nocase,
    activeflag character(2) COLLATE public.nocase,
    region character varying(50) COLLATE public.nocase,
    loc_cat character(20) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);