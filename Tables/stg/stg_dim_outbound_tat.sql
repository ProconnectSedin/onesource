CREATE TABLE stg.stg_dim_outbound_tat (
    id integer NOT NULL,
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

ALTER TABLE stg.stg_dim_outbound_tat ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_dim_outbound_tat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);