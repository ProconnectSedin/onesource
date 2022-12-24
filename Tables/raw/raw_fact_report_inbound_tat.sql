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