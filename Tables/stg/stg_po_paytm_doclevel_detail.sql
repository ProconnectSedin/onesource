-- Table: stg.stg_po_paytm_doclevel_detail

-- DROP TABLE IF EXISTS stg.stg_po_paytm_doclevel_detail;

CREATE TABLE IF NOT EXISTS stg.stg_po_paytm_doclevel_detail
(
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
    CONSTRAINT pkpo_paytm_doclevel_detail PRIMARY KEY (paytm_pono, paytm_poamendmentno, paytm_poou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_po_paytm_doclevel_detail
    OWNER to proconnect;
-- Index: stg_po_paytm_doclevel_detail_key_idx

-- DROP INDEX IF EXISTS stg.stg_po_paytm_doclevel_detail_key_idx;

CREATE INDEX IF NOT EXISTS stg_po_paytm_doclevel_detail_key_idx
    ON stg.stg_po_paytm_doclevel_detail USING btree
    (paytm_poou ASC NULLS LAST, paytm_pono COLLATE public.nocase ASC NULLS LAST, paytm_poamendmentno ASC NULLS LAST)
    TABLESPACE pg_default;