CREATE TABLE raw.raw_fact_report_outboundsla (
    raw_id bigint NOT NULL,
    orderdate date,
    division character varying(10) COLLATE public.nocase,
    location character varying(20) COLLATE public.nocase,
    locationdesc character varying(150) COLLATE public.nocase,
    ordertype character varying(30) COLLATE public.nocase,
    servicetype character varying(50) COLLATE public.nocase,
    cutoff time without time zone,
    fortheday integer,
    prevday integer,
    forthedaypick integer,
    prevdaypick integer,
    uptocompletedpick integer,
    uptoslainpick integer,
    prevslainpick integer,
    slainpick numeric,
    slaoutpick numeric,
    forthedaypack integer,
    prevdaypack integer,
    uptocompletedpack integer,
    uptoslainpack integer,
    prevslainpack integer,
    slainpack numeric,
    slaoutpack numeric,
    forthedaybr integer,
    prevdaybr integer,
    uptocompletedbr integer,
    forthedaydisp integer,
    prevdaydisp integer,
    uptocompleteddisp integer,
    uptoslaindisp integer,
    prevslaindisp integer,
    slaindisp numeric,
    slaoutdisp numeric,
    aftercutoff integer,
    aftercutoffpick integer,
    premiumslapick numeric,
    aftercutoffpack integer,
    premiumslapack numeric,
    aftercutoffbr integer,
    aftercutoffdisp integer,
    premiumsladisp numeric,
    forthedaydel integer,
    prevdaydel integer,
    aftercutoffdel integer,
    uptocompleteddel integer,
    uptoslaindel integer,
    prevslaindel integer,
    slaindel numeric,
    slaoutdel numeric,
    premiumsladel numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_report_outboundsla ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_report_outboundsla_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_report_outboundsla
    ADD CONSTRAINT raw_fact_report_outboundsla_pkey PRIMARY KEY (raw_id);