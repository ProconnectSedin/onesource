CREATE TABLE raw.raw_pcsit_inbound_location_shift_dtl (
    raw_id bigint NOT NULL,
    ou integer,
    locationcode character varying(50) COLLATE public.nocase,
    days integer NOT NULL,
    openingtime time without time zone,
    closingtime time without time zone,
    cutofftime time without time zone,
    weeks character varying(9) NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);