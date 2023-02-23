-- Table: dwh.d_ptpaytermmaster

-- DROP TABLE IF EXISTS dwh.d_ptpaytermmaster;

CREATE TABLE IF NOT EXISTS dwh.d_ptpaytermmaster
(
    pt_pay_term_mst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    pt_ouinstance integer,
    pt_paytermcode character varying(36) COLLATE public.nocase,
    pt_version_no integer,
    pt_description character varying(300) COLLATE public.nocase,
    pt_effectivedate timestamp without time zone,
    pt_expirydate timestamp without time zone,
    pt_status character varying(16) COLLATE public.nocase,
    pt_propdiscount character varying(30) COLLATE public.nocase,
    pt_anchordateinfo character varying(16) COLLATE public.nocase,
    pt_created_by character varying(60) COLLATE public.nocase,
    pt_created_date timestamp without time zone,
    pt_modified_by character varying(60) COLLATE public.nocase,
    pt_modified_date timestamp without time zone,
    pt_timestamp_value integer,
    pt_lo_id character varying(40) COLLATE public.nocase,
    pt_created_langid integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_ptpaytermmaster_pkey PRIMARY KEY (pt_pay_term_mst_key),
    CONSTRAINT d_ptpaytermmaster_ukey UNIQUE (pt_ouinstance, pt_paytermcode, pt_version_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_ptpaytermmaster
    OWNER to proconnect;