CREATE TABLE raw.raw_pcsit_mis_warehouse_sla_summary_ibd (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_pcsit_mis_warehouse_sla_summary_ibd ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_mis_warehouse_sla_summary_ibd_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_mis_warehouse_sla_summary_ibd
    ADD CONSTRAINT raw_pcsit_mis_warehouse_sla_summary_ibd_pkey PRIMARY KEY (raw_id);