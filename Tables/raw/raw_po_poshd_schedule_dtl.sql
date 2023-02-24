-- Table: raw.raw_po_poshd_schedule_dtl

-- DROP TABLE IF EXISTS "raw".raw_po_poshd_schedule_dtl;

CREATE TABLE IF NOT EXISTS "raw".raw_po_poshd_schedule_dtl
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    CONSTRAINT pkpo_poshd_schedule_dtl PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_po_poshd_schedule_dtl
    OWNER to proconnect;