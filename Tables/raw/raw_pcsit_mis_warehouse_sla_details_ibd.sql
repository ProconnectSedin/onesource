CREATE TABLE raw.raw_pcsit_mis_warehouse_sla_details_ibd (
    raw_id bigint NOT NULL,
    customercode character varying(10) COLLATE public.nocase,
    locationcode character varying(10) COLLATE public.nocase,
    locationdesc character varying(250) COLLATE public.nocase,
    ordernumber character varying(100) COLLATE public.nocase,
    ordertype character varying(50) COLLATE public.nocase,
    createddt character varying(20) COLLATE public.nocase,
    actualdt character varying(20) COLLATE public.nocase,
    agreedtat integer,
    grexpdt character varying(20) COLLATE public.nocase,
    grdt character varying(20) COLLATE public.nocase,
    grtat integer,
    paexpdt character varying(20) COLLATE public.nocase,
    padt character varying(20) COLLATE public.nocase,
    patat integer,
    pastatus character varying(50) COLLATE public.nocase,
    ibtat integer,
    slastatus character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_mis_warehouse_sla_details_ibd ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_mis_warehouse_sla_details_ibd_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_mis_warehouse_sla_details_ibd
    ADD CONSTRAINT raw_pcsit_mis_warehouse_sla_details_ibd_pkey PRIMARY KEY (raw_id);