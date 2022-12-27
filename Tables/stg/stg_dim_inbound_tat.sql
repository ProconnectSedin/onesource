CREATE TABLE stg.stg_dim_inbound_tat (
    id integer NOT NULL,
    ou integer,
    locationcode character varying(30) COLLATE public.nocase,
    ordertype character varying(30) COLLATE public.nocase,
    servicetype character varying(30) COLLATE public.nocase,
    cutofftime time without time zone,
    processtat character varying(10) COLLATE public.nocase,
    grtat character varying(10) COLLATE public.nocase,
    putawaytat character varying(10) COLLATE public.nocase,
    openingtime time without time zone,
    closingtime time without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_dim_inbound_tat ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_dim_inbound_tat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);