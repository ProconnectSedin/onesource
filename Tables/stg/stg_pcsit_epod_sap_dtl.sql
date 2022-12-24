CREATE TABLE stg.stg_pcsit_epod_sap_dtl (
    billingdocument character varying(200) COLLATE public.nocase,
    billingdate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);