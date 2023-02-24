-- Table: raw.raw_po_powh_allocation_dtl

-- DROP TABLE IF EXISTS "raw".raw_po_powh_allocation_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_po_powh_allocation_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    powh_poou integer NOT NULL,
    powh_pono character varying(72) COLLATE public.nocase NOT NULL,
    powh_poamendmentno integer NOT NULL,
    powh_polineno integer NOT NULL,
    powh_posubscheduleno integer NOT NULL,
    powh_scheduleno integer NOT NULL,
    powh_allocqty numeric NOT NULL,
    powh_balancequantity numeric,
    powh_warehousecode character varying(40) COLLATE public.nocase,
    powh_ccusage character varying(80) COLLATE public.nocase,
    powh_createdby character varying(120) COLLATE public.nocase NOT NULL,
    powh_grrecdqty numeric,
    powh_createddate timestamp without time zone NOT NULL,
    powh_lastmodifiedby character varying(120) COLLATE public.nocase NOT NULL,
    powh_graccpdqty numeric,
    powh_grretrndqty numeric,
    powh_lastmodifieddate timestamp without time zone NOT NULL,
    powh_grrejdqty numeric,
    powh_grmovdqty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pkpo_powh_allocation_dtl PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_po_powh_allocation_dtl
    OWNER to proconnect;