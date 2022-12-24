CREATE TABLE stg.stg_fact_report_outbound_tat (
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