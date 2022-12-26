CREATE TABLE raw.raw_pcsit_delivery_sap_dtl (
    raw_id bigint NOT NULL,
    billingdocument character varying(200) COLLATE public.nocase,
    billingdate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);