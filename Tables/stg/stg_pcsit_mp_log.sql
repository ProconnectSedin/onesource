CREATE TABLE stg.stg_pcsit_mp_log (
    shipmentid integer NOT NULL,
    shipment_json text,
    created_date timestamp without time zone,
    status character varying(200) COLLATE public.nocase,
    obd_json text,
    error_msg character varying COLLATE public.nocase,
    order_no character varying(400) COLLATE public.nocase,
    einvoiceurl character varying COLLATE public.nocase,
    ewaybillurl character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);