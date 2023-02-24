-- Table: dwh.f_poposhdscheduledtl

-- DROP TABLE IF EXISTS dwh.f_poposhdscheduledtl;

CREATE TABLE IF NOT EXISTS dwh.f_poposhdscheduledtl
(
    poshd_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    poshd_datekey bigint,
    poshd_poou integer,
    poshd_pono character varying(36) COLLATE public.nocase,
    poshd_poamendmentno integer,
    poshd_polineno integer,
    poshd_scheduleno integer,
    poshd_shddate timestamp without time zone,
    poshd_acusage character varying(40) COLLATE public.nocase,
    poshd_shdqty numeric(13,2),
    poshd_balqty numeric(13,2),
    poshd_createdby character varying(60) COLLATE public.nocase,
    poshd_lastmodifiedby character varying(60) COLLATE public.nocase,
    poshd_lastmodifieddate timestamp without time zone,
    poshd_createddate timestamp without time zone,
    poshd_grrecdqty numeric(13,2),
    poshd_graccpdqty numeric(13,2),
    poshd_grmovdqty numeric(13,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_poposhdscheduledtl_pkey PRIMARY KEY (poshd_key),
    CONSTRAINT f_poposhdscheduledtl_ukey UNIQUE (poshd_poou, poshd_pono, poshd_poamendmentno, poshd_polineno, poshd_scheduleno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_poposhdscheduledtl
    OWNER to proconnect;
-- Index: f_poposhdscheduledtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_poposhdscheduledtl_key_idx;

CREATE INDEX IF NOT EXISTS f_poposhdscheduledtl_key_idx
    ON dwh.f_poposhdscheduledtl USING btree
    (poshd_poou ASC NULLS LAST, poshd_pono COLLATE public.nocase ASC NULLS LAST, poshd_poamendmentno ASC NULLS LAST, poshd_polineno ASC NULLS LAST, poshd_scheduleno ASC NULLS LAST)
    TABLESPACE pg_default;