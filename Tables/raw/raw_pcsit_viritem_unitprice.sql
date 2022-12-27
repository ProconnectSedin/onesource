CREATE TABLE raw.raw_pcsit_viritem_unitprice (
    raw_id bigint NOT NULL,
    ou integer,
    cust character(40) COLLATE public.nocase,
    item_code character varying(80) COLLATE public.nocase,
    unit_price character varying(200) COLLATE public.nocase,
    invoicevalue character varying(200) COLLATE public.nocase,
    obd_date timestamp without time zone,
    ordernumber character varying(400) COLLATE public.nocase,
    order_qty integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_viritem_unitprice ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_viritem_unitprice_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_viritem_unitprice
    ADD CONSTRAINT raw_pcsit_viritem_unitprice_pkey PRIMARY KEY (raw_id);