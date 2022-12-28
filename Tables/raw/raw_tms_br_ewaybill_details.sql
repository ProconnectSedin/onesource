CREATE TABLE raw.raw_tms_br_ewaybill_details (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_tms_br_ewaybill_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_br_ewaybill_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_br_ewaybill_details
    ADD CONSTRAINT raw_tms_br_ewaybill_details_pkey PRIMARY KEY (raw_id);