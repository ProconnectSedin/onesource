CREATE TABLE stg.stg_pcsit_mis_warehouse_sla_summary_ibd (
    fromdate date,
    todate date,
    locationdesc character varying(250) COLLATE public.nocase,
    agreedtat integer,
    patat integer,
    actualtat integer,
    processedorder integer,
    pendingorder integer,
    slain integer,
    slainavg numeric,
    slainpercentage numeric,
    slaout integer,
    slaoutavg numeric,
    slaoutpercentage numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);