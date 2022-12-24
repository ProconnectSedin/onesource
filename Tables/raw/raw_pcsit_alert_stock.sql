CREATE TABLE raw.raw_pcsit_alert_stock (
    raw_id bigint NOT NULL,
    locationcode character varying(50) COLLATE public.nocase,
    locationdesc character varying(150) COLLATE public.nocase,
    emailid character varying COLLATE public.nocase,
    zonal_emailid character varying COLLATE public.nocase,
    manager_emailid character varying COLLATE public.nocase,
    zone character varying(50) COLLATE public.nocase,
    region character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);