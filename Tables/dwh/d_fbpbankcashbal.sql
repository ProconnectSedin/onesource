-- Table: dwh.d_fbpbankcashbal

-- DROP TABLE IF EXISTS dwh.d_fbpbankcashbal;

CREATE TABLE IF NOT EXISTS dwh.d_fbpbankcashbal
(
    fbpbankcashbal_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
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
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_fbpbankcashbal_pkey PRIMARY KEY (fbpbankcashbal_key),
    CONSTRAINT d_fbpbankcashbal_ukey UNIQUE (ou_id, bankcash_code, fb_id, pay_type)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_fbpbankcashbal
    OWNER to proconnect;