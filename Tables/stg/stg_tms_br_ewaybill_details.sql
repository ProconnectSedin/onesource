CREATE TABLE stg.stg_tms_br_ewaybill_details (
    ewbd_br_no character varying(72) COLLATE public.nocase,
    ewbd_ouinstance integer,
    ewbd_bill_no character varying(160) COLLATE public.nocase,
    ewbd_ewaybl_guid character varying(512) COLLATE public.nocase,
    ewbd_remarks character varying(1020) COLLATE public.nocase,
    ewbd_created_date timestamp without time zone,
    ewbd_created_by character varying(120) COLLATE public.nocase,
    ewbd_modified_date timestamp without time zone,
    ewbd_modified_by character varying(120) COLLATE public.nocase,
    ewbd_timestamp integer,
    ewbd_expiry_date timestamp without time zone,
    ewbd_shipper_invoice_date timestamp without time zone,
    ewbd_shipper_invoice_value numeric,
    ewbd_shipper_invoice_no character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);