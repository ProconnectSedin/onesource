-- Table: tmp.f_sla_shipment_trackingstatus_tmp

-- DROP TABLE IF EXISTS tmp.f_sla_shipment_trackingstatus_tmp;

CREATE TABLE IF NOT EXISTS tmp.f_sla_shipment_trackingstatus_tmp
(
    ord_sono character varying(50) COLLATE public.nocase,
    cust_id integer,
    trackingstatus character varying(50) COLLATE public.nocase
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS tmp.f_sla_shipment_trackingstatus_tmp
    OWNER to proconnect;
-- Index: f_sla_shipment_trackingstatus_tmp_idx1

-- DROP INDEX IF EXISTS tmp.f_sla_shipment_trackingstatus_tmp_idx1;

CREATE INDEX IF NOT EXISTS f_sla_shipment_trackingstatus_tmp_idx1
    ON tmp.f_sla_shipment_trackingstatus_tmp USING btree
    (ord_sono COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: f_sla_shipment_trackingstatus_tmp_idx2

-- DROP INDEX IF EXISTS tmp.f_sla_shipment_trackingstatus_tmp_idx2;

CREATE INDEX IF NOT EXISTS f_sla_shipment_trackingstatus_tmp_idx2
    ON tmp.f_sla_shipment_trackingstatus_tmp USING btree
    (ord_sono COLLATE public.nocase ASC NULLS LAST, cust_id ASC NULLS LAST, trackingstatus COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;