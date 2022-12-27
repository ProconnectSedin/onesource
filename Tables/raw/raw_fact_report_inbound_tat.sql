CREATE TABLE raw.raw_fact_report_inbound_tat (
    raw_id bigint NOT NULL,
    ou integer,
    customercode character varying(20) COLLATE public.nocase,
    locationcode character varying(20) COLLATE public.nocase,
    surrogatekey character varying(100) COLLATE public.nocase,
    act_grtat integer,
    chg_grtat integer,
    act_patat integer,
    chg_patat integer,
    act_ibdtat integer,
    chg_ibdtat integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_report_inbound_tat ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_report_inbound_tat_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_report_inbound_tat
    ADD CONSTRAINT raw_fact_report_inbound_tat_pkey PRIMARY KEY (raw_id);