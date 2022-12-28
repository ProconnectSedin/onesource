CREATE TABLE raw.raw_dim_inbound_tat (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_dim_inbound_tat ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_dim_inbound_tat_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_dim_inbound_tat
    ADD CONSTRAINT raw_dim_inbound_tat_pkey PRIMARY KEY (raw_id);