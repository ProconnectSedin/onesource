-- Table: dwh.d_ardcustomeraccountmst

-- DROP TABLE IF EXISTS dwh.d_ardcustomeraccountmst;

CREATE TABLE IF NOT EXISTS dwh.d_ardcustomeraccountmst
(
    ardcustomeraccountmst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START -1 MINVALUE -1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint ,
    opcoa_key bigint ,
    curr_key bigint ,
    company_code character varying(20) COLLATE public.nocase,
    customer_group character varying(20) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    effective_from timestamp without time zone,
    sequence_no integer,
    timestamps integer,
    custctrl_account character varying(80) COLLATE public.nocase,
    custprepay_account character varying(80) COLLATE public.nocase,
    custnonar_account character varying(80) COLLATE public.nocase,
    effective_to timestamp without time zone,
    resou_id integer,
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
    CONSTRAINT d_ardcustomeraccountmst_pkey PRIMARY KEY (ardcustomeraccountmst_key),
    CONSTRAINT d_ardcustomeraccountmst_ukey UNIQUE (company_code, customer_group, fb_id, effective_from, currency_code, sequence_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ardcustomeraccountmst
    OWNER to proconnect;
-- Index: d_ardcustomeraccountmst_key_idx

-- DROP INDEX IF EXISTS dwh.d_ardcustomeraccountmst_key_idx;

CREATE INDEX IF NOT EXISTS d_ardcustomeraccountmst_key_idx
    ON dwh.d_ardcustomeraccountmst USING btree
    (company_code COLLATE public.nocase ASC NULLS LAST, customer_group COLLATE public.nocase ASC NULLS LAST, fb_id COLLATE public.nocase ASC NULLS LAST, effective_from ASC NULLS LAST, currency_code COLLATE public.nocase ASC NULLS LAST, sequence_no ASC NULLS LAST)
    TABLESPACE pg_default;