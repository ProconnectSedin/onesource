CREATE TABLE stg.stg_pcsit_alert_inbound (
    id integer NOT NULL,
    locationcode character varying(50) COLLATE public.nocase,
    emailid character varying COLLATE public.nocase,
    zonal_emailid character varying COLLATE public.nocase,
    regional_emailid character varying COLLATE public.nocase,
    manager_emailid character varying COLLATE public.nocase,
    zone character varying(50) COLLATE public.nocase,
    region character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);