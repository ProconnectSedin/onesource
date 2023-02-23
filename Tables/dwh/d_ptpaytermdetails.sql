-- Table: dwh.d_ptpaytermdetails

-- DROP TABLE IF EXISTS dwh.d_ptpaytermdetails;

CREATE TABLE IF NOT EXISTS dwh.d_ptpaytermdetails
(
    pt_pay_term_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    pt_ouinstance integer,
    pt_paytermcode character varying(36) COLLATE public.nocase,
    pt_version_no integer,
    pt_serialno integer,
    pt_duedays integer,
    pt_duepercentage numeric(10,5),
    pt_discountdays integer,
    pt_discountpercentage numeric(10,5),
    pt_penalty numeric(10,5),
    pt_per numeric(10,5),
    pt_timeunit character varying(16) COLLATE public.nocase,
    pt_created_by character varying(60) COLLATE public.nocase,
    pt_created_date timestamp without time zone,
    pt_modified_by character varying(60) COLLATE public.nocase,
    pt_modified_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ptpaytermdetails_pkey PRIMARY KEY (pt_pay_term_dtl_key),
    CONSTRAINT d_ptpaytermdetails_ukey UNIQUE (pt_ouinstance, pt_paytermcode, pt_version_no, pt_serialno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ptpaytermdetails
    OWNER to proconnect;