CREATE TABLE stg.stg_pcsit_location_shift_dtl (
    ou integer,
    locationcode character varying(50) COLLATE public.nocase,
    days integer NOT NULL,
    openingtime time without time zone,
    closingtime time without time zone,
    cutofftime time without time zone,
    weeks character varying(9) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);