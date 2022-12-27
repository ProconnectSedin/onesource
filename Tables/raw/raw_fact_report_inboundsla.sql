CREATE TABLE raw.raw_fact_report_inboundsla (
    raw_id bigint NOT NULL,
    asndate date,
    division character varying(10) COLLATE public.nocase,
    location character varying(20) COLLATE public.nocase,
    locationdesc character varying(150) COLLATE public.nocase,
    ordertype character varying(30) COLLATE public.nocase,
    servicetype character varying(50) COLLATE public.nocase,
    cutoff time without time zone,
    fortheday integer,
    prevday integer,
    forthedayputaway integer,
    prevdayputaway integer,
    uptocompletedputaway integer,
    aftercutoff integer,
    aftercompletedputaway integer,
    uptoslain integer,
    prevslain integer,
    slain numeric,
    slaout numeric,
    premiumsla numeric,
    ou integer,
    asntype character varying(30) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_report_inboundsla ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_report_inboundsla_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_report_inboundsla
    ADD CONSTRAINT raw_fact_report_inboundsla_pkey PRIMARY KEY (raw_id);