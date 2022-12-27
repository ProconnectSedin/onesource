CREATE TABLE raw.raw_fact_report_outbound_tat (
    raw_id bigint NOT NULL,
    ou integer,
    surrogatekey character varying(100) COLLATE public.nocase,
    act_picktat integer,
    chg_picktat integer,
    act_packtat integer,
    chg_packtat integer,
    act_disptat integer,
    chg_disptat integer,
    act_delptat integer,
    chg_delptat integer,
    locationcode character varying(20) COLLATE public.nocase,
    customercode character varying(20) COLLATE public.nocase,
    act_obdtat integer,
    chg_obdtat integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_report_outbound_tat ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_report_outbound_tat_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_report_outbound_tat
    ADD CONSTRAINT raw_fact_report_outbound_tat_pkey PRIMARY KEY (raw_id);