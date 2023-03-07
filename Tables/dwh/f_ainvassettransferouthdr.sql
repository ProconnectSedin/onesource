-- Table: dwh.f_ainvassettransferouthdr

-- DROP TABLE IF EXISTS dwh.f_ainvassettransferouthdr;

CREATE TABLE IF NOT EXISTS dwh.f_ainvassettransferouthdr
(
    ainvassettransferouthdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    no_type character varying(20) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    confirm_reqd character varying(30) COLLATE public.nocase,
    transfer_date character varying(50) COLLATE public.nocase,
    tcal_status character varying(30) COLLATE public.nocase,
    tcal_exclusive_amt numeric(13,2),
    transfer_in_no character varying(40) COLLATE public.nocase,
    receipt_date timestamp without time zone,
    transfer_in_status character varying(50) COLLATE public.nocase,
    tcal_status_in character varying(30) COLLATE public.nocase,
    tcal_exclusive_amt_in numeric(13,2),
    "timestamp" integer,
    no_type_in character varying(20) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate character varying(50) COLLATE public.nocase,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate character varying(50) COLLATE public.nocase,
    transfer_in_ou integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ainvassettransferouthdr_pkey PRIMARY KEY (ainvassettransferouthdr_key),
    CONSTRAINT f_ainvassettransferouthdr_ukey UNIQUE (tran_type, tran_ou, tran_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ainvassettransferouthdr
    OWNER to proconnect;
-- Index: f_ainvassettransferouthdr_key_idx1

-- DROP INDEX IF EXISTS dwh.f_ainvassettransferouthdr_key_idx1;

CREATE INDEX IF NOT EXISTS f_ainvassettransferouthdr_key_idx1
    ON dwh.f_ainvassettransferouthdr USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;