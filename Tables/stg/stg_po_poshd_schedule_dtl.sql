-- Table: stg.stg_po_poshd_schedule_dtl

-- DROP TABLE IF EXISTS stg.stg_po_poshd_schedule_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_po_poshd_schedule_dtl
(
    poshd_poou integer NOT NULL,
    poshd_pono character varying(72) COLLATE public.nocase NOT NULL,
    poshd_poamendmentno integer NOT NULL,
    poshd_polineno integer NOT NULL,
    poshd_scheduleno integer NOT NULL,
    poshd_shddate timestamp without time zone,
    poshd_acusage character varying(80) COLLATE public.nocase,
    poshd_analysiscode character(20) COLLATE public.nocase,
    poshd_subanalysiscode character(20) COLLATE public.nocase,
    poshd_shdqty numeric,
    poshd_balqty numeric,
    poshd_createdby character varying(120) COLLATE public.nocase,
    poshd_lastmodifiedby character varying(120) COLLATE public.nocase,
    poshd_lastmodifieddate timestamp without time zone,
    poshd_createddate timestamp without time zone,
    poshd_grrecdqty numeric,
    poshd_graccpdqty numeric,
    poshd_grretrndqty numeric,
    poshd_grrejdqty numeric,
    poshd_grmovdqty numeric,
    poshd_despatchqty numeric,
    poshd_solineno integer,
    poshd_soscheduleno integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pkpo_poshd_schedule_dtl PRIMARY KEY (poshd_poou, poshd_pono, poshd_poamendmentno, poshd_polineno, poshd_scheduleno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_po_poshd_schedule_dtl
    OWNER to proconnect;
-- Index: stg_po_poshd_schedule_dtl_key_idx

-- DROP INDEX IF EXISTS stg.stg_po_poshd_schedule_dtl_key_idx;

CREATE INDEX IF NOT EXISTS stg_po_poshd_schedule_dtl_key_idx
    ON stg.stg_po_poshd_schedule_dtl USING btree
    (poshd_poou ASC NULLS LAST, poshd_pono COLLATE public.nocase ASC NULLS LAST, poshd_poamendmentno ASC NULLS LAST, poshd_polineno ASC NULLS LAST, poshd_scheduleno ASC NULLS LAST)
    TABLESPACE pg_default;