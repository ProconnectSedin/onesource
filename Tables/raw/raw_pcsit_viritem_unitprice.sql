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