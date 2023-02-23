-- Table: dwh.f_popowhallocationdtl

-- DROP TABLE IF EXISTS dwh.f_popowhallocationdtl;

CREATE TABLE IF NOT EXISTS dwh.f_popowhallocationdtl
(
    powh_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    powh_whkey bigint,
    powh_poou integer,
    powh_pono character varying(36) COLLATE public.nocase,
    powh_poamendmentno integer,
    powh_polineno integer,
    powh_posubscheduleno integer,
    powh_scheduleno integer,
    powh_allocqty numeric(13,2),
    powh_balancequantity numeric(13,2),
    powh_warehousecode character varying(20) COLLATE public.nocase,
    powh_ccusage character varying(40) COLLATE public.nocase,
    powh_createdby character varying(60) COLLATE public.nocase,
    powh_grrecdqty numeric(13,2),
    powh_createddate timestamp without time zone,
    powh_lastmodifiedby character varying(60) COLLATE public.nocase,
    powh_graccpdqty numeric(13,2),
    powh_grretrndqty numeric(13,2),
    powh_lastmodifieddate timestamp without time zone,
    powh_grrejdqty numeric(13,2),
    powh_grmovdqty numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_popowhallocationdtl_pkey PRIMARY KEY (powh_key),
    CONSTRAINT f_popowhallocationdtl_ukey UNIQUE (powh_poou, powh_pono, powh_poamendmentno, powh_polineno, powh_posubscheduleno, powh_scheduleno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_popowhallocationdtl
    OWNER to proconnect;
-- Index: f_popowhallocationdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_popowhallocationdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_popowhallocationdtl_key_idx
    ON dwh.f_popowhallocationdtl USING btree
    (powh_poou ASC NULLS LAST, powh_pono COLLATE public.nocase ASC NULLS LAST, powh_poamendmentno ASC NULLS LAST, powh_polineno ASC NULLS LAST, powh_posubscheduleno ASC NULLS LAST, powh_scheduleno ASC NULLS LAST)
    TABLESPACE pg_default;