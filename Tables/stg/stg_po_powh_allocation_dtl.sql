-- Table: stg.stg_po_powh_allocation_dtl

-- DROP TABLE IF EXISTS stg.stg_po_powh_allocation_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_po_powh_allocation_dtl
(
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
    CONSTRAINT pkpo_powh_allocation_dtl PRIMARY KEY (powh_pono, powh_poamendmentno, powh_polineno, powh_scheduleno, powh_posubscheduleno, powh_poou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_po_powh_allocation_dtl
    OWNER to proconnect;
-- Index: stg_po_powh_allocation_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_po_powh_allocation_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_po_powh_allocation_dtl_key_idx
    ON stg.stg_po_powh_allocation_dtl USING btree
    (powh_poou ASC NULLS LAST, powh_pono COLLATE public.nocase ASC NULLS LAST, powh_poamendmentno ASC NULLS LAST, powh_polineno ASC NULLS LAST, powh_posubscheduleno ASC NULLS LAST, powh_scheduleno ASC NULLS LAST)
    TABLESPACE pg_default;