CREATE TABLE raw.raw_dim_outbound_tat (
    raw_id bigint NOT NULL,
    id integer,
    ou integer,
    locationcode character varying(50) COLLATE public.nocase,
    ordertype character varying(20) COLLATE public.nocase,
    servicetype character varying(30) COLLATE public.nocase,
    processtat character varying(50) COLLATE public.nocase,
    picktat character varying(30) COLLATE public.nocase,
    packtat character varying(30) COLLATE public.nocase,
    disptat character varying(30) COLLATE public.nocase,
    deltat character varying(30) COLLATE public.nocase,
    picktat1 integer,
    packtat1 integer,
    disptat1 integer,
    deltat1 integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);