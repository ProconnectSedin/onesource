-- Table: stg.stg_fbp_bankcash_bal

-- DROP TABLE IF EXISTS stg.stg_fbp_bankcash_bal;

CREATE TABLE IF NOT EXISTS stg.stg_fbp_bankcash_bal
(
    ou_id integer,
    bankcash_code character varying(64) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    pay_type character varying(60) COLLATE public.nocase,
    "timestamp" integer,
    request_bal numeric(20,3),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreatedatetime timestamp(3) without time zone
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_fbp_bankcash_bal
    OWNER to proconnect;