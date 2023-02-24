-- Table: raw.raw_po_paytm_doclevel_detail

-- DROP TABLE IF EXISTS "raw".raw_po_paytm_doclevel_detail;

CREATE TABLE IF NOT EXISTS "raw".raw_po_paytm_doclevel_detail
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    paytm_poou integer NOT NULL,
    paytm_pono character varying(72) COLLATE public.nocase NOT NULL,
    paytm_poamendmentno integer NOT NULL,
    paytm_advancepayable numeric,
    paytm_payterm character varying(60) COLLATE public.nocase,
    paytm_paytosupplier character varying(64) COLLATE public.nocase,
    paytm_ptversion integer,
    paytm_paymode character varying(100) COLLATE public.nocase,
    paytm_paymentstatus character varying(32) COLLATE public.nocase NOT NULL,
    paytm_advancepaid numeric,
    paytm_invoiceou integer NOT NULL,
    paytm_insuranceliability character varying(32) COLLATE public.nocase,
    paytm_ddchargesbornby character varying(32) COLLATE public.nocase,
    paytm_insuranceterm character varying(60) COLLATE public.nocase,
    paytm_insuranceamt numeric,
    paytm_autoinvoice character varying(32) COLLATE public.nocase NOT NULL,
    paytm_incoterm character varying(48) COLLATE public.nocase,
    paytm_addressid character varying(24) COLLATE public.nocase,
    paytm_deliverypoint character varying(160) COLLATE public.nocase,
    paytm_packingterm character varying(60) COLLATE public.nocase,
    paytm_transmode character varying(100) COLLATE public.nocase,
    paytm_transhipment character varying(32) COLLATE public.nocase NOT NULL,
    paytm_shippartial character varying(32) COLLATE public.nocase NOT NULL,
    paytm_incoplace character varying(160) COLLATE public.nocase,
    paytm_createdby character varying(120) COLLATE public.nocase NOT NULL,
    paytm_createddate timestamp without time zone NOT NULL,
    paytm_lastmodifiedby character varying(120) COLLATE public.nocase NOT NULL,
    paytm_lastmodifieddate timestamp without time zone NOT NULL,
    paytm_groption character varying(32) COLLATE public.nocase NOT NULL,
    paytm_advancetolerance numeric,
    paytm_invoicebeforegr character varying(32) COLLATE public.nocase,
    paytm_carrier character varying(40) COLLATE public.nocase,
    paytm_packingremarks character varying(2040) COLLATE public.nocase,
    paytm_shippingremarks character varying(2040) COLLATE public.nocase,
    paytm_reasoncode character varying(40) COLLATE public.nocase,
    paytm_policyno character varying(128) COLLATE public.nocase,
    paytm_lcno character varying(120) COLLATE public.nocase,
    paytm_lcamt numeric,
    paytm_lcissdate timestamp without time zone,
    paytm_lcexpdate timestamp without time zone,
    lcbg_app character varying(100) COLLATE public.nocase NOT NULL DEFAULT 'NON'::character varying,
    paytm_advancerequired character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pkpo_paytm_doclevel_detail PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_po_paytm_doclevel_detail
    OWNER to proconnect;